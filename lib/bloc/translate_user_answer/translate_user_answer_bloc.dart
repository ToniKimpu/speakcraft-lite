import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pmp_english/core/di/service_locator.dart';
import 'package:pmp_english/core/logger/app_logger.dart';
import 'package:pmp_english/model/app_user/app_user.dart';
import 'package:pmp_english/model/translation/translation.dart';

import '../../services/supabase_service.dart';

import 'package:json_annotation/json_annotation.dart';

part 'translate_user_answer_bloc.freezed.dart';

@freezed
abstract class TranslateUserAnswerEvent with _$TranslateUserAnswerEvent {
  const factory TranslateUserAnswerEvent.addTranslateUserAnswerList(
    List<Translation> userTranslations,
    int completedDayId,
  ) = _AddTranslateUserAnswerList;
}

@freezed
abstract class TranslateUserAnswerState with _$TranslateUserAnswerState {
  const factory TranslateUserAnswerState.initial() = _Initial;
  const factory TranslateUserAnswerState.loading() = _Loading;
  const factory TranslateUserAnswerState.onSuccess() = _OnSuccess;
  const factory TranslateUserAnswerState.error(String message) = _Error;
}

class TranslateUserAnswerBloc
    extends Bloc<TranslateUserAnswerEvent, TranslateUserAnswerState> {
  TranslateUserAnswerBloc() : super(const TranslateUserAnswerState.initial()) {
    on<TranslateUserAnswerEvent>(
      (event, emit) async {
        try {
          await event.when(
            addTranslateUserAnswerList: (
              List<Translation> userTranslations,
              completedDayId,
            ) async {
              emit(const TranslateUserAnswerState.loading());
              for (final userAnswer in userTranslations) {
                await supabase.from('translation_user_answer').insert({
                  'answer': userAnswer.userAnswer,
                  'translation_id': userAnswer.id,
                  'user_id': sl<ValueNotifier<AppUser>>().value.id,
                });
              }
              await supabase.from('translation_days_users_relation').insert({
                'user_id': sl<ValueNotifier<AppUser>>().value.id,
                'translation_day_id': completedDayId,
              });
              emit(const TranslateUserAnswerState.onSuccess());
            },
          );
        } catch (e) {
          AppLogger.instance.error('Load Translate User Answers error: ${e.toString()}', error: e);
          emit(TranslateUserAnswerState.error(e.toString()));
        }
      },
    );
  }
}
