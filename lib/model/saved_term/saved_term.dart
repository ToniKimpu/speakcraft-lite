import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:speakcraft/model/vocabulary/vocabulary.dart';

part 'saved_term.freezed.dart';
part 'saved_term.g.dart';

@freezed
class SavedTerm with _$SavedTerm {
  const SavedTerm._();

  const factory SavedTerm({
    int? id,
    required String term,
    @Default('') String kind,
    String? translationMy,
    String? definitionMy,
    @Default('[]') String examplesJson,
    String? sourceTitle,
    String? sourceSentence,
    required DateTime savedAt,
  }) = _SavedTerm;

  factory SavedTerm.fromJson(Map<String, dynamic> json) =>
      _$SavedTermFromJson(json);

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
