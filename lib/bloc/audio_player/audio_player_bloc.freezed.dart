// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audio_player_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AudioPlayerEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String audioUrl) setUrl,
    required TResult Function(int position) setCurrentPosition,
    required TResult Function(Duration duration) setTotalDuration,
    required TResult Function(PlayerState playerState) updatePlayerState,
    required TResult Function() play,
    required TResult Function() pause,
    required TResult Function() stop,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String audioUrl)? setUrl,
    TResult? Function(int position)? setCurrentPosition,
    TResult? Function(Duration duration)? setTotalDuration,
    TResult? Function(PlayerState playerState)? updatePlayerState,
    TResult? Function()? play,
    TResult? Function()? pause,
    TResult? Function()? stop,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String audioUrl)? setUrl,
    TResult Function(int position)? setCurrentPosition,
    TResult Function(Duration duration)? setTotalDuration,
    TResult Function(PlayerState playerState)? updatePlayerState,
    TResult Function()? play,
    TResult Function()? pause,
    TResult Function()? stop,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SetUrl value) setUrl,
    required TResult Function(_SetCurrentPosition value) setCurrentPosition,
    required TResult Function(_SetTotalDuration value) setTotalDuration,
    required TResult Function(_UpdatePlayerState value) updatePlayerState,
    required TResult Function(_Play value) play,
    required TResult Function(_Pause value) pause,
    required TResult Function(_Stop value) stop,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SetUrl value)? setUrl,
    TResult? Function(_SetCurrentPosition value)? setCurrentPosition,
    TResult? Function(_SetTotalDuration value)? setTotalDuration,
    TResult? Function(_UpdatePlayerState value)? updatePlayerState,
    TResult? Function(_Play value)? play,
    TResult? Function(_Pause value)? pause,
    TResult? Function(_Stop value)? stop,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SetUrl value)? setUrl,
    TResult Function(_SetCurrentPosition value)? setCurrentPosition,
    TResult Function(_SetTotalDuration value)? setTotalDuration,
    TResult Function(_UpdatePlayerState value)? updatePlayerState,
    TResult Function(_Play value)? play,
    TResult Function(_Pause value)? pause,
    TResult Function(_Stop value)? stop,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AudioPlayerEventCopyWith<$Res> {
  factory $AudioPlayerEventCopyWith(
          AudioPlayerEvent value, $Res Function(AudioPlayerEvent) then) =
      _$AudioPlayerEventCopyWithImpl<$Res, AudioPlayerEvent>;
}

/// @nodoc
class _$AudioPlayerEventCopyWithImpl<$Res, $Val extends AudioPlayerEvent>
    implements $AudioPlayerEventCopyWith<$Res> {
  _$AudioPlayerEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AudioPlayerEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$SetUrlImplCopyWith<$Res> {
  factory _$$SetUrlImplCopyWith(
          _$SetUrlImpl value, $Res Function(_$SetUrlImpl) then) =
      __$$SetUrlImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String audioUrl});
}

/// @nodoc
class __$$SetUrlImplCopyWithImpl<$Res>
    extends _$AudioPlayerEventCopyWithImpl<$Res, _$SetUrlImpl>
    implements _$$SetUrlImplCopyWith<$Res> {
  __$$SetUrlImplCopyWithImpl(
      _$SetUrlImpl _value, $Res Function(_$SetUrlImpl) _then)
      : super(_value, _then);

  /// Create a copy of AudioPlayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? audioUrl = null,
  }) {
    return _then(_$SetUrlImpl(
      null == audioUrl
          ? _value.audioUrl
          : audioUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SetUrlImpl implements _SetUrl {
  const _$SetUrlImpl(this.audioUrl);

  @override
  final String audioUrl;

  @override
  String toString() {
    return 'AudioPlayerEvent.setUrl(audioUrl: $audioUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetUrlImpl &&
            (identical(other.audioUrl, audioUrl) ||
                other.audioUrl == audioUrl));
  }

  @override
  int get hashCode => Object.hash(runtimeType, audioUrl);

  /// Create a copy of AudioPlayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SetUrlImplCopyWith<_$SetUrlImpl> get copyWith =>
      __$$SetUrlImplCopyWithImpl<_$SetUrlImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String audioUrl) setUrl,
    required TResult Function(int position) setCurrentPosition,
    required TResult Function(Duration duration) setTotalDuration,
    required TResult Function(PlayerState playerState) updatePlayerState,
    required TResult Function() play,
    required TResult Function() pause,
    required TResult Function() stop,
  }) {
    return setUrl(audioUrl);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String audioUrl)? setUrl,
    TResult? Function(int position)? setCurrentPosition,
    TResult? Function(Duration duration)? setTotalDuration,
    TResult? Function(PlayerState playerState)? updatePlayerState,
    TResult? Function()? play,
    TResult? Function()? pause,
    TResult? Function()? stop,
  }) {
    return setUrl?.call(audioUrl);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String audioUrl)? setUrl,
    TResult Function(int position)? setCurrentPosition,
    TResult Function(Duration duration)? setTotalDuration,
    TResult Function(PlayerState playerState)? updatePlayerState,
    TResult Function()? play,
    TResult Function()? pause,
    TResult Function()? stop,
    required TResult orElse(),
  }) {
    if (setUrl != null) {
      return setUrl(audioUrl);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SetUrl value) setUrl,
    required TResult Function(_SetCurrentPosition value) setCurrentPosition,
    required TResult Function(_SetTotalDuration value) setTotalDuration,
    required TResult Function(_UpdatePlayerState value) updatePlayerState,
    required TResult Function(_Play value) play,
    required TResult Function(_Pause value) pause,
    required TResult Function(_Stop value) stop,
  }) {
    return setUrl(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SetUrl value)? setUrl,
    TResult? Function(_SetCurrentPosition value)? setCurrentPosition,
    TResult? Function(_SetTotalDuration value)? setTotalDuration,
    TResult? Function(_UpdatePlayerState value)? updatePlayerState,
    TResult? Function(_Play value)? play,
    TResult? Function(_Pause value)? pause,
    TResult? Function(_Stop value)? stop,
  }) {
    return setUrl?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SetUrl value)? setUrl,
    TResult Function(_SetCurrentPosition value)? setCurrentPosition,
    TResult Function(_SetTotalDuration value)? setTotalDuration,
    TResult Function(_UpdatePlayerState value)? updatePlayerState,
    TResult Function(_Play value)? play,
    TResult Function(_Pause value)? pause,
    TResult Function(_Stop value)? stop,
    required TResult orElse(),
  }) {
    if (setUrl != null) {
      return setUrl(this);
    }
    return orElse();
  }
}

abstract class _SetUrl implements AudioPlayerEvent {
  const factory _SetUrl(final String audioUrl) = _$SetUrlImpl;

  String get audioUrl;

  /// Create a copy of AudioPlayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SetUrlImplCopyWith<_$SetUrlImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SetCurrentPositionImplCopyWith<$Res> {
  factory _$$SetCurrentPositionImplCopyWith(_$SetCurrentPositionImpl value,
          $Res Function(_$SetCurrentPositionImpl) then) =
      __$$SetCurrentPositionImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int position});
}

