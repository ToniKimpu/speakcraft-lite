import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pmp_english/core/logger/app_logger.dart';
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
          AppLogger.instance.error('Load Pattern Exercises error: ${e.toString()}', error: e);
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
          .from("pattern_exercises")
          .select(
              "*,vocabularies:pattern_exercises_vocabularies_relation(pattern_vocabularies(*))")
          .eq("exercise_id", exerciseId)
          .order("created_at", ascending: true);
      AppLogger.instance.debug("_mapLoadPatternExercisesToState: dataRes: $dataRes");
      if (dataRes.isEmpty) {
        emit(const PatternExerciseState.loaded(<PatternExercise>[]));
        return;
      }

      final patternExercises = dataRes
          .map((e) => PatternExercise.fromJsonWithVocabularies(e))
          .toList();

      emit(PatternExerciseState.loaded(patternExercises));
    } catch (e) {
      AppLogger.instance.error('_mapLoadPatternExercisesToState: errror: ${e.toString()}', error: e);
      emit(PatternExerciseState.error(e.toString()));
    }
  }

  _mapLoadPatternExercisesWithAnswerToState(
      int exerciseId, Emitter<PatternExerciseState> emit) async {
    emit(const PatternExerciseState.loading());
    try {
      AppLogger.instance.debug(
          '_mapLoadPatternExercisesWithAnswerToState: dataRes: ${GlobalAppState().currentUser.id}');
      final dataRes = await supabase
          .from("pattern_exercises")
          .select("*,exercise_user_answers!inner(answer)")
          .eq('exercise_id', exerciseId)
          .eq("exercise_user_answers.user_id", GlobalAppState().currentUser.id!)
          .order("created_at", ascending: true);
      AppLogger.instance.debug(
          '_mapLoadPatternExercisesWithAnswerToState: dataRes: $dataRes');
      if (dataRes.isEmpty) {
        emit(const PatternExerciseState.loaded(<PatternExercise>[]));
        return;
      }
      final patternExercises = dataRes
          .map((e) => PatternExercise.fromJsonWithUserAnswer(e))
          .toList();
      emit(PatternExerciseState.loaded(patternExercises));
    } catch (e) {
      AppLogger.instance.error('_mapLoadPatternExercisesWithAnswerToState: ${e.toString()}', error: e);
      emit(PatternExerciseState.error(e.toString()));
    }
  }
}
