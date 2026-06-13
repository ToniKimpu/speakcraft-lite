// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_speaking_topic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DailySpeakingTopicImpl _$$DailySpeakingTopicImplFromJson(
        Map<String, dynamic> json) =>
    _$DailySpeakingTopicImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      promptEn: json['prompt_en'] as String,
      promptMm: json['prompt_mm'] as String,
      difficulty:
          $enumDecodeNullable(_$TopicDifficultyEnumMap, json['difficulty']) ??
              TopicDifficulty.beginner,
      durationTargetSeconds:
          (json['duration_target_seconds'] as num?)?.toInt() ?? 180,
      vocabulary: (json['vocabulary'] as List<dynamic>?)
              ?.map((e) => TopicVocabItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <TopicVocabItem>[],
      targetPhrases: (json['target_phrases'] as List<dynamic>?)
              ?.map(
                  (e) => TopicTargetPhrase.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <TopicTargetPhrase>[],
      outline: (json['outline'] as List<dynamic>?)
              ?.map((e) => TopicOutlineStep.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <TopicOutlineStep>[],
      grammarPatterns: (json['grammar_patterns'] as List<dynamic>?)
              ?.map((e) =>
                  TopicGrammarPattern.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <TopicGrammarPattern>[],
      commonMistakes: (json['common_mistakes'] as List<dynamic>?)
              ?.map(
                  (e) => TopicCommonMistake.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <TopicCommonMistake>[],
      exampleAnswerEn: json['example_answer_en'] as String? ?? '',
      exampleAnswerMm: json['example_answer_mm'] as String? ?? '',
      warmupQuestions: (json['warmup_questions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const <String>[],
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$DailySpeakingTopicImplToJson(
        _$DailySpeakingTopicImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'prompt_en': instance.promptEn,
      'prompt_mm': instance.promptMm,
      'difficulty': _$TopicDifficultyEnumMap[instance.difficulty]!,
      'duration_target_seconds': instance.durationTargetSeconds,
      'vocabulary': instance.vocabulary,
      'target_phrases': instance.targetPhrases,
      'outline': instance.outline,
      'grammar_patterns': instance.grammarPatterns,
      'common_mistakes': instance.commonMistakes,
      'example_answer_en': instance.exampleAnswerEn,
      'example_answer_mm': instance.exampleAnswerMm,
      'warmup_questions': instance.warmupQuestions,
      'tags': instance.tags,
      'created_at': instance.createdAt?.toIso8601String(),
    };

const _$TopicDifficultyEnumMap = {
  TopicDifficulty.beginner: 'beginner',
  TopicDifficulty.intermediate: 'intermediate',
  TopicDifficulty.advanced: 'advanced',
};

_$TopicVocabItemImpl _$$TopicVocabItemImplFromJson(Map<String, dynamic> json) =>
    _$TopicVocabItemImpl(
      term: json['term'] as String,
      definitionMm: json['definition_mm'] as String,
      exampleEn: json['example_en'] as String,
      related: (json['related'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
    );

Map<String, dynamic> _$$TopicVocabItemImplToJson(
        _$TopicVocabItemImpl instance) =>
    <String, dynamic>{
      'term': instance.term,
      'definition_mm': instance.definitionMm,
      'example_en': instance.exampleEn,
      'related': instance.related,
    };

_$TopicOutlineStepImpl _$$TopicOutlineStepImplFromJson(
        Map<String, dynamic> json) =>
    _$TopicOutlineStepImpl(
      pointEn: json['point_en'] as String,
      pointMm: json['point_mm'] as String? ?? '',
      starterEn: json['starter_en'] as String? ?? '',
    );

Map<String, dynamic> _$$TopicOutlineStepImplToJson(
        _$TopicOutlineStepImpl instance) =>
    <String, dynamic>{
      'point_en': instance.pointEn,
      'point_mm': instance.pointMm,
      'starter_en': instance.starterEn,
    };

_$TopicGrammarPatternImpl _$$TopicGrammarPatternImplFromJson(
        Map<String, dynamic> json) =>
    _$TopicGrammarPatternImpl(
      patternEn: json['pattern_en'] as String,
      exampleEn: json['example_en'] as String? ?? '',
      noteMm: json['note_mm'] as String? ?? '',
    );

Map<String, dynamic> _$$TopicGrammarPatternImplToJson(
        _$TopicGrammarPatternImpl instance) =>
    <String, dynamic>{
      'pattern_en': instance.patternEn,
      'example_en': instance.exampleEn,
      'note_mm': instance.noteMm,
    };

_$TopicCommonMistakeImpl _$$TopicCommonMistakeImplFromJson(
        Map<String, dynamic> json) =>
    _$TopicCommonMistakeImpl(
      avoidEn: json['avoid_en'] as String,
      useEn: json['use_en'] as String,
      noteMm: json['note_mm'] as String? ?? '',
    );

Map<String, dynamic> _$$TopicCommonMistakeImplToJson(
        _$TopicCommonMistakeImpl instance) =>
    <String, dynamic>{
      'avoid_en': instance.avoidEn,
      'use_en': instance.useEn,
      'note_mm': instance.noteMm,
    };

_$TopicTargetPhraseImpl _$$TopicTargetPhraseImplFromJson(
        Map<String, dynamic> json) =>
    _$TopicTargetPhraseImpl(
      phraseEn: json['phrase_en'] as String,
      translationMm: json['translation_mm'] as String,
    );

Map<String, dynamic> _$$TopicTargetPhraseImplToJson(
        _$TopicTargetPhraseImpl instance) =>
    <String, dynamic>{
      'phrase_en': instance.phraseEn,
      'translation_mm': instance.translationMm,
    };