/// @nodoc
class __$$SetCurrentPositionImplCopyWithImpl<$Res>
    extends _$AudioPlayerEventCopyWithImpl<$Res, _$SetCurrentPositionImpl>
    implements _$$SetCurrentPositionImplCopyWith<$Res> {
  __$$SetCurrentPositionImplCopyWithImpl(_$SetCurrentPositionImpl _value,
      $Res Function(_$SetCurrentPositionImpl) _then)
      : super(_value, _then);

  /// Create a copy of AudioPlayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? position = null,
  }) {
    return _then(_$SetCurrentPositionImpl(
      null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$SetCurrentPositionImpl implements _SetCurrentPosition {
  const _$SetCurrentPositionImpl(this.position);

  @override
  final int position;

  @override
  String toString() {
    return 'AudioPlayerEvent.setCurrentPosition(position: $position)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetCurrentPositionImpl &&
            (identical(other.position, position) ||
                other.position == position));
  }

  @override
  int get hashCode => Object.hash(runtimeType, position);

  /// Create a copy of AudioPlayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SetCurrentPositionImplCopyWith<_$SetCurrentPositionImpl> get copyWith =>
      __$$SetCurrentPositionImplCopyWithImpl<_$SetCurrentPositionImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String audioUrl) setUrl,
    required TResult Function(int position) setCurrentPosition,
    required TResult Function(Duration duration) setTotalDuration,
    required TResult Function(PlayerState playerState) updatePlayerState,
    required TResult Function() play,
    required TResult Function() pause,
    required TResult Function() stop,
  }) {
    return setCurrentPosition(position);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String audioUrl)? setUrl,
    TResult? Function(int position)? setCurrentPosition,
    TResult? Function(Duration duration)? setTotalDuration,
    TResult? Function(PlayerState playerState)? updatePlayerState,
    TResult? Function()? play,
    TResult? Function()? pause,
    TResult? Function()? stop,
  }) {
    return setCurrentPosition?.call(position);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String audioUrl)? setUrl,
    TResult Function(int position)? setCurrentPosition,
    TResult Function(Duration duration)? setTotalDuration,
    TResult Function(PlayerState playerState)? updatePlayerState,
    TResult Function()? play,
    TResult Function()? pause,
    TResult Function()? stop,
    required TResult orElse(),
  }) {
    if (setCurrentPosition != null) {
      return setCurrentPosition(position);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SetUrl value) setUrl,
    required TResult Function(_SetCurrentPosition value) setCurrentPosition,
    required TResult Function(_SetTotalDuration value) setTotalDuration,
    required TResult Function(_UpdatePlayerState value) updatePlayerState,
    required TResult Function(_Play value) play,
    required TResult Function(_Pause value) pause,
    required TResult Function(_Stop value) stop,
  }) {
    return setCurrentPosition(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SetUrl value)? setUrl,
    TResult? Function(_SetCurrentPosition value)? setCurrentPosition,
    TResult? Function(_SetTotalDuration value)? setTotalDuration,
    TResult? Function(_UpdatePlayerState value)? updatePlayerState,
    TResult? Function(_Play value)? play,
    TResult? Function(_Pause value)? pause,
    TResult? Function(_Stop value)? stop,
  }) {
    return setCurrentPosition?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SetUrl value)? setUrl,
    TResult Function(_SetCurrentPosition value)? setCurrentPosition,
    TResult Function(_SetTotalDuration value)? setTotalDuration,
    TResult Function(_UpdatePlayerState value)? updatePlayerState,
    TResult Function(_Play value)? play,
    TResult Function(_Pause value)? pause,
    TResult Function(_Stop value)? stop,
    required TResult orElse(),
  }) {
    if (setCurrentPosition != null) {
      return setCurrentPosition(this);
    }
    return orElse();
  }
}

abstract class _SetCurrentPosition implements AudioPlayerEvent {
  const factory _SetCurrentPosition(final int position) =
      _$SetCurrentPositionImpl;

  int get position;

  /// Create a copy of AudioPlayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SetCurrentPositionImplCopyWith<_$SetCurrentPositionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SetTotalDurationImplCopyWith<$Res> {
  factory _$$SetTotalDurationImplCopyWith(_$SetTotalDurationImpl value,
          $Res Function(_$SetTotalDurationImpl) then) =
      __$$SetTotalDurationImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Duration duration});
}

/// @nodoc
class __$$SetTotalDurationImplCopyWithImpl<$Res>
    extends _$AudioPlayerEventCopyWithImpl<$Res, _$SetTotalDurationImpl>
    implements _$$SetTotalDurationImplCopyWith<$Res> {
  __$$SetTotalDurationImplCopyWithImpl(_$SetTotalDurationImpl _value,
      $Res Function(_$SetTotalDurationImpl) _then)
      : super(_value, _then);

  /// Create a copy of AudioPlayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? duration = null,
  }) {
    return _then(_$SetTotalDurationImpl(
      null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
    ));
  }
}

/// @nodoc

class _$SetTotalDurationImpl implements _SetTotalDuration {
  const _$SetTotalDurationImpl(this.duration);

  @override
  final Duration duration;

  @override
  String toString() {
    return 'AudioPlayerEvent.setTotalDuration(duration: $duration)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetTotalDurationImpl &&
            (identical(other.duration, duration) ||
                other.duration == duration));
  }

  @override
  int get hashCode => Object.hash(runtimeType, duration);

  /// Create a copy of AudioPlayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SetTotalDurationImplCopyWith<_$SetTotalDurationImpl> get copyWith =>
      __$$SetTotalDurationImplCopyWithImpl<_$SetTotalDurationImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String audioUrl) setUrl,
    required TResult Function(int position) setCurrentPosition,
    required TResult Function(Duration duration) setTotalDuration,
    required TResult Function(PlayerState playerState) updatePlayerState,
    required TResult Function() play,
    required TResult Function() pause,
    required TResult Function() stop,
  }) {
    return setTotalDuration(duration);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String audioUrl)? setUrl,
    TResult? Function(int position)? setCurrentPosition,
    TResult? Function(Duration duration)? setTotalDuration,
    TResult? Function(PlayerState playerState)? updatePlayerState,
    TResult? Function()? play,
    TResult? Function()? pause,
    TResult? Function()? stop,
  }) {
    return setTotalDuration?.call(duration);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String audioUrl)? setUrl,
    TResult Function(int position)? setCurrentPosition,
    TResult Function(Duration duration)? setTotalDuration,
    TResult Function(PlayerState playerState)? updatePlayerState,
    TResult Function()? play,
    TResult Function()? pause,
    TResult Function()? stop,
    required TResult orElse(),
  }) {
    if (setTotalDuration != null) {
      return setTotalDuration(duration);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SetUrl value) setUrl,
    required TResult Function(_SetCurrentPosition value) setCurrentPosition,
    required TResult Function(_SetTotalDuration value) setTotalDuration,
    required TResult Function(_UpdatePlayerState value) updatePlayerState,
    required TResult Function(_Play value) play,
    required TResult Function(_Pause value) pause,
    required TResult Function(_Stop value) stop,
  }) {
    return setTotalDuration(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SetUrl value)? setUrl,
    TResult? Function(_SetCurrentPosition value)? setCurrentPosition,
    TResult? Function(_SetTotalDuration value)? setTotalDuration,
    TResult? Function(_UpdatePlayerState value)? updatePlayerState,
    TResult? Function(_Play value)? play,
    TResult? Function(_Pause value)? pause,
    TResult? Function(_Stop value)? stop,
  }) {
    return setTotalDuration?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SetUrl value)? setUrl,
    TResult Function(_SetCurrentPosition value)? setCurrentPosition,
    TResult Function(_SetTotalDuration value)? setTotalDuration,
    TResult Function(_UpdatePlayerState value)? updatePlayerState,
    TResult Function(_Play value)? play,
    TResult Function(_Pause value)? pause,
    TResult Function(_Stop value)? stop,
    required TResult orElse(),
  }) {
    if (setTotalDuration != null) {
      return setTotalDuration(this);
    }
    return orElse();
  }
}

abstract class _SetTotalDuration implements AudioPlayerEvent {
  const factory _SetTotalDuration(final Duration duration) =
      _$SetTotalDurationImpl;

  Duration get duration;

  /// Create a copy of AudioPlayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SetTotalDurationImplCopyWith<_$SetTotalDurationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdatePlayerStateImplCopyWith<$Res> {
  factory _$$UpdatePlayerStateImplCopyWith(_$UpdatePlayerStateImpl value,
          $Res Function(_$UpdatePlayerStateImpl) then) =
      __$$UpdatePlayerStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({PlayerState playerState});
}

