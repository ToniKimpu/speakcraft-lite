import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pmp_english/core/logger/app_logger.dart';

import '../../model/exercise/exercise.dart';
import '../../services/supabase_service.dart';

import 'package:json_annotation/json_annotation.dart';

part 'exercise_bloc.freezed.dart';

@freezed
abstract class ExerciseEvent with _$ExerciseEvent {
  const factory ExerciseEvent.loadExercises(int dayId) = _LoadExercises;
}

@freezed
abstract class ExerciseState with _$ExerciseState {
  const factory ExerciseState.initial() = _Initial;
  const factory ExerciseState.loading() = _Loading;
  const factory ExerciseState.loaded(List<Exercise> exercises) = _Loaded;
  const factory ExerciseState.error(String message) = _Error;
}

class ExerciseBloc extends Bloc<ExerciseEvent, ExerciseState> {
  ExerciseBloc() : super(const ExerciseState.initial()) {
    on<ExerciseEvent>(
      (event, emit) async {
        try {
          await event.when(
            loadExercises: (dayId) => _mapLoadExercisesToState(dayId, emit),
          );
        } catch (e) {
          AppLogger.instance.error('Error loading exercises: ${e.toString()}', error: e);
          emit(ExerciseState.error(e.toString()));
        }
      },
    );
  }

  Future<void> _mapLoadExercisesToState(
      int dayId, Emitter<ExerciseState> emit) async {
    emit(const ExerciseState.loading());
    try {
      final dataRes = await supabase
          .from('exercises')
          .select('*,exercises_users_relation(*)')
          .eq('day_id', dayId)
          .eq('is_deleted', false);
      if (dataRes.isEmpty) {
        emit(const ExerciseState.loaded(<Exercise>[]));
        return;
      }
      final exercises = dataRes.map((e) => Exercise(
        id: e['id'] as int,
        exerciseName: e['exercise_name'] as String,
        dayId: e['day_id'] as int,
        isComplete: (e['exercises_users_relation'] as List).isNotEmpty,
      )).toList();
      emit(ExerciseState.loaded(exercises));
    } catch (e) {
      AppLogger.instance.error('Error fetching exercises: ${e.toString()}', error: e);
      emit(ExerciseState.error(e.toString()));
    }
  }
}
