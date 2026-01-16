// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sentence_explanation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SentenceExplanationImpl _$$SentenceExplanationImplFromJson(
        Map<String, dynamic> json) =>
    _$SentenceExplanationImpl(
      id: (json['id'] as num).toInt(),
      start: (json['start'] as num).toDouble(),
      end: (json['end'] as num).toDouble(),
      english: json['english'] as String,
      burmese: json['burmese'] as String,
      explanationUrl: json['explanation_url'] as String,
    );

Map<String, dynamic> _$$SentenceExplanationImplToJson(
        _$SentenceExplanationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'start': instance.start,
      'end': instance.end,
      'english': instance.english,
      'burmese': instance.burmese,
      'explanation_url': instance.explanationUrl,
    };
