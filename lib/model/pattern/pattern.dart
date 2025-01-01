// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import '../pattern_example/pattern_example.dart';

part 'pattern.freezed.dart';
part 'pattern.g.dart';

@freezed
class Pattern with _$Pattern {
  const factory Pattern({
    int? id,
    required String pattern,
    String? title,
    String? description,
    @JsonKey(name: 'audio_path') String? audioPath,
    @JsonKey(name: 'lesson_id') int? lessonId,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'pattern_examples')
    required List<PatternExample>? patternExamples,
    @JsonKey(
      name: 'pattern_user_comments',
      fromJson: _hasCommentByUser,
    )
    bool? hasComment,
  }) = _Pattern;

  factory Pattern.fromJson(Map<String, dynamic> json) =>
      _$PatternFromJson(json);

  static List<Pattern> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Pattern.fromJson(json)).toList();
  }
}

bool? _hasCommentByUser(List<dynamic>? list) {
  if (list == null) return null;
  if (list.isEmpty) return false;
  return true;
}
