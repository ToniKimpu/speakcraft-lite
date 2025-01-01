// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translation_level.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TranslationLevelImpl _$$TranslationLevelImplFromJson(
        Map<String, dynamic> json) =>
    _$TranslationLevelImpl(
      id: (json['id'] as num).toInt(),
      levelName: json['level_name'] as String,
    );

Map<String, dynamic> _$$TranslationLevelImplToJson(
        _$TranslationLevelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'level_name': instance.levelName,
    };
