// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listening_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ListeningQuestionImpl _$$ListeningQuestionImplFromJson(
        Map<String, dynamic> json) =>
    _$ListeningQuestionImpl(
      start: (json['start'] as num).toDouble(),
      end: (json['end'] as num).toDouble(),
      text: json['text'] as String,
      question: json['question'] as String,
      answers: (json['answers'] as List<dynamic>)
          .map((e) => AnswerOption.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ListeningQuestionImplToJson(
        _$ListeningQuestionImpl instance) =>
    <String, dynamic>{
      'start': instance.start,
      'end': instance.end,
      'text': instance.text,
      'question': instance.question,
      'answers': instance.answers,
    };

_$AnswerOptionImpl _$$AnswerOptionImplFromJson(Map<String, dynamic> json) =>
    _$AnswerOptionImpl(
      answer: json['answer'] as String,
      correct: json['correct'] as bool,
    );

Map<String, dynamic> _$$AnswerOptionImplToJson(_$AnswerOptionImpl instance) =>
    <String, dynamic>{
      'answer': instance.answer,
      'correct': instance.correct,
    };
