// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'exercise.freezed.dart';
part 'exercise.g.dart';

@freezed
class Exercise with _$Exercise {
  const factory Exercise({
    required int id,
    @JsonKey(name: 'exercise_name') required String exerciseName,
    @JsonKey(name: 'day_id') required int dayId,
    required bool isComplete,
  }) = _Exercise;

  factory Exercise.fromJson(Map<String, dynamic> json) =>
      _$ExerciseFromJson(json);

  factory Exercise.fromJson1(Map<String, dynamic> json) => Exercise(
        id: json['id'] as int,
        exerciseName: json['exercise_name'] as String,
        dayId: json['day_id'] as int,
        isComplete: json['exercises_users_relation'].isNotEmpty,
      );

  static List<Exercise> fromJsonList1(List<dynamic> jsonList) {
    return jsonList.map((json) => Exercise.fromJson1(json)).toList();
  }
}
