// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pattern_exercise_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PatternExerciseEvent {
  int get exerciseId => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int exerciseId) loadPatternExercises,
    required TResult Function(int exerciseId) loadPatternExercisesWithAnswers,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int exerciseId)? loadPatternExercises,
    TResult? Function(int exerciseId)? loadPatternExercisesWithAnswers,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int exerciseId)? loadPatternExercises,
    TResult Function(int exerciseId)? loadPatternExercisesWithAnswers,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadPatternExercises value) loadPatternExercises,
    required TResult Function(_LoadPatternExercisesWithAnswer value)
        loadPatternExercisesWithAnswers,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadPatternExercises value)? loadPatternExercises,
    TResult? Function(_LoadPatternExercisesWithAnswer value)?
        loadPatternExercisesWithAnswers,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadPatternExercises value)? loadPatternExercises,
    TResult Function(_LoadPatternExercisesWithAnswer value)?
        loadPatternExercisesWithAnswers,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of PatternExerciseEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PatternExerciseEventCopyWith<PatternExerciseEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PatternExerciseEventCopyWith<$Res> {
  factory $PatternExerciseEventCopyWith(PatternExerciseEvent value,
          $Res Function(PatternExerciseEvent) then) =
      _$PatternExerciseEventCopyWithImpl<$Res, PatternExerciseEvent>;
  @useResult
  $Res call({int exerciseId});
}

/// @nodoc
class _$PatternExerciseEventCopyWithImpl<$Res,
        $Val extends PatternExerciseEvent>
    implements $PatternExerciseEventCopyWith<$Res> {
  _$PatternExerciseEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PatternExerciseEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exerciseId = null,
  }) {
    return _then(_value.copyWith(
      exerciseId: null == exerciseId
          ? _value.exerciseId
          : exerciseId // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoadPatternExercisesImplCopyWith<$Res>
    implements $PatternExerciseEventCopyWith<$Res> {
  factory _$$LoadPatternExercisesImplCopyWith(_$LoadPatternExercisesImpl value,
          $Res Function(_$LoadPatternExercisesImpl) then) =
      __$$LoadPatternExercisesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int exerciseId});
}

/// @nodoc
class __$$LoadPatternExercisesImplCopyWithImpl<$Res>
    extends _$PatternExerciseEventCopyWithImpl<$Res, _$LoadPatternExercisesImpl>
    implements _$$LoadPatternExercisesImplCopyWith<$Res> {
  __$$LoadPatternExercisesImplCopyWithImpl(_$LoadPatternExercisesImpl _value,
      $Res Function(_$LoadPatternExercisesImpl) _then)
      : super(_value, _then);

  /// Create a copy of PatternExerciseEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exerciseId = null,
  }) {
    return _then(_$LoadPatternExercisesImpl(
      null == exerciseId
          ? _value.exerciseId
          : exerciseId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$LoadPatternExercisesImpl
    with DiagnosticableTreeMixin
    implements _LoadPatternExercises {
  const _$LoadPatternExercisesImpl(this.exerciseId);

  @override
  final int exerciseId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PatternExerciseEvent.loadPatternExercises(exerciseId: $exerciseId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty(
          'type', 'PatternExerciseEvent.loadPatternExercises'))
      ..add(DiagnosticsProperty('exerciseId', exerciseId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadPatternExercisesImpl &&
            (identical(other.exerciseId, exerciseId) ||
                other.exerciseId == exerciseId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, exerciseId);

  /// Create a copy of PatternExerciseEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadPatternExercisesImplCopyWith<_$LoadPatternExercisesImpl>
      get copyWith =>
          __$$LoadPatternExercisesImplCopyWithImpl<_$LoadPatternExercisesImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int exerciseId) loadPatternExercises,
    required TResult Function(int exerciseId) loadPatternExercisesWithAnswers,
  }) {
    return loadPatternExercises(exerciseId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int exerciseId)? loadPatternExercises,
    TResult? Function(int exerciseId)? loadPatternExercisesWithAnswers,
  }) {
    return loadPatternExercises?.call(exerciseId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int exerciseId)? loadPatternExercises,
    TResult Function(int exerciseId)? loadPatternExercisesWithAnswers,
    required TResult orElse(),
  }) {
    if (loadPatternExercises != null) {
      return loadPatternExercises(exerciseId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadPatternExercises value) loadPatternExercises,
    required TResult Function(_LoadPatternExercisesWithAnswer value)
        loadPatternExercisesWithAnswers,
  }) {
    return loadPatternExercises(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadPatternExercises value)? loadPatternExercises,
    TResult? Function(_LoadPatternExercisesWithAnswer value)?
        loadPatternExercisesWithAnswers,
  }) {
    return loadPatternExercises?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadPatternExercises value)? loadPatternExercises,
    TResult Function(_LoadPatternExercisesWithAnswer value)?
        loadPatternExercisesWithAnswers,
    required TResult orElse(),
  }) {
    if (loadPatternExercises != null) {
      return loadPatternExercises(this);
    }
    return orElse();
  }
}