/// @nodoc
class __$$UpdatePlayerStateImplCopyWithImpl<$Res>
    extends _$AudioPlayerEventCopyWithImpl<$Res, _$UpdatePlayerStateImpl>
    implements _$$UpdatePlayerStateImplCopyWith<$Res> {
  __$$UpdatePlayerStateImplCopyWithImpl(_$UpdatePlayerStateImpl _value,
      $Res Function(_$UpdatePlayerStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AudioPlayerEvent
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
    return 'AudioPlayerEvent.updatePlayerState(playerState: $playerState)';
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

  /// Create a copy of AudioPlayerEvent
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
    required TResult Function(String audioUrl) setUrl,
    required TResult Function(int position) setCurrentPosition,
    required TResult Function(Duration duration) setTotalDuration,
    required TResult Function(PlayerState playerState) updatePlayerState,
    required TResult Function() play,
    required TResult Function() pause,
    required TResult Function() stop,
  }) {
    return updatePlayerState(playerState);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String audioUrl)? setUrl,
    TResult? Function(int position)? setCurrentPosition,
    TResult? Function(Duration duration)? setTotalDuration,
    TResult? Function(PlayerState playerState)? updatePlayerState,
    TResult? Function()? play,
    TResult? Function()? pause,
    TResult? Function()? stop,
  }) {
    return updatePlayerState?.call(playerState);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String audioUrl)? setUrl,
    TResult Function(int position)? setCurrentPosition,
    TResult Function(Duration duration)? setTotalDuration,
    TResult Function(PlayerState playerState)? updatePlayerState,
    TResult Function()? play,
    TResult Function()? pause,
    TResult Function()? stop,
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
    required TResult Function(_SetUrl value) setUrl,
    required TResult Function(_SetCurrentPosition value) setCurrentPosition,
    required TResult Function(_SetTotalDuration value) setTotalDuration,
    required TResult Function(_UpdatePlayerState value) updatePlayerState,
    required TResult Function(_Play value) play,
    required TResult Function(_Pause value) pause,
    required TResult Function(_Stop value) stop,
  }) {
    return updatePlayerState(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SetUrl value)? setUrl,
    TResult? Function(_SetCurrentPosition value)? setCurrentPosition,
    TResult? Function(_SetTotalDuration value)? setTotalDuration,
    TResult? Function(_UpdatePlayerState value)? updatePlayerState,
    TResult? Function(_Play value)? play,
    TResult? Function(_Pause value)? pause,
    TResult? Function(_Stop value)? stop,
  }) {
    return updatePlayerState?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SetUrl value)? setUrl,
    TResult Function(_SetCurrentPosition value)? setCurrentPosition,
    TResult Function(_SetTotalDuration value)? setTotalDuration,
    TResult Function(_UpdatePlayerState value)? updatePlayerState,
    TResult Function(_Play value)? play,
    TResult Function(_Pause value)? pause,
    TResult Function(_Stop value)? stop,
    required TResult orElse(),
  }) {
    if (updatePlayerState != null) {
      return updatePlayerState(this);
    }
    return orElse();
  }
}

abstract class _UpdatePlayerState implements AudioPlayerEvent {
  const factory _UpdatePlayerState(final PlayerState playerState) =
      _$UpdatePlayerStateImpl;

  PlayerState get playerState;

  /// Create a copy of AudioPlayerEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdatePlayerStateImplCopyWith<_$UpdatePlayerStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PlayImplCopyWith<$Res> {
  factory _$$PlayImplCopyWith(
          _$PlayImpl value, $Res Function(_$PlayImpl) then) =
      __$$PlayImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PlayImplCopyWithImpl<$Res>
    extends _$AudioPlayerEventCopyWithImpl<$Res, _$PlayImpl>
    implements _$$PlayImplCopyWith<$Res> {
  __$$PlayImplCopyWithImpl(_$PlayImpl _value, $Res Function(_$PlayImpl) _then)
      : super(_value, _then);

  /// Create a copy of AudioPlayerEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$PlayImpl implements _Play {
  const _$PlayImpl();

  @override
  String toString() {
    return 'AudioPlayerEvent.play()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PlayImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String audioUrl) setUrl,
    required TResult Function(int position) setCurrentPosition,
    required TResult Function(Duration duration) setTotalDuration,
    required TResult Function(PlayerState playerState) updatePlayerState,
    required TResult Function() play,
    required TResult Function() pause,
    required TResult Function() stop,
  }) {
    return play();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String audioUrl)? setUrl,
    TResult? Function(int position)? setCurrentPosition,
    TResult? Function(Duration duration)? setTotalDuration,
    TResult? Function(PlayerState playerState)? updatePlayerState,
    TResult? Function()? play,
    TResult? Function()? pause,
    TResult? Function()? stop,
  }) {
    return play?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String audioUrl)? setUrl,
    TResult Function(int position)? setCurrentPosition,
    TResult Function(Duration duration)? setTotalDuration,
    TResult Function(PlayerState playerState)? updatePlayerState,
    TResult Function()? play,
    TResult Function()? pause,
    TResult Function()? stop,
    required TResult orElse(),
  }) {
    if (play != null) {
      return play();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SetUrl value) setUrl,
    required TResult Function(_SetCurrentPosition value) setCurrentPosition,
    required TResult Function(_SetTotalDuration value) setTotalDuration,
    required TResult Function(_UpdatePlayerState value) updatePlayerState,
    required TResult Function(_Play value) play,
    required TResult Function(_Pause value) pause,
    required TResult Function(_Stop value) stop,
  }) {
    return play(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SetUrl value)? setUrl,
    TResult? Function(_SetCurrentPosition value)? setCurrentPosition,
    TResult? Function(_SetTotalDuration value)? setTotalDuration,
    TResult? Function(_UpdatePlayerState value)? updatePlayerState,
    TResult? Function(_Play value)? play,
    TResult? Function(_Pause value)? pause,
    TResult? Function(_Stop value)? stop,
  }) {
    return play?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SetUrl value)? setUrl,
    TResult Function(_SetCurrentPosition value)? setCurrentPosition,
    TResult Function(_SetTotalDuration value)? setTotalDuration,
    TResult Function(_UpdatePlayerState value)? updatePlayerState,
    TResult Function(_Play value)? play,
    TResult Function(_Pause value)? pause,
    TResult Function(_Stop value)? stop,
    required TResult orElse(),
  }) {
    if (play != null) {
      return play(this);
    }
    return orElse();
  }
}

abstract class _Play implements AudioPlayerEvent {
  const factory _Play() = _$PlayImpl;
}

/// @nodoc
abstract class _$$PauseImplCopyWith<$Res> {
  factory _$$PauseImplCopyWith(
          _$PauseImpl value, $Res Function(_$PauseImpl) then) =
      __$$PauseImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PauseImplCopyWithImpl<$Res>
    extends _$AudioPlayerEventCopyWithImpl<$Res, _$PauseImpl>
    implements _$$PauseImplCopyWith<$Res> {
  __$$PauseImplCopyWithImpl(
      _$PauseImpl _value, $Res Function(_$PauseImpl) _then)
      : super(_value, _then);

  /// Create a copy of AudioPlayerEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$PauseImpl implements _Pause {
  const _$PauseImpl();

  @override
  String toString() {
    return 'AudioPlayerEvent.pause()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PauseImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String audioUrl) setUrl,
    required TResult Function(int position) setCurrentPosition,
    required TResult Function(Duration duration) setTotalDuration,
    required TResult Function(PlayerState playerState) updatePlayerState,
    required TResult Function() play,
    required TResult Function() pause,
    required TResult Function() stop,
  }) {
    return pause();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String audioUrl)? setUrl,
    TResult? Function(int position)? setCurrentPosition,
    TResult? Function(Duration duration)? setTotalDuration,
    TResult? Function(PlayerState playerState)? updatePlayerState,
    TResult? Function()? play,
    TResult? Function()? pause,
    TResult? Function()? stop,
  }) {
    return pause?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String audioUrl)? setUrl,
    TResult Function(int position)? setCurrentPosition,
    TResult Function(Duration duration)? setTotalDuration,
    TResult Function(PlayerState playerState)? updatePlayerState,
    TResult Function()? play,
    TResult Function()? pause,
    TResult Function()? stop,
    required TResult orElse(),
  }) {
    if (pause != null) {
      return pause();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SetUrl value) setUrl,
    required TResult Function(_SetCurrentPosition value) setCurrentPosition,
    required TResult Function(_SetTotalDuration value) setTotalDuration,
    required TResult Function(_UpdatePlayerState value) updatePlayerState,
    required TResult Function(_Play value) play,
    required TResult Function(_Pause value) pause,
    required TResult Function(_Stop value) stop,
  }) {
    return pause(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SetUrl value)? setUrl,
    TResult? Function(_SetCurrentPosition value)? setCurrentPosition,
    TResult? Function(_SetTotalDuration value)? setTotalDuration,
    TResult? Function(_UpdatePlayerState value)? updatePlayerState,
    TResult? Function(_Play value)? play,
    TResult? Function(_Pause value)? pause,
    TResult? Function(_Stop value)? stop,
  }) {
    return pause?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SetUrl value)? setUrl,
    TResult Function(_SetCurrentPosition value)? setCurrentPosition,
    TResult Function(_SetTotalDuration value)? setTotalDuration,
    TResult Function(_UpdatePlayerState value)? updatePlayerState,
    TResult Function(_Play value)? play,
    TResult Function(_Pause value)? pause,
    TResult Function(_Stop value)? stop,
    required TResult orElse(),
  }) {
    if (pause != null) {
      return pause(this);
    }
    return orElse();
  }
}

