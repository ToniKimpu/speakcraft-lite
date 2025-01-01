// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import '../app_user/app_user.dart';

part 'pattern_user_comment.freezed.dart';
part 'pattern_user_comment.g.dart';

@freezed
class PatternUserComment with _$PatternUserComment {
  const factory PatternUserComment({
    int? id,
    required String comment,
    @JsonKey(name: 'user_id') required int userId,
    @JsonKey(name: 'pattern_id') required int patternId,
    @JsonKey(name: 'users') AppUser? user,
  }) = _PatternUserComment;

  factory PatternUserComment.fromJson(Map<String, dynamic> json) =>
      _$PatternUserCommentFromJson(json);
  static List<PatternUserComment> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => PatternUserComment.fromJson(json)).toList();
  }
}
