// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_speaking_prep_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DailySpeakingPrepEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String topicText, Set<PrepSection> sections)
        expand,
    required TResult Function(PrepSection section) askMore,
    required TResult Function() reset,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String topicText, Set<PrepSection> sections)? expand,
    TResult? Function(PrepSection section)? askMore,
    TResult? Function()? reset,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String topicText, Set<PrepSection> sections)? expand,
    TResult Function(PrepSection section)? askMore,
    TResult Function()? reset,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Expand value) expand,
    required TResult Function(_AskMore value) askMore,
    required TResult Function(_Reset value) reset,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Expand value)? expand,
    TResult? Function(_AskMore value)? askMore,
    TResult? Function(_Reset value)? reset,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Expand value)? expand,
    TResult Function(_AskMore value)? askMore,
    TResult Function(_Reset value)? reset,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailySpeakingPrepEventCopyWith<$Res> {
  factory $DailySpeakingPrepEventCopyWith(DailySpeakingPrepEvent value,
          $Res Function(DailySpeakingPrepEvent) then) =
      _$DailySpeakingPrepEventCopyWithImpl<$Res, DailySpeakingPrepEvent>;
}

/// @nodoc
class _$DailySpeakingPrepEventCopyWithImpl<$Res,
        $Val extends DailySpeakingPrepEvent>
    implements $DailySpeakingPrepEventCopyWith<$Res> {
  _$DailySpeakingPrepEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DailySpeakingPrepEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ExpandImplCopyWith<$Res> {
  factory _$$ExpandImplCopyWith(
          _$ExpandImpl value, $Res Function(_$ExpandImpl) then) =
      __$$ExpandImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String topicText, Set<PrepSection> sections});
}

/// @nodoc
class __$$ExpandImplCopyWithImpl<$Res>
    extends _$DailySpeakingPrepEventCopyWithImpl<$Res, _$ExpandImpl>
    implements _$$ExpandImplCopyWith<$Res> {
  __$$ExpandImplCopyWithImpl(
      _$ExpandImpl _value, $Res Function(_$ExpandImpl) _then)
      : super(_value, _then);

  /// Create a copy of DailySpeakingPrepEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? topicText = null,
    Object? sections = null,
  }) {
    return _then(_$ExpandImpl(
      null == topicText
          ? _value.topicText
          : topicText // ignore: cast_nullable_to_non_nullable
              as String,
      null == sections
          ? _value._sections
          : sections // ignore: cast_nullable_to_non_nullable
              as Set<PrepSection>,
    ));
  }
}

/// @nodoc

class _$ExpandImpl implements _Expand {
  const _$ExpandImpl(this.topicText, final Set<PrepSection> sections)
      : _sections = sections;

  @override
  final String topicText;
  final Set<PrepSection> _sections;
  @override
  Set<PrepSection> get sections {
    if (_sections is EqualUnmodifiableSetView) return _sections;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_sections);
  }

  @override
  String toString() {
    return 'DailySpeakingPrepEvent.expand(topicText: $topicText, sections: $sections)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExpandImpl &&
            (identical(other.topicText, topicText) ||
                other.topicText == topicText) &&
            const DeepCollectionEquality().equals(other._sections, _sections));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, topicText, const DeepCollectionEquality().hash(_sections));

  /// Create a copy of DailySpeakingPrepEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExpandImplCopyWith<_$ExpandImpl> get copyWith =>
      __$$ExpandImplCopyWithImpl<_$ExpandImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String topicText, Set<PrepSection> sections)
        expand,
    required TResult Function(PrepSection section) askMore,
    required TResult Function() reset,
  }) {
    return expand(topicText, sections);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String topicText, Set<PrepSection> sections)? expand,
    TResult? Function(PrepSection section)? askMore,
    TResult? Function()? reset,
  }) {
    return expand?.call(topicText, sections);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String topicText, Set<PrepSection> sections)? expand,
    TResult Function(PrepSection section)? askMore,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (expand != null) {
      return expand(topicText, sections);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Expand value) expand,
    required TResult Function(_AskMore value) askMore,
    required TResult Function(_Reset value) reset,
  }) {
    return expand(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Expand value)? expand,
    TResult? Function(_AskMore value)? askMore,
    TResult? Function(_Reset value)? reset,
  }) {
    return expand?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Expand value)? expand,
    TResult Function(_AskMore value)? askMore,
    TResult Function(_Reset value)? reset,
    required TResult orElse(),
  }) {
    if (expand != null) {
      return expand(this);
    }
    return orElse();
  }
}

