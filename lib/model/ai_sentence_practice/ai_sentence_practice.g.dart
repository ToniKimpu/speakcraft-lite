// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_sentence_practice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AiSentencePracticeImpl _$$AiSentencePracticeImplFromJson(
        Map<String, dynamic> json) =>
    _$AiSentencePracticeImpl(
      id: (json['id'] as num).toInt(),
      inputSentence: json['input_sentence'] as String,
      correctedSentence: json['corrected_sentence'] as String?,
      explanation: json['explanation'] as String?,
      totalTokensUsed: (json['total_tokens_used'] as num).toInt(),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$AiSentencePracticeImplToJson(
        _$AiSentencePracticeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'input_sentence': instance.inputSentence,
      'corrected_sentence': instance.correctedSentence,
      'explanation': instance.explanation,
      'total_tokens_used': instance.totalTokensUsed,
      'created_at': instance.createdAt?.toIso8601String(),
    };
