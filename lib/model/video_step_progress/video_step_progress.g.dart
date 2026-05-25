// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_step_progress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VideoStepProgressImpl _$$VideoStepProgressImplFromJson(
        Map<String, dynamic> json) =>
    _$VideoStepProgressImpl(
      youtubeId: json['youtubeId'] as String,
      stepKey: json['stepKey'] as String,
      state: (json['state'] as num?)?.toInt() ?? 0,
      lastOpenedAt: json['lastOpenedAt'] == null
          ? null
          : DateTime.parse(json['lastOpenedAt'] as String),
      openCount: (json['openCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$VideoStepProgressImplToJson(
        _$VideoStepProgressImpl instance) =>
    <String, dynamic>{
      'youtubeId': instance.youtubeId,
      'stepKey': instance.stepKey,
      'state': instance.state,
      'lastOpenedAt': instance.lastOpenedAt?.toIso8601String(),
      'openCount': instance.openCount,
    };
