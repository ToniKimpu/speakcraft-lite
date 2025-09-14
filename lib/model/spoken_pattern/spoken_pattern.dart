// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import '../pattern_example/pattern_example.dart';

part 'spoken_pattern.freezed.dart';
part 'spoken_pattern.g.dart';

@freezed
class SpokenPattern with _$SpokenPattern {
  const factory SpokenPattern({
    int? id,
    required String pattern,
    String? title,
    String? description,
    @JsonKey(
      name: 'subject_verb_agreements',
      fromJson: _subjectVerbAgreementFromJson,
    )
    String? subjectVerbAgreement,
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
  }) = _SpokenPattern;

  factory SpokenPattern.fromJson(Map<String, dynamic> json) =>
      _$SpokenPatternFromJson(json);

  static List<SpokenPattern> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => SpokenPattern.fromJson(json)).toList();
  }
}

String? _subjectVerbAgreementFromJson(dynamic value) {
  if (value == null) return null;

  // if it's already a String
  if (value is String) return value;

  // if it's a Map (like your example: {"name": "I => am;He,She,It => is;We,You,They => are"})
  if (value is Map<String, dynamic>) {
    return value['name'] as String?;
  }

  return null;
}

bool? _hasCommentByUser(List<dynamic>? list) {
  if (list == null) return null;
  if (list.isEmpty) return false;
  return true;
}
