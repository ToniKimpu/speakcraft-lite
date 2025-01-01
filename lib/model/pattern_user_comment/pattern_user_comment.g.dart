// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pattern_user_comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PatternUserCommentImpl _$$PatternUserCommentImplFromJson(
        Map<String, dynamic> json) =>
    _$PatternUserCommentImpl(
      id: (json['id'] as num?)?.toInt(),
      comment: json['comment'] as String,
      userId: (json['user_id'] as num).toInt(),
      patternId: (json['pattern_id'] as num).toInt(),
      user: json['users'] == null
          ? null
          : AppUser.fromJson(json['users'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PatternUserCommentImplToJson(
        _$PatternUserCommentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'comment': instance.comment,
      'user_id': instance.userId,
      'pattern_id': instance.patternId,
      'users': instance.user,
    };