abstract class _Expand implements DailySpeakingPrepEvent {
  const factory _Expand(
      final String topicText, final Set<PrepSection> sections) = _$ExpandImpl;

  String get topicText;
  Set<PrepSection> get sections;

  /// Create a copy of DailySpeakingPrepEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExpandImplCopyWith<_$ExpandImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AskMoreImplCopyWith<$Res> {
  factory _$$AskMoreImplCopyWith(
          _$AskMoreImpl value, $Res Function(_$AskMoreImpl) then) =
      __$$AskMoreImplCopyWithImpl<$Res>;
  @useResult
  $Res call({PrepSection section});
}

/// @nodoc
class __$$AskMoreImplCopyWithImpl<$Res>
    extends _$DailySpeakingPrepEventCopyWithImpl<$Res, _$AskMoreImpl>
    implements _$$AskMoreImplCopyWith<$Res> {
  __$$AskMoreImplCopyWithImpl(
      _$AskMoreImpl _value, $Res Function(_$AskMoreImpl) _then)
      : super(_value, _then);

  /// Create a copy of DailySpeakingPrepEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? section = null,
  }) {
    return _then(_$AskMoreImpl(
      null == section
          ? _value.section
          : section // ignore: cast_nullable_to_non_nullable
              as PrepSection,
    ));
  }
}

/// @nodoc

class _$AskMoreImpl implements _AskMore {
  const _$AskMoreImpl(this.section);

  @override
  final PrepSection section;

  @override
  String toString() {
    return 'DailySpeakingPrepEvent.askMore(section: $section)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AskMoreImpl &&
            (identical(other.section, section) || other.section == section));
  }

  @override
  int get hashCode => Object.hash(runtimeType, section);

  /// Create a copy of DailySpeakingPrepEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AskMoreImplCopyWith<_$AskMoreImpl> get copyWith =>
      __$$AskMoreImplCopyWithImpl<_$AskMoreImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String topicText, Set<PrepSection> sections)
        expand,
    required TResult Function(PrepSection section) askMore,
    required TResult Function() reset,
  }) {
    return askMore(section);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String topicText, Set<PrepSection> sections)? expand,
    TResult? Function(PrepSection section)? askMore,
    TResult? Function()? reset,
  }) {
    return askMore?.call(section);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String topicText, Set<PrepSection> sections)? expand,
    TResult Function(PrepSection section)? askMore,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (askMore != null) {
      return askMore(section);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Expand value) expand,
    required TResult Function(_AskMore value) askMore,
    required TResult Function(_Reset value) reset,
  }) {
    return askMore(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Expand value)? expand,
    TResult? Function(_AskMore value)? askMore,
    TResult? Function(_Reset value)? reset,
  }) {
    return askMore?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Expand value)? expand,
    TResult Function(_AskMore value)? askMore,
    TResult Function(_Reset value)? reset,
    required TResult orElse(),
  }) {
    if (askMore != null) {
      return askMore(this);
    }
    return orElse();
  }
}

abstract class _AskMore implements DailySpeakingPrepEvent {
  const factory _AskMore(final PrepSection section) = _$AskMoreImpl;

  PrepSection get section;

  /// Create a copy of DailySpeakingPrepEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AskMoreImplCopyWith<_$AskMoreImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ResetImplCopyWith<$Res> {
  factory _$$ResetImplCopyWith(
          _$ResetImpl value, $Res Function(_$ResetImpl) then) =
      __$$ResetImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ResetImplCopyWithImpl<$Res>
    extends _$DailySpeakingPrepEventCopyWithImpl<$Res, _$ResetImpl>
    implements _$$ResetImplCopyWith<$Res> {
  __$$ResetImplCopyWithImpl(
      _$ResetImpl _value, $Res Function(_$ResetImpl) _then)
      : super(_value, _then);

  /// Create a copy of DailySpeakingPrepEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ResetImpl implements _Reset {
  const _$ResetImpl();

  @override
  String toString() {
    return 'DailySpeakingPrepEvent.reset()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ResetImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String topicText, Set<PrepSection> sections)
        expand,
    required TResult Function(PrepSection section) askMore,
    required TResult Function() reset,
  }) {
    return reset();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String topicText, Set<PrepSection> sections)? expand,
    TResult? Function(PrepSection section)? askMore,
    TResult? Function()? reset,
  }) {
    return reset?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String topicText, Set<PrepSection> sections)? expand,
    TResult Function(PrepSection section)? askMore,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (reset != null) {
      return reset();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Expand value) expand,
    required TResult Function(_AskMore value) askMore,
    required TResult Function(_Reset value) reset,
  }) {
    return reset(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Expand value)? expand,
    TResult? Function(_AskMore value)? askMore,
    TResult? Function(_Reset value)? reset,
  }) {
    return reset?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Expand value)? expand,
    TResult Function(_AskMore value)? askMore,
    TResult Function(_Reset value)? reset,
    required TResult orElse(),
  }) {
    if (reset != null) {
      return reset(this);
    }
    return orElse();
  }
}

