// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translation_day.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TranslationDayImpl _$$TranslationDayImplFromJson(Map<String, dynamic> json) =>
    _$TranslationDayImpl(
      id: (json['id'] as num).toInt(),
      dayName: json['day_name'] as String,
      isComplete: json['isComplete'] as bool,
    );

Map<String, dynamic> _$$TranslationDayImplToJson(
        _$TranslationDayImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'day_name': instance.dayName,
      'isComplete': instance.isComplete,
    };
