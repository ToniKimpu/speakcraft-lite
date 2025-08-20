// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'lesson.freezed.dart';
part 'lesson.g.dart';

@freezed
class Lesson with _$Lesson {
  const factory Lesson({
    required int id,
    @JsonKey(name: 'lesson_name') required String lessonName,
    @JsonKey(defaultValue: "", name: 'subtitle') String? subtitle,
    @JsonKey(name: 'day_id') required int dayId,
    @JsonKey(name: 'is_deleted') required bool isDeleted,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _Lesson;

  factory Lesson.fromJson(Map<String, dynamic> json) => _$LessonFromJson(json);
  static List<Lesson> fromJsonList(List<dynamic>? jsonList) {
    if (jsonList == null) return [];
    return jsonList.map((json) => Lesson.fromJson(json)).toList();
  }
}