abstract class _Pause implements AudioPlayerEvent {
  const factory _Pause() = _$PauseImpl;
}

/// @nodoc
abstract class _$$StopImplCopyWith<$Res> {
  factory _$$StopImplCopyWith(
          _$StopImpl value, $Res Function(_$StopImpl) then) =
      __$$StopImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StopImplCopyWithImpl<$Res>
    extends _$AudioPlayerEventCopyWithImpl<$Res, _$StopImpl>
    implements _$$StopImplCopyWith<$Res> {
  __$$StopImplCopyWithImpl(_$StopImpl _value, $Res Function(_$StopImpl) _then)
      : super(_value, _then);

  /// Create a copy of AudioPlayerEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$StopImpl implements _Stop {
  const _$StopImpl();

  @override
  String toString() {
    return 'AudioPlayerEvent.stop()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StopImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String audioUrl) setUrl,
    required TResult Function(int position) setCurrentPosition,
    required TResult Function(Duration duration) setTotalDuration,
    required TResult Function(PlayerState playerState) updatePlayerState,
    required TResult Function() play,
    required TResult Function() pause,
    required TResult Function() stop,
  }) {
    return stop();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String audioUrl)? setUrl,
    TResult? Function(int position)? setCurrentPosition,
    TResult? Function(Duration duration)? setTotalDuration,
    TResult? Function(PlayerState playerState)? updatePlayerState,
    TResult? Function()? play,
    TResult? Function()? pause,
    TResult? Function()? stop,
  }) {
    return stop?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String audioUrl)? setUrl,
    TResult Function(int position)? setCurrentPosition,
    TResult Function(Duration duration)? setTotalDuration,
    TResult Function(PlayerState playerState)? updatePlayerState,
    TResult Function()? play,
    TResult Function()? pause,
    TResult Function()? stop,
    required TResult orElse(),
  }) {
    if (stop != null) {
      return stop();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SetUrl value) setUrl,
    required TResult Function(_SetCurrentPosition value) setCurrentPosition,
    required TResult Function(_SetTotalDuration value) setTotalDuration,
    required TResult Function(_UpdatePlayerState value) updatePlayerState,
    required TResult Function(_Play value) play,
    required TResult Function(_Pause value) pause,
    required TResult Function(_Stop value) stop,
  }) {
    return stop(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SetUrl value)? setUrl,
    TResult? Function(_SetCurrentPosition value)? setCurrentPosition,
    TResult? Function(_SetTotalDuration value)? setTotalDuration,
    TResult? Function(_UpdatePlayerState value)? updatePlayerState,
    TResult? Function(_Play value)? play,
    TResult? Function(_Pause value)? pause,
    TResult? Function(_Stop value)? stop,
  }) {
    return stop?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SetUrl value)? setUrl,
    TResult Function(_SetCurrentPosition value)? setCurrentPosition,
    TResult Function(_SetTotalDuration value)? setTotalDuration,
    TResult Function(_UpdatePlayerState value)? updatePlayerState,
    TResult Function(_Play value)? play,
    TResult Function(_Pause value)? pause,
    TResult Function(_Stop value)? stop,
    required TResult orElse(),
  }) {
    if (stop != null) {
      return stop(this);
    }
    return orElse();
  }
}

abstract class _Stop implements AudioPlayerEvent {
  const factory _Stop() = _$StopImpl;
}

/// @nodoc
mixin _$AudioPlayerState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String audioUrl) getUrl,
    required TResult Function() onPlay,
    required TResult Function() onPause,
    required TResult Function() onStop,
    required TResult Function(int position) onCurrentPosition,
    required TResult Function(Duration duration) onTotalDuration,
    required TResult Function(PlayerState playerState) onUpdatePlayerState,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String audioUrl)? getUrl,
    TResult? Function()? onPlay,
    TResult? Function()? onPause,
    TResult? Function()? onStop,
    TResult? Function(int position)? onCurrentPosition,
    TResult? Function(Duration duration)? onTotalDuration,
    TResult? Function(PlayerState playerState)? onUpdatePlayerState,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String audioUrl)? getUrl,
    TResult Function()? onPlay,
    TResult Function()? onPause,
    TResult Function()? onStop,
    TResult Function(int position)? onCurrentPosition,
    TResult Function(Duration duration)? onTotalDuration,
    TResult Function(PlayerState playerState)? onUpdatePlayerState,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_GetUrl value) getUrl,
    required TResult Function(_OnPlay value) onPlay,
    required TResult Function(_onPause value) onPause,
    required TResult Function(_onStop value) onStop,
    required TResult Function(_OnCurrentPosition value) onCurrentPosition,
    required TResult Function(_OnTotalDuration value) onTotalDuration,
    required TResult Function(_OnUpdatePlayerState value) onUpdatePlayerState,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_GetUrl value)? getUrl,
    TResult? Function(_OnPlay value)? onPlay,
    TResult? Function(_onPause value)? onPause,
    TResult? Function(_onStop value)? onStop,
    TResult? Function(_OnCurrentPosition value)? onCurrentPosition,
    TResult? Function(_OnTotalDuration value)? onTotalDuration,
    TResult? Function(_OnUpdatePlayerState value)? onUpdatePlayerState,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_GetUrl value)? getUrl,
    TResult Function(_OnPlay value)? onPlay,
    TResult Function(_onPause value)? onPause,
    TResult Function(_onStop value)? onStop,
    TResult Function(_OnCurrentPosition value)? onCurrentPosition,
    TResult Function(_OnTotalDuration value)? onTotalDuration,
    TResult Function(_OnUpdatePlayerState value)? onUpdatePlayerState,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AudioPlayerStateCopyWith<$Res> {
  factory $AudioPlayerStateCopyWith(
          AudioPlayerState value, $Res Function(AudioPlayerState) then) =
      _$AudioPlayerStateCopyWithImpl<$Res, AudioPlayerState>;
}

