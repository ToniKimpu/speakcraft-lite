import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart' hide JsonKey;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
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
      final session = await _persist(
        topicId: topic?.id,
        onRamp: onRamp,
        inputMode: DailySpeakingInputMode.voice,
        inputText: null,
        feedback: feedback,
        topicAttemptId: topicAttemptId,
        revisionNumber: revisionNumber,
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
      final session = await _persist(
        topicId: topic?.id,
        onRamp: onRamp,
        inputMode: DailySpeakingInputMode.text,
        inputText: trimmed,
        feedback: feedback,
        topicAttemptId: topicAttemptId,
        revisionNumber: revisionNumber,
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
