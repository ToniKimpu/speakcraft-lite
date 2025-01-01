import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pmp_english/global_app_state.dart';

import '../../model/pattern_exercise/pattern_exercise.dart';
import '../../services/supabase_service.dart';

part 'pattern_exercise_bloc.freezed.dart';

@freezed
abstract class PatternExerciseEvent with _$PatternExerciseEvent {
  const factory PatternExerciseEvent.loadPatternExercises(int exerciseId) =
      _LoadPatternExercises;
  const factory PatternExerciseEvent.loadPatternExercisesWithAnswers(
      int exerciseId) = _LoadPatternExercisesWithAnswer;
}

@freezed
abstract class PatternExerciseState with _$PatternExerciseState {
  const factory PatternExerciseState.initial() = _Initial;
  const factory PatternExerciseState.loading() = _Loading;
  const factory PatternExerciseState.loaded(
      List<PatternExercise> patternExercises) = _Loaded;
  const factory PatternExerciseState.error(String message) = _Error;
}

class PatternExerciseBloc
    extends Bloc<PatternExerciseEvent, PatternExerciseState> {
  PatternExerciseBloc() : super(const PatternExerciseState.initial()) {
    on<PatternExerciseEvent>(
      (event, emit) async {
        try {
          await event.when(
              loadPatternExercises: (exerciseId) =>
                  _mapLoadPatternExercisesToState(exerciseId, emit),
              loadPatternExercisesWithAnswers: (exerciseId) =>
                  _mapLoadPatternExercisesWithAnswerToState(exerciseId, emit));
        } catch (e) {
          debugPrint('Load Pattern Exercises error: ${e.toString()}');
          emit(PatternExerciseState.error(e.toString()));
        }
      },
    );
  }

  _mapLoadPatternExercisesToState(
      int exerciseId, Emitter<PatternExerciseState> emit) async {
    emit(const PatternExerciseState.loading());
    try {
      final dataRes = await supabase
          .rpc('get_pattern_exercises_with_vocabularies', params: {
        'exercise_id_param': exerciseId,
      });
      if (dataRes.isEmpty) {
        emit(const PatternExerciseState.loaded(<PatternExercise>[]));
        return;
      }
      final patternExercises = PatternExercise.fromJsonList(dataRes);
      emit(PatternExerciseState.loaded(patternExercises));
    } catch (e) {
      debugPrint('Error fetching pattern exercises: ${e.toString()}');
      emit(PatternExerciseState.error(e.toString()));
    }
  }

  _mapLoadPatternExercisesWithAnswerToState(
      int exerciseId, Emitter<PatternExerciseState> emit) async {
    emit(const PatternExerciseState.loading());
    try {
      final dataRes = await supabase
          .rpc('get_pattern_exercises_with_user_answers', params: {
        'exercise_id_param': exerciseId,
        'user_id_param': GlobalAppState().currentUser.id,
      });
      if (dataRes.isEmpty) {
        emit(const PatternExerciseState.loaded(<PatternExercise>[]));
        return;
      }
      final patternExercises = PatternExercise.fromJsonList1(dataRes);
      debugPrint("_patternExerciseInfo: ${dataRes.first.toString()}");
      emit(PatternExerciseState.loaded(patternExercises));
    } catch (e) {
      debugPrint('Error fetching pattern exercises: ${e.toString()}');
      emit(PatternExerciseState.error(e.toString()));
    }
  }
}
