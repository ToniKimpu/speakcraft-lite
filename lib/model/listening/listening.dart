// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
part 'listening.freezed.dart';
part 'listening.g.dart';

@freezed
class Listening with _$Listening {
  const factory Listening({
    required int id,
    required String title,
    required String thumbnail,
    required int start,
    required int end,
    @JsonKey(name: 'mm_subtitle') required bool hasMMSubtitle,
    @JsonKey(name: 'has_vocabularies') required bool hasVocabularies,
    @JsonKey(name: 'youtube_id') required String youtubeId,
    @JsonKey(name: 'subtitle_path') @Default('') String subtitlePath,
    @JsonKey(name: 'multiple_choice_path') @Default('') String multipleChoicePath,
    @JsonKey(name: 'shadowing_path') @Default('') String shadowingPath,
    @JsonKey(name: 'record_subtitle_path') @Default('') String recordSubtitlePath,
    @JsonKey(name: 'sentence_explanation_path') @Default('') String sentenceExplanationPath,
    @JsonKey(name: 'vocabulary_path') @Default('') String vocabularyPath,
    // Per-video Key Takeaways deck (Bunny path to key_takeaways.json). Empty =
    // the Key Takeaways step is hidden for this video.
    @JsonKey(name: 'key_takeaways_path') @Default('') String keyTakeawaysPath,
    @JsonKey(name: 'listening_category_id') int? listeningCategoryId,
    // Per-video free flag (Supabase listenings.is_free). Free videos unlock all
    // features; on non-free videos free users get subtitle play only, the rest
    // is premium. Gating: isFree || currentUser.isPremiumUser.
    @JsonKey(name: 'is_free') @Default(false) bool isFree,
    // Precomputed lesson-content counts, populated by the admin at save time
    // from the referenced JSON. Drive the "what you'll get" banner; 0 = unknown
    // (banner falls back to generic copy).
    @JsonKey(name: 'sentence_count') @Default(0) int sentenceCount,
    @JsonKey(name: 'vocab_count') @Default(0) int vocabCount,
    @JsonKey(name: 'pattern_count') @Default(0) int patternCount,
  }) = _Listening;

  factory Listening.fromJson(Map<String, dynamic> json) =>
      _$ListeningFromJson(json);
}
