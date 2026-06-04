import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart' hide JsonKey;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:speakcraft/core/logger/app_logger.dart';
import 'package:speakcraft/model/daily_speaking/daily_speaking_feedback.dart';
import 'package:speakcraft/model/daily_speaking/daily_speaking_session.dart';
import 'package:speakcraft/model/daily_speaking/daily_speaking_topic.dart';
import 'package:speakcraft/services/app_database/app_database.dart';
import 'package:speakcraft/services/daily_speaking/daily_speaking_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'daily_speaking_bloc.freezed.dart';

@freezed
class DailySpeakingEvent with _$DailySpeakingEvent {
  const factory DailySpeakingEvent.submitVoice({
    required String audioPath,
    required String onRamp,
    required List<String> requestedSections,
    DailySpeakingTopic? topic,
    String? topicAttemptId,
    @Default(1) int revisionNumber,
  }) = _SubmitVoice;
  const factory DailySpeakingEvent.submitText({
    required String text,
    required String onRamp,
    required List<String> requestedSections,
    DailySpeakingTopic? topic,
    String? topicAttemptId,
    @Default(1) int revisionNumber,
  }) = _SubmitText;
  const factory DailySpeakingEvent.reset() = _Reset;
}

@freezed
class DailySpeakingState with _$DailySpeakingState {
  const factory DailySpeakingState.initial() = _Initial;
  const factory DailySpeakingState.submitting({String? message}) = _Submitting;
  const factory DailySpeakingState.success(DailySpeakingSession session) =
      _Success;
  const factory DailySpeakingState.socketError() = _SocketError;
  const factory DailySpeakingState.error(String message) = _Error;
}

