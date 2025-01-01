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
    String? userAnswer,
  }) = _PatternExercise;

  factory PatternExercise.fromJson(Map<String, dynamic> json) =>
      _$PatternExerciseFromJson(json);
  static List<PatternExercise> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => PatternExercise.fromJson(json)).toList();
  }

  factory PatternExercise.fromJson1(Map<String, dynamic> json) {
    return PatternExercise(
      id: json['id'],
      burmeseText: json['burmese_text'],
      englishText: json['english_text'],
      audioPath: json['audio_path'],
      userAnswer: json['user_answer'],
      vocabularies: <PatternVocabulary>[],
    );
  }
  static List<PatternExercise> fromJsonList1(List<dynamic> jsonList) {
    return jsonList.map((json) => PatternExercise.fromJson1(json)).toList();
  }
}
