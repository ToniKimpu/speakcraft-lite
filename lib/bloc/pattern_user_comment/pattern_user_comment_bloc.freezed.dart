// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pattern_user_comment_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PatternUserCommentEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool withLoading, int patternId) loadComments,
    required TResult Function(bool withLoading, int commentId) loadReplies,
    required TResult Function(int patternId, String comment) addComment,
    required TResult Function(int commentId, String reply) addReply,
    required TResult Function(int commentId) deleteComment,
    required TResult Function(int replyId) deleteReply,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool withLoading, int patternId)? loadComments,
    TResult? Function(bool withLoading, int commentId)? loadReplies,
    TResult? Function(int patternId, String comment)? addComment,
    TResult? Function(int commentId, String reply)? addReply,
    TResult? Function(int commentId)? deleteComment,
    TResult? Function(int replyId)? deleteReply,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool withLoading, int patternId)? loadComments,
    TResult Function(bool withLoading, int commentId)? loadReplies,
    TResult Function(int patternId, String comment)? addComment,
    TResult Function(int commentId, String reply)? addReply,
    TResult Function(int commentId)? deleteComment,
    TResult Function(int replyId)? deleteReply,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadComments value) loadComments,
    required TResult Function(_LoadReplies value) loadReplies,
    required TResult Function(_AddComment value) addComment,
    required TResult Function(_AddReply value) addReply,
    required TResult Function(_DeleteComment value) deleteComment,
    required TResult Function(_DeleteReply value) deleteReply,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadComments value)? loadComments,
    TResult? Function(_LoadReplies value)? loadReplies,
    TResult? Function(_AddComment value)? addComment,
    TResult? Function(_AddReply value)? addReply,
    TResult? Function(_DeleteComment value)? deleteComment,
    TResult? Function(_DeleteReply value)? deleteReply,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadComments value)? loadComments,
    TResult Function(_LoadReplies value)? loadReplies,
    TResult Function(_AddComment value)? addComment,
    TResult Function(_AddReply value)? addReply,
    TResult Function(_DeleteComment value)? deleteComment,
    TResult Function(_DeleteReply value)? deleteReply,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PatternUserCommentEventCopyWith<$Res> {
  factory $PatternUserCommentEventCopyWith(PatternUserCommentEvent value,
          $Res Function(PatternUserCommentEvent) then) =
      _$PatternUserCommentEventCopyWithImpl<$Res, PatternUserCommentEvent>;
}

/// @nodoc
class _$PatternUserCommentEventCopyWithImpl<$Res,
        $Val extends PatternUserCommentEvent>
    implements $PatternUserCommentEventCopyWith<$Res> {
  _$PatternUserCommentEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PatternUserCommentEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadCommentsImplCopyWith<$Res> {
  factory _$$LoadCommentsImplCopyWith(
          _$LoadCommentsImpl value, $Res Function(_$LoadCommentsImpl) then) =
      __$$LoadCommentsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool withLoading, int patternId});
}

/// @nodoc
class __$$LoadCommentsImplCopyWithImpl<$Res>
    extends _$PatternUserCommentEventCopyWithImpl<$Res, _$LoadCommentsImpl>
    implements _$$LoadCommentsImplCopyWith<$Res> {
  __$$LoadCommentsImplCopyWithImpl(
      _$LoadCommentsImpl _value, $Res Function(_$LoadCommentsImpl) _then)
      : super(_value, _then);

  /// Create a copy of PatternUserCommentEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? withLoading = null,
    Object? patternId = null,
  }) {
    return _then(_$LoadCommentsImpl(
      null == withLoading
          ? _value.withLoading
          : withLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      null == patternId
          ? _value.patternId
          : patternId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$LoadCommentsImpl with DiagnosticableTreeMixin implements _LoadComments {
  const _$LoadCommentsImpl(this.withLoading, this.patternId);

  @override
  final bool withLoading;
  @override
  final int patternId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PatternUserCommentEvent.loadComments(withLoading: $withLoading, patternId: $patternId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PatternUserCommentEvent.loadComments'))
      ..add(DiagnosticsProperty('withLoading', withLoading))
      ..add(DiagnosticsProperty('patternId', patternId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadCommentsImpl &&
            (identical(other.withLoading, withLoading) ||
                other.withLoading == withLoading) &&
            (identical(other.patternId, patternId) ||
                other.patternId == patternId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, withLoading, patternId);

  /// Create a copy of PatternUserCommentEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadCommentsImplCopyWith<_$LoadCommentsImpl> get copyWith =>
      __$$LoadCommentsImplCopyWithImpl<_$LoadCommentsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool withLoading, int patternId) loadComments,
    required TResult Function(bool withLoading, int commentId) loadReplies,
    required TResult Function(int patternId, String comment) addComment,
    required TResult Function(int commentId, String reply) addReply,
    required TResult Function(int commentId) deleteComment,
    required TResult Function(int replyId) deleteReply,
  }) {
    return loadComments(withLoading, patternId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool withLoading, int patternId)? loadComments,
    TResult? Function(bool withLoading, int commentId)? loadReplies,
    TResult? Function(int patternId, String comment)? addComment,
    TResult? Function(int commentId, String reply)? addReply,
    TResult? Function(int commentId)? deleteComment,
    TResult? Function(int replyId)? deleteReply,
  }) {
    return loadComments?.call(withLoading, patternId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool withLoading, int patternId)? loadComments,
    TResult Function(bool withLoading, int commentId)? loadReplies,
    TResult Function(int patternId, String comment)? addComment,
    TResult Function(int commentId, String reply)? addReply,
    TResult Function(int commentId)? deleteComment,
    TResult Function(int replyId)? deleteReply,
    required TResult orElse(),
  }) {
    if (loadComments != null) {
      return loadComments(withLoading, patternId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadComments value) loadComments,
    required TResult Function(_LoadReplies value) loadReplies,
    required TResult Function(_AddComment value) addComment,
    required TResult Function(_AddReply value) addReply,
    required TResult Function(_DeleteComment value) deleteComment,
    required TResult Function(_DeleteReply value) deleteReply,
  }) {
    return loadComments(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadComments value)? loadComments,
    TResult? Function(_LoadReplies value)? loadReplies,
    TResult? Function(_AddComment value)? addComment,
    TResult? Function(_AddReply value)? addReply,
    TResult? Function(_DeleteComment value)? deleteComment,
    TResult? Function(_DeleteReply value)? deleteReply,
  }) {
    return loadComments?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadComments value)? loadComments,
    TResult Function(_LoadReplies value)? loadReplies,
    TResult Function(_AddComment value)? addComment,
    TResult Function(_AddReply value)? addReply,
    TResult Function(_DeleteComment value)? deleteComment,
    TResult Function(_DeleteReply value)? deleteReply,
    required TResult orElse(),
  }) {
    if (loadComments != null) {
      return loadComments(this);
    }
    return orElse();
  }
}

abstract class _LoadComments implements PatternUserCommentEvent {
  const factory _LoadComments(final bool withLoading, final int patternId) =
      _$LoadCommentsImpl;

  bool get withLoading;
  int get patternId;

