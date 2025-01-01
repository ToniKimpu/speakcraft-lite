// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'translate_user_answer_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TranslateUserAnswerEvent {
  List<Translation> get userTranslations => throw _privateConstructorUsedError;
  int get completedDayId => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            List<Translation> userTranslations, int completedDayId)
        addTranslateUserAnswerList,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<Translation> userTranslations, int completedDayId)?
        addTranslateUserAnswerList,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Translation> userTranslations, int completedDayId)?
        addTranslateUserAnswerList,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AddTranslateUserAnswerList value)
        addTranslateUserAnswerList,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AddTranslateUserAnswerList value)?
        addTranslateUserAnswerList,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AddTranslateUserAnswerList value)?
        addTranslateUserAnswerList,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of TranslateUserAnswerEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TranslateUserAnswerEventCopyWith<TranslateUserAnswerEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TranslateUserAnswerEventCopyWith<$Res> {
  factory $TranslateUserAnswerEventCopyWith(TranslateUserAnswerEvent value,
          $Res Function(TranslateUserAnswerEvent) then) =
      _$TranslateUserAnswerEventCopyWithImpl<$Res, TranslateUserAnswerEvent>;
  @useResult
  $Res call({List<Translation> userTranslations, int completedDayId});
}

/// @nodoc
class _$TranslateUserAnswerEventCopyWithImpl<$Res,
        $Val extends TranslateUserAnswerEvent>
    implements $TranslateUserAnswerEventCopyWith<$Res> {
  _$TranslateUserAnswerEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TranslateUserAnswerEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userTranslations = null,
    Object? completedDayId = null,
  }) {
    return _then(_value.copyWith(
      userTranslations: null == userTranslations
          ? _value.userTranslations
          : userTranslations // ignore: cast_nullable_to_non_nullable
              as List<Translation>,
      completedDayId: null == completedDayId
          ? _value.completedDayId
          : completedDayId // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AddTranslateUserAnswerListImplCopyWith<$Res>
    implements $TranslateUserAnswerEventCopyWith<$Res> {
  factory _$$AddTranslateUserAnswerListImplCopyWith(
          _$AddTranslateUserAnswerListImpl value,
          $Res Function(_$AddTranslateUserAnswerListImpl) then) =
      __$$AddTranslateUserAnswerListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Translation> userTranslations, int completedDayId});
}

/// @nodoc
class __$$AddTranslateUserAnswerListImplCopyWithImpl<$Res>
    extends _$TranslateUserAnswerEventCopyWithImpl<$Res,
        _$AddTranslateUserAnswerListImpl>
    implements _$$AddTranslateUserAnswerListImplCopyWith<$Res> {
  __$$AddTranslateUserAnswerListImplCopyWithImpl(
      _$AddTranslateUserAnswerListImpl _value,
      $Res Function(_$AddTranslateUserAnswerListImpl) _then)
      : super(_value, _then);

  /// Create a copy of TranslateUserAnswerEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userTranslations = null,
    Object? completedDayId = null,
  }) {
    return _then(_$AddTranslateUserAnswerListImpl(
      null == userTranslations
          ? _value._userTranslations
          : userTranslations // ignore: cast_nullable_to_non_nullable
              as List<Translation>,
      null == completedDayId
          ? _value.completedDayId
          : completedDayId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$AddTranslateUserAnswerListImpl implements _AddTranslateUserAnswerList {
  const _$AddTranslateUserAnswerListImpl(
      final List<Translation> userTranslations, this.completedDayId)
      : _userTranslations = userTranslations;

  final List<Translation> _userTranslations;
  @override
  List<Translation> get userTranslations {
    if (_userTranslations is EqualUnmodifiableListView)
      return _userTranslations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_userTranslations);
  }

  @override
  final int completedDayId;

  @override
  String toString() {
    return 'TranslateUserAnswerEvent.addTranslateUserAnswerList(userTranslations: $userTranslations, completedDayId: $completedDayId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddTranslateUserAnswerListImpl &&
            const DeepCollectionEquality()
                .equals(other._userTranslations, _userTranslations) &&
            (identical(other.completedDayId, completedDayId) ||
                other.completedDayId == completedDayId));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_userTranslations), completedDayId);

  /// Create a copy of TranslateUserAnswerEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddTranslateUserAnswerListImplCopyWith<_$AddTranslateUserAnswerListImpl>
      get copyWith => __$$AddTranslateUserAnswerListImplCopyWithImpl<
          _$AddTranslateUserAnswerListImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            List<Translation> userTranslations, int completedDayId)
        addTranslateUserAnswerList,
  }) {
    return addTranslateUserAnswerList(userTranslations, completedDayId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<Translation> userTranslations, int completedDayId)?
        addTranslateUserAnswerList,
  }) {
    return addTranslateUserAnswerList?.call(userTranslations, completedDayId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Translation> userTranslations, int completedDayId)?
        addTranslateUserAnswerList,
    required TResult orElse(),
  }) {
    if (addTranslateUserAnswerList != null) {
      return addTranslateUserAnswerList(userTranslations, completedDayId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AddTranslateUserAnswerList value)
        addTranslateUserAnswerList,
  }) {
    return addTranslateUserAnswerList(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AddTranslateUserAnswerList value)?
        addTranslateUserAnswerList,
  }) {
    return addTranslateUserAnswerList?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AddTranslateUserAnswerList value)?
        addTranslateUserAnswerList,
    required TResult orElse(),
  }) {
    if (addTranslateUserAnswerList != null) {
      return addTranslateUserAnswerList(this);
    }
    return orElse();
  }
}

