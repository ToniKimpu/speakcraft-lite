// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_speaking_feedback.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DailySpeakingFeedbackImpl _$$DailySpeakingFeedbackImplFromJson(
        Map<String, dynamic> json) =>
    _$DailySpeakingFeedbackImpl(
      score: (json['score'] as num).toInt(),
      level: $enumDecodeNullable(_$CefrLevelEnumMap, json['level']) ??
          CefrLevel.beginner,
      inferredTopic: json['inferred_topic'] as String?,
      durationSeconds: (json['duration_seconds'] as num?)?.toInt() ?? 0,
      wordCount: (json['word_count'] as num?)?.toInt() ?? 0,
      speakingPaceWpm: (json['speaking_pace_wpm'] as num?)?.toInt() ?? 0,
      strengths: (json['strengths'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      fixes: (json['fixes'] as List<dynamic>?)
              ?.map((e) => FeedbackFix.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <FeedbackFix>[],
      nativeRewrite: json['native_rewrite'] as String? ?? '',
      pronunciationNotes: (json['pronunciation_notes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      explanationMm: json['explanation_mm'] as String? ?? '',
      targetPhraseResults: (json['target_phrase_results'] as List<dynamic>?)
              ?.map(
                  (e) => TargetPhraseResult.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <TargetPhraseResult>[],
      totalTokens: (json['total_tokens'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$DailySpeakingFeedbackImplToJson(
        _$DailySpeakingFeedbackImpl instance) =>
    <String, dynamic>{
      'score': instance.score,
      'level': _$CefrLevelEnumMap[instance.level]!,
      'inferred_topic': instance.inferredTopic,
      'duration_seconds': instance.durationSeconds,
      'word_count': instance.wordCount,
      'speaking_pace_wpm': instance.speakingPaceWpm,
      'strengths': instance.strengths,
      'fixes': instance.fixes,
      'native_rewrite': instance.nativeRewrite,
      'pronunciation_notes': instance.pronunciationNotes,
      'explanation_mm': instance.explanationMm,
      'target_phrase_results': instance.targetPhraseResults,
      'total_tokens': instance.totalTokens,
    };

const _$CefrLevelEnumMap = {
  CefrLevel.beginner: 'beginner',
  CefrLevel.elementary: 'elementary',
  CefrLevel.intermediate: 'intermediate',
  CefrLevel.upperIntermediate: 'upper_intermediate',
  CefrLevel.advanced: 'advanced',
  CefrLevel.fluent: 'fluent',
};

_$FeedbackFixImpl _$$FeedbackFixImplFromJson(Map<String, dynamic> json) =>
    _$FeedbackFixImpl(
      original: json['original'] as String,
      corrected: json['corrected'] as String,
      reasonMm: json['reason_mm'] as String,
    );

Map<String, dynamic> _$$FeedbackFixImplToJson(_$FeedbackFixImpl instance) =>
    <String, dynamic>{
      'original': instance.original,
      'corrected': instance.corrected,
      'reason_mm': instance.reasonMm,
    };

_$TargetPhraseResultImpl _$$TargetPhraseResultImplFromJson(
        Map<String, dynamic> json) =>
    _$TargetPhraseResultImpl(
      phraseEn: json['phrase_en'] as String,
      used: json['used'] as bool,
      usedCorrectly: json['used_correctly'] as bool? ?? false,
    );

Map<String, dynamic> _$$TargetPhraseResultImplToJson(
        _$TargetPhraseResultImpl instance) =>
    <String, dynamic>{
      'phrase_en': instance.phraseEn,
      'used': instance.used,
      'used_correctly': instance.usedCorrectly,
    };
