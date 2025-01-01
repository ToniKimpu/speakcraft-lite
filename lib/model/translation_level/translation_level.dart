// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'translation_level.freezed.dart';
part 'translation_level.g.dart';

@freezed
class TranslationLevel with _$TranslationLevel {
  const factory TranslationLevel({
    required int id,
    @JsonKey(name: 'level_name') required String levelName,
  }) = _TranslationLevel;

  factory TranslationLevel.fromJson(Map<String, dynamic> json) =>
      _$TranslationLevelFromJson(json);
  static List<TranslationLevel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => TranslationLevel.fromJson(json)).toList();
  }
}
