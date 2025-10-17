import 'dart:io';

import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pmp_english/services/app_database/app_database.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../model/ai_sentence_practice/ai_sentence_practice.dart';
import '../../model/listening_practice_answer/listening_practice_answer.dart';
import '../../services/supabase_service.dart';

part 'listening_practice_answer_bloc.freezed.dart';

@freezed
sealed class ListeningPracticeAnswerEvent with _$ListeningPracticeAnswerEvent {
  const factory ListeningPracticeAnswerEvent.load() = _Load;
  const factory ListeningPracticeAnswerEvent.saveUserAnswers(
      List<ListeningPracticeAnswer> userAnswers) = _SaveUserAnswers;
}

@freezed
sealed class ListeningPracticeAnswerState with _$ListeningPracticeAnswerState {
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
            _mapSaveUserAnswers(userAnswers),
      );
    });
  }

  Future<void> _mapSaveUserAnswers(
      List<ListeningPracticeAnswer> userAnswers) async {
    final db = AppDatabase.instance();

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
            youtubeId: Value(answer.youtubeId),
          ),
        );
      }
    });
  }

  Future<void> _loadGroupDataToState(
      bool correctData, Emitter<ListeningPracticeAnswerState> emit) async {
    try {
      emit(const ListeningPracticeAnswerState.loading());
      debugPrint("_loadGroupDataToState: starting....");
      final data =
          await ((AppDatabase.instance().aiSentencePracticeTable.select()
                ..where(
                  (tbl) => correctData
                      ? tbl.correctedSentence.isNull()
                      : tbl.correctedSentence.isNotNull(),
                ))
                ..orderBy([
                  (tbl) => OrderingTerm(
                      expression: tbl.createdAt, mode: OrderingMode.desc)
                ]))
              .get();
      debugPrint("_loadGroupDataToState: has fetched....");
      final Map<DateTime, List<AiSentencePractice>> aiResponseGroupByDate = {};
      for (final item in data) {
        if (item.createdAt == null) continue;
        final dateOnly = DateTime(
          item.createdAt!.year,
          item.createdAt!.month,
          item.createdAt!.day,
        );
        aiResponseGroupByDate.putIfAbsent(dateOnly, () => []).add(item);
      }
    } catch (e) {
      emit(ListeningPracticeAnswerState.error(e.toString()));
    }
  }

  Future<void> _reviewSentenceToState(
      String input, Emitter<ListeningPracticeAnswerState> emit) async {
    try {
      if (input.isEmpty) {
        emit(const ListeningPracticeAnswerState.error(
            "Please enter a sentence"));
        return;
      }
      emit(const ListeningPracticeAnswerState.loading());
      final resData = await supabase.functions.invoke(
        "sentence-review",
        body: {
          "sentence": input,
        },
      );
      final data = resData.data;
      if (data is! Map) {
        emit(const ListeningPracticeAnswerState.error(
            "Invalid response from server"));
        return;
      }
      final aiSentencePractice =
          await AppDatabase.instance().aiSentencePracticeTable.insertReturning(
                AiSentencePracticeTableCompanion(
                  inputSentence: Value(input),
                  correctedSentence: Value(data['corrected']),
                  explanation: Value(data['explanation_mm']),
                  totalTokensUsed: Value(data['total_tokens'] ?? 0),
                ),
              );
    } catch (e) {
      if (e is SocketException) {
      } else if (e is FunctionException) {
        emit(const ListeningPracticeAnswerState.error(
            'Sorry, the server is busy.'));
      } else {
        emit(const ListeningPracticeAnswerState.error(
            'There are something wrong.'));
      }
      debugPrint("_reviewSentenceToState: error: ${e.toString()}");
    }
  }

  // Future<void> _mapDeleteToState(
  //   AiSentencePractice data,
  //   Emitter<ListeningPracticeAnswerState> emit,
  // ) async {
  //   emit(const ListeningPracticeAnswerState.loading());
  //   try {
  //     await Future.delayed(const Duration(seconds: 1));
  //     await AppDatabase.instance().aiSentencePracticeTable.deleteWhere(
  //           (tbl) => tbl.id.equals(data.id),
  //         );
  //     emit(ListeningPracticeAnswerState.success(data));
  //   } catch (e) {
  //     emit(ListeningPracticeAnswerState.error(e.toString()));
  //   }
  // }
}
