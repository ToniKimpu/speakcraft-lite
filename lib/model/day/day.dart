// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pmp_english/model/exercise/exercise.dart';
import 'package:pmp_english/model/lesson/lesson.dart';

part 'day.freezed.dart';
part 'day.g.dart';

@freezed
class Day with _$Day {
  const factory Day({
    required int id,
    @JsonKey(name: 'order_number') required int orderNumber,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'lessons') required List<Lesson> lessons,
    @JsonKey(name: 'exercises') required List<Exercise> exercises,
    required bool isComplete,
  }) = _Day;

  factory Day.fromJson(Map<String, dynamic> json) => _$DayFromJson(json);
  static List<Day> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Day.fromJson(json)).toList();
  }

  factory Day.fromJson1(Map<String, dynamic> json) {
    return Day(
      id: json['id'] as int,
      orderNumber: json['order_number'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      isComplete: json['days_users_relation'].isNotEmpty,
      lessons: Lesson.fromJsonList(json['lessons'] as List<dynamic>?),
      exercises: Exercise.fromJsonList1(json['exercises'] as List<dynamic>?),
    );
  }
}
