import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pmp_english/global_app_state.dart';

import '../../model/translation_day/translation_day.dart';
import '../../services/supabase_service.dart';

part 'translation_day_bloc.freezed.dart';

@freezed
abstract class TranslationDayEvent with _$TranslationDayEvent {
  const factory TranslationDayEvent.loadTranslationDays(
      int translationLevelId) = _LoadTranslationDays;
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
            loadTranslationDays: (translationLevelId) =>
                _mapLoadTranslationDaysToState(translationLevelId, emit),
          );
        } catch (e) {
          debugPrint('Error loading translation days: ${e.toString()}');
          emit(TranslationDayState.error(e.toString()));
        }
      },
    );
  }

  Future<void> _mapLoadTranslationDaysToState(
      int translationLevelId, Emitter<TranslationDayState> emit) async {
    emit(const TranslationDayState.loading());
    try {
      final dataRes = await supabase
          .from('translation_days')
          .select('*,translation_days_users_relation(translation_day_id)')
          .eq('translation_level_id', translationLevelId)
          .eq('translation_days_users_relation.user_id',
              GlobalAppState().currentUser.id!)
          .eq('is_deleted', false);
      if (dataRes.isEmpty) {
        emit(const TranslationDayState.loaded(<TranslationDay>[]));
        return;
      }
      final List<TranslationDay> translationDays =
          dataRes.map((item) => TranslationDay.fromJson1(item)).toList();
      emit(TranslationDayState.loaded(translationDays));
    } catch (e) {
      debugPrint('Error fetching translation days: ${e.toString()}');
      emit(TranslationDayState.error(e.toString()));
    }
  }
}
