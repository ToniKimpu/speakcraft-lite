import 'package:freezed_annotation/freezed_annotation.dart';

part 'listening_question.freezed.dart';
part 'listening_question.g.dart';

@freezed
class ListeningQuestion with _$ListeningQuestion {
  const factory ListeningQuestion({
    required double start,
    required double end,
    required String text,
    required String question,
    required List<AnswerOption> answers,
  }) = _ListeningQuestion;

  factory ListeningQuestion.fromJson(Map<String, dynamic> json) =>
      _$ListeningQuestionFromJson(json);
}

@freezed
class AnswerOption with _$AnswerOption {
  const factory AnswerOption({
    required String answer,
    required bool correct,
  }) = _AnswerOption;

  factory AnswerOption.fromJson(Map<String, dynamic> json) =>
      _$AnswerOptionFromJson(json);
}
