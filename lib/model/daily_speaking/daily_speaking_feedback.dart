// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'daily_speaking_feedback.freezed.dart';
part 'daily_speaking_feedback.g.dart';

enum CefrLevel {
  @JsonValue('beginner')
  beginner,
  @JsonValue('elementary')
  elementary,
  @JsonValue('intermediate')
  intermediate,
  @JsonValue('upper_intermediate')
  upperIntermediate,
  @JsonValue('advanced')
  advanced,
  @JsonValue('fluent')
  fluent,
}

@freezed
class DailySpeakingFeedback with _$DailySpeakingFeedback {
  const factory DailySpeakingFeedback({
    required int score,
    @Default(CefrLevel.beginner) CefrLevel level,
    @JsonKey(name: 'inferred_topic') String? inferredTopic,
    /// The learner's words as the AI heard them. Always returned for voice
    /// sessions (Gemini already reads the audio, so the marginal token cost is
    /// small) and persisted into the session's `inputText` so the result page
    /// and history can show what was actually said. Empty on the text path,
    /// where `inputText` already holds the typed words.
    @JsonKey(name: 'transcript') @Default('') String transcript,
    @JsonKey(name: 'duration_seconds') @Default(0) int durationSeconds,
    @JsonKey(name: 'word_count') @Default(0) int wordCount,
    @JsonKey(name: 'speaking_pace_wpm') @Default(0) int speakingPaceWpm,
    @Default(<String>[]) List<String> strengths,
    @Default(<FeedbackFix>[]) List<FeedbackFix> fixes,
    @JsonKey(name: 'native_rewrite') @Default('') String nativeRewrite,
    @JsonKey(name: 'pronunciation_notes') @Default(<String>[])
    List<String> pronunciationNotes,
    @JsonKey(name: 'explanation_mm') @Default('') String explanationMm,
    @JsonKey(name: 'target_phrase_results') @Default(<TargetPhraseResult>[])
    List<TargetPhraseResult> targetPhraseResults,
    // --- Optional sections, returned only when requested via
    // `requested_sections`. All default-empty so the result page can keep
    // rendering each section iff non-empty.
    @JsonKey(name: 'grammar_patterns') @Default(<String>[])
    List<String> grammarPatterns,
    @JsonKey(name: 'interference_notes') @Default(<FeedbackFix>[])
    List<FeedbackFix> interferenceNotes,
    @JsonKey(name: 'vocab_upgrades') @Default(<VocabUpgrade>[])
    List<VocabUpgrade> vocabUpgrades,
    @Default(<String>[]) List<String> collocations,
    @Default(<IdiomSuggestion>[]) List<IdiomSuggestion> idioms,
    @JsonKey(name: 'sentence_rewrites') @Default(<SentenceRewrite>[])
    List<SentenceRewrite> sentenceRewrites,
    @JsonKey(name: 'filler_words') @Default(<FillerWord>[])
    List<FillerWord> fillerWords,
    @JsonKey(name: 'sub_scores') SubScores? subScores,
    @JsonKey(name: 'total_tokens') @Default(0) int totalTokens,
  }) = _DailySpeakingFeedback;

  factory DailySpeakingFeedback.fromJson(Map<String, dynamic> json) =>
      _$DailySpeakingFeedbackFromJson(json);
}

@freezed
class FeedbackFix with _$FeedbackFix {
  const factory FeedbackFix({
    required String original,
    required String corrected,
    @JsonKey(name: 'reason_mm') required String reasonMm,
  }) = _FeedbackFix;

  factory FeedbackFix.fromJson(Map<String, dynamic> json) =>
      _$FeedbackFixFromJson(json);
}

/// A basic word the learner used → a more precise/advanced alternative, with a
/// Burmese reason. Used by the `better_vocab` section.
@freezed
class VocabUpgrade with _$VocabUpgrade {
  const factory VocabUpgrade({
    required String original,
    required String suggestion,
    @JsonKey(name: 'reason_mm') @Default('') String reasonMm,
  }) = _VocabUpgrade;

  factory VocabUpgrade.fromJson(Map<String, dynamic> json) =>
      _$VocabUpgradeFromJson(json);
}

/// A natural idiom / phrasal verb the learner could have used, with its Burmese
/// meaning. Used by the `idioms` section.
@freezed
class IdiomSuggestion with _$IdiomSuggestion {
  const factory IdiomSuggestion({
    required String expression,
    @JsonKey(name: 'meaning_mm') @Default('') String meaningMm,
  }) = _IdiomSuggestion;

  factory IdiomSuggestion.fromJson(Map<String, dynamic> json) =>
      _$IdiomSuggestionFromJson(json);
}

/// One of the learner's sentences rewritten to sound native. Used by the
/// `sentence_rewrite` section.
@freezed
class SentenceRewrite with _$SentenceRewrite {
  const factory SentenceRewrite({
    required String original,
    required String rewrite,
  }) = _SentenceRewrite;

  factory SentenceRewrite.fromJson(Map<String, dynamic> json) =>
      _$SentenceRewriteFromJson(json);
}

/// A filler word and how many times it occurred. Voice only — `filler_words`.
@freezed
class FillerWord with _$FillerWord {
  const factory FillerWord({
    required String word,
    @Default(0) int count,
  }) = _FillerWord;

  factory FillerWord.fromJson(Map<String, dynamic> json) =>
      _$FillerWordFromJson(json);
}

/// Per-skill breakdown of the overall score (0–100 each). Used by `sub_scores`.
@freezed
class SubScores with _$SubScores {
  const factory SubScores({
    @Default(0) int grammar,
    @Default(0) int vocabulary,
    @Default(0) int fluency,
    @Default(0) int pronunciation,
  }) = _SubScores;

  factory SubScores.fromJson(Map<String, dynamic> json) =>
      _$SubScoresFromJson(json);
}

@freezed
class TargetPhraseResult with _$TargetPhraseResult {
  const factory TargetPhraseResult({
    @JsonKey(name: 'phrase_en') required String phraseEn,
    required bool used,
    @JsonKey(name: 'used_correctly') @Default(false) bool usedCorrectly,
  }) = _TargetPhraseResult;

  factory TargetPhraseResult.fromJson(Map<String, dynamic> json) =>
      _$TargetPhraseResultFromJson(json);
}
