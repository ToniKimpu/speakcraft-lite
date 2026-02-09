// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pmp_english/model/pattern_vocabulary/pattern_vocabulary.dart';

part 'pattern_exercise.freezed.dart';
part 'pattern_exercise.g.dart';

@freezed
class PatternExercise with _$PatternExercise {
  const factory PatternExercise({
    @JsonKey(name: 'pattern_exercise_id') required int id,
    @JsonKey(name: 'burmese_text') required String burmeseText,
    @JsonKey(name: 'english_text') required String englishText,
    @JsonKey(name: 'audio_path') String? audioPath,
    @JsonKey(name: 'pattern_id') int? patternId,
    String? pattern,
    @JsonKey(name: 'vocabularies')
    required List<PatternVocabulary> vocabularies,
    String? words,
    String? userAnswer,
  }) = _PatternExercise;

  factory PatternExercise.fromJson(Map<String, dynamic> json) =>
      _$PatternExerciseFromJson(json);
  static List<PatternExercise> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => PatternExercise.fromJson(json)).toList();
  }

  factory PatternExercise.fromJsonWithUserAnswer(Map<String, dynamic> json) {
    // Extract user answer from nested array if available
    final userAnswers = json['exercise_user_answers'] as List<dynamic>?;
    final userAnswer = userAnswers != null && userAnswers.isNotEmpty
        ? userAnswers.first['answer'] as String?
        : null;

    return PatternExercise(
      id: json['id'] as int,
      burmeseText: json['burmese_text'] as String,
      englishText: json['english_text'] as String,
      audioPath: json['audio_path'] as String?,
      userAnswer: userAnswer,
      vocabularies: <PatternVocabulary>[],
    );
  }
  factory PatternExercise.fromJsonWithVocabularies(Map<String, dynamic> json) {
    final vocabList = json['vocabularies'] as List<dynamic>?;
    final vocabularies = vocabList != null
        ? vocabList
            .map((item) =>
                PatternVocabulary.fromJson(item['pattern_vocabularies']))
            .toList()
        : <PatternVocabulary>[];

    return PatternExercise(
      id: json['id'] as int,
      burmeseText: json['burmese_text'] as String,
      englishText: json['english_text'] as String,
      audioPath: json['audio_path'] as String?,
      userAnswer: null, // if unused
      vocabularies: vocabularies,
    );
  }
}
