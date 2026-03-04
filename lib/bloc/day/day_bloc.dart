import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pmp_english/core/di/service_locator.dart';
import 'package:pmp_english/core/logger/app_logger.dart';
import 'package:pmp_english/repositories/day/day_repository.dart';

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
  final DayRepository _repository;

  DayBloc({DayRepository? repository})
      : _repository = repository ?? sl<DayRepository>(),
        super(const DayState.initial()) {
    on<DayEvent>(
      (event, emit) async {
        await event.when(
          loadDays: () => _mapLoadDaysToState(emit),
        );
      },
    );
  }

  Future<void> _mapLoadDaysToState(Emitter<DayState> emit) async {
    emit(const DayState.loading());
    try {
      final days = await _repository.loadDays();
      emit(DayState.loaded(null, days));
    } catch (e) {
      AppLogger.instance.error('_mapLoadDaysToState error: ${e.toString()}', error: e);
      if (e is SocketException || e is TimeoutException) {
        emit(const DayState.socketError(
            'Please check your internet connection and try again.'));
        return;
      }
      emit(DayState.error(e.toString()));
    }
  }
}
