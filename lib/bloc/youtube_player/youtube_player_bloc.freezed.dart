// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'youtube_player_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$YoutubePlayerEvent {
  PlayerState get playerState => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(PlayerState playerState) updatePlayerState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(PlayerState playerState)? updatePlayerState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(PlayerState playerState)? updatePlayerState,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UpdatePlayerState value) updatePlayerState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UpdatePlayerState value)? updatePlayerState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UpdatePlayerState value)? updatePlayerState,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of YoutubePlayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $YoutubePlayerEventCopyWith<YoutubePlayerEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $YoutubePlayerEventCopyWith<$Res> {
  factory $YoutubePlayerEventCopyWith(
          YoutubePlayerEvent value, $Res Function(YoutubePlayerEvent) then) =
      _$YoutubePlayerEventCopyWithImpl<$Res, YoutubePlayerEvent>;
  @useResult
  $Res call({PlayerState playerState});
}

/// @nodoc
class _$YoutubePlayerEventCopyWithImpl<$Res, $Val extends YoutubePlayerEvent>
    implements $YoutubePlayerEventCopyWith<$Res> {
  _$YoutubePlayerEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of YoutubePlayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerState = null,
  }) {
    return _then(_value.copyWith(
      playerState: null == playerState
          ? _value.playerState
          : playerState // ignore: cast_nullable_to_non_nullable
              as PlayerState,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UpdatePlayerStateImplCopyWith<$Res>
    implements $YoutubePlayerEventCopyWith<$Res> {
  factory _$$UpdatePlayerStateImplCopyWith(_$UpdatePlayerStateImpl value,
          $Res Function(_$UpdatePlayerStateImpl) then) =
      __$$UpdatePlayerStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({PlayerState playerState});
}

/// @nodoc
class __$$UpdatePlayerStateImplCopyWithImpl<$Res>
    extends _$YoutubePlayerEventCopyWithImpl<$Res, _$UpdatePlayerStateImpl>
    implements _$$UpdatePlayerStateImplCopyWith<$Res> {
  __$$UpdatePlayerStateImplCopyWithImpl(_$UpdatePlayerStateImpl _value,
      $Res Function(_$UpdatePlayerStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of YoutubePlayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerState = null,
  }) {
    return _then(_$UpdatePlayerStateImpl(
      null == playerState
          ? _value.playerState
          : playerState // ignore: cast_nullable_to_non_nullable
              as PlayerState,
    ));
  }
}

/// @nodoc

class _$UpdatePlayerStateImpl implements _UpdatePlayerState {
  const _$UpdatePlayerStateImpl(this.playerState);

  @override
  final PlayerState playerState;

  @override
  String toString() {
    return 'YoutubePlayerEvent.updatePlayerState(playerState: $playerState)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdatePlayerStateImpl &&
            (identical(other.playerState, playerState) ||
                other.playerState == playerState));
  }

  @override
  int get hashCode => Object.hash(runtimeType, playerState);

  /// Create a copy of YoutubePlayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdatePlayerStateImplCopyWith<_$UpdatePlayerStateImpl> get copyWith =>
      __$$UpdatePlayerStateImplCopyWithImpl<_$UpdatePlayerStateImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(PlayerState playerState) updatePlayerState,
  }) {
    return updatePlayerState(playerState);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(PlayerState playerState)? updatePlayerState,
  }) {
    return updatePlayerState?.call(playerState);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(PlayerState playerState)? updatePlayerState,
    required TResult orElse(),
  }) {
    if (updatePlayerState != null) {
      return updatePlayerState(playerState);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_UpdatePlayerState value) updatePlayerState,
  }) {
    return updatePlayerState(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_UpdatePlayerState value)? updatePlayerState,
  }) {
    return updatePlayerState?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_UpdatePlayerState value)? updatePlayerState,
    required TResult orElse(),
  }) {
    if (updatePlayerState != null) {
      return updatePlayerState(this);
    }
    return orElse();
  }
}

abstract class _UpdatePlayerState implements YoutubePlayerEvent {
  const factory _UpdatePlayerState(final PlayerState playerState) =
      _$UpdatePlayerStateImpl;

  @override
  PlayerState get playerState;

  /// Create a copy of YoutubePlayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdatePlayerStateImplCopyWith<_$UpdatePlayerStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$YoutubePlayerState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(PlayerState playerState) onUpdatePlayerState,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(PlayerState playerState)? onUpdatePlayerState,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(PlayerState playerState)? onUpdatePlayerState,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_OnUpdatePlayerState value) onUpdatePlayerState,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_OnUpdatePlayerState value)? onUpdatePlayerState,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_OnUpdatePlayerState value)? onUpdatePlayerState,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $YoutubePlayerStateCopyWith<$Res> {
  factory $YoutubePlayerStateCopyWith(
          YoutubePlayerState value, $Res Function(YoutubePlayerState) then) =
      _$YoutubePlayerStateCopyWithImpl<$Res, YoutubePlayerState>;
}

