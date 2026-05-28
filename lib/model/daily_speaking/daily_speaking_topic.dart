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
    @JsonKey(name: 'warmup_questions') @Default(<String>[])
    List<String> warmupQuestions,
    @Default(<String>[]) List<String> tags,
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
  }) = _TopicVocabItem;

  factory TopicVocabItem.fromJson(Map<String, dynamic> json) =>
      _$TopicVocabItemFromJson(json);
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
