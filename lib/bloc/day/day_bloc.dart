import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pmp_english/global_app_state.dart';
import 'package:pmp_english/model/exercise/exercise.dart';
import 'package:pmp_english/model/lesson/lesson.dart';
import 'package:pmp_english/services/supabase_service.dart';

import '../../model/day/day.dart';

part 'day_bloc.freezed.dart';

@freezed
abstract class DayEvent with _$DayEvent {
  const factory DayEvent.loadDays() = _LoadDays;
}

@freezed
abstract class DayState with _$DayState {
  const factory DayState.initial() = _Initial;
  const factory DayState.loading() = _Loading;
  const factory DayState.loaded(Day? currentDay, List<Day> days) = _Loaded;
  const factory DayState.socketError(String message) = _SocketError;
  const factory DayState.error(String message) = _Error;
}

class DayBloc extends Bloc<DayEvent, DayState> {
  DayBloc() : super(const DayState.initial()) {
    on<DayEvent>(
      (event, emit) async {
        try {
          await event.when(
            loadDays: () => _mapLoadDaysToState(emit),
          );
        } catch (e) {
          debugPrint('Load Days error ${e.toString()}');
          emit(DayState.error(e.toString()));
        }
      },
    );
  }
  _mapLoadDaysToState(Emitter<DayState> emit) async {
    emit(const DayState.loading());
    try {
      final dataRes = await supabase
          .from('days')
          .select('*,days_users_relation(*)')
          .eq('days_users_relation.user_id', GlobalAppState().currentUser.id!)
          .eq('is_deleted', false)
          .order("order_number", ascending: true);
      if (dataRes.isEmpty) {
        emit(const DayState.loaded(null, <Day>[]));
        return;
      }
      final days = dataRes.map((e) => Day.fromJson1(e)).toList();
      if (days.isEmpty) {
        emit(const DayState.loaded(null, <Day>[]));
        return;
      }
      // Fetch all lessons for these days in one go
      final lessonDataRes = await supabase
          .from("lessons")
          .select("*")
          .eq("is_deleted", false)
          .inFilter("day_id", days.map((d) => d.id).toList())
          .order("created_at", ascending: true);

      final allLessons = Lesson.fromJsonList(lessonDataRes);

// Fetch all exercises for these days in one go
      final exerciseDataRes = await supabase
          .from("exercises")
          .select("*, exercises_users_relation(*)")
          .eq("is_deleted", false)
          .inFilter("day_id", days.map((d) => d.id).toList())
          .order("created_at", ascending: true);

      final allExercises = Exercise.fromJsonList1(exerciseDataRes);

// Group lessons and exercises by day_id
      final lessonsByDay = {
        for (var id in days.map((d) => d.id))
          id: allLessons.where((l) => l.dayId == id).toList()
      };

      final exercisesByDay = {
        for (var id in days.map((d) => d.id))
          id: allExercises.where((e) => e.dayId == id).toList()
      };

// Build updated days
      final updatedDays = days
          .map((day) => day.copyWith(
                lessons: lessonsByDay[day.id] ?? [],
                exercises: exercisesByDay[day.id] ?? [],
              ))
          .toList();

      emit(DayState.loaded(null, updatedDays));
    } catch (e) {
      debugPrint("_mapLoadDayToState: ${e.toString()}");
      if (e is SocketException || e is TimeoutException) {
        emit(const DayState.socketError(
            "Please check your internet connection and try again."));
        return;
      }
      emit(DayState.error(e.toString()));
    }
  }
}