  /// Create a copy of PatternUserCommentEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadCommentsImplCopyWith<_$LoadCommentsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadRepliesImplCopyWith<$Res> {
  factory _$$LoadRepliesImplCopyWith(
          _$LoadRepliesImpl value, $Res Function(_$LoadRepliesImpl) then) =
      __$$LoadRepliesImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool withLoading, int commentId});
}

/// @nodoc
class __$$LoadRepliesImplCopyWithImpl<$Res>
    extends _$PatternUserCommentEventCopyWithImpl<$Res, _$LoadRepliesImpl>
    implements _$$LoadRepliesImplCopyWith<$Res> {
  __$$LoadRepliesImplCopyWithImpl(
      _$LoadRepliesImpl _value, $Res Function(_$LoadRepliesImpl) _then)
      : super(_value, _then);

  /// Create a copy of PatternUserCommentEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? withLoading = null,
    Object? commentId = null,
  }) {
    return _then(_$LoadRepliesImpl(
      null == withLoading
          ? _value.withLoading
          : withLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      null == commentId
          ? _value.commentId
          : commentId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$LoadRepliesImpl with DiagnosticableTreeMixin implements _LoadReplies {
  const _$LoadRepliesImpl(this.withLoading, this.commentId);

  @override
  final bool withLoading;
  @override
  final int commentId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PatternUserCommentEvent.loadReplies(withLoading: $withLoading, commentId: $commentId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PatternUserCommentEvent.loadReplies'))
      ..add(DiagnosticsProperty('withLoading', withLoading))
      ..add(DiagnosticsProperty('commentId', commentId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadRepliesImpl &&
            (identical(other.withLoading, withLoading) ||
                other.withLoading == withLoading) &&
            (identical(other.commentId, commentId) ||
                other.commentId == commentId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, withLoading, commentId);

  /// Create a copy of PatternUserCommentEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadRepliesImplCopyWith<_$LoadRepliesImpl> get copyWith =>
      __$$LoadRepliesImplCopyWithImpl<_$LoadRepliesImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool withLoading, int patternId) loadComments,
    required TResult Function(bool withLoading, int commentId) loadReplies,
    required TResult Function(int patternId, String comment) addComment,
    required TResult Function(int commentId, String reply) addReply,
    required TResult Function(int commentId) deleteComment,
    required TResult Function(int replyId) deleteReply,
  }) {
    return loadReplies(withLoading, commentId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool withLoading, int patternId)? loadComments,
    TResult? Function(bool withLoading, int commentId)? loadReplies,
    TResult? Function(int patternId, String comment)? addComment,
    TResult? Function(int commentId, String reply)? addReply,
    TResult? Function(int commentId)? deleteComment,
    TResult? Function(int replyId)? deleteReply,
  }) {
    return loadReplies?.call(withLoading, commentId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool withLoading, int patternId)? loadComments,
    TResult Function(bool withLoading, int commentId)? loadReplies,
    TResult Function(int patternId, String comment)? addComment,
    TResult Function(int commentId, String reply)? addReply,
    TResult Function(int commentId)? deleteComment,
    TResult Function(int replyId)? deleteReply,
    required TResult orElse(),
  }) {
    if (loadReplies != null) {
      return loadReplies(withLoading, commentId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadComments value) loadComments,
    required TResult Function(_LoadReplies value) loadReplies,
    required TResult Function(_AddComment value) addComment,
    required TResult Function(_AddReply value) addReply,
    required TResult Function(_DeleteComment value) deleteComment,
    required TResult Function(_DeleteReply value) deleteReply,
  }) {
    return loadReplies(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadComments value)? loadComments,
    TResult? Function(_LoadReplies value)? loadReplies,
    TResult? Function(_AddComment value)? addComment,
    TResult? Function(_AddReply value)? addReply,
    TResult? Function(_DeleteComment value)? deleteComment,
    TResult? Function(_DeleteReply value)? deleteReply,
  }) {
    return loadReplies?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadComments value)? loadComments,
    TResult Function(_LoadReplies value)? loadReplies,
    TResult Function(_AddComment value)? addComment,
    TResult Function(_AddReply value)? addReply,
    TResult Function(_DeleteComment value)? deleteComment,
    TResult Function(_DeleteReply value)? deleteReply,
    required TResult orElse(),
  }) {
    if (loadReplies != null) {
      return loadReplies(this);
    }
    return orElse();
  }
}

abstract class _LoadReplies implements PatternUserCommentEvent {
  const factory _LoadReplies(final bool withLoading, final int commentId) =
      _$LoadRepliesImpl;

  bool get withLoading;
  int get commentId;

  /// Create a copy of PatternUserCommentEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadRepliesImplCopyWith<_$LoadRepliesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AddCommentImplCopyWith<$Res> {
  factory _$$AddCommentImplCopyWith(
          _$AddCommentImpl value, $Res Function(_$AddCommentImpl) then) =
      __$$AddCommentImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int patternId, String comment});
}

/// @nodoc
class __$$AddCommentImplCopyWithImpl<$Res>
    extends _$PatternUserCommentEventCopyWithImpl<$Res, _$AddCommentImpl>
    implements _$$AddCommentImplCopyWith<$Res> {
  __$$AddCommentImplCopyWithImpl(
      _$AddCommentImpl _value, $Res Function(_$AddCommentImpl) _then)
      : super(_value, _then);

  /// Create a copy of PatternUserCommentEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? patternId = null,
    Object? comment = null,
  }) {
    return _then(_$AddCommentImpl(
      null == patternId
          ? _value.patternId
          : patternId // ignore: cast_nullable_to_non_nullable
              as int,
      null == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AddCommentImpl with DiagnosticableTreeMixin implements _AddComment {
  const _$AddCommentImpl(this.patternId, this.comment);

  @override
  final int patternId;
  @override
  final String comment;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PatternUserCommentEvent.addComment(patternId: $patternId, comment: $comment)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PatternUserCommentEvent.addComment'))
      ..add(DiagnosticsProperty('patternId', patternId))
      ..add(DiagnosticsProperty('comment', comment));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddCommentImpl &&
            (identical(other.patternId, patternId) ||
                other.patternId == patternId) &&
            (identical(other.comment, comment) || other.comment == comment));
  }

  @override
  int get hashCode => Object.hash(runtimeType, patternId, comment);

  /// Create a copy of PatternUserCommentEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddCommentImplCopyWith<_$AddCommentImpl> get copyWith =>
      __$$AddCommentImplCopyWithImpl<_$AddCommentImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool withLoading, int patternId) loadComments,
    required TResult Function(bool withLoading, int commentId) loadReplies,
    required TResult Function(int patternId, String comment) addComment,
    required TResult Function(int commentId, String reply) addReply,
    required TResult Function(int commentId) deleteComment,
    required TResult Function(int replyId) deleteReply,
  }) {
    return addComment(patternId, comment);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool withLoading, int patternId)? loadComments,
    TResult? Function(bool withLoading, int commentId)? loadReplies,
    TResult? Function(int patternId, String comment)? addComment,
    TResult? Function(int commentId, String reply)? addReply,
    TResult? Function(int commentId)? deleteComment,
    TResult? Function(int replyId)? deleteReply,
  }) {
    return addComment?.call(patternId, comment);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool withLoading, int patternId)? loadComments,
    TResult Function(bool withLoading, int commentId)? loadReplies,
    TResult Function(int patternId, String comment)? addComment,
    TResult Function(int commentId, String reply)? addReply,
    TResult Function(int commentId)? deleteComment,
    TResult Function(int replyId)? deleteReply,
    required TResult orElse(),
  }) {
    if (addComment != null) {
      return addComment(patternId, comment);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadComments value) loadComments,
    required TResult Function(_LoadReplies value) loadReplies,
    required TResult Function(_AddComment value) addComment,
    required TResult Function(_AddReply value) addReply,
    required TResult Function(_DeleteComment value) deleteComment,
    required TResult Function(_DeleteReply value) deleteReply,
  }) {
    return addComment(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadComments value)? loadComments,
    TResult? Function(_LoadReplies value)? loadReplies,
    TResult? Function(_AddComment value)? addComment,
    TResult? Function(_AddReply value)? addReply,
    TResult? Function(_DeleteComment value)? deleteComment,
    TResult? Function(_DeleteReply value)? deleteReply,
  }) {
    return addComment?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadComments value)? loadComments,
    TResult Function(_LoadReplies value)? loadReplies,
    TResult Function(_AddComment value)? addComment,
    TResult Function(_AddReply value)? addReply,
    TResult Function(_DeleteComment value)? deleteComment,
    TResult Function(_DeleteReply value)? deleteReply,
    required TResult orElse(),
  }) {
    if (addComment != null) {
      return addComment(this);
    }
    return orElse();
  }
}

