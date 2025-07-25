// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

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
  }) = _PatternExample;

  factory PatternExample.fromJson(Map<String, dynamic> json) =>
      _$PatternExampleFromJson(json);
  static List<PatternExample> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => PatternExample.fromJson(json)).toList();
  }
}
