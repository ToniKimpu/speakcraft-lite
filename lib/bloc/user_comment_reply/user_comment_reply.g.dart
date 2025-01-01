// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_comment_reply.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserCommentReplyImpl _$$UserCommentReplyImplFromJson(
        Map<String, dynamic> json) =>
    _$UserCommentReplyImpl(
      id: (json['id'] as num).toInt(),
      reply: json['reply'] as String,
      userId: (json['user_id'] as num).toInt(),
      patternUserCommentId: (json['pattern_user_comment_id'] as num).toInt(),
      user: json['users'] == null
          ? null
          : AppUser.fromJson(json['users'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$UserCommentReplyImplToJson(
        _$UserCommentReplyImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'reply': instance.reply,
      'user_id': instance.userId,
      'pattern_user_comment_id': instance.patternUserCommentId,
      'users': instance.user,
    };
