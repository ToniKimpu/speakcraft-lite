// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listening.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ListeningImpl _$$ListeningImplFromJson(Map<String, dynamic> json) =>
    _$ListeningImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      thumbnail: json['thumbnail'] as String,
      start: (json['start'] as num).toInt(),
      end: (json['end'] as num).toInt(),
      hasMMSubtitle: json['mm_subtitle'] as bool,
      hasVocabularies: json['has_vocabularies'] as bool,
      youtubeId: json['youtube_id'] as String,
      subtitlePath: json['subtitle_path'] as String? ?? '',
      multipleChoicePath: json['multiple_choice_path'] as String? ?? '',
      shadowingPath: json['shadowing_path'] as String? ?? '',
      recordSubtitlePath: json['record_subtitle_path'] as String? ?? '',
      sentenceExplanationPath:
          json['sentence_explanation_path'] as String? ?? '',
      vocabularyPath: json['vocabulary_path'] as String? ?? '',
      keyTakeawaysPath: json['key_takeaways_path'] as String? ?? '',
      listeningCategoryId: (json['listening_category_id'] as num?)?.toInt(),
      importId: json['import_id'] as String? ?? '',
      isFree: json['is_free'] as bool? ?? false,
      sentenceCount: (json['sentence_count'] as num?)?.toInt() ?? 0,
      vocabCount: (json['vocab_count'] as num?)?.toInt() ?? 0,
      patternCount: (json['pattern_count'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$ListeningImplToJson(_$ListeningImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'thumbnail': instance.thumbnail,
      'start': instance.start,
      'end': instance.end,
      'mm_subtitle': instance.hasMMSubtitle,
      'has_vocabularies': instance.hasVocabularies,
      'youtube_id': instance.youtubeId,
      'subtitle_path': instance.subtitlePath,
      'multiple_choice_path': instance.multipleChoicePath,
      'shadowing_path': instance.shadowingPath,
      'record_subtitle_path': instance.recordSubtitlePath,
      'sentence_explanation_path': instance.sentenceExplanationPath,
      'vocabulary_path': instance.vocabularyPath,
      'key_takeaways_path': instance.keyTakeawaysPath,
      'listening_category_id': instance.listeningCategoryId,
      'import_id': instance.importId,
      'is_free': instance.isFree,
      'sentence_count': instance.sentenceCount,
      'vocab_count': instance.vocabCount,
      'pattern_count': instance.patternCount,
    };
