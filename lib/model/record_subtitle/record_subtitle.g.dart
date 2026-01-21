// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record_subtitle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RecordSubtitleImpl _$$RecordSubtitleImplFromJson(Map<String, dynamic> json) =>
    _$RecordSubtitleImpl(
      id: json['id'] as String,
      start: (json['start'] as num).toDouble(),
      end: (json['end'] as num).toDouble(),
      data: (json['data'] as List<dynamic>)
          .map((e) => RecordSubtitleItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$RecordSubtitleImplToJson(
        _$RecordSubtitleImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'start': instance.start,
      'end': instance.end,
      'data': instance.data,
    };

_$RecordSubtitleItemImpl _$$RecordSubtitleItemImplFromJson(
        Map<String, dynamic> json) =>
    _$RecordSubtitleItemImpl(
      start: (json['start'] as num).toDouble(),
      end: (json['end'] as num).toDouble(),
      text: json['text'] as String,
    );

Map<String, dynamic> _$$RecordSubtitleItemImplToJson(
        _$RecordSubtitleItemImpl instance) =>
    <String, dynamic>{
      'start': instance.start,
      'end': instance.end,
      'text': instance.text,
    };
