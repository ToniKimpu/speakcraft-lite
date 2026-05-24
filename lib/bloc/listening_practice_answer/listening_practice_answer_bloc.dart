import 'package:drift/drift.dart' hide JsonKey;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:speakcraft/core/logger/app_logger.dart';
import 'package:speakcraft/services/app_database/app_database.dart';

import '../../model/listening_practice_answer/listening_practice_answer.dart';


part 'listening_practice_answer_bloc.freezed.dart';

@freezed
class ListeningPracticeAnswerEvent with _$ListeningPracticeAnswerEvent {
  const factory ListeningPracticeAnswerEvent.load() = _Load;
  const factory ListeningPracticeAnswerEvent.saveUserAnswers(
      List<ListeningPracticeAnswer> userAnswers) = _SaveUserAnswers;
}

@freezed
class ListeningPracticeAnswerState with _$ListeningPracticeAnswerState {
  const factory ListeningPracticeAnswerState.initial() = _Initial;
  const factory ListeningPracticeAnswerState.loading({String? message}) =
      _Loading;
  const factory ListeningPracticeAnswerState.loaded(
      List<ListeningPracticeAnswer> userAnswers) = _Loaded;
  const factory ListeningPracticeAnswerState.onSaved() = _OnSaved;
  const factory ListeningPracticeAnswerState.error(String message) = _Error;
}

class ListeningPracticeAnswerBloc
    extends Bloc<ListeningPracticeAnswerEvent, ListeningPracticeAnswerState> {
  ListeningPracticeAnswerBloc()
      : super(const ListeningPracticeAnswerState.initial()) {
    on<ListeningPracticeAnswerEvent>((event, emit) async {
      await event.when(
        load: () async {},
        saveUserAnswers: (userAnswers) async =>
            await _mapSaveUserAnswers(userAnswers, emit),
      );
    });
  }

  Future<void> _mapSaveUserAnswers(List<ListeningPracticeAnswer> userAnswers,
      Emitter<ListeningPracticeAnswerState> emit) async {
    try {
      emit(const ListeningPracticeAnswerState.loading(message: ""));
      final db = AppDatabase.instance();
      await Future.delayed(const Duration(seconds: 1));
      await db.batch((batch) {
        for (final answer in userAnswers) {
          batch.insert(
            db.listeningPracticeAnswerTable,
            ListeningPracticeAnswerTableCompanion(
              groupId: Value(answer.groupId),
              questionId: Value(answer.questionId),
              userAnswer: Value(answer.userAnswer),
              timeSpent: Value(answer.timeSpent),
              isCorrect: Value(answer.isCorrect),
              youtubeId: Value(answer.youtubeId.trim()),
            ),
          );
        }
      });
      emit(const ListeningPracticeAnswerState.onSaved());
    } catch (e) {
      AppLogger.instance.error("_mapSavUseAnswersLogs: ${e.toString()}", error: e);
      emit(ListeningPracticeAnswerState.error(e.toString()));
    }
  }
}
