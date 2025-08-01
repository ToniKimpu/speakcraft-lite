// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'subtitle.freezed.dart';
part 'subtitle.g.dart';

@freezed
class Subtitle with _$Subtitle {
  const factory Subtitle({
    int? id,
    required String english,
    String? burmese,
    String? description,
    @Default("") required String audioName,
    required Duration start,
    required Duration end,
    required double scrollPosition,
    @Default(<SubtitleVocabulary>[]) List<SubtitleVocabulary>? vocabularies,
  }) = _Subtitle;

  factory Subtitle.fromJson(Map<String, dynamic> json) =>
      _$SubtitleFromJson(json);
  factory Subtitle.empty() => const Subtitle(
        id: null,
        english: '',
        burmese: null,
        description: null,
        audioName: "",
        start: Duration.zero,
        end: Duration.zero,
        scrollPosition: 0,
        vocabularies: [],
      );
}

@freezed
class SubtitleVocabulary with _$SubtitleVocabulary {
  const factory SubtitleVocabulary({
    int? id,
    required String english,
    required String burmese,
    String? explanation,
  }) = _SubtitleVocabulary;

  factory SubtitleVocabulary.fromJson(Map<String, dynamic> json) =>
      _$SubtitleVocabularyFromJson(json);
}

extension SubtitleX on Subtitle {
  bool get isEmpty =>
      english.isEmpty &&
      (burmese?.isEmpty ?? true) &&
      (description?.isEmpty ?? true) &&
      (audioName.isEmpty) &&
      start == Duration.zero &&
      end == Duration.zero &&
      (vocabularies == null || vocabularies!.isEmpty);

  bool get isNotEmpty => !isEmpty;
}
