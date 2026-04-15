// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vocabulary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SentenceVocabularyImpl _$$SentenceVocabularyImplFromJson(
        Map<String, dynamic> json) =>
    _$SentenceVocabularyImpl(
      sentenceId: (json['sentence_id'] as num).toInt(),
      words: (json['words'] as List<dynamic>?)
              ?.map((e) => VocabularyWord.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <VocabularyWord>[],
    );

Map<String, dynamic> _$$SentenceVocabularyImplToJson(
        _$SentenceVocabularyImpl instance) =>
    <String, dynamic>{
      'sentence_id': instance.sentenceId,
      'words': instance.words,
    };

_$VocabularyWordImpl _$$VocabularyWordImplFromJson(Map<String, dynamic> json) =>
    _$VocabularyWordImpl(
      word: json['word'] as String,
      pos: json['pos'] as String? ?? '',
      ipa: json['ipa'] as String? ?? '',
      definitionEn: json['definition_en'] as String? ?? '',
      definitionMy: json['definition_my'] as String? ?? '',
      examples: (json['examples'] as List<dynamic>?)
              ?.map(
                  (e) => VocabularyExample.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <VocabularyExample>[],
    );

Map<String, dynamic> _$$VocabularyWordImplToJson(
        _$VocabularyWordImpl instance) =>
    <String, dynamic>{
      'word': instance.word,
      'pos': instance.pos,
      'ipa': instance.ipa,
      'definition_en': instance.definitionEn,
      'definition_my': instance.definitionMy,
      'examples': instance.examples,
    };

_$VocabularyExampleImpl _$$VocabularyExampleImplFromJson(
        Map<String, dynamic> json) =>
    _$VocabularyExampleImpl(
      english: json['english'] as String? ?? '',
      burmese: json['burmese'] as String? ?? '',
    );

Map<String, dynamic> _$$VocabularyExampleImplToJson(
        _$VocabularyExampleImpl instance) =>
    <String, dynamic>{
      'english': instance.english,
      'burmese': instance.burmese,
    };
