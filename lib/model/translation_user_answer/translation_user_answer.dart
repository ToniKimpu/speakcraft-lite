// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'translation_user_answer.freezed.dart';
part 'translation_user_answer.g.dart';

@freezed
class TranslationUserAnswer with _$TranslationUserAnswer {
  const factory TranslationUserAnswer({
    required int id,
    required String answer,
    @JsonKey(name: 'user_id') required int userId,
    @JsonKey(name: 'translation_id') required int translationId,
  }) = _TranslationUserAnswer;

  factory TranslationUserAnswer.fromJson(Map<String, dynamic> json) =>
      _$TranslationUserAnswerFromJson(json);
}