/// @nodoc
class _$YoutubePlayerStateCopyWithImpl<$Res, $Val extends YoutubePlayerState>
    implements $YoutubePlayerStateCopyWith<$Res> {
  _$YoutubePlayerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of YoutubePlayerState
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
    extends _$YoutubePlayerStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of YoutubePlayerState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'YoutubePlayerState.initial()';
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
    required TResult Function(PlayerState playerState) onUpdatePlayerState,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(PlayerState playerState)? onUpdatePlayerState,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(PlayerState playerState)? onUpdatePlayerState,
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
    required TResult Function(_OnUpdatePlayerState value) onUpdatePlayerState,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_OnUpdatePlayerState value)? onUpdatePlayerState,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_OnUpdatePlayerState value)? onUpdatePlayerState,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements YoutubePlayerState {
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
    extends _$YoutubePlayerStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of YoutubePlayerState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'YoutubePlayerState.loading()';
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
    required TResult Function(PlayerState playerState) onUpdatePlayerState,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(PlayerState playerState)? onUpdatePlayerState,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(PlayerState playerState)? onUpdatePlayerState,
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
    required TResult Function(_OnUpdatePlayerState value) onUpdatePlayerState,
    required TResult Function(_Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_OnUpdatePlayerState value)? onUpdatePlayerState,
    TResult? Function(_Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_OnUpdatePlayerState value)? onUpdatePlayerState,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements YoutubePlayerState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$OnUpdatePlayerStateImplCopyWith<$Res> {
  factory _$$OnUpdatePlayerStateImplCopyWith(_$OnUpdatePlayerStateImpl value,
          $Res Function(_$OnUpdatePlayerStateImpl) then) =
      __$$OnUpdatePlayerStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({PlayerState playerState});
}

/// @nodoc
class __$$OnUpdatePlayerStateImplCopyWithImpl<$Res>
    extends _$YoutubePlayerStateCopyWithImpl<$Res, _$OnUpdatePlayerStateImpl>
    implements _$$OnUpdatePlayerStateImplCopyWith<$Res> {
  __$$OnUpdatePlayerStateImplCopyWithImpl(_$OnUpdatePlayerStateImpl _value,
      $Res Function(_$OnUpdatePlayerStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of YoutubePlayerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerState = null,
  }) {
    return _then(_$OnUpdatePlayerStateImpl(
      null == playerState
          ? _value.playerState
          : playerState // ignore: cast_nullable_to_non_nullable
              as PlayerState,
    ));
  }
}

/// @nodoc

class _$OnUpdatePlayerStateImpl implements _OnUpdatePlayerState {
  const _$OnUpdatePlayerStateImpl(this.playerState);

  @override
  final PlayerState playerState;

  @override
  String toString() {
    return 'YoutubePlayerState.onUpdatePlayerState(playerState: $playerState)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnUpdatePlayerStateImpl &&
            (identical(other.playerState, playerState) ||
                other.playerState == playerState));
  }

  @override
  int get hashCode => Object.hash(runtimeType, playerState);

  /// Create a copy of YoutubePlayerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OnUpdatePlayerStateImplCopyWith<_$OnUpdatePlayerStateImpl> get copyWith =>
      __$$OnUpdatePlayerStateImplCopyWithImpl<_$OnUpdatePlayerStateImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(PlayerState playerState) onUpdatePlayerState,
    required TResult Function(String message) error,
  }) {
    return onUpdatePlayerState(playerState);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(PlayerState playerState)? onUpdatePlayerState,
    TResult? Function(String message)? error,
  }) {
    return onUpdatePlayerState?.call(playerState);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(PlayerState playerState)? onUpdatePlayerState,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (onUpdatePlayerState != null) {
      return onUpdatePlayerState(playerState);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_OnUpdatePlayerState value) onUpdatePlayerState,
    required TResult Function(_Error value) error,
  }) {
    return onUpdatePlayerState(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_OnUpdatePlayerState value)? onUpdatePlayerState,
    TResult? Function(_Error value)? error,
  }) {
    return onUpdatePlayerState?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_OnUpdatePlayerState value)? onUpdatePlayerState,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (onUpdatePlayerState != null) {
      return onUpdatePlayerState(this);
    }
    return orElse();
  }
}

abstract class _OnUpdatePlayerState implements YoutubePlayerState {
  const factory _OnUpdatePlayerState(final PlayerState playerState) =
      _$OnUpdatePlayerStateImpl;

  PlayerState get playerState;

  /// Create a copy of YoutubePlayerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OnUpdatePlayerStateImplCopyWith<_$OnUpdatePlayerStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
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
    extends _$YoutubePlayerStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of YoutubePlayerState
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

class _$ErrorImpl implements _Error {
  const _$ErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'YoutubePlayerState.error(message: $message)';
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

  /// Create a copy of YoutubePlayerState
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
    required TResult Function(PlayerState playerState) onUpdatePlayerState,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(PlayerState playerState)? onUpdatePlayerState,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(PlayerState playerState)? onUpdatePlayerState,
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
    required TResult Function(_OnUpdatePlayerState value) onUpdatePlayerState,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_OnUpdatePlayerState value)? onUpdatePlayerState,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_OnUpdatePlayerState value)? onUpdatePlayerState,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements YoutubePlayerState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;

  /// Create a copy of YoutubePlayerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
