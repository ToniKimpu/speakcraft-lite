// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'vocabulary.freezed.dart';
part 'vocabulary.g.dart';

@freezed
class SentenceVocabulary with _$SentenceVocabulary {
  const factory SentenceVocabulary({
    @JsonKey(name: 'sentence_id') required int sentenceId,
    @Default(<VocabularyWord>[]) List<VocabularyWord> words,
  }) = _SentenceVocabulary;

  factory SentenceVocabulary.fromJson(Map<String, dynamic> json) =>
      _$SentenceVocabularyFromJson(json);
}

@freezed
class VocabularyWord with _$VocabularyWord {
  const factory VocabularyWord({
    required String word,
    @Default('') String pos,
    @Default('') String ipa,
    @JsonKey(name: 'definition_en') @Default('') String definitionEn,
    @JsonKey(name: 'definition_my') @Default('') String definitionMy,
    @Default(<VocabularyExample>[]) List<VocabularyExample> examples,
  }) = _VocabularyWord;

  factory VocabularyWord.fromJson(Map<String, dynamic> json) =>
      _$VocabularyWordFromJson(json);
}

@freezed
class VocabularyExample with _$VocabularyExample {
  const factory VocabularyExample({
    @Default('') String english,
    @Default('') String burmese,
  }) = _VocabularyExample;

  factory VocabularyExample.fromJson(Map<String, dynamic> json) =>
      _$VocabularyExampleFromJson(json);
}