abstract class _AddComment implements PatternUserCommentEvent {
  const factory _AddComment(final int patternId, final String comment) =
      _$AddCommentImpl;

  int get patternId;
  String get comment;

  /// Create a copy of PatternUserCommentEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddCommentImplCopyWith<_$AddCommentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AddReplyImplCopyWith<$Res> {
  factory _$$AddReplyImplCopyWith(
          _$AddReplyImpl value, $Res Function(_$AddReplyImpl) then) =
      __$$AddReplyImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int commentId, String reply});
}

/// @nodoc
class __$$AddReplyImplCopyWithImpl<$Res>
    extends _$PatternUserCommentEventCopyWithImpl<$Res, _$AddReplyImpl>
    implements _$$AddReplyImplCopyWith<$Res> {
  __$$AddReplyImplCopyWithImpl(
      _$AddReplyImpl _value, $Res Function(_$AddReplyImpl) _then)
      : super(_value, _then);

  /// Create a copy of PatternUserCommentEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? commentId = null,
    Object? reply = null,
  }) {
    return _then(_$AddReplyImpl(
      null == commentId
          ? _value.commentId
          : commentId // ignore: cast_nullable_to_non_nullable
              as int,
      null == reply
          ? _value.reply
          : reply // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AddReplyImpl with DiagnosticableTreeMixin implements _AddReply {
  const _$AddReplyImpl(this.commentId, this.reply);

  @override
  final int commentId;
  @override
  final String reply;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PatternUserCommentEvent.addReply(commentId: $commentId, reply: $reply)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PatternUserCommentEvent.addReply'))
      ..add(DiagnosticsProperty('commentId', commentId))
      ..add(DiagnosticsProperty('reply', reply));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddReplyImpl &&
            (identical(other.commentId, commentId) ||
                other.commentId == commentId) &&
            (identical(other.reply, reply) || other.reply == reply));
  }

  @override
  int get hashCode => Object.hash(runtimeType, commentId, reply);

  /// Create a copy of PatternUserCommentEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddReplyImplCopyWith<_$AddReplyImpl> get copyWith =>
      __$$AddReplyImplCopyWithImpl<_$AddReplyImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool withLoading, int patternId) loadComments,
    required TResult Function(bool withLoading, int commentId) loadReplies,
    required TResult Function(int patternId, String comment) addComment,
    required TResult Function(int commentId, String reply) addReply,
    required TResult Function(int commentId) deleteComment,
    required TResult Function(int replyId) deleteReply,
  }) {
    return addReply(commentId, reply);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool withLoading, int patternId)? loadComments,
    TResult? Function(bool withLoading, int commentId)? loadReplies,
    TResult? Function(int patternId, String comment)? addComment,
    TResult? Function(int commentId, String reply)? addReply,
    TResult? Function(int commentId)? deleteComment,
    TResult? Function(int replyId)? deleteReply,
  }) {
    return addReply?.call(commentId, reply);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool withLoading, int patternId)? loadComments,
    TResult Function(bool withLoading, int commentId)? loadReplies,
    TResult Function(int patternId, String comment)? addComment,
    TResult Function(int commentId, String reply)? addReply,
    TResult Function(int commentId)? deleteComment,
    TResult Function(int replyId)? deleteReply,
    required TResult orElse(),
  }) {
    if (addReply != null) {
      return addReply(commentId, reply);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadComments value) loadComments,
    required TResult Function(_LoadReplies value) loadReplies,
    required TResult Function(_AddComment value) addComment,
    required TResult Function(_AddReply value) addReply,
    required TResult Function(_DeleteComment value) deleteComment,
    required TResult Function(_DeleteReply value) deleteReply,
  }) {
    return addReply(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadComments value)? loadComments,
    TResult? Function(_LoadReplies value)? loadReplies,
    TResult? Function(_AddComment value)? addComment,
    TResult? Function(_AddReply value)? addReply,
    TResult? Function(_DeleteComment value)? deleteComment,
    TResult? Function(_DeleteReply value)? deleteReply,
  }) {
    return addReply?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadComments value)? loadComments,
    TResult Function(_LoadReplies value)? loadReplies,
    TResult Function(_AddComment value)? addComment,
    TResult Function(_AddReply value)? addReply,
    TResult Function(_DeleteComment value)? deleteComment,
    TResult Function(_DeleteReply value)? deleteReply,
    required TResult orElse(),
  }) {
    if (addReply != null) {
      return addReply(this);
    }
    return orElse();
  }
}

abstract class _AddReply implements PatternUserCommentEvent {
  const factory _AddReply(final int commentId, final String reply) =
      _$AddReplyImpl;

  int get commentId;
  String get reply;

  /// Create a copy of PatternUserCommentEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddReplyImplCopyWith<_$AddReplyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeleteCommentImplCopyWith<$Res> {
  factory _$$DeleteCommentImplCopyWith(
          _$DeleteCommentImpl value, $Res Function(_$DeleteCommentImpl) then) =
      __$$DeleteCommentImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int commentId});
}

