// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'daily_speaking_topic.freezed.dart';
part 'daily_speaking_topic.g.dart';

enum TopicDifficulty {
  @JsonValue('beginner')
  beginner,
  @JsonValue('intermediate')
  intermediate,
  @JsonValue('advanced')
  advanced,
}

@freezed
class DailySpeakingTopic with _$DailySpeakingTopic {
  const factory DailySpeakingTopic({
    required String id,
    required String title,
    @JsonKey(name: 'prompt_en') required String promptEn,
    @JsonKey(name: 'prompt_mm') required String promptMm,
    @Default(TopicDifficulty.beginner) TopicDifficulty difficulty,
    @JsonKey(name: 'duration_target_seconds') @Default(180)
    int durationTargetSeconds,
    @Default(<TopicVocabItem>[]) List<TopicVocabItem> vocabulary,
    @JsonKey(name: 'target_phrases') @Default(<TopicTargetPhrase>[])
    List<TopicTargetPhrase> targetPhrases,

    /// The suggested-topic "guide" fields (P3 prep page). All optional so older
    /// topics and the guided→topic mapping keep working with empty lists.
    /// `outline` is the talk's spine; `grammarPatterns` the structural backbone;
    /// `commonMistakes` Myanmar-interference fixes; `exampleAnswer*` a gated model.
    @Default(<TopicOutlineStep>[]) List<TopicOutlineStep> outline,
    @JsonKey(name: 'grammar_patterns') @Default(<TopicGrammarPattern>[])
    List<TopicGrammarPattern> grammarPatterns,
    @JsonKey(name: 'common_mistakes') @Default(<TopicCommonMistake>[])
    List<TopicCommonMistake> commonMistakes,
    @JsonKey(name: 'example_answer_en') @Default('') String exampleAnswerEn,
    @JsonKey(name: 'example_answer_mm') @Default('') String exampleAnswerMm,
    @JsonKey(name: 'warmup_questions') @Default(<String>[])
    List<String> warmupQuestions,
    @Default(<String>[]) List<String> tags,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _DailySpeakingTopic;

  factory DailySpeakingTopic.fromJson(Map<String, dynamic> json) =>
      _$DailySpeakingTopicFromJson(json);
}

@freezed
class TopicVocabItem with _$TopicVocabItem {
  const factory TopicVocabItem({
    required String term,
    @JsonKey(name: 'definition_mm') required String definitionMm,
    @JsonKey(name: 'example_en') required String exampleEn,

    /// Optional "you could also use" alternatives, shown in the vocab sheet.
    @Default(<String>[]) List<String> related,
  }) = _TopicVocabItem;

  factory TopicVocabItem.fromJson(Map<String, dynamic> json) =>
      _$TopicVocabItemFromJson(json);
}

/// One beat of the suggested-topic talk structure: what to cover at this point,
/// with an example sentence-starter to get the learner moving.
@freezed
class TopicOutlineStep with _$TopicOutlineStep {
  const factory TopicOutlineStep({
    @JsonKey(name: 'point_en') required String pointEn,
    @JsonKey(name: 'point_mm') @Default('') String pointMm,
    @JsonKey(name: 'starter_en') @Default('') String starterEn,
  }) = _TopicOutlineStep;

  factory TopicOutlineStep.fromJson(Map<String, dynamic> json) =>
      _$TopicOutlineStepFromJson(json);
}

/// A grammar pattern the learner can lean on (e.g. "I ended up + V-ing"), with
/// a filled example and a short Burmese note on when/how to use it.
@freezed
class TopicGrammarPattern with _$TopicGrammarPattern {
  const factory TopicGrammarPattern({
    @JsonKey(name: 'pattern_en') required String patternEn,
    @JsonKey(name: 'example_en') @Default('') String exampleEn,
    @JsonKey(name: 'note_mm') @Default('') String noteMm,
  }) = _TopicGrammarPattern;

  factory TopicGrammarPattern.fromJson(Map<String, dynamic> json) =>
      _$TopicGrammarPatternFromJson(json);
}

/// A common Myanmar-learner mistake for this topic: what to avoid, the fix, and
/// a short Burmese note explaining why.
@freezed
class TopicCommonMistake with _$TopicCommonMistake {
  const factory TopicCommonMistake({
    @JsonKey(name: 'avoid_en') required String avoidEn,
    @JsonKey(name: 'use_en') required String useEn,
    @JsonKey(name: 'note_mm') @Default('') String noteMm,
  }) = _TopicCommonMistake;

  factory TopicCommonMistake.fromJson(Map<String, dynamic> json) =>
      _$TopicCommonMistakeFromJson(json);
}

@freezed
class TopicTargetPhrase with _$TopicTargetPhrase {
  const factory TopicTargetPhrase({
    @JsonKey(name: 'phrase_en') required String phraseEn,
    @JsonKey(name: 'translation_mm') required String translationMm,
  }) = _TopicTargetPhrase;

  factory TopicTargetPhrase.fromJson(Map<String, dynamic> json) =>
      _$TopicTargetPhraseFromJson(json);
}
