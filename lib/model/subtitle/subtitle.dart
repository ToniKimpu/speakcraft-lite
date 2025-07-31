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
    String? autioName,
    required Duration start,
    required Duration end,
    required double scrollPosition,
    List<SubtitleVocabulary>? vocabulary,
  }) = _Subtitle;

  factory Subtitle.fromJson(Map<String, dynamic> json) =>
      _$SubtitleFromJson(json);
  factory Subtitle.empty() => const Subtitle(
        id: null,
        english: '',
        burmese: null,
        description: null,
        autioName: null,
        start: Duration.zero,
        end: Duration.zero,
        scrollPosition: 0,
        vocabulary: [],
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
      (autioName?.isEmpty ?? true) &&
      start == Duration.zero &&
      end == Duration.zero &&
      (vocabulary == null || vocabulary!.isEmpty);

  bool get isNotEmpty => !isEmpty;
}