abstract class _LoadPatternExercises implements PatternExerciseEvent {
  const factory _LoadPatternExercises(final int exerciseId) =
      _$LoadPatternExercisesImpl;

  @override
  int get exerciseId;

  /// Create a copy of PatternExerciseEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadPatternExercisesImplCopyWith<_$LoadPatternExercisesImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadPatternExercisesWithAnswerImplCopyWith<$Res>
    implements $PatternExerciseEventCopyWith<$Res> {
  factory _$$LoadPatternExercisesWithAnswerImplCopyWith(
          _$LoadPatternExercisesWithAnswerImpl value,
          $Res Function(_$LoadPatternExercisesWithAnswerImpl) then) =
      __$$LoadPatternExercisesWithAnswerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int exerciseId});
}

/// @nodoc
class __$$LoadPatternExercisesWithAnswerImplCopyWithImpl<$Res>
    extends _$PatternExerciseEventCopyWithImpl<$Res,
        _$LoadPatternExercisesWithAnswerImpl>
    implements _$$LoadPatternExercisesWithAnswerImplCopyWith<$Res> {
  __$$LoadPatternExercisesWithAnswerImplCopyWithImpl(
      _$LoadPatternExercisesWithAnswerImpl _value,
      $Res Function(_$LoadPatternExercisesWithAnswerImpl) _then)
      : super(_value, _then);

  /// Create a copy of PatternExerciseEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exerciseId = null,
  }) {
    return _then(_$LoadPatternExercisesWithAnswerImpl(
      null == exerciseId
          ? _value.exerciseId
          : exerciseId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$LoadPatternExercisesWithAnswerImpl
    with DiagnosticableTreeMixin
    implements _LoadPatternExercisesWithAnswer {
  const _$LoadPatternExercisesWithAnswerImpl(this.exerciseId);

  @override
  final int exerciseId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PatternExerciseEvent.loadPatternExercisesWithAnswers(exerciseId: $exerciseId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty(
          'type', 'PatternExerciseEvent.loadPatternExercisesWithAnswers'))
      ..add(DiagnosticsProperty('exerciseId', exerciseId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadPatternExercisesWithAnswerImpl &&
            (identical(other.exerciseId, exerciseId) ||
                other.exerciseId == exerciseId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, exerciseId);

  /// Create a copy of PatternExerciseEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadPatternExercisesWithAnswerImplCopyWith<
          _$LoadPatternExercisesWithAnswerImpl>
      get copyWith => __$$LoadPatternExercisesWithAnswerImplCopyWithImpl<
          _$LoadPatternExercisesWithAnswerImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int exerciseId) loadPatternExercises,
    required TResult Function(int exerciseId) loadPatternExercisesWithAnswers,
  }) {
    return loadPatternExercisesWithAnswers(exerciseId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int exerciseId)? loadPatternExercises,
    TResult? Function(int exerciseId)? loadPatternExercisesWithAnswers,
  }) {
    return loadPatternExercisesWithAnswers?.call(exerciseId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int exerciseId)? loadPatternExercises,
    TResult Function(int exerciseId)? loadPatternExercisesWithAnswers,
    required TResult orElse(),
  }) {
    if (loadPatternExercisesWithAnswers != null) {
      return loadPatternExercisesWithAnswers(exerciseId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadPatternExercises value) loadPatternExercises,
    required TResult Function(_LoadPatternExercisesWithAnswer value)
        loadPatternExercisesWithAnswers,
  }) {
    return loadPatternExercisesWithAnswers(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadPatternExercises value)? loadPatternExercises,
    TResult? Function(_LoadPatternExercisesWithAnswer value)?
        loadPatternExercisesWithAnswers,
  }) {
    return loadPatternExercisesWithAnswers?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadPatternExercises value)? loadPatternExercises,
    TResult Function(_LoadPatternExercisesWithAnswer value)?
        loadPatternExercisesWithAnswers,
    required TResult orElse(),
  }) {
    if (loadPatternExercisesWithAnswers != null) {
      return loadPatternExercisesWithAnswers(this);
    }
    return orElse();
  }
}