/// @nodoc
class _$AudioPlayerStateCopyWithImpl<$Res, $Val extends AudioPlayerState>
    implements $AudioPlayerStateCopyWith<$Res> {
  _$AudioPlayerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AudioPlayerState
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
    extends _$AudioPlayerStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of AudioPlayerState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'AudioPlayerState.initial()';
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
    required TResult Function(String audioUrl) getUrl,
    required TResult Function() onPlay,
    required TResult Function() onPause,
    required TResult Function() onStop,
    required TResult Function(int position) onCurrentPosition,
    required TResult Function(Duration duration) onTotalDuration,
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
    TResult? Function(String audioUrl)? getUrl,
    TResult? Function()? onPlay,
    TResult? Function()? onPause,
    TResult? Function()? onStop,
    TResult? Function(int position)? onCurrentPosition,
    TResult? Function(Duration duration)? onTotalDuration,
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
    TResult Function(String audioUrl)? getUrl,
    TResult Function()? onPlay,
    TResult Function()? onPause,
    TResult Function()? onStop,
    TResult Function(int position)? onCurrentPosition,
    TResult Function(Duration duration)? onTotalDuration,
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
    required TResult Function(_GetUrl value) getUrl,
    required TResult Function(_OnPlay value) onPlay,
    required TResult Function(_onPause value) onPause,
    required TResult Function(_onStop value) onStop,
    required TResult Function(_OnCurrentPosition value) onCurrentPosition,
    required TResult Function(_OnTotalDuration value) onTotalDuration,
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
    TResult? Function(_GetUrl value)? getUrl,
    TResult? Function(_OnPlay value)? onPlay,
    TResult? Function(_onPause value)? onPause,
    TResult? Function(_onStop value)? onStop,
    TResult? Function(_OnCurrentPosition value)? onCurrentPosition,
    TResult? Function(_OnTotalDuration value)? onTotalDuration,
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
    TResult Function(_GetUrl value)? getUrl,
    TResult Function(_OnPlay value)? onPlay,
    TResult Function(_onPause value)? onPause,
    TResult Function(_onStop value)? onStop,
    TResult Function(_OnCurrentPosition value)? onCurrentPosition,
    TResult Function(_OnTotalDuration value)? onTotalDuration,
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

abstract class _Initial implements AudioPlayerState {
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
    extends _$AudioPlayerStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of AudioPlayerState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'AudioPlayerState.loading()';
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
    required TResult Function(String audioUrl) getUrl,
    required TResult Function() onPlay,
    required TResult Function() onPause,
    required TResult Function() onStop,
    required TResult Function(int position) onCurrentPosition,
    required TResult Function(Duration duration) onTotalDuration,
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
    TResult? Function(String audioUrl)? getUrl,
    TResult? Function()? onPlay,
    TResult? Function()? onPause,
    TResult? Function()? onStop,
    TResult? Function(int position)? onCurrentPosition,
    TResult? Function(Duration duration)? onTotalDuration,
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
    TResult Function(String audioUrl)? getUrl,
    TResult Function()? onPlay,
    TResult Function()? onPause,
    TResult Function()? onStop,
    TResult Function(int position)? onCurrentPosition,
    TResult Function(Duration duration)? onTotalDuration,
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
    required TResult Function(_GetUrl value) getUrl,
    required TResult Function(_OnPlay value) onPlay,
    required TResult Function(_onPause value) onPause,
    required TResult Function(_onStop value) onStop,
    required TResult Function(_OnCurrentPosition value) onCurrentPosition,
    required TResult Function(_OnTotalDuration value) onTotalDuration,
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
    TResult? Function(_GetUrl value)? getUrl,
    TResult? Function(_OnPlay value)? onPlay,
    TResult? Function(_onPause value)? onPause,
    TResult? Function(_onStop value)? onStop,
    TResult? Function(_OnCurrentPosition value)? onCurrentPosition,
    TResult? Function(_OnTotalDuration value)? onTotalDuration,
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
    TResult Function(_GetUrl value)? getUrl,
    TResult Function(_OnPlay value)? onPlay,
    TResult Function(_onPause value)? onPause,
    TResult Function(_onStop value)? onStop,
    TResult Function(_OnCurrentPosition value)? onCurrentPosition,
    TResult Function(_OnTotalDuration value)? onTotalDuration,
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

abstract class _Loading implements AudioPlayerState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$GetUrlImplCopyWith<$Res> {
  factory _$$GetUrlImplCopyWith(
          _$GetUrlImpl value, $Res Function(_$GetUrlImpl) then) =
      __$$GetUrlImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String audioUrl});
}

/// @nodoc
class __$$GetUrlImplCopyWithImpl<$Res>
    extends _$AudioPlayerStateCopyWithImpl<$Res, _$GetUrlImpl>
    implements _$$GetUrlImplCopyWith<$Res> {
  __$$GetUrlImplCopyWithImpl(
      _$GetUrlImpl _value, $Res Function(_$GetUrlImpl) _then)
      : super(_value, _then);

  /// Create a copy of AudioPlayerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? audioUrl = null,
  }) {
    return _then(_$GetUrlImpl(
      null == audioUrl
          ? _value.audioUrl
          : audioUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$GetUrlImpl implements _GetUrl {
  const _$GetUrlImpl(this.audioUrl);

  @override
  final String audioUrl;

  @override
  String toString() {
    return 'AudioPlayerState.getUrl(audioUrl: $audioUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetUrlImpl &&
            (identical(other.audioUrl, audioUrl) ||
                other.audioUrl == audioUrl));
  }

  @override
  int get hashCode => Object.hash(runtimeType, audioUrl);

  /// Create a copy of AudioPlayerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetUrlImplCopyWith<_$GetUrlImpl> get copyWith =>
      __$$GetUrlImplCopyWithImpl<_$GetUrlImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String audioUrl) getUrl,
    required TResult Function() onPlay,
    required TResult Function() onPause,
    required TResult Function() onStop,
    required TResult Function(int position) onCurrentPosition,
    required TResult Function(Duration duration) onTotalDuration,
    required TResult Function(PlayerState playerState) onUpdatePlayerState,
    required TResult Function(String message) error,
  }) {
    return getUrl(audioUrl);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String audioUrl)? getUrl,
    TResult? Function()? onPlay,
    TResult? Function()? onPause,
    TResult? Function()? onStop,
    TResult? Function(int position)? onCurrentPosition,
    TResult? Function(Duration duration)? onTotalDuration,
    TResult? Function(PlayerState playerState)? onUpdatePlayerState,
    TResult? Function(String message)? error,
  }) {
    return getUrl?.call(audioUrl);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String audioUrl)? getUrl,
    TResult Function()? onPlay,
    TResult Function()? onPause,
    TResult Function()? onStop,
    TResult Function(int position)? onCurrentPosition,
    TResult Function(Duration duration)? onTotalDuration,
    TResult Function(PlayerState playerState)? onUpdatePlayerState,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (getUrl != null) {
      return getUrl(audioUrl);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_GetUrl value) getUrl,
    required TResult Function(_OnPlay value) onPlay,
    required TResult Function(_onPause value) onPause,
    required TResult Function(_onStop value) onStop,
    required TResult Function(_OnCurrentPosition value) onCurrentPosition,
    required TResult Function(_OnTotalDuration value) onTotalDuration,
    required TResult Function(_OnUpdatePlayerState value) onUpdatePlayerState,
    required TResult Function(_Error value) error,
  }) {
    return getUrl(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_GetUrl value)? getUrl,
    TResult? Function(_OnPlay value)? onPlay,
    TResult? Function(_onPause value)? onPause,
    TResult? Function(_onStop value)? onStop,
    TResult? Function(_OnCurrentPosition value)? onCurrentPosition,
    TResult? Function(_OnTotalDuration value)? onTotalDuration,
    TResult? Function(_OnUpdatePlayerState value)? onUpdatePlayerState,
    TResult? Function(_Error value)? error,
  }) {
    return getUrl?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_GetUrl value)? getUrl,
    TResult Function(_OnPlay value)? onPlay,
    TResult Function(_onPause value)? onPause,
    TResult Function(_onStop value)? onStop,
    TResult Function(_OnCurrentPosition value)? onCurrentPosition,
    TResult Function(_OnTotalDuration value)? onTotalDuration,
    TResult Function(_OnUpdatePlayerState value)? onUpdatePlayerState,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (getUrl != null) {
      return getUrl(this);
    }
    return orElse();
  }
}

abstract class _GetUrl implements AudioPlayerState {
  const factory _GetUrl(final String audioUrl) = _$GetUrlImpl;

  String get audioUrl;

