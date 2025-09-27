// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pattern_example.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PatternExampleImpl _$$PatternExampleImplFromJson(Map<String, dynamic> json) =>
    _$PatternExampleImpl(
      id: (json['id'] as num).toInt(),
      englishText: json['english_text'] as String,
      burmeseText: json['burmese_text'] as String?,
      patternId: (json['pattern_id'] as num).toInt(),
      startAt: (json['start_at'] as num).toInt(),
      practicable: json['practicable'] as bool,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      vocabularies: _vocabulariesFromJson(json['vocabularies'] as List?),
    );

Map<String, dynamic> _$$PatternExampleImplToJson(
        _$PatternExampleImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'english_text': instance.englishText,
      'burmese_text': instance.burmeseText,
      'pattern_id': instance.patternId,
      'start_at': instance.startAt,
      'practicable': instance.practicable,
      'created_at': instance.createdAt?.toIso8601String(),
      'vocabularies': instance.vocabularies,
    };
