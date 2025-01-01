// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import '../pattern_vocabulary/pattern_vocabulary.dart';

part 'translation.freezed.dart';
part 'translation.g.dart';

@freezed
class Translation with _$Translation {
  const factory Translation({
    required int id,
    @JsonKey(name: 'english_text') required String englishText,
    @JsonKey(name: 'burmese_text') required String burmeseText,
    @JsonKey(name: 'words') String? words,
    @JsonKey(name: 'audio_path') String? audioPath,
    @JsonKey(name: 'vocabularies') List<PatternVocabulary>? vocabularies,
    String? userAnswer,
  }) = _Translation;

  factory Translation.fromJson(Map<String, dynamic> json) =>
      _$TranslationFromJson(json);

  static List<Translation> fromJsonList1(List<dynamic> jsonList) {
    return jsonList.map((json) => Translation.fromJson1(json)).toList();
  }

  // Factory for parsing the day object and its related information
  factory Translation.fromJson1(Map<String, dynamic> json) {
    return Translation(
      id: json['id'] as int,
      englishText: json['english_text'] as String,
      burmeseText: json['burmese_text'] as String,
      words: json['words'] as String?,
      userAnswer: (json['translation_user_answer'] as List?)
          ?.firstOrNull?['answer'] as String?,
      vocabularies: (json['vocabularies'] as List<dynamic>? ?? [])
          .map((v) => PatternVocabulary.fromJson(v as Map<String, dynamic>))
          .toList(),
    );
  }
}
