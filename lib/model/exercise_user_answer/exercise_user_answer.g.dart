// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_user_answer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExerciseUserAnswerImpl _$$ExerciseUserAnswerImplFromJson(
        Map<String, dynamic> json) =>
    _$ExerciseUserAnswerImpl(
      userAnswer: json['userAnswer'] as String,
      patternExerciseId: (json['patternExerciseId'] as num).toInt(),
    );

Map<String, dynamic> _$$ExerciseUserAnswerImplToJson(
        _$ExerciseUserAnswerImpl instance) =>
    <String, dynamic>{
      'userAnswer': instance.userAnswer,
      'patternExerciseId': instance.patternExerciseId,
    };
