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

class AiSentencePracticeBloc extends Bloc<UserRecordedSentenceAudioEvent,
    UserRecordedSentenceAudioState> {
  AiSentencePracticeBloc()
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

  // Future<void> _loadGroupDataToState(
  //     bool correctData, Emitter<UserRecordedSentenceAudioState> emit) async {
  //   try {
  //     emit(const UserRecordedSentenceAudioState.loading());
  //     debugPrint("_loadGroupDataToState: starting....");
  //     final data =
  //         await ((AppDatabase.instance().aiSentencePracticeTable.select()
  //               ..where(
  //                 (tbl) => correctData
  //                     ? tbl.correctedSentence.isNull()
  //                     : tbl.correctedSentence.isNotNull(),
  //               ))
  //               ..orderBy([
  //                 (tbl) => OrderingTerm(
  //                     expression: tbl.createdAt, mode: OrderingMode.desc)
  //               ]))
  //             .get();
  //     debugPrint("_loadGroupDataToState: has fetched....");
  //     final Map<DateTime, List<AiSentencePractice>> aiResponseGroupByDate = {};

  //     for (final item in data) {
  //       if (item.createdAt == null) continue;

  //       final dateOnly = DateTime(
  //         item.createdAt!.year,
  //         item.createdAt!.month,
  //         item.createdAt!.day,
  //       );
  //       aiResponseGroupByDate.putIfAbsent(dateOnly, () => []).add(item);
  //     }
  //     emit(
  //       UserRecordedSentenceAudioState.loadedGroupData(
  //         aiResponseGroupByDate,
  //       ),
  //     );
  //   } catch (e) {
  //     emit(UserRecordedSentenceAudioState.error(e.toString()));
  //   }
  // }

  // Future<void> _reviewSentenceToState(
  //     String input, Emitter<UserRecordedSentenceAudioState> emit) async {
  //   try {
  //     if (input.isEmpty) {
  //       emit(const UserRecordedSentenceAudioState.error(
  //           "Please enter a sentence"));
  //       return;
  //     }
  //     emit(const UserRecordedSentenceAudioState.loading());
  //     final resData = await supabase.functions.invoke(
  //       "sentence-review",
  //       body: {
  //         "sentence": input,
  //       },
  //     );

  //     final data = resData.data;
  //     if (data is! Map) {
  //       emit(const UserRecordedSentenceAudioState.error(
  //           "Invalid response from server"));
  //       return;
  //     }
  //     final aiSentencePractice =
  //         await AppDatabase.instance().aiSentencePracticeTable.insertReturning(
  //               AiSentencePracticeTableCompanion(
  //                 inputSentence: Value(input),
  //                 correctedSentence: Value(data['corrected']),
  //                 explanation: Value(data['explanation_mm']),
  //                 totalTokensUsed: Value(data['total_tokens'] ?? 0),
  //               ),
  //             );
  //     emit(UserRecordedSentenceAudioState.success(aiSentencePractice));
  //   } catch (e) {
  //     if (e is SocketException) {
  //       emit(const UserRecordedSentenceAudioState.socketError());
  //     } else if (e is FunctionException) {
  //       emit(const UserRecordedSentenceAudioState.error(
  //           'Sorry, the server is busy.'));
  //     } else {
  //       emit(const UserRecordedSentenceAudioState.error(
  //           'There are something wrong.'));
  //     }
  //     debugPrint("_reviewSentenceToState: error: ${e.toString()}");
  //   }
  // }

  Future<void> _mapInsertToState(
    UserRecordedSentenceAudio data,
    Emitter<UserRecordedSentenceAudioState> emit,
  ) async {
    try {
      final userRecordedSentenceAudio = await AppDatabase.instance()
          .userRecordedSentenceAudioTable
          .insertReturning(
            UserRecordedSentenceAudioTableCompanion(
              audioName: Value(data.audioName),
              audioPath: Value(data.audioPath),
              sentenceId: Value(data.sentenceId),
              youtubeId: Value(data.youtubeId),
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
