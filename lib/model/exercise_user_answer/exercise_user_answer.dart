import 'package:freezed_annotation/freezed_annotation.dart';

part 'exercise_user_answer.freezed.dart';
part 'exercise_user_answer.g.dart';

@freezed
class ExerciseUserAnswer with _$ExerciseUserAnswer {
  const factory ExerciseUserAnswer({
    required String userAnswer,
    required int patternExerciseId,
  }) = _ExerciseUserAnswer;

  factory ExerciseUserAnswer.fromJson(Map<String, dynamic> json) =>
      _$ExerciseUserAnswerFromJson(json);

  static List<ExerciseUserAnswer> fromJsonList(List<dynamic> data) {
    return data
        .map((e) => ExerciseUserAnswer.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
