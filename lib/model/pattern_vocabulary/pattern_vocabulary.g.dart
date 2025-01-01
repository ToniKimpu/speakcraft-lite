// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pattern_vocabulary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PatternVocabularyImpl _$$PatternVocabularyImplFromJson(
        Map<String, dynamic> json) =>
    _$PatternVocabularyImpl(
      id: (json['id'] as num).toInt(),
      englishText: json['english_text'] as String,
      burmeseText: json['burmese_text'] as String,
      audioPath: json['audio_path'] as String?,
    );

Map<String, dynamic> _$$PatternVocabularyImplToJson(
        _$PatternVocabularyImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'english_text': instance.englishText,
      'burmese_text': instance.burmeseText,
      'audio_path': instance.audioPath,
    };
