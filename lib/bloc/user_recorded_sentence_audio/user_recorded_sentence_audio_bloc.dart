import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:speakcraft/core/logger/app_logger.dart';
import 'package:speakcraft/model/listening/listening_recording.dart';
import 'package:speakcraft/repositories/listening/listening_recording_repository.dart';

part 'user_recorded_sentence_audio_bloc.freezed.dart';

@freezed
sealed class UserRecordedSentenceAudioEvent
    with _$UserRecordedSentenceAudioEvent {
  /// Load all of this video's recordings for the current user.
  const factory UserRecordedSentenceAudioEvent.load({
    required int listeningId,
    required bool withLoading,
  }) = _Load;

  /// Upload + persist a new take for a sentence (cap enforced server-side).
  const factory UserRecordedSentenceAudioEvent.insert({
    required int listeningId,
    required String sentenceId,
    required File file,
  }) = _Insert;

  const factory UserRecordedSentenceAudioEvent.delete(ListeningRecording data) =
      _Delete;
}

@freezed
sealed class UserRecordedSentenceAudioState
    with _$UserRecordedSentenceAudioState {
  const factory UserRecordedSentenceAudioState.initial() = _Initial;
  const factory UserRecordedSentenceAudioState.loading({String? message}) =
      _Loading;
  const factory UserRecordedSentenceAudioState.loaded(
      List<ListeningRecording> data) = _Loaded;
  const factory UserRecordedSentenceAudioState.success() = _Success;
  const factory UserRecordedSentenceAudioState.error(String message) = _Error;
}

class UserRecordedSentenceAudioBloc extends Bloc<UserRecordedSentenceAudioEvent,
    UserRecordedSentenceAudioState> {
  UserRecordedSentenceAudioBloc({ListeningRecordingRepository? repository})
      : _repo = repository ?? ListeningRecordingRepository(),
        super(const UserRecordedSentenceAudioState.initial()) {
    on<UserRecordedSentenceAudioEvent>((event, emit) async {
      await event.when(
        load: (listeningId, withLoading) =>
            _mapLoadToState(listeningId, withLoading, emit),
        insert: (listeningId, sentenceId, file) =>
            _mapInsertToState(listeningId, sentenceId, file, emit),
        delete: (data) => _mapDeleteToState(data, emit),
      );
    });
  }

  final ListeningRecordingRepository _repo;

  Future<void> _mapLoadToState(
    int listeningId,
    bool withLoading,
    Emitter<UserRecordedSentenceAudioState> emit,
  ) async {
    try {
      if (withLoading) {
        emit(const UserRecordedSentenceAudioState.loading());
      }
      final data = await _repo.list(listeningId: listeningId);
      emit(UserRecordedSentenceAudioState.loaded(data));
    } catch (e) {
      AppLogger.instance.error('recordings load: $e', error: e);
      emit(UserRecordedSentenceAudioState.error(e.toString()));
    }
  }

  Future<void> _mapInsertToState(
    int listeningId,
    String sentenceId,
    File file,
    Emitter<UserRecordedSentenceAudioState> emit,
  ) async {
    try {
      emit(const UserRecordedSentenceAudioState.loading());
      await _repo.save(
        listeningId: listeningId,
        sentenceId: sentenceId,
        audio: file,
      );
      // The local temp file has been uploaded; clean it up.
      try {
        if (await file.exists()) await file.delete();
      } catch (_) {}
      emit(const UserRecordedSentenceAudioState.success());
    } catch (e) {
      AppLogger.instance.error('recording insert: $e', error: e);
      emit(UserRecordedSentenceAudioState.error(e.toString()));
    }
  }

  Future<void> _mapDeleteToState(
    ListeningRecording data,
    Emitter<UserRecordedSentenceAudioState> emit,
  ) async {
    emit(const UserRecordedSentenceAudioState.loading());
    try {
      await _repo.delete(data);
      emit(const UserRecordedSentenceAudioState.success());
    } catch (e) {
      AppLogger.instance.error('recording delete: $e', error: e);
      emit(UserRecordedSentenceAudioState.error(e.toString()));
    }
  }
}