class DailySpeakingBloc
    extends Bloc<DailySpeakingEvent, DailySpeakingState> {
  DailySpeakingBloc({DailySpeakingService? service})
      : _service = service ?? DailySpeakingService(),
        super(const DailySpeakingState.initial()) {
    on<DailySpeakingEvent>((event, emit) async {
      await event.when(
        submitVoice: (audioPath, onRamp, sections, topic, attemptId, rev) =>
            _submitVoice(audioPath, onRamp, sections, topic, attemptId, rev, emit),
        submitText: (text, onRamp, sections, topic, attemptId, rev) =>
            _submitText(text, onRamp, sections, topic, attemptId, rev, emit),
        reset: () async => emit(const DailySpeakingState.initial()),
      );
    });
  }

  final DailySpeakingService _service;

  Future<void> _submitVoice(
    String audioPath,
    String onRamp,
    List<String> requestedSections,
    DailySpeakingTopic? topic,
    String? topicAttemptId,
    int revisionNumber,
    Emitter<DailySpeakingState> emit,
  ) async {
    try {
      final file = File(audioPath);
      if (!await file.exists()) {
        emit(const DailySpeakingState.error('Audio file is missing.'));
        return;
      }
      emit(const DailySpeakingState.submitting());
      final feedback = await _service.reviewSession(
        SessionInput.voice(
          audioPath: audioPath,
          onRamp: onRamp,
          requestedSections: requestedSections,
          topic: topic,
        ),
      );
      // Mint the chain id up front so the saved audio filename can reference it.
      final attemptId =
          topicAttemptId ?? DateTime.now().microsecondsSinceEpoch.toString();
      // Keep the recording for replay / A/B, then prune older chains' audio so
      // on-device storage stays bounded (keep-active-chain policy).
      final savedAudioPath =
          await _persistAudio(audioPath, attemptId, revisionNumber);
      await _pruneAudioExceptChain(attemptId);
      // Reuse `inputText` for the learner's words: the AI transcript for voice,
      // the typed text for the write path. The result page renders both the
      // same way.
      final transcript = feedback.transcript.trim();
      // Just-talk carries no chosen topic, but the AI infers one — synthesize a
      // topic from it so just-talk can also be polished/retried and revealed.
      final effectiveTopic = topic ?? _inferredTopic(onRamp, feedback);
      final session = await _persist(
        topicId: effectiveTopic?.id,
        onRamp: onRamp,
        inputMode: DailySpeakingInputMode.voice,
        inputText: transcript.isEmpty ? null : transcript,
        feedback: feedback,
        topicAttemptId: attemptId,
        revisionNumber: revisionNumber,
        audioPath: savedAudioPath,
        topicJson:
            effectiveTopic == null ? null : jsonEncode(effectiveTopic.toJson()),
      );
      emit(DailySpeakingState.success(session));
    } catch (e, st) {
      _handleError(e, st, emit);
    }
  }

  Future<void> _submitText(
    String text,
    String onRamp,
    List<String> requestedSections,
    DailySpeakingTopic? topic,
    String? topicAttemptId,
    int revisionNumber,
    Emitter<DailySpeakingState> emit,
  ) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty) {
      emit(const DailySpeakingState.error('Please write something first.'));
      return;
    }
    try {
      emit(const DailySpeakingState.submitting());
      final feedback = await _service.reviewSession(
        SessionInput.text(
          text: trimmed,
          onRamp: onRamp,
          requestedSections: requestedSections,
          topic: topic,
        ),
      );
      final effectiveTopic = topic ?? _inferredTopic(onRamp, feedback);
      final session = await _persist(
        topicId: effectiveTopic?.id,
        onRamp: onRamp,
        inputMode: DailySpeakingInputMode.text,
        inputText: trimmed,
        feedback: feedback,
        topicAttemptId: topicAttemptId,
        revisionNumber: revisionNumber,
        topicJson:
            effectiveTopic == null ? null : jsonEncode(effectiveTopic.toJson()),
      );
      emit(DailySpeakingState.success(session));
    } catch (e, st) {
      _handleError(e, st, emit);
    }
  }

  Future<DailySpeakingSession> _persist({
    required String? topicId,
    required String onRamp,
    required String inputMode,
    required String? inputText,
    required DailySpeakingFeedback feedback,
    String? topicAttemptId,
    int revisionNumber = 1,
    String? audioPath,
    String? topicJson,
  }) async {
    // Mint a chain id on the first attempt so "Polish & retry" has something to
    // carry forward. microsecondsSinceEpoch is unique enough for a local,
    // single-device store and avoids pulling in a uuid dependency.
    final attemptId =
        topicAttemptId ?? DateTime.now().microsecondsSinceEpoch.toString();
    final row = await AppDatabase.instance()
        .dailySpeakingSessionTable
        .insertReturning(
          DailySpeakingSessionTableCompanion(
            topicId: Value(topicId),
            onRamp: Value(onRamp),
            inputMode: Value(inputMode),
            inputText: Value(inputText),
            feedbackJson: Value(jsonEncode(feedback.toJson())),
            totalTokens: Value(feedback.totalTokens),
            topicAttemptId: Value(attemptId),
            revisionNumber: Value(revisionNumber),
            audioPath: Value(audioPath),
            topicJson: Value(topicJson),
          ),
        );
    return DailySpeakingSession(
      id: row.id,
      topicId: row.topicId,
      onRamp: row.onRamp,
      inputMode: row.inputMode,
      inputText: row.inputText,
      feedback: feedback,
      createdAt: row.createdAt,
      topicAttemptId: row.topicAttemptId,
      revisionNumber: row.revisionNumber,
      audioPath: row.audioPath,
      topicJson: row.topicJson,
    );
  }

  /// Copies the just-recorded temp clip into the app documents directory so it
  /// survives past the OS temp cache. Returns the saved path, or null if the
  /// source is missing or the copy fails (audio replay is best-effort — a
  /// failure here must not block showing feedback).
  Future<String?> _persistAudio(
    String tempPath,
    String attemptId,
    int revisionNumber,
  ) async {
    try {
      final src = File(tempPath);
      if (!await src.exists()) return null;
      final docs = await getApplicationDocumentsDirectory();
      final dir = Directory('${docs.path}/daily_speaking_audio');
      if (!await dir.exists()) await dir.create(recursive: true);
      final dot = tempPath.lastIndexOf('.');
      final ext = dot == -1 ? 'm4a' : tempPath.substring(dot + 1);
      final dest = '${dir.path}/${attemptId}_v$revisionNumber.$ext';
      await src.copy(dest);
      return dest;
    } catch (e) {
      AppLogger.instance.error('DailySpeaking: save audio failed: $e', error: e);
      return null;
    }
  }

  /// Keep-active-chain storage policy: deletes the saved audio files for every
  /// attempt chain except [attemptId] and clears their `audioPath`. Called when
  /// a new chain's first version is recorded, so only the topic currently being
  /// practised (and its earlier versions, for A/B replay) keeps audio on disk.
  Future<void> _pruneAudioExceptChain(String attemptId) async {
    try {
      final table = AppDatabase.instance().dailySpeakingSessionTable;
      final stale = await (table.select()
            ..where((t) =>
                t.audioPath.isNotNull() &
                t.topicAttemptId.equals(attemptId).not()))
          .get();
      if (stale.isEmpty) return;
      for (final row in stale) {
        final path = row.audioPath;
        if (path == null) continue;
        final f = File(path);
        if (await f.exists()) await f.delete();
      }
      await (table.update()
            ..where((t) =>
                t.audioPath.isNotNull() &
                t.topicAttemptId.equals(attemptId).not()))
          .write(const DailySpeakingSessionTableCompanion(
        audioPath: Value(null),
      ));
    } catch (e) {
      AppLogger.instance
          .error('DailySpeaking: prune audio failed: $e', error: e);
    }
  }

  /// Just-talk carries no chosen topic, but the AI returns an inferred one.
  /// Synthesize a topic from it (mirroring own-topic's synthetic topic) so the
  /// session can be polished/retried on the same subject. Null for other
  /// on-ramps (they pass a real topic already) or when nothing was inferred.
  DailySpeakingTopic? _inferredTopic(String onRamp, DailySpeakingFeedback fb) {
    if (onRamp != DailySpeakingOnRamp.justTalk) return null;
    final t = fb.inferredTopic?.trim();
    if (t == null || t.isEmpty) return null;
    return DailySpeakingTopic(
      id: 'inferred',
      title: t,
      promptEn: t,
      promptMm: '',
    );
  }

  void _handleError(
    Object e,
    StackTrace st,
    Emitter<DailySpeakingState> emit,
  ) {
    AppLogger.instance.error('DailySpeakingBloc submit error: $e', error: e);
    if (e is SocketException) {
      emit(const DailySpeakingState.socketError());
    } else if (e is FunctionException) {
      emit(const DailySpeakingState.error('Sorry, the server is busy.'));
    } else {
      emit(const DailySpeakingState.error('Something went wrong.'));
    }
  }
}
