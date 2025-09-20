// ignore_for_file: invalid_annotation_target

import 'package:flutter/foundation.dart' show debugPrint;
import 'package:freezed_annotation/freezed_annotation.dart';

import '../pattern_vocabulary/pattern_vocabulary.dart';

part 'pattern_example.freezed.dart';
part 'pattern_example.g.dart';

@freezed
class PatternExample with _$PatternExample {
  const factory PatternExample({
    required int id,
    @JsonKey(name: 'english_text') required String englishText,
    @JsonKey(name: 'burmese_text') String? burmeseText,
    @JsonKey(name: 'pattern_id') required int patternId,
    @JsonKey(name: 'start_at') required int startAt,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'vocabularies', fromJson: _vocabulariesFromJson)
    List<PatternVocabulary>? vocabularies,
  }) = _PatternExample;

  factory PatternExample.fromJson(Map<String, dynamic> json) =>
      _$PatternExampleFromJson(json);
}

List<PatternVocabulary> _vocabulariesFromJson(List<dynamic>? vocabList) {
  if (vocabList == null || vocabList.isEmpty) {
    return <PatternVocabulary>[];
  }
  debugPrint("_fromJsonWithVocabularies: ${vocabList.length} vocabularies");
  final vocabularies = vocabList
      .map((item) => PatternVocabulary.fromJson(item['pattern_vocabularies']))
      .toList();
  return vocabularies;
}