/// @nodoc
class __$$DeleteCommentImplCopyWithImpl<$Res>
    extends _$PatternUserCommentEventCopyWithImpl<$Res, _$DeleteCommentImpl>
    implements _$$DeleteCommentImplCopyWith<$Res> {
  __$$DeleteCommentImplCopyWithImpl(
      _$DeleteCommentImpl _value, $Res Function(_$DeleteCommentImpl) _then)
      : super(_value, _then);

  /// Create a copy of PatternUserCommentEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? commentId = null,
  }) {
    return _then(_$DeleteCommentImpl(
      null == commentId
          ? _value.commentId
          : commentId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$DeleteCommentImpl
    with DiagnosticableTreeMixin
    implements _DeleteComment {
  const _$DeleteCommentImpl(this.commentId);

  @override
  final int commentId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PatternUserCommentEvent.deleteComment(commentId: $commentId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
          DiagnosticsProperty('type', 'PatternUserCommentEvent.deleteComment'))
      ..add(DiagnosticsProperty('commentId', commentId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteCommentImpl &&
            (identical(other.commentId, commentId) ||
                other.commentId == commentId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, commentId);

  /// Create a copy of PatternUserCommentEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteCommentImplCopyWith<_$DeleteCommentImpl> get copyWith =>
      __$$DeleteCommentImplCopyWithImpl<_$DeleteCommentImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool withLoading, int patternId) loadComments,
    required TResult Function(bool withLoading, int commentId) loadReplies,
    required TResult Function(int patternId, String comment) addComment,
    required TResult Function(int commentId, String reply) addReply,
    required TResult Function(int commentId) deleteComment,
    required TResult Function(int replyId) deleteReply,
  }) {
    return deleteComment(commentId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool withLoading, int patternId)? loadComments,
    TResult? Function(bool withLoading, int commentId)? loadReplies,
    TResult? Function(int patternId, String comment)? addComment,
    TResult? Function(int commentId, String reply)? addReply,
    TResult? Function(int commentId)? deleteComment,
    TResult? Function(int replyId)? deleteReply,
  }) {
    return deleteComment?.call(commentId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool withLoading, int patternId)? loadComments,
    TResult Function(bool withLoading, int commentId)? loadReplies,
    TResult Function(int patternId, String comment)? addComment,
    TResult Function(int commentId, String reply)? addReply,
    TResult Function(int commentId)? deleteComment,
    TResult Function(int replyId)? deleteReply,
    required TResult orElse(),
  }) {
    if (deleteComment != null) {
      return deleteComment(commentId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadComments value) loadComments,
    required TResult Function(_LoadReplies value) loadReplies,
    required TResult Function(_AddComment value) addComment,
    required TResult Function(_AddReply value) addReply,
    required TResult Function(_DeleteComment value) deleteComment,
    required TResult Function(_DeleteReply value) deleteReply,
  }) {
    return deleteComment(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadComments value)? loadComments,
    TResult? Function(_LoadReplies value)? loadReplies,
    TResult? Function(_AddComment value)? addComment,
    TResult? Function(_AddReply value)? addReply,
    TResult? Function(_DeleteComment value)? deleteComment,
    TResult? Function(_DeleteReply value)? deleteReply,
  }) {
    return deleteComment?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadComments value)? loadComments,
    TResult Function(_LoadReplies value)? loadReplies,
    TResult Function(_AddComment value)? addComment,
    TResult Function(_AddReply value)? addReply,
    TResult Function(_DeleteComment value)? deleteComment,
    TResult Function(_DeleteReply value)? deleteReply,
    required TResult orElse(),
  }) {
    if (deleteComment != null) {
      return deleteComment(this);
    }
    return orElse();
  }
}

abstract class _DeleteComment implements PatternUserCommentEvent {
  const factory _DeleteComment(final int commentId) = _$DeleteCommentImpl;

  int get commentId;

  /// Create a copy of PatternUserCommentEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeleteCommentImplCopyWith<_$DeleteCommentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeleteReplyImplCopyWith<$Res> {
  factory _$$DeleteReplyImplCopyWith(
          _$DeleteReplyImpl value, $Res Function(_$DeleteReplyImpl) then) =
      __$$DeleteReplyImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int replyId});
}

/// @nodoc
class __$$DeleteReplyImplCopyWithImpl<$Res>
    extends _$PatternUserCommentEventCopyWithImpl<$Res, _$DeleteReplyImpl>
    implements _$$DeleteReplyImplCopyWith<$Res> {
  __$$DeleteReplyImplCopyWithImpl(
      _$DeleteReplyImpl _value, $Res Function(_$DeleteReplyImpl) _then)
      : super(_value, _then);

  /// Create a copy of PatternUserCommentEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? replyId = null,
  }) {
    return _then(_$DeleteReplyImpl(
      null == replyId
          ? _value.replyId
          : replyId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$DeleteReplyImpl with DiagnosticableTreeMixin implements _DeleteReply {
  const _$DeleteReplyImpl(this.replyId);

  @override
  final int replyId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PatternUserCommentEvent.deleteReply(replyId: $replyId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PatternUserCommentEvent.deleteReply'))
      ..add(DiagnosticsProperty('replyId', replyId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteReplyImpl &&
            (identical(other.replyId, replyId) || other.replyId == replyId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, replyId);

  /// Create a copy of PatternUserCommentEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteReplyImplCopyWith<_$DeleteReplyImpl> get copyWith =>
      __$$DeleteReplyImplCopyWithImpl<_$DeleteReplyImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool withLoading, int patternId) loadComments,
    required TResult Function(bool withLoading, int commentId) loadReplies,
    required TResult Function(int patternId, String comment) addComment,
    required TResult Function(int commentId, String reply) addReply,
    required TResult Function(int commentId) deleteComment,
    required TResult Function(int replyId) deleteReply,
  }) {
    return deleteReply(replyId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool withLoading, int patternId)? loadComments,
    TResult? Function(bool withLoading, int commentId)? loadReplies,
    TResult? Function(int patternId, String comment)? addComment,
    TResult? Function(int commentId, String reply)? addReply,
    TResult? Function(int commentId)? deleteComment,
    TResult? Function(int replyId)? deleteReply,
  }) {
    return deleteReply?.call(replyId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool withLoading, int patternId)? loadComments,
    TResult Function(bool withLoading, int commentId)? loadReplies,
    TResult Function(int patternId, String comment)? addComment,
    TResult Function(int commentId, String reply)? addReply,
    TResult Function(int commentId)? deleteComment,
    TResult Function(int replyId)? deleteReply,
    required TResult orElse(),
  }) {
    if (deleteReply != null) {
      return deleteReply(replyId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadComments value) loadComments,
    required TResult Function(_LoadReplies value) loadReplies,
    required TResult Function(_AddComment value) addComment,
    required TResult Function(_AddReply value) addReply,
    required TResult Function(_DeleteComment value) deleteComment,
    required TResult Function(_DeleteReply value) deleteReply,
  }) {
    return deleteReply(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadComments value)? loadComments,
    TResult? Function(_LoadReplies value)? loadReplies,
    TResult? Function(_AddComment value)? addComment,
    TResult? Function(_AddReply value)? addReply,
    TResult? Function(_DeleteComment value)? deleteComment,
    TResult? Function(_DeleteReply value)? deleteReply,
  }) {
    return deleteReply?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadComments value)? loadComments,
    TResult Function(_LoadReplies value)? loadReplies,
    TResult Function(_AddComment value)? addComment,
    TResult Function(_AddReply value)? addReply,
    TResult Function(_DeleteComment value)? deleteComment,
    TResult Function(_DeleteReply value)? deleteReply,
    required TResult orElse(),
  }) {
    if (deleteReply != null) {
      return deleteReply(this);
    }
    return orElse();
  }
}

abstract class _DeleteReply implements PatternUserCommentEvent {
  const factory _DeleteReply(final int replyId) = _$DeleteReplyImpl;

