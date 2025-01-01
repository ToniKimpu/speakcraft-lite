// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExerciseImpl _$$ExerciseImplFromJson(Map<String, dynamic> json) =>
    _$ExerciseImpl(
      id: (json['id'] as num).toInt(),
      exerciseName: json['exercise_name'] as String,
      dayId: (json['day_id'] as num).toInt(),
      isComplete: json['isComplete'] as bool,
    );

Map<String, dynamic> _$$ExerciseImplToJson(_$ExerciseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'exercise_name': instance.exerciseName,
      'day_id': instance.dayId,
      'isComplete': instance.isComplete,
    };
