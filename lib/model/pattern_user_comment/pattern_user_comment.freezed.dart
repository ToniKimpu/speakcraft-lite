// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pattern_user_comment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PatternUserComment _$PatternUserCommentFromJson(Map<String, dynamic> json) {
  return _PatternUserComment.fromJson(json);
}

/// @nodoc
mixin _$PatternUserComment {
  int? get id => throw _privateConstructorUsedError;
  String get comment => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  int get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'pattern_id')
  int get patternId => throw _privateConstructorUsedError;
  @JsonKey(name: 'users')
  AppUser? get user => throw _privateConstructorUsedError;

  /// Serializes this PatternUserComment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PatternUserComment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PatternUserCommentCopyWith<PatternUserComment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PatternUserCommentCopyWith<$Res> {
  factory $PatternUserCommentCopyWith(
          PatternUserComment value, $Res Function(PatternUserComment) then) =
      _$PatternUserCommentCopyWithImpl<$Res, PatternUserComment>;
  @useResult
  $Res call(
      {int? id,
      String comment,
      @JsonKey(name: 'user_id') int userId,
      @JsonKey(name: 'pattern_id') int patternId,
      @JsonKey(name: 'users') AppUser? user});

  $AppUserCopyWith<$Res>? get user;
}

/// @nodoc
class _$PatternUserCommentCopyWithImpl<$Res, $Val extends PatternUserComment>
    implements $PatternUserCommentCopyWith<$Res> {
  _$PatternUserCommentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PatternUserComment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? comment = null,
    Object? userId = null,
    Object? patternId = null,
    Object? user = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      comment: null == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      patternId: null == patternId
          ? _value.patternId
          : patternId // ignore: cast_nullable_to_non_nullable
              as int,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as AppUser?,
    ) as $Val);
  }

  /// Create a copy of PatternUserComment
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
abstract class _$$PatternUserCommentImplCopyWith<$Res>
    implements $PatternUserCommentCopyWith<$Res> {
  factory _$$PatternUserCommentImplCopyWith(_$PatternUserCommentImpl value,
          $Res Function(_$PatternUserCommentImpl) then) =
      __$$PatternUserCommentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String comment,
      @JsonKey(name: 'user_id') int userId,
      @JsonKey(name: 'pattern_id') int patternId,
      @JsonKey(name: 'users') AppUser? user});

  @override
  $AppUserCopyWith<$Res>? get user;
}

/// @nodoc
class __$$PatternUserCommentImplCopyWithImpl<$Res>
    extends _$PatternUserCommentCopyWithImpl<$Res, _$PatternUserCommentImpl>
    implements _$$PatternUserCommentImplCopyWith<$Res> {
  __$$PatternUserCommentImplCopyWithImpl(_$PatternUserCommentImpl _value,
      $Res Function(_$PatternUserCommentImpl) _then)
      : super(_value, _then);

  /// Create a copy of PatternUserComment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? comment = null,
    Object? userId = null,
    Object? patternId = null,
    Object? user = freezed,
  }) {
    return _then(_$PatternUserCommentImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      comment: null == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      patternId: null == patternId
          ? _value.patternId
          : patternId // ignore: cast_nullable_to_non_nullable
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
class _$PatternUserCommentImpl implements _PatternUserComment {
  const _$PatternUserCommentImpl(
      {this.id,
      required this.comment,
      @JsonKey(name: 'user_id') required this.userId,
      @JsonKey(name: 'pattern_id') required this.patternId,
      @JsonKey(name: 'users') this.user});

  factory _$PatternUserCommentImpl.fromJson(Map<String, dynamic> json) =>
      _$$PatternUserCommentImplFromJson(json);

  @override
  final int? id;
  @override
  final String comment;
  @override
  @JsonKey(name: 'user_id')
  final int userId;
  @override
  @JsonKey(name: 'pattern_id')
  final int patternId;
  @override
  @JsonKey(name: 'users')
  final AppUser? user;

  @override
  String toString() {
    return 'PatternUserComment(id: $id, comment: $comment, userId: $userId, patternId: $patternId, user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PatternUserCommentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.patternId, patternId) ||
                other.patternId == patternId) &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, comment, userId, patternId, user);

  /// Create a copy of PatternUserComment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PatternUserCommentImplCopyWith<_$PatternUserCommentImpl> get copyWith =>
      __$$PatternUserCommentImplCopyWithImpl<_$PatternUserCommentImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PatternUserCommentImplToJson(
      this,
    );
  }
}

abstract class _PatternUserComment implements PatternUserComment {
  const factory _PatternUserComment(
      {final int? id,
      required final String comment,
      @JsonKey(name: 'user_id') required final int userId,
      @JsonKey(name: 'pattern_id') required final int patternId,
      @JsonKey(name: 'users') final AppUser? user}) = _$PatternUserCommentImpl;

  factory _PatternUserComment.fromJson(Map<String, dynamic> json) =
      _$PatternUserCommentImpl.fromJson;

  @override
  int? get id;
  @override
  String get comment;
  @override
  @JsonKey(name: 'user_id')
  int get userId;
  @override
  @JsonKey(name: 'pattern_id')
  int get patternId;
  @override
  @JsonKey(name: 'users')
  AppUser? get user;

  /// Create a copy of PatternUserComment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PatternUserCommentImplCopyWith<_$PatternUserCommentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
