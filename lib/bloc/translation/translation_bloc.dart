import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pmp_english/global_app_state.dart';
import 'package:pmp_english/model/translation_level/translation_level.dart';
import 'package:pmp_english/services/supabase_service.dart';

import '../../model/translation/translation.dart';

part 'translation_bloc.freezed.dart';

@freezed
abstract class TranslationEvent with _$TranslationEvent {
  const factory TranslationEvent.loadTranslations(int translationDayId) =
      _LoadTranslations;
  const factory TranslationEvent.loadTranslationLevels() =
      _LoadTranslationLevels;
  const factory TranslationEvent.loadUserTranslations(int translationDayId) =
      _LoadUserTranslations;
}

@freezed
abstract class TranslationState with _$TranslationState {
  const factory TranslationState.initial() = _Initial;
  const factory TranslationState.loading() = _Loading;
  const factory TranslationState.loaded(List<Translation> translations) =
      _Loaded;
  const factory TranslationState.translationLevelsLoaded(
      List<TranslationLevel> translationLevels) = _TranslationLevelsLoaded;
  const factory TranslationState.error(String message) = _Error;
}

class TranslationBloc extends Bloc<TranslationEvent, TranslationState> {
  TranslationBloc() : super(const TranslationState.initial()) {
    on<TranslationEvent>(
      (event, emit) async {
        try {
          await event.when(
            loadTranslations: (translationDayId) =>
                _mapLoadTranslationsToState(translationDayId, emit),
            loadUserTranslations: (translationId) =>
                _mapLoadUserTranslationsToState(translationId, emit),
            loadTranslationLevels: () => _mapLoadTranslationLevelsToState(emit),
          );
        } catch (e) {
          debugPrint('Load Translations error: ${e.toString()}');
          emit(TranslationState.error(e.toString()));
        }
      },
    );
  }

  Future<void> _mapLoadTranslationLevelsToState(
      Emitter<TranslationState> emit) async {
    emit(const TranslationState.loading());
    try {
      final dataRes = await supabase.from('translation_levels').select('*');
      if (dataRes.isEmpty) {
        emit(const TranslationState.translationLevelsLoaded(
            <TranslationLevel>[]));
        return;
      }
      final translations = TranslationLevel.fromJsonList(dataRes);
      emit(TranslationState.translationLevelsLoaded(translations));
    } catch (e) {
      debugPrint('Error fetching translation levels: ${e.toString()}');
      emit(TranslationState.error(e.toString()));
    }
  }

  Future<void> _mapLoadUserTranslationsToState(
      int translationDayId, Emitter<TranslationState> emit) async {
    emit(const TranslationState.loading());
    try {
      final dataRes = await supabase
          .from('translations')
          .select('*,translation_user_answer!inner(answer)')
          .eq('translation_day_id', translationDayId)
          .eq('translation_user_answer.user_id',
              GlobalAppState().currentUser.id!)
          .eq('is_deleted', false);
      if (dataRes.isEmpty) {
        emit(const TranslationState.loaded(<Translation>[]));
        return;
      }
      final translations = Translation.fromJsonList1(dataRes);
      emit(TranslationState.loaded(translations));
    } catch (e) {
      debugPrint('Error fetching translations: ${e.toString()}');
      emit(TranslationState.error(e.toString()));
    }
  }

  Future<void> _mapLoadTranslationsToState(
      int translationDayId, Emitter<TranslationState> emit) async {
    emit(const TranslationState.loading());
    try {
      final dataRes = await supabase.rpc(
        'get_translations_with_vocabularies_by_day',
        params: {'translation_day_id_param': translationDayId},
      );
      if (dataRes.isEmpty) {
        emit(const TranslationState.loaded(<Translation>[]));
        return;
      }
      debugPrint("_translationLoaded: ${dataRes[1].toString()} DataRes");

      final translations = Translation.fromJsonList1(dataRes);
      emit(TranslationState.loaded(translations));
    } catch (e) {
      debugPrint('Error fetching translations: ${e.toString()}');
      emit(TranslationState.error(e.toString()));
    }
  }
}
