// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_recorded_sentence_audio.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserRecordedSentenceAudioImpl _$$UserRecordedSentenceAudioImplFromJson(
        Map<String, dynamic> json) =>
    _$UserRecordedSentenceAudioImpl(
      id: (json['id'] as num?)?.toInt(),
      sentenceId: json['sentenceId'] as String,
      youtubeId: json['youtubeId'] as String,
      audioPath: json['audioPath'] as String,
      audioName: json['audioName'] as String,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$UserRecordedSentenceAudioImplToJson(
        _$UserRecordedSentenceAudioImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sentenceId': instance.sentenceId,
      'youtubeId': instance.youtubeId,
      'audioPath': instance.audioPath,
      'audioName': instance.audioName,
      'created_at': instance.createdAt?.toIso8601String(),
    };
