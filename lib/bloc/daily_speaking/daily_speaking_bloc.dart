import 'dart:convert';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:speakcraft/core/logger/app_logger.dart';
import 'package:speakcraft/model/daily_speaking/daily_speaking_feedback.dart';
import 'package:speakcraft/model/daily_speaking/daily_speaking_session.dart';
import 'package:speakcraft/model/daily_speaking/daily_speaking_topic.dart';
import 'package:speakcraft/repositories/daily_speaking/daily_speaking_session_repository.dart';
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

  /// AI temporarily overloaded (Gemini "high demand"). Transient and retryable
  /// for free — the UI offers an immediate retry rather than a dead-end error.
  const factory DailySpeakingState.busy() = _Busy;
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
  final DailySpeakingSessionRepository _repo = DailySpeakingSessionRepository();

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
      // Measure the real recording length here (the edge function trusts it
      // over Gemini's unreliable estimate).
      int durationSeconds = 0;
      final probe = AudioPlayer();
      try {
        final d = await probe.setFilePath(audioPath);
        durationSeconds = d?.inSeconds ?? 0;
      } catch (_) {
        // Non-fatal — fall back to the AI estimate.
      } finally {
        await probe.dispose();
      }
      // Mint the chain id up front so the server row, the saved audio filename,
      // and the local persist all share it.
      final attemptId =
          topicAttemptId ?? DateTime.now().microsecondsSinceEpoch.toString();
      final feedback = await _service.reviewSession(
        SessionInput.voice(
          audioPath: audioPath,
          onRamp: onRamp,
          requestedSections: requestedSections,
          topic: topic,
          durationSeconds: durationSeconds,
          topicAttemptId: attemptId,
          revisionNumber: revisionNumber,
        ),
      );
      // The edge function already wrote the session (incl. audio) to Supabase —
      // build the result session from that server row.
      final session = await _buildSession(
        onRamp: onRamp,
        inputMode: DailySpeakingInputMode.voice,
        topic: topic,
        feedback: feedback,
        attemptId: attemptId,
        revisionNumber: revisionNumber,
        fallbackText: feedback.effectiveTranscript.trim(),
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
      final attemptId =
          topicAttemptId ?? DateTime.now().microsecondsSinceEpoch.toString();
      final feedback = await _service.reviewSession(
        SessionInput.text(
          text: trimmed,
          onRamp: onRamp,
          requestedSections: requestedSections,
          topic: topic,
          topicAttemptId: attemptId,
          revisionNumber: revisionNumber,
        ),
      );
      final session = await _buildSession(
        onRamp: onRamp,
        inputMode: DailySpeakingInputMode.text,
        topic: topic,
        feedback: feedback,
        attemptId: attemptId,
        revisionNumber: revisionNumber,
        fallbackText: trimmed,
      );
      emit(DailySpeakingState.success(session));
    } catch (e, st) {
      _handleError(e, st, emit);
    }
  }

  /// Builds the result-screen session from the server row the edge function just
  /// wrote (id, audio_path, created_at), then overlays the client-side topic —
  /// just-talk's topic is inferred on the client after feedback, so it isn't on
  /// the server row. Falls back to a local-only session if the fetch fails.
  Future<DailySpeakingSession> _buildSession({
    required String onRamp,
    required String inputMode,
    required DailySpeakingTopic? topic,
    required DailySpeakingFeedback feedback,
    required String attemptId,
    required int revisionNumber,
    required String? fallbackText,
  }) async {
    final effectiveTopic = topic ?? _inferredTopic(onRamp, feedback);
    final text =
        (fallbackText == null || fallbackText.isEmpty) ? null : fallbackText;
    DailySpeakingSession? fetched;
    try {
      fetched = await _repo.latestFor(
        topicAttemptId: attemptId,
        revisionNumber: revisionNumber,
      );
    } catch (e) {
      AppLogger.instance.error('DailySpeaking: fetch session failed: $e');
    }
    final base = fetched ??
        DailySpeakingSession(
          id: 0,
          onRamp: onRamp,
          inputMode: inputMode,
          inputText: text,
          feedback: feedback,
          createdAt: DateTime.now(),
          topicAttemptId: attemptId,
          revisionNumber: revisionNumber,
        );
    return base.copyWith(
      topicId: effectiveTopic?.id ?? base.topicId,
      topicJson:
          effectiveTopic == null ? null : jsonEncode(effectiveTopic.toJson()),
      inputText:
          (base.inputText == null || base.inputText!.isEmpty) ? text : base.inputText,
    );
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
    if (e is DailySpeakingBusyException) {
      emit(const DailySpeakingState.busy());
    } else if (e is DailySpeakingProcessingException) {
      // The job is still running server-side; ask the learner to retry shortly.
      emit(const DailySpeakingState.busy());
    } else if (e is SocketException) {
      emit(const DailySpeakingState.socketError());
    } else if (e is FunctionException) {
      emit(const DailySpeakingState.error('Sorry, the server is busy.'));
    } else {
      emit(const DailySpeakingState.error('Something went wrong.'));
    }
  }
}