  /// Create a copy of AudioPlayerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetUrlImplCopyWith<_$GetUrlImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OnPlayImplCopyWith<$Res> {
  factory _$$OnPlayImplCopyWith(
          _$OnPlayImpl value, $Res Function(_$OnPlayImpl) then) =
      __$$OnPlayImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OnPlayImplCopyWithImpl<$Res>
    extends _$AudioPlayerStateCopyWithImpl<$Res, _$OnPlayImpl>
    implements _$$OnPlayImplCopyWith<$Res> {
  __$$OnPlayImplCopyWithImpl(
      _$OnPlayImpl _value, $Res Function(_$OnPlayImpl) _then)
      : super(_value, _then);

  /// Create a copy of AudioPlayerState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$OnPlayImpl implements _OnPlay {
  const _$OnPlayImpl();

  @override
  String toString() {
    return 'AudioPlayerState.onPlay()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$OnPlayImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String audioUrl) getUrl,
    required TResult Function() onPlay,
    required TResult Function() onPause,
    required TResult Function() onStop,
    required TResult Function(int position) onCurrentPosition,
    required TResult Function(Duration duration) onTotalDuration,
    required TResult Function(PlayerState playerState) onUpdatePlayerState,
    required TResult Function(String message) error,
  }) {
    return onPlay();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String audioUrl)? getUrl,
    TResult? Function()? onPlay,
    TResult? Function()? onPause,
    TResult? Function()? onStop,
    TResult? Function(int position)? onCurrentPosition,
    TResult? Function(Duration duration)? onTotalDuration,
    TResult? Function(PlayerState playerState)? onUpdatePlayerState,
    TResult? Function(String message)? error,
  }) {
    return onPlay?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String audioUrl)? getUrl,
    TResult Function()? onPlay,
    TResult Function()? onPause,
    TResult Function()? onStop,
    TResult Function(int position)? onCurrentPosition,
    TResult Function(Duration duration)? onTotalDuration,
    TResult Function(PlayerState playerState)? onUpdatePlayerState,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (onPlay != null) {
      return onPlay();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_GetUrl value) getUrl,
    required TResult Function(_OnPlay value) onPlay,
    required TResult Function(_onPause value) onPause,
    required TResult Function(_onStop value) onStop,
    required TResult Function(_OnCurrentPosition value) onCurrentPosition,
    required TResult Function(_OnTotalDuration value) onTotalDuration,
    required TResult Function(_OnUpdatePlayerState value) onUpdatePlayerState,
    required TResult Function(_Error value) error,
  }) {
    return onPlay(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_GetUrl value)? getUrl,
    TResult? Function(_OnPlay value)? onPlay,
    TResult? Function(_onPause value)? onPause,
    TResult? Function(_onStop value)? onStop,
    TResult? Function(_OnCurrentPosition value)? onCurrentPosition,
    TResult? Function(_OnTotalDuration value)? onTotalDuration,
    TResult? Function(_OnUpdatePlayerState value)? onUpdatePlayerState,
    TResult? Function(_Error value)? error,
  }) {
    return onPlay?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_GetUrl value)? getUrl,
    TResult Function(_OnPlay value)? onPlay,
    TResult Function(_onPause value)? onPause,
    TResult Function(_onStop value)? onStop,
    TResult Function(_OnCurrentPosition value)? onCurrentPosition,
    TResult Function(_OnTotalDuration value)? onTotalDuration,
    TResult Function(_OnUpdatePlayerState value)? onUpdatePlayerState,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (onPlay != null) {
      return onPlay(this);
    }
    return orElse();
  }
}

abstract class _OnPlay implements AudioPlayerState {
  const factory _OnPlay() = _$OnPlayImpl;
}

/// @nodoc
abstract class _$$onPauseImplCopyWith<$Res> {
  factory _$$onPauseImplCopyWith(
          _$onPauseImpl value, $Res Function(_$onPauseImpl) then) =
      __$$onPauseImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$onPauseImplCopyWithImpl<$Res>
    extends _$AudioPlayerStateCopyWithImpl<$Res, _$onPauseImpl>
    implements _$$onPauseImplCopyWith<$Res> {
  __$$onPauseImplCopyWithImpl(
      _$onPauseImpl _value, $Res Function(_$onPauseImpl) _then)
      : super(_value, _then);

  /// Create a copy of AudioPlayerState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$onPauseImpl implements _onPause {
  const _$onPauseImpl();

  @override
  String toString() {
    return 'AudioPlayerState.onPause()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$onPauseImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String audioUrl) getUrl,
    required TResult Function() onPlay,
    required TResult Function() onPause,
    required TResult Function() onStop,
    required TResult Function(int position) onCurrentPosition,
    required TResult Function(Duration duration) onTotalDuration,
    required TResult Function(PlayerState playerState) onUpdatePlayerState,
    required TResult Function(String message) error,
  }) {
    return onPause();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String audioUrl)? getUrl,
    TResult? Function()? onPlay,
    TResult? Function()? onPause,
    TResult? Function()? onStop,
    TResult? Function(int position)? onCurrentPosition,
    TResult? Function(Duration duration)? onTotalDuration,
    TResult? Function(PlayerState playerState)? onUpdatePlayerState,
    TResult? Function(String message)? error,
  }) {
    return onPause?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String audioUrl)? getUrl,
    TResult Function()? onPlay,
    TResult Function()? onPause,
    TResult Function()? onStop,
    TResult Function(int position)? onCurrentPosition,
    TResult Function(Duration duration)? onTotalDuration,
    TResult Function(PlayerState playerState)? onUpdatePlayerState,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (onPause != null) {
      return onPause();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_GetUrl value) getUrl,
    required TResult Function(_OnPlay value) onPlay,
    required TResult Function(_onPause value) onPause,
    required TResult Function(_onStop value) onStop,
    required TResult Function(_OnCurrentPosition value) onCurrentPosition,
    required TResult Function(_OnTotalDuration value) onTotalDuration,
    required TResult Function(_OnUpdatePlayerState value) onUpdatePlayerState,
    required TResult Function(_Error value) error,
  }) {
    return onPause(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_GetUrl value)? getUrl,
    TResult? Function(_OnPlay value)? onPlay,
    TResult? Function(_onPause value)? onPause,
    TResult? Function(_onStop value)? onStop,
    TResult? Function(_OnCurrentPosition value)? onCurrentPosition,
    TResult? Function(_OnTotalDuration value)? onTotalDuration,
    TResult? Function(_OnUpdatePlayerState value)? onUpdatePlayerState,
    TResult? Function(_Error value)? error,
  }) {
    return onPause?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_GetUrl value)? getUrl,
    TResult Function(_OnPlay value)? onPlay,
    TResult Function(_onPause value)? onPause,
    TResult Function(_onStop value)? onStop,
    TResult Function(_OnCurrentPosition value)? onCurrentPosition,
    TResult Function(_OnTotalDuration value)? onTotalDuration,
    TResult Function(_OnUpdatePlayerState value)? onUpdatePlayerState,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (onPause != null) {
      return onPause(this);
    }
    return orElse();
  }
}

abstract class _onPause implements AudioPlayerState {
  const factory _onPause() = _$onPauseImpl;
}

