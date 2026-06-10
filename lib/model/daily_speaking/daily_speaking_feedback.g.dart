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
      transcript: json['transcript'] as String? ?? '',
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
      grammarPatterns: (json['grammar_patterns'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      interferenceNotes: (json['interference_notes'] as List<dynamic>?)
              ?.map((e) => FeedbackFix.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <FeedbackFix>[],
      vocabUpgrades: (json['vocab_upgrades'] as List<dynamic>?)
              ?.map((e) => VocabUpgrade.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <VocabUpgrade>[],
      collocations: (json['collocations'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      idioms: (json['idioms'] as List<dynamic>?)
              ?.map((e) => IdiomSuggestion.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <IdiomSuggestion>[],
      sentenceRewrites: (json['sentence_rewrites'] as List<dynamic>?)
              ?.map((e) => SentenceRewrite.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <SentenceRewrite>[],
      fillerWords: (json['filler_words'] as List<dynamic>?)
              ?.map((e) => FillerWord.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <FillerWord>[],
      subScores: json['sub_scores'] == null
          ? null
          : SubScores.fromJson(json['sub_scores'] as Map<String, dynamic>),
      totalTokens: (json['total_tokens'] as num?)?.toInt() ?? 0,
      sentences: (json['sentences'] as List<dynamic>?)
              ?.map((e) => FeedbackSentence.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <FeedbackSentence>[],
    );

Map<String, dynamic> _$$DailySpeakingFeedbackImplToJson(
        _$DailySpeakingFeedbackImpl instance) =>
    <String, dynamic>{
      'score': instance.score,
      'level': _$CefrLevelEnumMap[instance.level]!,
      'inferred_topic': instance.inferredTopic,
      'transcript': instance.transcript,
      'duration_seconds': instance.durationSeconds,
      'word_count': instance.wordCount,
      'speaking_pace_wpm': instance.speakingPaceWpm,
      'strengths': instance.strengths,
      'fixes': instance.fixes,
      'native_rewrite': instance.nativeRewrite,
      'pronunciation_notes': instance.pronunciationNotes,
      'explanation_mm': instance.explanationMm,
      'target_phrase_results': instance.targetPhraseResults,
      'grammar_patterns': instance.grammarPatterns,
      'interference_notes': instance.interferenceNotes,
      'vocab_upgrades': instance.vocabUpgrades,
      'collocations': instance.collocations,
      'idioms': instance.idioms,
      'sentence_rewrites': instance.sentenceRewrites,
      'filler_words': instance.fillerWords,
      'sub_scores': instance.subScores,
      'total_tokens': instance.totalTokens,
      'sentences': instance.sentences,
    };

const _$CefrLevelEnumMap = {
  CefrLevel.beginner: 'beginner',
  CefrLevel.elementary: 'elementary',
  CefrLevel.intermediate: 'intermediate',
  CefrLevel.upperIntermediate: 'upper_intermediate',
  CefrLevel.advanced: 'advanced',
  CefrLevel.fluent: 'fluent',
};

_$FeedbackSentenceImpl _$$FeedbackSentenceImplFromJson(
        Map<String, dynamic> json) =>
    _$FeedbackSentenceImpl(
      original: json['original'] as String,
      native: json['native'] as String? ?? '',
      changed: json['changed'] as bool? ?? false,
      segments: (json['segments'] as List<dynamic>?)
              ?.map((e) => FeedbackSegment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <FeedbackSegment>[],
    );

Map<String, dynamic> _$$FeedbackSentenceImplToJson(
        _$FeedbackSentenceImpl instance) =>
    <String, dynamic>{
      'original': instance.original,
      'native': instance.native,
      'changed': instance.changed,
      'segments': instance.segments,
    };

_$FeedbackSegmentImpl _$$FeedbackSegmentImplFromJson(
        Map<String, dynamic> json) =>
    _$FeedbackSegmentImpl(
      text: json['text'] as String,
      type: $enumDecodeNullable(_$SegmentTypeEnumMap, json['type']),
      correction: json['correction'] as String? ?? '',
      reasonMm: json['reason_mm'] as String? ?? '',
      reasonEn: json['reason_en'] as String? ?? '',
    );

Map<String, dynamic> _$$FeedbackSegmentImplToJson(
        _$FeedbackSegmentImpl instance) =>
    <String, dynamic>{
      'text': instance.text,
      'type': _$SegmentTypeEnumMap[instance.type],
      'correction': instance.correction,
      'reason_mm': instance.reasonMm,
      'reason_en': instance.reasonEn,
    };

const _$SegmentTypeEnumMap = {
  SegmentType.grammar: 'grammar',
  SegmentType.vocab: 'vocab',
  SegmentType.interference: 'interference',
  SegmentType.filler: 'filler',
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

_$VocabUpgradeImpl _$$VocabUpgradeImplFromJson(Map<String, dynamic> json) =>
    _$VocabUpgradeImpl(
      original: json['original'] as String,
      suggestion: json['suggestion'] as String,
      reasonMm: json['reason_mm'] as String? ?? '',
    );

Map<String, dynamic> _$$VocabUpgradeImplToJson(_$VocabUpgradeImpl instance) =>
    <String, dynamic>{
      'original': instance.original,
      'suggestion': instance.suggestion,
      'reason_mm': instance.reasonMm,
    };

_$IdiomSuggestionImpl _$$IdiomSuggestionImplFromJson(
        Map<String, dynamic> json) =>
    _$IdiomSuggestionImpl(
      expression: json['expression'] as String,
      meaningMm: json['meaning_mm'] as String? ?? '',
    );

Map<String, dynamic> _$$IdiomSuggestionImplToJson(
        _$IdiomSuggestionImpl instance) =>
    <String, dynamic>{
      'expression': instance.expression,
      'meaning_mm': instance.meaningMm,
    };

_$SentenceRewriteImpl _$$SentenceRewriteImplFromJson(
        Map<String, dynamic> json) =>
    _$SentenceRewriteImpl(
      original: json['original'] as String,
      rewrite: json['rewrite'] as String,
    );

Map<String, dynamic> _$$SentenceRewriteImplToJson(
        _$SentenceRewriteImpl instance) =>
    <String, dynamic>{
      'original': instance.original,
      'rewrite': instance.rewrite,
    };

_$FillerWordImpl _$$FillerWordImplFromJson(Map<String, dynamic> json) =>
    _$FillerWordImpl(
      word: json['word'] as String,
      count: (json['count'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$FillerWordImplToJson(_$FillerWordImpl instance) =>
    <String, dynamic>{
      'word': instance.word,
      'count': instance.count,
    };

_$SubScoresImpl _$$SubScoresImplFromJson(Map<String, dynamic> json) =>
    _$SubScoresImpl(
      grammar: (json['grammar'] as num?)?.toInt() ?? 0,
      vocabulary: (json['vocabulary'] as num?)?.toInt() ?? 0,
      fluency: (json['fluency'] as num?)?.toInt() ?? 0,
      pronunciation: (json['pronunciation'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$SubScoresImplToJson(_$SubScoresImpl instance) =>
    <String, dynamic>{
      'grammar': instance.grammar,
      'vocabulary': instance.vocabulary,
      'fluency': instance.fluency,
      'pronunciation': instance.pronunciation,
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
