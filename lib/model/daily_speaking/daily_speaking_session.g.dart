// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_speaking_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DailySpeakingSessionImpl _$$DailySpeakingSessionImplFromJson(
        Map<String, dynamic> json) =>
    _$DailySpeakingSessionImpl(
      id: (json['id'] as num).toInt(),
      topicId: json['topicId'] as String?,
      onRamp: json['onRamp'] as String,
      inputMode: json['inputMode'] as String,
      inputText: json['inputText'] as String?,
      feedback: DailySpeakingFeedback.fromJson(
          json['feedback'] as Map<String, dynamic>),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      audioPath: json['audioPath'] as String?,
      topicAttemptId: json['topicAttemptId'] as String?,
      revisionNumber: (json['revisionNumber'] as num?)?.toInt() ?? 1,
      topicJson: json['topicJson'] as String?,
    );

Map<String, dynamic> _$$DailySpeakingSessionImplToJson(
        _$DailySpeakingSessionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'topicId': instance.topicId,
      'onRamp': instance.onRamp,
      'inputMode': instance.inputMode,
      'inputText': instance.inputText,
      'feedback': instance.feedback,
      'createdAt': instance.createdAt?.toIso8601String(),
      'audioPath': instance.audioPath,
      'topicAttemptId': instance.topicAttemptId,
      'revisionNumber': instance.revisionNumber,
      'topicJson': instance.topicJson,
    };
