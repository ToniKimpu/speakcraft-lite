// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subtitle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SubtitleImpl _$$SubtitleImplFromJson(Map<String, dynamic> json) =>
    _$SubtitleImpl(
      id: (json['id'] as num?)?.toInt(),
      english: json['english'] as String,
      burmese: json['burmese'] as String?,
      description: json['description'] as String?,
      audioName: json['audioName'] as String? ?? "",
      start: Duration(microseconds: (json['start'] as num).toInt()),
      end: Duration(microseconds: (json['end'] as num).toInt()),
      widgetHeight: (json['widgetHeight'] as num).toDouble(),
      scrollPosition: (json['scrollPosition'] as num).toDouble(),
      vocabularies: (json['vocabularies'] as List<dynamic>?)
              ?.map(
                  (e) => SubtitleVocabulary.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <SubtitleVocabulary>[],
    );

Map<String, dynamic> _$$SubtitleImplToJson(_$SubtitleImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'english': instance.english,
      'burmese': instance.burmese,
      'description': instance.description,
      'audioName': instance.audioName,
      'start': instance.start.inMicroseconds,
      'end': instance.end.inMicroseconds,
      'widgetHeight': instance.widgetHeight,
      'scrollPosition': instance.scrollPosition,
      'vocabularies': instance.vocabularies,
    };

_$SubtitleVocabularyImpl _$$SubtitleVocabularyImplFromJson(
        Map<String, dynamic> json) =>
    _$SubtitleVocabularyImpl(
      id: (json['id'] as num?)?.toInt(),
      english: json['english'] as String,
      burmese: json['burmese'] as String,
      explanation: json['explanation'] as String?,
    );

Map<String, dynamic> _$$SubtitleVocabularyImplToJson(
        _$SubtitleVocabularyImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'english': instance.english,
      'burmese': instance.burmese,
      'explanation': instance.explanation,
    };
