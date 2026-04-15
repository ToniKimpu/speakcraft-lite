import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pmp_english/model/vocabulary/vocabulary.dart';

part 'saved_vocabulary_word.freezed.dart';
part 'saved_vocabulary_word.g.dart';

@freezed
class SavedVocabularyWord with _$SavedVocabularyWord {
  const SavedVocabularyWord._();

  const factory SavedVocabularyWord({
    int? id,
    required String word,
    @Default('') String pos,
    @Default('') String ipa,
    @Default('') String definitionEn,
    @Default('') String definitionMy,
    @Default('[]') String examplesJson,
    String? sourceYoutubeId,
    String? sourceSentence,
    required DateTime savedAt,
  }) = _SavedVocabularyWord;

  factory SavedVocabularyWord.fromJson(Map<String, dynamic> json) =>
      _$SavedVocabularyWordFromJson(json);

  /// Decode the stored [examplesJson] blob into typed `VocabularyExample`s.
  List<VocabularyExample> get examples {
    if (examplesJson.isEmpty) return const [];
    final raw = jsonDecode(examplesJson);
    if (raw is! List) return const [];
    return raw
        .map((e) => VocabularyExample.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
