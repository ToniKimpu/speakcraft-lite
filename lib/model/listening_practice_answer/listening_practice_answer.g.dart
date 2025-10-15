// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listening_practice_answer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ListeningPracticeAnswerModelImpl _$$ListeningPracticeAnswerModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ListeningPracticeAnswerModelImpl(
      id: (json['id'] as num?)?.toInt(),
      groupId: json['groupId'] as String,
      questionId: (json['questionId'] as num).toInt(),
      userAnswer: json['userAnswer'] as String?,
      timeSpent: (json['timeSpent'] as num).toInt(),
      isCorrect: json['isCorrect'] as bool,
    );

Map<String, dynamic> _$$ListeningPracticeAnswerModelImplToJson(
        _$ListeningPracticeAnswerModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'groupId': instance.groupId,
      'questionId': instance.questionId,
      'userAnswer': instance.userAnswer,
      'timeSpent': instance.timeSpent,
      'isCorrect': instance.isCorrect,
    };