abstract class _LoadPatternExercisesWithAnswer implements PatternExerciseEvent {
  const factory _LoadPatternExercisesWithAnswer(final int exerciseId) =
      _$LoadPatternExercisesWithAnswerImpl;

  @override
  int get exerciseId;

  /// Create a copy of PatternExerciseEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadPatternExercisesWithAnswerImplCopyWith<
          _$LoadPatternExercisesWithAnswerImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PatternExerciseState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<PatternExercise> patternExercises) loaded,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<PatternExercise> patternExercises)? loaded,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<PatternExercise> patternExercises)? loaded,
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
abstract class $PatternExerciseStateCopyWith<$Res> {
  factory $PatternExerciseStateCopyWith(PatternExerciseState value,
          $Res Function(PatternExerciseState) then) =
      _$PatternExerciseStateCopyWithImpl<$Res, PatternExerciseState>;
}

/// @nodoc
class _$PatternExerciseStateCopyWithImpl<$Res,
        $Val extends PatternExerciseState>
    implements $PatternExerciseStateCopyWith<$Res> {
  _$PatternExerciseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PatternExerciseState
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
    extends _$PatternExerciseStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of PatternExerciseState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl with DiagnosticableTreeMixin implements _Initial {
  const _$InitialImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PatternExerciseState.initial()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PatternExerciseState.initial'));
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
    required TResult Function(List<PatternExercise> patternExercises) loaded,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<PatternExercise> patternExercises)? loaded,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<PatternExercise> patternExercises)? loaded,
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

abstract class _Initial implements PatternExerciseState {
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
    extends _$PatternExerciseStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of PatternExerciseState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl with DiagnosticableTreeMixin implements _Loading {
  const _$LoadingImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PatternExerciseState.loading()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PatternExerciseState.loading'));
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
    required TResult Function(List<PatternExercise> patternExercises) loaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<PatternExercise> patternExercises)? loaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<PatternExercise> patternExercises)? loaded,
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

abstract class _Loading implements PatternExerciseState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<PatternExercise> patternExercises});
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$PatternExerciseStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of PatternExerciseState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? patternExercises = null,
  }) {
    return _then(_$LoadedImpl(
      null == patternExercises
          ? _value._patternExercises
          : patternExercises // ignore: cast_nullable_to_non_nullable
              as List<PatternExercise>,
    ));
  }
}

/// @nodoc

class _$LoadedImpl with DiagnosticableTreeMixin implements _Loaded {
  const _$LoadedImpl(final List<PatternExercise> patternExercises)
      : _patternExercises = patternExercises;

  final List<PatternExercise> _patternExercises;
  @override
  List<PatternExercise> get patternExercises {
    if (_patternExercises is EqualUnmodifiableListView)
      return _patternExercises;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_patternExercises);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PatternExerciseState.loaded(patternExercises: $patternExercises)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PatternExerciseState.loaded'))
      ..add(DiagnosticsProperty('patternExercises', patternExercises));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            const DeepCollectionEquality()
                .equals(other._patternExercises, _patternExercises));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_patternExercises));

  /// Create a copy of PatternExerciseState
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
    required TResult Function(List<PatternExercise> patternExercises) loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(patternExercises);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<PatternExercise> patternExercises)? loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(patternExercises);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<PatternExercise> patternExercises)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(patternExercises);
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

abstract class _Loaded implements PatternExerciseState {
  const factory _Loaded(final List<PatternExercise> patternExercises) =
      _$LoadedImpl;

  List<PatternExercise> get patternExercises;

  /// Create a copy of PatternExerciseState
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
    extends _$PatternExerciseStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of PatternExerciseState
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
    return 'PatternExerciseState.error(message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PatternExerciseState.error'))
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

  /// Create a copy of PatternExerciseState
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
    required TResult Function(List<PatternExercise> patternExercises) loaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<PatternExercise> patternExercises)? loaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<PatternExercise> patternExercises)? loaded,
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

abstract class _Error implements PatternExerciseState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;

  /// Create a copy of PatternExerciseState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
