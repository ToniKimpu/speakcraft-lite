// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pattern_exercise.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PatternExerciseImpl _$$PatternExerciseImplFromJson(
        Map<String, dynamic> json) =>
    _$PatternExerciseImpl(
      id: (json['pattern_exercise_id'] as num).toInt(),
      burmeseText: json['burmese_text'] as String,
      englishText: json['english_text'] as String,
      audioPath: json['audio_path'] as String?,
      patternId: (json['pattern_id'] as num?)?.toInt(),
      pattern: json['pattern'] as String?,
      vocabularies: (json['vocabularies'] as List<dynamic>)
          .map((e) => PatternVocabulary.fromJson(e as Map<String, dynamic>))
          .toList(),
      words: json['words'] as String?,
      userAnswer: json['userAnswer'] as String?,
    );

Map<String, dynamic> _$$PatternExerciseImplToJson(
        _$PatternExerciseImpl instance) =>
    <String, dynamic>{
      'pattern_exercise_id': instance.id,
      'burmese_text': instance.burmeseText,
      'english_text': instance.englishText,
      'audio_path': instance.audioPath,
      'pattern_id': instance.patternId,
      'pattern': instance.pattern,
      'vocabularies': instance.vocabularies,
      'words': instance.words,
      'userAnswer': instance.userAnswer,
    };
