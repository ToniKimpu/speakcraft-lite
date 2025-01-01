import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../model/exercise/exercise.dart';
import '../../services/supabase_service.dart';

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
          debugPrint('Error loading exercises: ${e.toString()}');
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
      final exercises = Exercise.fromJsonList1(dataRes);
      emit(ExerciseState.loaded(exercises));
    } catch (e) {
      debugPrint('Error fetching exercises: ${e.toString()}');
      emit(ExerciseState.error(e.toString()));
    }
  }
}
