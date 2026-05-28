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
