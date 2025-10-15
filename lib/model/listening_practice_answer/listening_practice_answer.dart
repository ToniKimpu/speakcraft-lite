import 'package:freezed_annotation/freezed_annotation.dart';

part 'listening_practice_answer.freezed.dart';
part 'listening_practice_answer.g.dart';

@freezed
class ListeningPracticeAnswerModel with _$ListeningPracticeAnswerModel {
  const factory ListeningPracticeAnswerModel({
    int? id,
    required String groupId,
    required int questionId,
    String? userAnswer,
    required int timeSpent,
    required bool isCorrect,
  }) = _ListeningPracticeAnswerModel;

  factory ListeningPracticeAnswerModel.fromJson(Map<String, dynamic> json) =>
      _$ListeningPracticeAnswerModelFromJson(json);
}
