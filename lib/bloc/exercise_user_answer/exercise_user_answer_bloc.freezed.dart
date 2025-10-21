// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exercise_user_answer_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ExerciseUserAnswerEvent {
  List<ExerciseUserAnswer> get userAnswers =>
      throw _privateConstructorUsedError;
  Exercise get exercise => throw _privateConstructorUsedError;
  bool get isLastIndex => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<ExerciseUserAnswer> userAnswers,
            Exercise exercise, bool isLastIndex)
        addUserAnswerList,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<ExerciseUserAnswer> userAnswers, Exercise exercise,
            bool isLastIndex)?
        addUserAnswerList,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<ExerciseUserAnswer> userAnswers, Exercise exercise,
            bool isLastIndex)?
        addUserAnswerList,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AddUserAnswer value) addUserAnswerList,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AddUserAnswer value)? addUserAnswerList,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AddUserAnswer value)? addUserAnswerList,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of ExerciseUserAnswerEvent
  /// with the given fields replaced by the non-null parameter values.
  $ExerciseUserAnswerEventCopyWith<ExerciseUserAnswerEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExerciseUserAnswerEventCopyWith<$Res> {
  factory $ExerciseUserAnswerEventCopyWith(ExerciseUserAnswerEvent value,
          $Res Function(ExerciseUserAnswerEvent) then) =
      _$ExerciseUserAnswerEventCopyWithImpl<$Res, ExerciseUserAnswerEvent>;
  @useResult
  $Res call(
      {List<ExerciseUserAnswer> userAnswers,
      Exercise exercise,
      bool isLastIndex});

  $ExerciseCopyWith<$Res> get exercise;
}

/// @nodoc
class _$ExerciseUserAnswerEventCopyWithImpl<$Res,
        $Val extends ExerciseUserAnswerEvent>
    implements $ExerciseUserAnswerEventCopyWith<$Res> {
  _$ExerciseUserAnswerEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExerciseUserAnswerEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userAnswers = null,
    Object? exercise = null,
    Object? isLastIndex = null,
  }) {
    return _then(_value.copyWith(
      userAnswers: null == userAnswers
          ? _value.userAnswers
          : userAnswers // ignore: cast_nullable_to_non_nullable
              as List<ExerciseUserAnswer>,
      exercise: null == exercise
          ? _value.exercise
          : exercise // ignore: cast_nullable_to_non_nullable
              as Exercise,
      isLastIndex: null == isLastIndex
          ? _value.isLastIndex
          : isLastIndex // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  /// Create a copy of ExerciseUserAnswerEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ExerciseCopyWith<$Res> get exercise {
    return $ExerciseCopyWith<$Res>(_value.exercise, (value) {
      return _then(_value.copyWith(exercise: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AddUserAnswerImplCopyWith<$Res>
    implements $ExerciseUserAnswerEventCopyWith<$Res> {
  factory _$$AddUserAnswerImplCopyWith(
          _$AddUserAnswerImpl value, $Res Function(_$AddUserAnswerImpl) then) =
      __$$AddUserAnswerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<ExerciseUserAnswer> userAnswers,
      Exercise exercise,
      bool isLastIndex});

  @override
  $ExerciseCopyWith<$Res> get exercise;
}

/// @nodoc
class __$$AddUserAnswerImplCopyWithImpl<$Res>
    extends _$ExerciseUserAnswerEventCopyWithImpl<$Res, _$AddUserAnswerImpl>
    implements _$$AddUserAnswerImplCopyWith<$Res> {
  __$$AddUserAnswerImplCopyWithImpl(
      _$AddUserAnswerImpl _value, $Res Function(_$AddUserAnswerImpl) _then)
      : super(_value, _then);

  /// Create a copy of ExerciseUserAnswerEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userAnswers = null,
    Object? exercise = null,
    Object? isLastIndex = null,
  }) {
    return _then(_$AddUserAnswerImpl(
      null == userAnswers
          ? _value._userAnswers
          : userAnswers // ignore: cast_nullable_to_non_nullable
              as List<ExerciseUserAnswer>,
      null == exercise
          ? _value.exercise
          : exercise // ignore: cast_nullable_to_non_nullable
              as Exercise,
      null == isLastIndex
          ? _value.isLastIndex
          : isLastIndex // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$AddUserAnswerImpl implements _AddUserAnswer {
  const _$AddUserAnswerImpl(final List<ExerciseUserAnswer> userAnswers,
      this.exercise, this.isLastIndex)
      : _userAnswers = userAnswers;

  final List<ExerciseUserAnswer> _userAnswers;
  @override
  List<ExerciseUserAnswer> get userAnswers {
    if (_userAnswers is EqualUnmodifiableListView) return _userAnswers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_userAnswers);
  }

  @override
  final Exercise exercise;
  @override
  final bool isLastIndex;

  @override
  String toString() {
    return 'ExerciseUserAnswerEvent.addUserAnswerList(userAnswers: $userAnswers, exercise: $exercise, isLastIndex: $isLastIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddUserAnswerImpl &&
            const DeepCollectionEquality()
                .equals(other._userAnswers, _userAnswers) &&
            (identical(other.exercise, exercise) ||
                other.exercise == exercise) &&
            (identical(other.isLastIndex, isLastIndex) ||
                other.isLastIndex == isLastIndex));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_userAnswers), exercise, isLastIndex);

  /// Create a copy of ExerciseUserAnswerEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  _$$AddUserAnswerImplCopyWith<_$AddUserAnswerImpl> get copyWith =>
      __$$AddUserAnswerImplCopyWithImpl<_$AddUserAnswerImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<ExerciseUserAnswer> userAnswers,
            Exercise exercise, bool isLastIndex)
        addUserAnswerList,
  }) {
    return addUserAnswerList(userAnswers, exercise, isLastIndex);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<ExerciseUserAnswer> userAnswers, Exercise exercise,
            bool isLastIndex)?
        addUserAnswerList,
  }) {
    return addUserAnswerList?.call(userAnswers, exercise, isLastIndex);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<ExerciseUserAnswer> userAnswers, Exercise exercise,
            bool isLastIndex)?
        addUserAnswerList,
    required TResult orElse(),
  }) {
    if (addUserAnswerList != null) {
      return addUserAnswerList(userAnswers, exercise, isLastIndex);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AddUserAnswer value) addUserAnswerList,
  }) {
    return addUserAnswerList(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AddUserAnswer value)? addUserAnswerList,
  }) {
    return addUserAnswerList?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AddUserAnswer value)? addUserAnswerList,
    required TResult orElse(),
  }) {
    if (addUserAnswerList != null) {
      return addUserAnswerList(this);
    }
    return orElse();
  }
}