  int get replyId;

  /// Create a copy of PatternUserCommentEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeleteReplyImplCopyWith<_$DeleteReplyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PatternUserCommentState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() commenting,
    required TResult Function() deleting,
    required TResult Function(List<PatternUserComment> comments) loaded,
    required TResult Function(List<UserCommentReply> replies) repliesLoaded,
    required TResult Function() addComentSuccess,
    required TResult Function() deleteCommentSuccess,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? commenting,
    TResult? Function()? deleting,
    TResult? Function(List<PatternUserComment> comments)? loaded,
    TResult? Function(List<UserCommentReply> replies)? repliesLoaded,
    TResult? Function()? addComentSuccess,
    TResult? Function()? deleteCommentSuccess,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? commenting,
    TResult Function()? deleting,
    TResult Function(List<PatternUserComment> comments)? loaded,
    TResult Function(List<UserCommentReply> replies)? repliesLoaded,
    TResult Function()? addComentSuccess,
    TResult Function()? deleteCommentSuccess,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Commenting value) commenting,
    required TResult Function(_Deleting value) deleting,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_ReplyLoaded value) repliesLoaded,
    required TResult Function(_AddCommentSuccess value) addComentSuccess,
    required TResult Function(_DeleteCommentSuccess value) deleteCommentSuccess,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Commenting value)? commenting,
    TResult? Function(_Deleting value)? deleting,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_ReplyLoaded value)? repliesLoaded,
    TResult? Function(_AddCommentSuccess value)? addComentSuccess,
    TResult? Function(_DeleteCommentSuccess value)? deleteCommentSuccess,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Commenting value)? commenting,
    TResult Function(_Deleting value)? deleting,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_ReplyLoaded value)? repliesLoaded,
    TResult Function(_AddCommentSuccess value)? addComentSuccess,
    TResult Function(_DeleteCommentSuccess value)? deleteCommentSuccess,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PatternUserCommentStateCopyWith<$Res> {
  factory $PatternUserCommentStateCopyWith(PatternUserCommentState value,
          $Res Function(PatternUserCommentState) then) =
      _$PatternUserCommentStateCopyWithImpl<$Res, PatternUserCommentState>;
}

/// @nodoc
class _$PatternUserCommentStateCopyWithImpl<$Res,
        $Val extends PatternUserCommentState>
    implements $PatternUserCommentStateCopyWith<$Res> {
  _$PatternUserCommentStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PatternUserCommentState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$PatternUserCommentStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of PatternUserCommentState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl with DiagnosticableTreeMixin implements _Initial {
  const _$InitialImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PatternUserCommentState.initial()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PatternUserCommentState.initial'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() commenting,
    required TResult Function() deleting,
    required TResult Function(List<PatternUserComment> comments) loaded,
    required TResult Function(List<UserCommentReply> replies) repliesLoaded,
    required TResult Function() addComentSuccess,
    required TResult Function() deleteCommentSuccess,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? commenting,
    TResult? Function()? deleting,
    TResult? Function(List<PatternUserComment> comments)? loaded,
    TResult? Function(List<UserCommentReply> replies)? repliesLoaded,
    TResult? Function()? addComentSuccess,
    TResult? Function()? deleteCommentSuccess,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? commenting,
    TResult Function()? deleting,
    TResult Function(List<PatternUserComment> comments)? loaded,
    TResult Function(List<UserCommentReply> replies)? repliesLoaded,
    TResult Function()? addComentSuccess,
    TResult Function()? deleteCommentSuccess,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Commenting value) commenting,
    required TResult Function(_Deleting value) deleting,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_ReplyLoaded value) repliesLoaded,
    required TResult Function(_AddCommentSuccess value) addComentSuccess,
    required TResult Function(_DeleteCommentSuccess value) deleteCommentSuccess,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Commenting value)? commenting,
    TResult? Function(_Deleting value)? deleting,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_ReplyLoaded value)? repliesLoaded,
    TResult? Function(_AddCommentSuccess value)? addComentSuccess,
    TResult? Function(_DeleteCommentSuccess value)? deleteCommentSuccess,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Commenting value)? commenting,
    TResult Function(_Deleting value)? deleting,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_ReplyLoaded value)? repliesLoaded,
    TResult Function(_AddCommentSuccess value)? addComentSuccess,
    TResult Function(_DeleteCommentSuccess value)? deleteCommentSuccess,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements PatternUserCommentState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$PatternUserCommentStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of PatternUserCommentState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl with DiagnosticableTreeMixin implements _Loading {
  const _$LoadingImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PatternUserCommentState.loading()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PatternUserCommentState.loading'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() commenting,
    required TResult Function() deleting,
    required TResult Function(List<PatternUserComment> comments) loaded,
    required TResult Function(List<UserCommentReply> replies) repliesLoaded,
    required TResult Function() addComentSuccess,
    required TResult Function() deleteCommentSuccess,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? commenting,
    TResult? Function()? deleting,
    TResult? Function(List<PatternUserComment> comments)? loaded,
    TResult? Function(List<UserCommentReply> replies)? repliesLoaded,
    TResult? Function()? addComentSuccess,
    TResult? Function()? deleteCommentSuccess,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? commenting,
    TResult Function()? deleting,
    TResult Function(List<PatternUserComment> comments)? loaded,
    TResult Function(List<UserCommentReply> replies)? repliesLoaded,
    TResult Function()? addComentSuccess,
    TResult Function()? deleteCommentSuccess,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Commenting value) commenting,
    required TResult Function(_Deleting value) deleting,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_ReplyLoaded value) repliesLoaded,
    required TResult Function(_AddCommentSuccess value) addComentSuccess,
    required TResult Function(_DeleteCommentSuccess value) deleteCommentSuccess,
    required TResult Function(_Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Commenting value)? commenting,
    TResult? Function(_Deleting value)? deleting,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_ReplyLoaded value)? repliesLoaded,
    TResult? Function(_AddCommentSuccess value)? addComentSuccess,
    TResult? Function(_DeleteCommentSuccess value)? deleteCommentSuccess,
    TResult? Function(_Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Commenting value)? commenting,
    TResult Function(_Deleting value)? deleting,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_ReplyLoaded value)? repliesLoaded,
    TResult Function(_AddCommentSuccess value)? addComentSuccess,
    TResult Function(_DeleteCommentSuccess value)? deleteCommentSuccess,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements PatternUserCommentState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$CommentingImplCopyWith<$Res> {
  factory _$$CommentingImplCopyWith(
          _$CommentingImpl value, $Res Function(_$CommentingImpl) then) =
      __$$CommentingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CommentingImplCopyWithImpl<$Res>
    extends _$PatternUserCommentStateCopyWithImpl<$Res, _$CommentingImpl>
    implements _$$CommentingImplCopyWith<$Res> {
  __$$CommentingImplCopyWithImpl(
      _$CommentingImpl _value, $Res Function(_$CommentingImpl) _then)
      : super(_value, _then);

  /// Create a copy of PatternUserCommentState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CommentingImpl with DiagnosticableTreeMixin implements _Commenting {
  const _$CommentingImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PatternUserCommentState.commenting()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PatternUserCommentState.commenting'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CommentingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() commenting,
    required TResult Function() deleting,
    required TResult Function(List<PatternUserComment> comments) loaded,
    required TResult Function(List<UserCommentReply> replies) repliesLoaded,
    required TResult Function() addComentSuccess,
    required TResult Function() deleteCommentSuccess,
    required TResult Function(String message) error,
  }) {
    return commenting();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? commenting,
    TResult? Function()? deleting,
    TResult? Function(List<PatternUserComment> comments)? loaded,
    TResult? Function(List<UserCommentReply> replies)? repliesLoaded,
    TResult? Function()? addComentSuccess,
    TResult? Function()? deleteCommentSuccess,
    TResult? Function(String message)? error,
  }) {
    return commenting?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? commenting,
    TResult Function()? deleting,
    TResult Function(List<PatternUserComment> comments)? loaded,
    TResult Function(List<UserCommentReply> replies)? repliesLoaded,
    TResult Function()? addComentSuccess,
    TResult Function()? deleteCommentSuccess,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (commenting != null) {
      return commenting();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Commenting value) commenting,
    required TResult Function(_Deleting value) deleting,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_ReplyLoaded value) repliesLoaded,
    required TResult Function(_AddCommentSuccess value) addComentSuccess,
    required TResult Function(_DeleteCommentSuccess value) deleteCommentSuccess,
    required TResult Function(_Error value) error,
  }) {
    return commenting(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Commenting value)? commenting,
    TResult? Function(_Deleting value)? deleting,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_ReplyLoaded value)? repliesLoaded,
    TResult? Function(_AddCommentSuccess value)? addComentSuccess,
    TResult? Function(_DeleteCommentSuccess value)? deleteCommentSuccess,
    TResult? Function(_Error value)? error,
  }) {
    return commenting?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Commenting value)? commenting,
    TResult Function(_Deleting value)? deleting,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_ReplyLoaded value)? repliesLoaded,
    TResult Function(_AddCommentSuccess value)? addComentSuccess,
    TResult Function(_DeleteCommentSuccess value)? deleteCommentSuccess,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (commenting != null) {
      return commenting(this);
    }
    return orElse();
  }
}

