import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pmp_english/model/translation/translation.dart';

import '../../global_app_state.dart';
import '../../services/supabase_service.dart';

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
                  'user_id': GlobalAppState().currentUser.id,
                });
              }
              await supabase.from('translation_days_users_relation').insert({
                'user_id': GlobalAppState().currentUser.id,
                'translation_day_id': completedDayId,
              });
              emit(const TranslateUserAnswerState.onSuccess());
            },
          );
        } catch (e) {
          debugPrint('Load Translate User Answers error: ${e.toString()}');
          emit(TranslateUserAnswerState.error(e.toString()));
        }
      },
    );
  }
}