/// @nodoc
abstract class _$$onStopImplCopyWith<$Res> {
  factory _$$onStopImplCopyWith(
          _$onStopImpl value, $Res Function(_$onStopImpl) then) =
      __$$onStopImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$onStopImplCopyWithImpl<$Res>
    extends _$AudioPlayerStateCopyWithImpl<$Res, _$onStopImpl>
    implements _$$onStopImplCopyWith<$Res> {
  __$$onStopImplCopyWithImpl(
      _$onStopImpl _value, $Res Function(_$onStopImpl) _then)
      : super(_value, _then);

  /// Create a copy of AudioPlayerState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$onStopImpl implements _onStop {
  const _$onStopImpl();

  @override
  String toString() {
    return 'AudioPlayerState.onStop()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$onStopImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String audioUrl) getUrl,
    required TResult Function() onPlay,
    required TResult Function() onPause,
    required TResult Function() onStop,
    required TResult Function(int position) onCurrentPosition,
    required TResult Function(Duration duration) onTotalDuration,
    required TResult Function(PlayerState playerState) onUpdatePlayerState,
    required TResult Function(String message) error,
  }) {
    return onStop();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String audioUrl)? getUrl,
    TResult? Function()? onPlay,
    TResult? Function()? onPause,
    TResult? Function()? onStop,
    TResult? Function(int position)? onCurrentPosition,
    TResult? Function(Duration duration)? onTotalDuration,
    TResult? Function(PlayerState playerState)? onUpdatePlayerState,
    TResult? Function(String message)? error,
  }) {
    return onStop?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String audioUrl)? getUrl,
    TResult Function()? onPlay,
    TResult Function()? onPause,
    TResult Function()? onStop,
    TResult Function(int position)? onCurrentPosition,
    TResult Function(Duration duration)? onTotalDuration,
    TResult Function(PlayerState playerState)? onUpdatePlayerState,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (onStop != null) {
      return onStop();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_GetUrl value) getUrl,
    required TResult Function(_OnPlay value) onPlay,
    required TResult Function(_onPause value) onPause,
    required TResult Function(_onStop value) onStop,
    required TResult Function(_OnCurrentPosition value) onCurrentPosition,
    required TResult Function(_OnTotalDuration value) onTotalDuration,
    required TResult Function(_OnUpdatePlayerState value) onUpdatePlayerState,
    required TResult Function(_Error value) error,
  }) {
    return onStop(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_GetUrl value)? getUrl,
    TResult? Function(_OnPlay value)? onPlay,
    TResult? Function(_onPause value)? onPause,
    TResult? Function(_onStop value)? onStop,
    TResult? Function(_OnCurrentPosition value)? onCurrentPosition,
    TResult? Function(_OnTotalDuration value)? onTotalDuration,
    TResult? Function(_OnUpdatePlayerState value)? onUpdatePlayerState,
    TResult? Function(_Error value)? error,
  }) {
    return onStop?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_GetUrl value)? getUrl,
    TResult Function(_OnPlay value)? onPlay,
    TResult Function(_onPause value)? onPause,
    TResult Function(_onStop value)? onStop,
    TResult Function(_OnCurrentPosition value)? onCurrentPosition,
    TResult Function(_OnTotalDuration value)? onTotalDuration,
    TResult Function(_OnUpdatePlayerState value)? onUpdatePlayerState,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (onStop != null) {
      return onStop(this);
    }
    return orElse();
  }
}

abstract class _onStop implements AudioPlayerState {
  const factory _onStop() = _$onStopImpl;
}

/// @nodoc
abstract class _$$OnCurrentPositionImplCopyWith<$Res> {
  factory _$$OnCurrentPositionImplCopyWith(_$OnCurrentPositionImpl value,
          $Res Function(_$OnCurrentPositionImpl) then) =
      __$$OnCurrentPositionImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int position});
}

/// @nodoc
class __$$OnCurrentPositionImplCopyWithImpl<$Res>
    extends _$AudioPlayerStateCopyWithImpl<$Res, _$OnCurrentPositionImpl>
    implements _$$OnCurrentPositionImplCopyWith<$Res> {
  __$$OnCurrentPositionImplCopyWithImpl(_$OnCurrentPositionImpl _value,
      $Res Function(_$OnCurrentPositionImpl) _then)
      : super(_value, _then);

  /// Create a copy of AudioPlayerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? position = null,
  }) {
    return _then(_$OnCurrentPositionImpl(
      null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$OnCurrentPositionImpl implements _OnCurrentPosition {
  const _$OnCurrentPositionImpl(this.position);

  @override
  final int position;

  @override
  String toString() {
    return 'AudioPlayerState.onCurrentPosition(position: $position)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnCurrentPositionImpl &&
            (identical(other.position, position) ||
                other.position == position));
  }

  @override
  int get hashCode => Object.hash(runtimeType, position);

  /// Create a copy of AudioPlayerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OnCurrentPositionImplCopyWith<_$OnCurrentPositionImpl> get copyWith =>
      __$$OnCurrentPositionImplCopyWithImpl<_$OnCurrentPositionImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String audioUrl) getUrl,
    required TResult Function() onPlay,
    required TResult Function() onPause,
    required TResult Function() onStop,
    required TResult Function(int position) onCurrentPosition,
    required TResult Function(Duration duration) onTotalDuration,
    required TResult Function(PlayerState playerState) onUpdatePlayerState,
    required TResult Function(String message) error,
  }) {
    return onCurrentPosition(position);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String audioUrl)? getUrl,
    TResult? Function()? onPlay,
    TResult? Function()? onPause,
    TResult? Function()? onStop,
    TResult? Function(int position)? onCurrentPosition,
    TResult? Function(Duration duration)? onTotalDuration,
    TResult? Function(PlayerState playerState)? onUpdatePlayerState,
    TResult? Function(String message)? error,
  }) {
    return onCurrentPosition?.call(position);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String audioUrl)? getUrl,
    TResult Function()? onPlay,
    TResult Function()? onPause,
    TResult Function()? onStop,
    TResult Function(int position)? onCurrentPosition,
    TResult Function(Duration duration)? onTotalDuration,
    TResult Function(PlayerState playerState)? onUpdatePlayerState,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (onCurrentPosition != null) {
      return onCurrentPosition(position);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_GetUrl value) getUrl,
    required TResult Function(_OnPlay value) onPlay,
    required TResult Function(_onPause value) onPause,
    required TResult Function(_onStop value) onStop,
    required TResult Function(_OnCurrentPosition value) onCurrentPosition,
    required TResult Function(_OnTotalDuration value) onTotalDuration,
    required TResult Function(_OnUpdatePlayerState value) onUpdatePlayerState,
    required TResult Function(_Error value) error,
  }) {
    return onCurrentPosition(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_GetUrl value)? getUrl,
    TResult? Function(_OnPlay value)? onPlay,
    TResult? Function(_onPause value)? onPause,
    TResult? Function(_onStop value)? onStop,
    TResult? Function(_OnCurrentPosition value)? onCurrentPosition,
    TResult? Function(_OnTotalDuration value)? onTotalDuration,
    TResult? Function(_OnUpdatePlayerState value)? onUpdatePlayerState,
    TResult? Function(_Error value)? error,
  }) {
    return onCurrentPosition?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_GetUrl value)? getUrl,
    TResult Function(_OnPlay value)? onPlay,
    TResult Function(_onPause value)? onPause,
    TResult Function(_onStop value)? onStop,
    TResult Function(_OnCurrentPosition value)? onCurrentPosition,
    TResult Function(_OnTotalDuration value)? onTotalDuration,
    TResult Function(_OnUpdatePlayerState value)? onUpdatePlayerState,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (onCurrentPosition != null) {
      return onCurrentPosition(this);
    }
    return orElse();
  }
}

abstract class _OnCurrentPosition implements AudioPlayerState {
  const factory _OnCurrentPosition(final int position) =
      _$OnCurrentPositionImpl;

  int get position;

  /// Create a copy of AudioPlayerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OnCurrentPositionImplCopyWith<_$OnCurrentPositionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OnTotalDurationImplCopyWith<$Res> {
  factory _$$OnTotalDurationImplCopyWith(_$OnTotalDurationImpl value,
          $Res Function(_$OnTotalDurationImpl) then) =
      __$$OnTotalDurationImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Duration duration});
}

/// @nodoc
class __$$OnTotalDurationImplCopyWithImpl<$Res>
    extends _$AudioPlayerStateCopyWithImpl<$Res, _$OnTotalDurationImpl>
    implements _$$OnTotalDurationImplCopyWith<$Res> {
  __$$OnTotalDurationImplCopyWithImpl(
      _$OnTotalDurationImpl _value, $Res Function(_$OnTotalDurationImpl) _then)
      : super(_value, _then);

  /// Create a copy of AudioPlayerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? duration = null,
  }) {
    return _then(_$OnTotalDurationImpl(
      null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
    ));
  }
}

/// @nodoc

class _$OnTotalDurationImpl implements _OnTotalDuration {
  const _$OnTotalDurationImpl(this.duration);

  @override
  final Duration duration;