abstract class _Commenting implements PatternUserCommentState {
  const factory _Commenting() = _$CommentingImpl;
}

/// @nodoc
abstract class _$$DeletingImplCopyWith<$Res> {
  factory _$$DeletingImplCopyWith(
          _$DeletingImpl value, $Res Function(_$DeletingImpl) then) =
      __$$DeletingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DeletingImplCopyWithImpl<$Res>
    extends _$PatternUserCommentStateCopyWithImpl<$Res, _$DeletingImpl>
    implements _$$DeletingImplCopyWith<$Res> {
  __$$DeletingImplCopyWithImpl(
      _$DeletingImpl _value, $Res Function(_$DeletingImpl) _then)
      : super(_value, _then);

  /// Create a copy of PatternUserCommentState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$DeletingImpl with DiagnosticableTreeMixin implements _Deleting {
  const _$DeletingImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PatternUserCommentState.deleting()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PatternUserCommentState.deleting'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$DeletingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() commenting,
    required TResult Function() deleting,
    required TResult Function(List<PatternUserComment> comments) loaded,
    required TResult Function(List<UserCommentReply> replies) repliesLoaded,
    required TResult Function() addComentSuccess,
    required TResult Function() deleteCommentSuccess,
    required TResult Function(String message) error,
  }) {
    return deleting();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? commenting,
    TResult? Function()? deleting,
    TResult? Function(List<PatternUserComment> comments)? loaded,
    TResult? Function(List<UserCommentReply> replies)? repliesLoaded,
    TResult? Function()? addComentSuccess,
    TResult? Function()? deleteCommentSuccess,
    TResult? Function(String message)? error,
  }) {
    return deleting?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? commenting,
    TResult Function()? deleting,
    TResult Function(List<PatternUserComment> comments)? loaded,
    TResult Function(List<UserCommentReply> replies)? repliesLoaded,
    TResult Function()? addComentSuccess,
    TResult Function()? deleteCommentSuccess,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (deleting != null) {
      return deleting();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Commenting value) commenting,
    required TResult Function(_Deleting value) deleting,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_ReplyLoaded value) repliesLoaded,
    required TResult Function(_AddCommentSuccess value) addComentSuccess,
    required TResult Function(_DeleteCommentSuccess value) deleteCommentSuccess,
    required TResult Function(_Error value) error,
  }) {
    return deleting(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Commenting value)? commenting,
    TResult? Function(_Deleting value)? deleting,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_ReplyLoaded value)? repliesLoaded,
    TResult? Function(_AddCommentSuccess value)? addComentSuccess,
    TResult? Function(_DeleteCommentSuccess value)? deleteCommentSuccess,
    TResult? Function(_Error value)? error,
  }) {
    return deleting?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Commenting value)? commenting,
    TResult Function(_Deleting value)? deleting,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_ReplyLoaded value)? repliesLoaded,
    TResult Function(_AddCommentSuccess value)? addComentSuccess,
    TResult Function(_DeleteCommentSuccess value)? deleteCommentSuccess,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (deleting != null) {
      return deleting(this);
    }
    return orElse();
  }
}

abstract class _Deleting implements PatternUserCommentState {
  const factory _Deleting() = _$DeletingImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<PatternUserComment> comments});
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$PatternUserCommentStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of PatternUserCommentState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? comments = null,
  }) {
    return _then(_$LoadedImpl(
      null == comments
          ? _value._comments
          : comments // ignore: cast_nullable_to_non_nullable
              as List<PatternUserComment>,
    ));
  }
}

/// @nodoc

class _$LoadedImpl with DiagnosticableTreeMixin implements _Loaded {
  const _$LoadedImpl(final List<PatternUserComment> comments)
      : _comments = comments;

