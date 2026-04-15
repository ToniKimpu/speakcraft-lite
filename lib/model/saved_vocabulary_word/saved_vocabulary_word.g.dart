// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_vocabulary_word.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SavedVocabularyWordImpl _$$SavedVocabularyWordImplFromJson(
        Map<String, dynamic> json) =>
    _$SavedVocabularyWordImpl(
      id: (json['id'] as num?)?.toInt(),
      word: json['word'] as String,
      pos: json['pos'] as String? ?? '',
      ipa: json['ipa'] as String? ?? '',
      definitionEn: json['definitionEn'] as String? ?? '',
      definitionMy: json['definitionMy'] as String? ?? '',
      examplesJson: json['examplesJson'] as String? ?? '[]',
      sourceYoutubeId: json['sourceYoutubeId'] as String?,
      sourceSentence: json['sourceSentence'] as String?,
      savedAt: DateTime.parse(json['savedAt'] as String),
    );

Map<String, dynamic> _$$SavedVocabularyWordImplToJson(
        _$SavedVocabularyWordImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'word': instance.word,
      'pos': instance.pos,
      'ipa': instance.ipa,
      'definitionEn': instance.definitionEn,
      'definitionMy': instance.definitionMy,
      'examplesJson': instance.examplesJson,
      'sourceYoutubeId': instance.sourceYoutubeId,
      'sourceSentence': instance.sourceSentence,
      'savedAt': instance.savedAt.toIso8601String(),
    };