  @override
  String toString() {
    return 'AudioPlayerState.onTotalDuration(duration: $duration)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnTotalDurationImpl &&
            (identical(other.duration, duration) ||
                other.duration == duration));
  }

  @override
  int get hashCode => Object.hash(runtimeType, duration);

  /// Create a copy of AudioPlayerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OnTotalDurationImplCopyWith<_$OnTotalDurationImpl> get copyWith =>
      __$$OnTotalDurationImplCopyWithImpl<_$OnTotalDurationImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String audioUrl) getUrl,
    required TResult Function() onPlay,
    required TResult Function() onPause,
    required TResult Function() onStop,
    required TResult Function(int position) onCurrentPosition,
    required TResult Function(Duration duration) onTotalDuration,
    required TResult Function(PlayerState playerState) onUpdatePlayerState,
    required TResult Function(String message) error,
  }) {
    return onTotalDuration(duration);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String audioUrl)? getUrl,
    TResult? Function()? onPlay,
    TResult? Function()? onPause,
    TResult? Function()? onStop,
    TResult? Function(int position)? onCurrentPosition,
    TResult? Function(Duration duration)? onTotalDuration,
    TResult? Function(PlayerState playerState)? onUpdatePlayerState,
    TResult? Function(String message)? error,
  }) {
    return onTotalDuration?.call(duration);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String audioUrl)? getUrl,
    TResult Function()? onPlay,
    TResult Function()? onPause,
    TResult Function()? onStop,
    TResult Function(int position)? onCurrentPosition,
    TResult Function(Duration duration)? onTotalDuration,
    TResult Function(PlayerState playerState)? onUpdatePlayerState,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (onTotalDuration != null) {
      return onTotalDuration(duration);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_GetUrl value) getUrl,
    required TResult Function(_OnPlay value) onPlay,
    required TResult Function(_onPause value) onPause,
    required TResult Function(_onStop value) onStop,
    required TResult Function(_OnCurrentPosition value) onCurrentPosition,
    required TResult Function(_OnTotalDuration value) onTotalDuration,
    required TResult Function(_OnUpdatePlayerState value) onUpdatePlayerState,
    required TResult Function(_Error value) error,
  }) {
    return onTotalDuration(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_GetUrl value)? getUrl,
    TResult? Function(_OnPlay value)? onPlay,
    TResult? Function(_onPause value)? onPause,
    TResult? Function(_onStop value)? onStop,
    TResult? Function(_OnCurrentPosition value)? onCurrentPosition,
    TResult? Function(_OnTotalDuration value)? onTotalDuration,
    TResult? Function(_OnUpdatePlayerState value)? onUpdatePlayerState,
    TResult? Function(_Error value)? error,
  }) {
    return onTotalDuration?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_GetUrl value)? getUrl,
    TResult Function(_OnPlay value)? onPlay,
    TResult Function(_onPause value)? onPause,
    TResult Function(_onStop value)? onStop,
    TResult Function(_OnCurrentPosition value)? onCurrentPosition,
    TResult Function(_OnTotalDuration value)? onTotalDuration,
    TResult Function(_OnUpdatePlayerState value)? onUpdatePlayerState,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (onTotalDuration != null) {
      return onTotalDuration(this);
    }
    return orElse();
  }
}

abstract class _OnTotalDuration implements AudioPlayerState {
  const factory _OnTotalDuration(final Duration duration) =
      _$OnTotalDurationImpl;

  Duration get duration;

  /// Create a copy of AudioPlayerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OnTotalDurationImplCopyWith<_$OnTotalDurationImpl> get copyWith =>
      throw _privateConstructorUsedError;
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
    extends _$AudioPlayerStateCopyWithImpl<$Res, _$OnUpdatePlayerStateImpl>
    implements _$$OnUpdatePlayerStateImplCopyWith<$Res> {
  __$$OnUpdatePlayerStateImplCopyWithImpl(_$OnUpdatePlayerStateImpl _value,
      $Res Function(_$OnUpdatePlayerStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AudioPlayerState
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
    return 'AudioPlayerState.onUpdatePlayerState(playerState: $playerState)';
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

  /// Create a copy of AudioPlayerState
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
    required TResult Function(String audioUrl) getUrl,
    required TResult Function() onPlay,
    required TResult Function() onPause,
    required TResult Function() onStop,
    required TResult Function(int position) onCurrentPosition,
    required TResult Function(Duration duration) onTotalDuration,
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
    TResult? Function(String audioUrl)? getUrl,
    TResult? Function()? onPlay,
    TResult? Function()? onPause,
    TResult? Function()? onStop,
    TResult? Function(int position)? onCurrentPosition,
    TResult? Function(Duration duration)? onTotalDuration,
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
    TResult Function(String audioUrl)? getUrl,
    TResult Function()? onPlay,
    TResult Function()? onPause,
    TResult Function()? onStop,
    TResult Function(int position)? onCurrentPosition,
    TResult Function(Duration duration)? onTotalDuration,
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
    required TResult Function(_GetUrl value) getUrl,
    required TResult Function(_OnPlay value) onPlay,
    required TResult Function(_onPause value) onPause,
    required TResult Function(_onStop value) onStop,
    required TResult Function(_OnCurrentPosition value) onCurrentPosition,
    required TResult Function(_OnTotalDuration value) onTotalDuration,
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
    TResult? Function(_GetUrl value)? getUrl,
    TResult? Function(_OnPlay value)? onPlay,
    TResult? Function(_onPause value)? onPause,
    TResult? Function(_onStop value)? onStop,
    TResult? Function(_OnCurrentPosition value)? onCurrentPosition,
    TResult? Function(_OnTotalDuration value)? onTotalDuration,
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
    TResult Function(_GetUrl value)? getUrl,
    TResult Function(_OnPlay value)? onPlay,
    TResult Function(_onPause value)? onPause,
    TResult Function(_onStop value)? onStop,
    TResult Function(_OnCurrentPosition value)? onCurrentPosition,
    TResult Function(_OnTotalDuration value)? onTotalDuration,
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

abstract class _OnUpdatePlayerState implements AudioPlayerState {
  const factory _OnUpdatePlayerState(final PlayerState playerState) =
      _$OnUpdatePlayerStateImpl;

  PlayerState get playerState;

  /// Create a copy of AudioPlayerState
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
    extends _$AudioPlayerStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of AudioPlayerState
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
    return 'AudioPlayerState.error(message: $message)';
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

  /// Create a copy of AudioPlayerState
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
    required TResult Function(String audioUrl) getUrl,
    required TResult Function() onPlay,
    required TResult Function() onPause,
    required TResult Function() onStop,
    required TResult Function(int position) onCurrentPosition,
    required TResult Function(Duration duration) onTotalDuration,
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
    TResult? Function(String audioUrl)? getUrl,
    TResult? Function()? onPlay,
    TResult? Function()? onPause,
    TResult? Function()? onStop,
    TResult? Function(int position)? onCurrentPosition,
    TResult? Function(Duration duration)? onTotalDuration,
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
    TResult Function(String audioUrl)? getUrl,
    TResult Function()? onPlay,
    TResult Function()? onPause,
    TResult Function()? onStop,
    TResult Function(int position)? onCurrentPosition,
    TResult Function(Duration duration)? onTotalDuration,
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
    required TResult Function(_GetUrl value) getUrl,
    required TResult Function(_OnPlay value) onPlay,
    required TResult Function(_onPause value) onPause,
    required TResult Function(_onStop value) onStop,
    required TResult Function(_OnCurrentPosition value) onCurrentPosition,
    required TResult Function(_OnTotalDuration value) onTotalDuration,
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
    TResult? Function(_GetUrl value)? getUrl,
    TResult? Function(_OnPlay value)? onPlay,
    TResult? Function(_onPause value)? onPause,
    TResult? Function(_onStop value)? onStop,
    TResult? Function(_OnCurrentPosition value)? onCurrentPosition,
    TResult? Function(_OnTotalDuration value)? onTotalDuration,
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
    TResult Function(_GetUrl value)? getUrl,
    TResult Function(_OnPlay value)? onPlay,
    TResult Function(_onPause value)? onPause,
    TResult Function(_onStop value)? onStop,
    TResult Function(_OnCurrentPosition value)? onCurrentPosition,
    TResult Function(_OnTotalDuration value)? onTotalDuration,
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

abstract class _Error implements AudioPlayerState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;

  /// Create a copy of AudioPlayerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
