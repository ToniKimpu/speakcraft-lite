import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pmp_english/model/user_recorded_sentence_audio/user_recorded_sentence_audio.dart';
import 'package:pmp_english/services/app_database/app_database.dart';

part 'user_recorded_sentence_audio_bloc.freezed.dart';

@freezed
sealed class UserRecordedSentenceAudioEvent
    with _$UserRecordedSentenceAudioEvent {
  const factory UserRecordedSentenceAudioEvent.load() = _Load;
  const factory UserRecordedSentenceAudioEvent.insert(
      UserRecordedSentenceAudio data) = _Insert;
  const factory UserRecordedSentenceAudioEvent.delete(
      UserRecordedSentenceAudio data) = _Delete;
}

@freezed
sealed class UserRecordedSentenceAudioState
    with _$UserRecordedSentenceAudioState {
  const factory UserRecordedSentenceAudioState.initial() = _Initial;
  const factory UserRecordedSentenceAudioState.loading({String? message}) =
      _Loading;
  const factory UserRecordedSentenceAudioState.loaded(
      List<UserRecordedSentenceAudio> data) = _Loaded;
  const factory UserRecordedSentenceAudioState.success(
      UserRecordedSentenceAudio data) = _Success;
  const factory UserRecordedSentenceAudioState.error(String message) = _Error;
}

class UserRecordedSentenceAudioBloc extends Bloc<UserRecordedSentenceAudioEvent,
    UserRecordedSentenceAudioState> {
  UserRecordedSentenceAudioBloc()
      : super(const UserRecordedSentenceAudioState.initial()) {
    on<UserRecordedSentenceAudioEvent>((event, emit) async {
      await event.when(
        load: () => _mapLoadToState(emit),
        insert: (data) => _mapInsertToState(data, emit),
        delete: (data) => _mapDeleteToState(data, emit),
      );
    });
  }

  Future<void> _mapLoadToState(
      Emitter<UserRecordedSentenceAudioState> emit) async {
    try {
      emit(const UserRecordedSentenceAudioState.loading());
      final data =
          await (AppDatabase.instance().userRecordedSentenceAudioTable.select()
                ..orderBy([
                  (tbl) => OrderingTerm(
                      expression: tbl.createdAt, mode: OrderingMode.desc)
                ]))
              .get();
      emit(UserRecordedSentenceAudioState.loaded(data));
    } catch (e) {
      emit(UserRecordedSentenceAudioState.error(e.toString()));
    }
  }

  Future<void> _mapInsertToState(
    UserRecordedSentenceAudio data,
    Emitter<UserRecordedSentenceAudioState> emit,
  ) async {
    try {
      final userRecordedSentenceAudio = await AppDatabase.instance()
          .userRecordedSentenceAudioTable
          .insertReturning(
            UserRecordedSentenceAudioTableCompanion(
              audioName: Value(data.audioName.trim()),
              audioPath: Value(data.audioPath.trim()),
              sentenceId: Value(data.sentenceId.trim()),
              youtubeId: Value(data.youtubeId.trim()),
            ),
          );
      emit(UserRecordedSentenceAudioState.success(userRecordedSentenceAudio));
    } catch (e) {
      debugPrint('_mapInsertToState: ${e.toString()}');
      emit(UserRecordedSentenceAudioState.error(e.toString()));
    }
  }

  Future<void> _mapDeleteToState(
    UserRecordedSentenceAudio data,
    Emitter<UserRecordedSentenceAudioState> emit,
  ) async {
    emit(const UserRecordedSentenceAudioState.loading());
    try {
      await Future.delayed(const Duration(seconds: 1));
      await AppDatabase.instance().userRecordedSentenceAudioTable.deleteWhere(
            (tbl) => tbl.id.equals(data.id!),
          );
      emit(UserRecordedSentenceAudioState.success(data));
    } catch (e) {
      debugPrint('_mapInsertToState: ${e.toString()}');
      emit(UserRecordedSentenceAudioState.error(e.toString()));
    }
  }
}
