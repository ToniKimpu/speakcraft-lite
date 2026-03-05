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

}