  final List<PatternUserComment> _comments;
  @override
  List<PatternUserComment> get comments {
    if (_comments is EqualUnmodifiableListView) return _comments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_comments);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PatternUserCommentState.loaded(comments: $comments)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PatternUserCommentState.loaded'))
      ..add(DiagnosticsProperty('comments', comments));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            const DeepCollectionEquality().equals(other._comments, _comments));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_comments));

  /// Create a copy of PatternUserCommentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      __$$LoadedImplCopyWithImpl<_$LoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() commenting,
    required TResult Function() deleting,
    required TResult Function(List<PatternUserComment> comments) loaded,
    required TResult Function(List<UserCommentReply> replies) repliesLoaded,
    required TResult Function() addComentSuccess,
    required TResult Function() deleteCommentSuccess,
    required TResult Function(String message) error,
  }) {
    return loaded(comments);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? commenting,
    TResult? Function()? deleting,
    TResult? Function(List<PatternUserComment> comments)? loaded,
    TResult? Function(List<UserCommentReply> replies)? repliesLoaded,
    TResult? Function()? addComentSuccess,
    TResult? Function()? deleteCommentSuccess,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(comments);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? commenting,
    TResult Function()? deleting,
    TResult Function(List<PatternUserComment> comments)? loaded,
    TResult Function(List<UserCommentReply> replies)? repliesLoaded,
    TResult Function()? addComentSuccess,
    TResult Function()? deleteCommentSuccess,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(comments);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Commenting value) commenting,
    required TResult Function(_Deleting value) deleting,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_ReplyLoaded value) repliesLoaded,
    required TResult Function(_AddCommentSuccess value) addComentSuccess,
    required TResult Function(_DeleteCommentSuccess value) deleteCommentSuccess,
    required TResult Function(_Error value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Commenting value)? commenting,
    TResult? Function(_Deleting value)? deleting,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_ReplyLoaded value)? repliesLoaded,
    TResult? Function(_AddCommentSuccess value)? addComentSuccess,
    TResult? Function(_DeleteCommentSuccess value)? deleteCommentSuccess,
    TResult? Function(_Error value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Commenting value)? commenting,
    TResult Function(_Deleting value)? deleting,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_ReplyLoaded value)? repliesLoaded,
    TResult Function(_AddCommentSuccess value)? addComentSuccess,
    TResult Function(_DeleteCommentSuccess value)? deleteCommentSuccess,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded implements PatternUserCommentState {
  const factory _Loaded(final List<PatternUserComment> comments) = _$LoadedImpl;

  List<PatternUserComment> get comments;

  /// Create a copy of PatternUserCommentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ReplyLoadedImplCopyWith<$Res> {
  factory _$$ReplyLoadedImplCopyWith(
          _$ReplyLoadedImpl value, $Res Function(_$ReplyLoadedImpl) then) =
      __$$ReplyLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<UserCommentReply> replies});
}

/// @nodoc
class __$$ReplyLoadedImplCopyWithImpl<$Res>
    extends _$PatternUserCommentStateCopyWithImpl<$Res, _$ReplyLoadedImpl>
    implements _$$ReplyLoadedImplCopyWith<$Res> {
  __$$ReplyLoadedImplCopyWithImpl(
      _$ReplyLoadedImpl _value, $Res Function(_$ReplyLoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of PatternUserCommentState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? replies = null,
  }) {
    return _then(_$ReplyLoadedImpl(
      null == replies
          ? _value._replies
          : replies // ignore: cast_nullable_to_non_nullable
              as List<UserCommentReply>,
    ));
  }
}

/// @nodoc

class _$ReplyLoadedImpl with DiagnosticableTreeMixin implements _ReplyLoaded {
  const _$ReplyLoadedImpl(final List<UserCommentReply> replies)
      : _replies = replies;

  final List<UserCommentReply> _replies;
  @override
  List<UserCommentReply> get replies {
    if (_replies is EqualUnmodifiableListView) return _replies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_replies);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PatternUserCommentState.repliesLoaded(replies: $replies)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
          DiagnosticsProperty('type', 'PatternUserCommentState.repliesLoaded'))
      ..add(DiagnosticsProperty('replies', replies));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReplyLoadedImpl &&
            const DeepCollectionEquality().equals(other._replies, _replies));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_replies));

  /// Create a copy of PatternUserCommentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReplyLoadedImplCopyWith<_$ReplyLoadedImpl> get copyWith =>
      __$$ReplyLoadedImplCopyWithImpl<_$ReplyLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() commenting,
    required TResult Function() deleting,
    required TResult Function(List<PatternUserComment> comments) loaded,
    required TResult Function(List<UserCommentReply> replies) repliesLoaded,
    required TResult Function() addComentSuccess,
    required TResult Function() deleteCommentSuccess,
    required TResult Function(String message) error,
  }) {
    return repliesLoaded(replies);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? commenting,
    TResult? Function()? deleting,
    TResult? Function(List<PatternUserComment> comments)? loaded,
    TResult? Function(List<UserCommentReply> replies)? repliesLoaded,
    TResult? Function()? addComentSuccess,
    TResult? Function()? deleteCommentSuccess,
    TResult? Function(String message)? error,
  }) {
    return repliesLoaded?.call(replies);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? commenting,
    TResult Function()? deleting,
    TResult Function(List<PatternUserComment> comments)? loaded,
    TResult Function(List<UserCommentReply> replies)? repliesLoaded,
    TResult Function()? addComentSuccess,
    TResult Function()? deleteCommentSuccess,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (repliesLoaded != null) {
      return repliesLoaded(replies);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Commenting value) commenting,
    required TResult Function(_Deleting value) deleting,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_ReplyLoaded value) repliesLoaded,
    required TResult Function(_AddCommentSuccess value) addComentSuccess,
    required TResult Function(_DeleteCommentSuccess value) deleteCommentSuccess,
    required TResult Function(_Error value) error,
  }) {
    return repliesLoaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Commenting value)? commenting,
    TResult? Function(_Deleting value)? deleting,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_ReplyLoaded value)? repliesLoaded,
    TResult? Function(_AddCommentSuccess value)? addComentSuccess,
    TResult? Function(_DeleteCommentSuccess value)? deleteCommentSuccess,
    TResult? Function(_Error value)? error,
  }) {
    return repliesLoaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Commenting value)? commenting,
    TResult Function(_Deleting value)? deleting,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_ReplyLoaded value)? repliesLoaded,
    TResult Function(_AddCommentSuccess value)? addComentSuccess,
    TResult Function(_DeleteCommentSuccess value)? deleteCommentSuccess,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (repliesLoaded != null) {
      return repliesLoaded(this);
    }
    return orElse();
  }
}

abstract class _ReplyLoaded implements PatternUserCommentState {
  const factory _ReplyLoaded(final List<UserCommentReply> replies) =
      _$ReplyLoadedImpl;

  List<UserCommentReply> get replies;

  /// Create a copy of PatternUserCommentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReplyLoadedImplCopyWith<_$ReplyLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AddCommentSuccessImplCopyWith<$Res> {
  factory _$$AddCommentSuccessImplCopyWith(_$AddCommentSuccessImpl value,
          $Res Function(_$AddCommentSuccessImpl) then) =
      __$$AddCommentSuccessImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AddCommentSuccessImplCopyWithImpl<$Res>
    extends _$PatternUserCommentStateCopyWithImpl<$Res, _$AddCommentSuccessImpl>
    implements _$$AddCommentSuccessImplCopyWith<$Res> {
  __$$AddCommentSuccessImplCopyWithImpl(_$AddCommentSuccessImpl _value,
      $Res Function(_$AddCommentSuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of PatternUserCommentState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AddCommentSuccessImpl
    with DiagnosticableTreeMixin
    implements _AddCommentSuccess {
  const _$AddCommentSuccessImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PatternUserCommentState.addComentSuccess()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty(
          'type', 'PatternUserCommentState.addComentSuccess'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AddCommentSuccessImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() commenting,
    required TResult Function() deleting,
    required TResult Function(List<PatternUserComment> comments) loaded,
    required TResult Function(List<UserCommentReply> replies) repliesLoaded,
    required TResult Function() addComentSuccess,
    required TResult Function() deleteCommentSuccess,
    required TResult Function(String message) error,
  }) {
    return addComentSuccess();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? commenting,
    TResult? Function()? deleting,
    TResult? Function(List<PatternUserComment> comments)? loaded,
    TResult? Function(List<UserCommentReply> replies)? repliesLoaded,
    TResult? Function()? addComentSuccess,
    TResult? Function()? deleteCommentSuccess,
    TResult? Function(String message)? error,
  }) {
    return addComentSuccess?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? commenting,
    TResult Function()? deleting,
    TResult Function(List<PatternUserComment> comments)? loaded,
    TResult Function(List<UserCommentReply> replies)? repliesLoaded,
    TResult Function()? addComentSuccess,
    TResult Function()? deleteCommentSuccess,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (addComentSuccess != null) {
      return addComentSuccess();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Commenting value) commenting,
    required TResult Function(_Deleting value) deleting,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_ReplyLoaded value) repliesLoaded,
    required TResult Function(_AddCommentSuccess value) addComentSuccess,
    required TResult Function(_DeleteCommentSuccess value) deleteCommentSuccess,
    required TResult Function(_Error value) error,
  }) {
    return addComentSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Commenting value)? commenting,
    TResult? Function(_Deleting value)? deleting,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_ReplyLoaded value)? repliesLoaded,
    TResult? Function(_AddCommentSuccess value)? addComentSuccess,
    TResult? Function(_DeleteCommentSuccess value)? deleteCommentSuccess,
    TResult? Function(_Error value)? error,
  }) {
    return addComentSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Commenting value)? commenting,
    TResult Function(_Deleting value)? deleting,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_ReplyLoaded value)? repliesLoaded,
    TResult Function(_AddCommentSuccess value)? addComentSuccess,
    TResult Function(_DeleteCommentSuccess value)? deleteCommentSuccess,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (addComentSuccess != null) {
      return addComentSuccess(this);
    }
    return orElse();
  }
}

