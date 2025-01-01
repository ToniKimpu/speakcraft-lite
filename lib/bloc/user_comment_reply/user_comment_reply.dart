// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../model/app_user/app_user.dart';

part 'user_comment_reply.freezed.dart';
part 'user_comment_reply.g.dart';

@freezed
class UserCommentReply with _$UserCommentReply {
  const factory UserCommentReply({
    required int id,
    required String reply,
    @JsonKey(name: 'user_id') required int userId,
    @JsonKey(name: 'pattern_user_comment_id') required int patternUserCommentId,
    @JsonKey(name: 'users') AppUser? user,
  }) = _UserCommentReply;

  factory UserCommentReply.fromJson(Map<String, dynamic> json) =>
      _$UserCommentReplyFromJson(json);
  static List<UserCommentReply> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => UserCommentReply.fromJson(json)).toList();
  }
}
