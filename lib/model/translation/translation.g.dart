// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TranslationImpl _$$TranslationImplFromJson(Map<String, dynamic> json) =>
    _$TranslationImpl(
      id: (json['id'] as num).toInt(),
      englishText: json['english_text'] as String,
      burmeseText: json['burmese_text'] as String,
      words: json['words'] as String?,
      audioPath: json['audio_path'] as String?,
      vocabularies: (json['vocabularies'] as List<dynamic>?)
          ?.map((e) => PatternVocabulary.fromJson(e as Map<String, dynamic>))
          .toList(),
      userAnswer: json['userAnswer'] as String?,
    );

Map<String, dynamic> _$$TranslationImplToJson(_$TranslationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'english_text': instance.englishText,
      'burmese_text': instance.burmeseText,
      'words': instance.words,
      'audio_path': instance.audioPath,
      'vocabularies': instance.vocabularies,
      'userAnswer': instance.userAnswer,
    };
