// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_comment_reply.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserCommentReply _$UserCommentReplyFromJson(Map<String, dynamic> json) {
  return _UserCommentReply.fromJson(json);
}

/// @nodoc
mixin _$UserCommentReply {
  int get id => throw _privateConstructorUsedError;
  String get reply => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  int get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'pattern_user_comment_id')
  int get patternUserCommentId => throw _privateConstructorUsedError;
  @JsonKey(name: 'users')
  AppUser? get user => throw _privateConstructorUsedError;

  /// Serializes this UserCommentReply to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserCommentReply
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserCommentReplyCopyWith<UserCommentReply> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCommentReplyCopyWith<$Res> {
  factory $UserCommentReplyCopyWith(
          UserCommentReply value, $Res Function(UserCommentReply) then) =
      _$UserCommentReplyCopyWithImpl<$Res, UserCommentReply>;
  @useResult
  $Res call(
      {int id,
      String reply,
      @JsonKey(name: 'user_id') int userId,
      @JsonKey(name: 'pattern_user_comment_id') int patternUserCommentId,
      @JsonKey(name: 'users') AppUser? user});

  $AppUserCopyWith<$Res>? get user;
}

/// @nodoc
class _$UserCommentReplyCopyWithImpl<$Res, $Val extends UserCommentReply>
    implements $UserCommentReplyCopyWith<$Res> {
  _$UserCommentReplyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserCommentReply
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? reply = null,
    Object? userId = null,
    Object? patternUserCommentId = null,
    Object? user = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      reply: null == reply
          ? _value.reply
          : reply // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      patternUserCommentId: null == patternUserCommentId
          ? _value.patternUserCommentId
          : patternUserCommentId // ignore: cast_nullable_to_non_nullable
              as int,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as AppUser?,
    ) as $Val);
  }

  /// Create a copy of UserCommentReply
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AppUserCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $AppUserCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserCommentReplyImplCopyWith<$Res>
    implements $UserCommentReplyCopyWith<$Res> {
  factory _$$UserCommentReplyImplCopyWith(_$UserCommentReplyImpl value,
          $Res Function(_$UserCommentReplyImpl) then) =
      __$$UserCommentReplyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String reply,
      @JsonKey(name: 'user_id') int userId,
      @JsonKey(name: 'pattern_user_comment_id') int patternUserCommentId,
      @JsonKey(name: 'users') AppUser? user});

  @override
  $AppUserCopyWith<$Res>? get user;
}

/// @nodoc
class __$$UserCommentReplyImplCopyWithImpl<$Res>
    extends _$UserCommentReplyCopyWithImpl<$Res, _$UserCommentReplyImpl>
    implements _$$UserCommentReplyImplCopyWith<$Res> {
  __$$UserCommentReplyImplCopyWithImpl(_$UserCommentReplyImpl _value,
      $Res Function(_$UserCommentReplyImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserCommentReply
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? reply = null,
    Object? userId = null,
    Object? patternUserCommentId = null,
    Object? user = freezed,
  }) {
    return _then(_$UserCommentReplyImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      reply: null == reply
          ? _value.reply
          : reply // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      patternUserCommentId: null == patternUserCommentId
          ? _value.patternUserCommentId
          : patternUserCommentId // ignore: cast_nullable_to_non_nullable
              as int,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as AppUser?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserCommentReplyImpl implements _UserCommentReply {
  const _$UserCommentReplyImpl(
      {required this.id,
      required this.reply,
      @JsonKey(name: 'user_id') required this.userId,
      @JsonKey(name: 'pattern_user_comment_id')
      required this.patternUserCommentId,
      @JsonKey(name: 'users') this.user});

  factory _$UserCommentReplyImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserCommentReplyImplFromJson(json);

  @override
  final int id;
  @override
  final String reply;
  @override
  @JsonKey(name: 'user_id')
  final int userId;
  @override
  @JsonKey(name: 'pattern_user_comment_id')
  final int patternUserCommentId;
  @override
  @JsonKey(name: 'users')
  final AppUser? user;

  @override
  String toString() {
    return 'UserCommentReply(id: $id, reply: $reply, userId: $userId, patternUserCommentId: $patternUserCommentId, user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserCommentReplyImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.reply, reply) || other.reply == reply) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.patternUserCommentId, patternUserCommentId) ||
                other.patternUserCommentId == patternUserCommentId) &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, reply, userId, patternUserCommentId, user);

  /// Create a copy of UserCommentReply
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserCommentReplyImplCopyWith<_$UserCommentReplyImpl> get copyWith =>
      __$$UserCommentReplyImplCopyWithImpl<_$UserCommentReplyImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserCommentReplyImplToJson(
      this,
    );
  }
}

abstract class _UserCommentReply implements UserCommentReply {
  const factory _UserCommentReply(
      {required final int id,
      required final String reply,
      @JsonKey(name: 'user_id') required final int userId,
      @JsonKey(name: 'pattern_user_comment_id')
      required final int patternUserCommentId,
      @JsonKey(name: 'users') final AppUser? user}) = _$UserCommentReplyImpl;

  factory _UserCommentReply.fromJson(Map<String, dynamic> json) =
      _$UserCommentReplyImpl.fromJson;

  @override
  int get id;
  @override
  String get reply;
  @override
  @JsonKey(name: 'user_id')
  int get userId;
  @override
  @JsonKey(name: 'pattern_user_comment_id')
  int get patternUserCommentId;
  @override
  @JsonKey(name: 'users')
  AppUser? get user;

  /// Create a copy of UserCommentReply
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserCommentReplyImplCopyWith<_$UserCommentReplyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
