// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'pattern_vocabulary.freezed.dart';
part 'pattern_vocabulary.g.dart';

@freezed
class PatternVocabulary with _$PatternVocabulary {
  const factory PatternVocabulary({
    required int id,
    @JsonKey(name: 'english_text') required String englishText,
    @JsonKey(name: 'burmese_text') required String burmeseText,
    @JsonKey(name: 'audio_path') String? audioPath,
  }) = _PatternVocabulary;

  factory PatternVocabulary.fromJson(Map<String, dynamic> json) =>
      _$PatternVocabularyFromJson(json);

  static List<PatternVocabulary> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => PatternVocabulary.fromJson(json)).toList();
  }
}
