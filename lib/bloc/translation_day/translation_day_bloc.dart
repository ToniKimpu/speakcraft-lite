import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pmp_english/core/di/service_locator.dart';
import 'package:pmp_english/core/logger/app_logger.dart';
import 'package:pmp_english/model/app_user/app_user.dart';

import '../../model/translation_day/translation_day.dart';
import '../../services/supabase_service.dart';

import 'package:json_annotation/json_annotation.dart';

part 'translation_day_bloc.freezed.dart';

@freezed
abstract class TranslationDayEvent with _$TranslationDayEvent {
  const factory TranslationDayEvent.loadTranslationDays() =
      _LoadTranslationDays;
}

@freezed
abstract class TranslationDayState with _$TranslationDayState {
  const factory TranslationDayState.initial() = _Initial;
  const factory TranslationDayState.loading() = _Loading;
  const factory TranslationDayState.loaded(
      List<TranslationDay> translationDays) = _Loaded;
  const factory TranslationDayState.error(String message) = _Error;
}

class TranslationDayBloc
    extends Bloc<TranslationDayEvent, TranslationDayState> {
  TranslationDayBloc() : super(const TranslationDayState.initial()) {
    on<TranslationDayEvent>(
      (event, emit) async {
        try {
          await event.when(
            loadTranslationDays: () =>
                _mapLoadTranslationDaysToState(emit),
          );
        } catch (e) {
          AppLogger.instance.error('Error loading translation days: ${e.toString()}', error: e);
          emit(TranslationDayState.error(e.toString()));
        }
      },
    );
  }

  Future<void> _mapLoadTranslationDaysToState(
      Emitter<TranslationDayState> emit) async {
    emit(const TranslationDayState.loading());
    try {
      final dataRes = await supabase
          .from('translation_days')
          .select('*,translation_days_users_relation(translation_day_id)')
          .eq('translation_days_users_relation.user_id',
              sl<ValueNotifier<AppUser>>().value.id!)
          .eq('is_deleted', false);
      if (dataRes.isEmpty) {
        emit(const TranslationDayState.loaded(<TranslationDay>[]));
        return;
      }
      final List<TranslationDay> translationDays =
          dataRes.map((item) => TranslationDay(
            id: item['id'] as int,
            dayName: item['day_name'] as String,
            isComplete: (item['translation_days_users_relation'] as List).isNotEmpty,
          )).toList();
      emit(TranslationDayState.loaded(translationDays));
    } catch (e) {
      AppLogger.instance.error('Error fetching translation days: ${e.toString()}', error: e);
      emit(TranslationDayState.error(e.toString()));
    }
  }
}
