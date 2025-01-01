import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pmp_english/global_app_state.dart';
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
          .select(
              '*, lessons(*),days_users_relation(*),exercises(*,exercises_users_relation(*))')
          .eq('days_users_relation.user_id', GlobalAppState().currentUser.id!)
          .eq('lessons.is_deleted', false)
          .eq('exercises.is_deleted', false)
          .eq('is_deleted', false);
      if (dataRes.isEmpty) {
        emit(const DayState.loaded(null, <Day>[]));
        return;
      }
      final days = dataRes.map((e) => Day.fromJson1(e)).toList();
      final notCompleteDays = days.where((day) => !day.isComplete).toList();
      if (days.isEmpty) {
        emit(const DayState.loaded(null, <Day>[]));
        return;
      }
      final currentDay = notCompleteDays.first;
      emit(DayState.loaded(currentDay, days));
    } catch (e) {
      debugPrint(e.toString());
      emit(DayState.error(e.toString()));
    }
  }
}