abstract class _AddCommentSuccess implements PatternUserCommentState {
  const factory _AddCommentSuccess() = _$AddCommentSuccessImpl;
}

/// @nodoc
abstract class _$$DeleteCommentSuccessImplCopyWith<$Res> {
  factory _$$DeleteCommentSuccessImplCopyWith(_$DeleteCommentSuccessImpl value,
          $Res Function(_$DeleteCommentSuccessImpl) then) =
      __$$DeleteCommentSuccessImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DeleteCommentSuccessImplCopyWithImpl<$Res>
    extends _$PatternUserCommentStateCopyWithImpl<$Res,
        _$DeleteCommentSuccessImpl>
    implements _$$DeleteCommentSuccessImplCopyWith<$Res> {
  __$$DeleteCommentSuccessImplCopyWithImpl(_$DeleteCommentSuccessImpl _value,
      $Res Function(_$DeleteCommentSuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of PatternUserCommentState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$DeleteCommentSuccessImpl
    with DiagnosticableTreeMixin
    implements _DeleteCommentSuccess {
  const _$DeleteCommentSuccessImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PatternUserCommentState.deleteCommentSuccess()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty(
          'type', 'PatternUserCommentState.deleteCommentSuccess'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteCommentSuccessImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() commenting,
    required TResult Function() deleting,
    required TResult Function(List<PatternUserComment> comments) loaded,
    required TResult Function(List<UserCommentReply> replies) repliesLoaded,
    required TResult Function() addComentSuccess,
    required TResult Function() deleteCommentSuccess,
    required TResult Function(String message) error,
  }) {
    return deleteCommentSuccess();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? commenting,
    TResult? Function()? deleting,
    TResult? Function(List<PatternUserComment> comments)? loaded,
    TResult? Function(List<UserCommentReply> replies)? repliesLoaded,
    TResult? Function()? addComentSuccess,
    TResult? Function()? deleteCommentSuccess,
    TResult? Function(String message)? error,
  }) {
    return deleteCommentSuccess?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? commenting,
    TResult Function()? deleting,
    TResult Function(List<PatternUserComment> comments)? loaded,
    TResult Function(List<UserCommentReply> replies)? repliesLoaded,
    TResult Function()? addComentSuccess,
    TResult Function()? deleteCommentSuccess,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (deleteCommentSuccess != null) {
      return deleteCommentSuccess();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Commenting value) commenting,
    required TResult Function(_Deleting value) deleting,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_ReplyLoaded value) repliesLoaded,
    required TResult Function(_AddCommentSuccess value) addComentSuccess,
    required TResult Function(_DeleteCommentSuccess value) deleteCommentSuccess,
    required TResult Function(_Error value) error,
  }) {
    return deleteCommentSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Commenting value)? commenting,
    TResult? Function(_Deleting value)? deleting,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_ReplyLoaded value)? repliesLoaded,
    TResult? Function(_AddCommentSuccess value)? addComentSuccess,
    TResult? Function(_DeleteCommentSuccess value)? deleteCommentSuccess,
    TResult? Function(_Error value)? error,
  }) {
    return deleteCommentSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Commenting value)? commenting,
    TResult Function(_Deleting value)? deleting,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_ReplyLoaded value)? repliesLoaded,
    TResult Function(_AddCommentSuccess value)? addComentSuccess,
    TResult Function(_DeleteCommentSuccess value)? deleteCommentSuccess,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (deleteCommentSuccess != null) {
      return deleteCommentSuccess(this);
    }
    return orElse();
  }
}

abstract class _DeleteCommentSuccess implements PatternUserCommentState {
  const factory _DeleteCommentSuccess() = _$DeleteCommentSuccessImpl;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$PatternUserCommentStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of PatternUserCommentState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ErrorImpl with DiagnosticableTreeMixin implements _Error {
  const _$ErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PatternUserCommentState.error(message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PatternUserCommentState.error'))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of PatternUserCommentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() commenting,
    required TResult Function() deleting,
    required TResult Function(List<PatternUserComment> comments) loaded,
    required TResult Function(List<UserCommentReply> replies) repliesLoaded,
    required TResult Function() addComentSuccess,
    required TResult Function() deleteCommentSuccess,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? commenting,
    TResult? Function()? deleting,
    TResult? Function(List<PatternUserComment> comments)? loaded,
    TResult? Function(List<UserCommentReply> replies)? repliesLoaded,
    TResult? Function()? addComentSuccess,
    TResult? Function()? deleteCommentSuccess,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? commenting,
    TResult Function()? deleting,
    TResult Function(List<PatternUserComment> comments)? loaded,
    TResult Function(List<UserCommentReply> replies)? repliesLoaded,
    TResult Function()? addComentSuccess,
    TResult Function()? deleteCommentSuccess,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Commenting value) commenting,
    required TResult Function(_Deleting value) deleting,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_ReplyLoaded value) repliesLoaded,
    required TResult Function(_AddCommentSuccess value) addComentSuccess,
    required TResult Function(_DeleteCommentSuccess value) deleteCommentSuccess,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Commenting value)? commenting,
    TResult? Function(_Deleting value)? deleting,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_ReplyLoaded value)? repliesLoaded,
    TResult? Function(_AddCommentSuccess value)? addComentSuccess,
    TResult? Function(_DeleteCommentSuccess value)? deleteCommentSuccess,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Commenting value)? commenting,
    TResult Function(_Deleting value)? deleting,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_ReplyLoaded value)? repliesLoaded,
    TResult Function(_AddCommentSuccess value)? addComentSuccess,
    TResult Function(_DeleteCommentSuccess value)? deleteCommentSuccess,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements PatternUserCommentState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;

  /// Create a copy of PatternUserCommentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
