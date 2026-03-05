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
    @JsonKey(name: 'listening_category_id') int? listeningCategoryId,
  }) = _Listening;

  factory Listening.fromJson(Map<String, dynamic> json) =>
      _$ListeningFromJson(json);
}
