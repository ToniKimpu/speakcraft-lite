// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_sentence_practice.freezed.dart';
part 'ai_sentence_practice.g.dart';

@freezed
class AiSentencePractice with _$AiSentencePractice {
  const factory AiSentencePractice({
    required int id,
    @JsonKey(name: 'input_sentence') required String inputSentence,
    @JsonKey(name: 'corrected_sentence') String? correctedSentence,
    String? explanation,
    @JsonKey(name: "total_tokens_used") required int totalTokensUsed,
    @JsonKey(name: "created_at") DateTime? createdAt,
  }) = _AiSentencePractice;

  factory AiSentencePractice.fromJson(Map<String, dynamic> json) =>
      _$AiSentencePracticeFromJson(json);
}
