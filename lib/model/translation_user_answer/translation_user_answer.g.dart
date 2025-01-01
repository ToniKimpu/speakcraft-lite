// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translation_user_answer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TranslationUserAnswerImpl _$$TranslationUserAnswerImplFromJson(
        Map<String, dynamic> json) =>
    _$TranslationUserAnswerImpl(
      id: (json['id'] as num).toInt(),
      answer: json['answer'] as String,
      userId: (json['user_id'] as num).toInt(),
      translationId: (json['translation_id'] as num).toInt(),
    );

Map<String, dynamic> _$$TranslationUserAnswerImplToJson(
        _$TranslationUserAnswerImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'answer': instance.answer,
      'user_id': instance.userId,
      'translation_id': instance.translationId,
    };