abstract class _Reset implements DailySpeakingPrepEvent {
  const factory _Reset() = _$ResetImpl;
}

/// @nodoc
mixin _$DailySpeakingPrepState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(DailySpeakingTopic topic, bool asking) loaded,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(DailySpeakingTopic topic, bool asking)? loaded,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(DailySpeakingTopic topic, bool asking)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailySpeakingPrepStateCopyWith<$Res> {
  factory $DailySpeakingPrepStateCopyWith(DailySpeakingPrepState value,
          $Res Function(DailySpeakingPrepState) then) =
      _$DailySpeakingPrepStateCopyWithImpl<$Res, DailySpeakingPrepState>;
}

/// @nodoc
class _$DailySpeakingPrepStateCopyWithImpl<$Res,
        $Val extends DailySpeakingPrepState>
    implements $DailySpeakingPrepStateCopyWith<$Res> {
  _$DailySpeakingPrepStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DailySpeakingPrepState
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
    extends _$DailySpeakingPrepStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of DailySpeakingPrepState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'DailySpeakingPrepState.initial()';
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
    required TResult Function(DailySpeakingTopic topic, bool asking) loaded,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(DailySpeakingTopic topic, bool asking)? loaded,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(DailySpeakingTopic topic, bool asking)? loaded,
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
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements DailySpeakingPrepState {
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
    extends _$DailySpeakingPrepStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of DailySpeakingPrepState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'DailySpeakingPrepState.loading()';
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
    required TResult Function(DailySpeakingTopic topic, bool asking) loaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(DailySpeakingTopic topic, bool asking)? loaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(DailySpeakingTopic topic, bool asking)? loaded,
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
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements DailySpeakingPrepState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({DailySpeakingTopic topic, bool asking});

  $DailySpeakingTopicCopyWith<$Res> get topic;
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$DailySpeakingPrepStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of DailySpeakingPrepState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? topic = null,
    Object? asking = null,
  }) {
    return _then(_$LoadedImpl(
      null == topic
          ? _value.topic
          : topic // ignore: cast_nullable_to_non_nullable
              as DailySpeakingTopic,
      asking: null == asking
          ? _value.asking
          : asking // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  /// Create a copy of DailySpeakingPrepState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DailySpeakingTopicCopyWith<$Res> get topic {
    return $DailySpeakingTopicCopyWith<$Res>(_value.topic, (value) {
      return _then(_value.copyWith(topic: value));
    });
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl(this.topic, {this.asking = false});

  @override
  final DailySpeakingTopic topic;
  @override
  @JsonKey()
  final bool asking;

  @override
  String toString() {
    return 'DailySpeakingPrepState.loaded(topic: $topic, asking: $asking)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            (identical(other.topic, topic) || other.topic == topic) &&
            (identical(other.asking, asking) || other.asking == asking));
  }

  @override
  int get hashCode => Object.hash(runtimeType, topic, asking);

  /// Create a copy of DailySpeakingPrepState
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
    required TResult Function(DailySpeakingTopic topic, bool asking) loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(topic, asking);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(DailySpeakingTopic topic, bool asking)? loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(topic, asking);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(DailySpeakingTopic topic, bool asking)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(topic, asking);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded implements DailySpeakingPrepState {
  const factory _Loaded(final DailySpeakingTopic topic, {final bool asking}) =
      _$LoadedImpl;

  DailySpeakingTopic get topic;
  bool get asking;

  /// Create a copy of DailySpeakingPrepState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
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
    extends _$DailySpeakingPrepStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of DailySpeakingPrepState
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
    return 'DailySpeakingPrepState.error(message: $message)';
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

  /// Create a copy of DailySpeakingPrepState
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
    required TResult Function(DailySpeakingTopic topic, bool asking) loaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(DailySpeakingTopic topic, bool asking)? loaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(DailySpeakingTopic topic, bool asking)? loaded,
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
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements DailySpeakingPrepState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;

  /// Create a copy of DailySpeakingPrepState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
