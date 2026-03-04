import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pmp_english/model/exercise/exercise.dart';
import 'package:pmp_english/model/exercise_user_answer/exercise_user_answer.dart';

import '../../global_app_state.dart';
import '../../services/app_database/app_database.dart';
import '../../services/supabase_service.dart';

part 'exercise_user_answer_bloc.freezed.dart';

@freezed
class ExerciseUserAnswerEvent with _$ExerciseUserAnswerEvent {
  const factory ExerciseUserAnswerEvent.addUserAnswerList(
    List<ExerciseUserAnswer> userAnswers,
    Exercise exercise,
    bool isLastIndex,
  ) = _AddUserAnswer;
}

@freezed
class ExerciseUserAnswerState with _$ExerciseUserAnswerState {
  const factory ExerciseUserAnswerState.initial() = _Initial;
  const factory ExerciseUserAnswerState.loading() = _Loading;
  const factory ExerciseUserAnswerState.onSuccess() = _OnSuccess;
  const factory ExerciseUserAnswerState.error(String message) = _Error;
}

class ExerciseUserAnswerBloc
    extends Bloc<ExerciseUserAnswerEvent, ExerciseUserAnswerState> {
  ExerciseUserAnswerBloc() : super(const ExerciseUserAnswerState.initial()) {
    on<ExerciseUserAnswerEvent>(
      (event, emit) async {
        try {
          await event.when(
            addUserAnswerList: (List<ExerciseUserAnswer> userAnswers, exercise,
                isLastIndex) async {
              emit(const ExerciseUserAnswerState.loading());
              await Future.delayed(const Duration(seconds: 3));
              final db = AppDatabase.instance();
              // for (final userAnswer in userAnswers) {
              //   await supabase.from('exercise_user_answers').insert(
              //     {
              //       'answer': userAnswer.userAnswer,
              //       'pattern_exercise_id': userAnswer.patternExerciseId,
              //       'user_id': GlobalAppState().currentUser.id,
              //     },
              //   );
              // }

              final List<Map<String, dynamic>> rows = userAnswers.map((answer) {
                return {
                  'answer': answer.userAnswer,
                  'pattern_exercise_id': answer.patternExerciseId,
                  'user_id': GlobalAppState().currentUser.id,
                };
              }).toList();
              await supabase.from('exercise_user_answers').insert(rows);
              await db.batch((batch) {
                for (final answer in userAnswers) {
                  batch.insert(
                    db.spokenPatternExerciseAnswerTable,
                    SpokenPatternExerciseAnswerTableCompanion(
                      patternExerciseId: Value(answer.patternExerciseId),
                      userAnswer: Value(answer.userAnswer),
                    ),
                  );
                }
              });
              await supabase.from('exercises_users_relation').insert({
                'user_id': GlobalAppState().currentUser.id,
                'exercise_id': exercise.id,
              });
              if (isLastIndex) {
                await supabase.from('days_users_relation').insert({
                  'user_id': GlobalAppState().currentUser.id,
                  'day_id': exercise.dayId,
                });
              }

              emit(const ExerciseUserAnswerState.onSuccess());
            },
          );
        } catch (e) {
          debugPrint('Load Exercise User Answers error: ${e.toString()}');
          emit(ExerciseUserAnswerState.error(e.toString()));
        }
      },
    );
  }
}