abstract class _AddTranslateUserAnswerList implements TranslateUserAnswerEvent {
  const factory _AddTranslateUserAnswerList(
          final List<Translation> userTranslations, final int completedDayId) =
      _$AddTranslateUserAnswerListImpl;

  @override
  List<Translation> get userTranslations;
  @override
  int get completedDayId;

  /// Create a copy of TranslateUserAnswerEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddTranslateUserAnswerListImplCopyWith<_$AddTranslateUserAnswerListImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TranslateUserAnswerState {
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
abstract class $TranslateUserAnswerStateCopyWith<$Res> {
  factory $TranslateUserAnswerStateCopyWith(TranslateUserAnswerState value,
          $Res Function(TranslateUserAnswerState) then) =
      _$TranslateUserAnswerStateCopyWithImpl<$Res, TranslateUserAnswerState>;
}

/// @nodoc
class _$TranslateUserAnswerStateCopyWithImpl<$Res,
        $Val extends TranslateUserAnswerState>
    implements $TranslateUserAnswerStateCopyWith<$Res> {
  _$TranslateUserAnswerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TranslateUserAnswerState
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
    extends _$TranslateUserAnswerStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of TranslateUserAnswerState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'TranslateUserAnswerState.initial()';
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

abstract class _Initial implements TranslateUserAnswerState {
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
    extends _$TranslateUserAnswerStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of TranslateUserAnswerState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'TranslateUserAnswerState.loading()';
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

abstract class _Loading implements TranslateUserAnswerState {
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
    extends _$TranslateUserAnswerStateCopyWithImpl<$Res, _$OnSuccessImpl>
    implements _$$OnSuccessImplCopyWith<$Res> {
  __$$OnSuccessImplCopyWithImpl(
      _$OnSuccessImpl _value, $Res Function(_$OnSuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of TranslateUserAnswerState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$OnSuccessImpl implements _OnSuccess {
  const _$OnSuccessImpl();

  @override
  String toString() {
    return 'TranslateUserAnswerState.onSuccess()';
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

abstract class _OnSuccess implements TranslateUserAnswerState {
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
    extends _$TranslateUserAnswerStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of TranslateUserAnswerState
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
    return 'TranslateUserAnswerState.error(message: $message)';
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

  /// Create a copy of TranslateUserAnswerState
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

abstract class _Error implements TranslateUserAnswerState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;

  /// Create a copy of TranslateUserAnswerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
