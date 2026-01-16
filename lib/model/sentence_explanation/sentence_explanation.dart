// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'sentence_explanation.freezed.dart';
part 'sentence_explanation.g.dart';

@freezed
class SentenceExplanation with _$SentenceExplanation {
  const factory SentenceExplanation({
    required int id,
    required double start,
    required double end,
    required String english,
    required String burmese,
    @JsonKey(name: 'explanation_url') required String explanationUrl,
  }) = _SentenceExplanation;

  factory SentenceExplanation.fromJson(Map<String, dynamic> json) =>
      _$SentenceExplanationFromJson(json);
}
