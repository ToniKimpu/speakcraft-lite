// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pattern.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PatternImpl _$$PatternImplFromJson(Map<String, dynamic> json) =>
    _$PatternImpl(
      id: (json['id'] as num?)?.toInt(),
      pattern: json['pattern'] as String,
      title: json['title'] as String?,
      description: json['description'] as String?,
      subjectVerbAgreement: json['subject_verb_agreement'] as String?,
      audioPath: json['audio_path'] as String?,
      lessonId: (json['lesson_id'] as num?)?.toInt(),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      patternExamples: (json['pattern_examples'] as List<dynamic>?)
          ?.map((e) => PatternExample.fromJson(e as Map<String, dynamic>))
          .toList(),
      hasComment: _hasCommentByUser(json['pattern_user_comments'] as List?),
    );

Map<String, dynamic> _$$PatternImplToJson(_$PatternImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pattern': instance.pattern,
      'title': instance.title,
      'description': instance.description,
      'subject_verb_agreement': instance.subjectVerbAgreement,
      'audio_path': instance.audioPath,
      'lesson_id': instance.lessonId,
      'created_at': instance.createdAt?.toIso8601String(),
      'pattern_examples': instance.patternExamples,
      'pattern_user_comments': instance.hasComment,
    };
