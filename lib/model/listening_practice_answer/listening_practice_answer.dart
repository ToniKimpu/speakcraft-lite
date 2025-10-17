import 'package:freezed_annotation/freezed_annotation.dart';

part 'listening_practice_answer.freezed.dart';
part 'listening_practice_answer.g.dart';

@freezed
class ListeningPracticeAnswer with _$ListeningPracticeAnswer {
  const factory ListeningPracticeAnswer({
    int? id,
    required String groupId,
    required int questionId,
    String? userAnswer,
    required int timeSpent,
    required bool isCorrect,
    required String youtubeId,
  }) = _ListeningPracticeAnswer;

  factory ListeningPracticeAnswer.fromJson(Map<String, dynamic> json) =>
      _$ListeningPracticeAnswerFromJson(json);
}