abstract class _AddUserAnswer implements ExerciseUserAnswerEvent {
  const factory _AddUserAnswer(final List<ExerciseUserAnswer> userAnswers,
      final Exercise exercise, final bool isLastIndex) = _$AddUserAnswerImpl;

  @override
  List<ExerciseUserAnswer> get userAnswers;
  @override
  Exercise get exercise;
  @override
  bool get isLastIndex;

  /// Create a copy of ExerciseUserAnswerEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  _$$AddUserAnswerImplCopyWith<_$AddUserAnswerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ExerciseUserAnswerState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() onSuccess,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? onSuccess,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? onSuccess,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_OnSuccess value) onSuccess,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_OnSuccess value)? onSuccess,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_OnSuccess value)? onSuccess,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExerciseUserAnswerStateCopyWith<$Res> {
  factory $ExerciseUserAnswerStateCopyWith(ExerciseUserAnswerState value,
          $Res Function(ExerciseUserAnswerState) then) =
      _$ExerciseUserAnswerStateCopyWithImpl<$Res, ExerciseUserAnswerState>;
}

/// @nodoc
class _$ExerciseUserAnswerStateCopyWithImpl<$Res,
        $Val extends ExerciseUserAnswerState>
    implements $ExerciseUserAnswerStateCopyWith<$Res> {
  _$ExerciseUserAnswerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExerciseUserAnswerState
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
    extends _$ExerciseUserAnswerStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of ExerciseUserAnswerState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'ExerciseUserAnswerState.initial()';
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
    required TResult Function() onSuccess,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? onSuccess,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? onSuccess,
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
    required TResult Function(_OnSuccess value) onSuccess,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_OnSuccess value)? onSuccess,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_OnSuccess value)? onSuccess,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements ExerciseUserAnswerState {
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
    extends _$ExerciseUserAnswerStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of ExerciseUserAnswerState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'ExerciseUserAnswerState.loading()';
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
    required TResult Function() onSuccess,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? onSuccess,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? onSuccess,
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
    required TResult Function(_OnSuccess value) onSuccess,
    required TResult Function(_Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_OnSuccess value)? onSuccess,
    TResult? Function(_Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_OnSuccess value)? onSuccess,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements ExerciseUserAnswerState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$OnSuccessImplCopyWith<$Res> {
  factory _$$OnSuccessImplCopyWith(
          _$OnSuccessImpl value, $Res Function(_$OnSuccessImpl) then) =
      __$$OnSuccessImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OnSuccessImplCopyWithImpl<$Res>
    extends _$ExerciseUserAnswerStateCopyWithImpl<$Res, _$OnSuccessImpl>
    implements _$$OnSuccessImplCopyWith<$Res> {
  __$$OnSuccessImplCopyWithImpl(
      _$OnSuccessImpl _value, $Res Function(_$OnSuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of ExerciseUserAnswerState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$OnSuccessImpl implements _OnSuccess {
  const _$OnSuccessImpl();

  @override
  String toString() {
    return 'ExerciseUserAnswerState.onSuccess()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$OnSuccessImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() onSuccess,
    required TResult Function(String message) error,
  }) {
    return onSuccess();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? onSuccess,
    TResult? Function(String message)? error,
  }) {
    return onSuccess?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? onSuccess,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (onSuccess != null) {
      return onSuccess();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_OnSuccess value) onSuccess,
    required TResult Function(_Error value) error,
  }) {
    return onSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_OnSuccess value)? onSuccess,
    TResult? Function(_Error value)? error,
  }) {
    return onSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_OnSuccess value)? onSuccess,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (onSuccess != null) {
      return onSuccess(this);
    }
    return orElse();
  }
}

abstract class _OnSuccess implements ExerciseUserAnswerState {
  const factory _OnSuccess() = _$OnSuccessImpl;
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
    extends _$ExerciseUserAnswerStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of ExerciseUserAnswerState
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
    return 'ExerciseUserAnswerState.error(message: $message)';
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

  /// Create a copy of ExerciseUserAnswerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() onSuccess,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? onSuccess,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? onSuccess,
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
    required TResult Function(_OnSuccess value) onSuccess,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_OnSuccess value)? onSuccess,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_OnSuccess value)? onSuccess,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements ExerciseUserAnswerState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;

  /// Create a copy of ExerciseUserAnswerState
  /// with the given fields replaced by the non-null parameter values.
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
