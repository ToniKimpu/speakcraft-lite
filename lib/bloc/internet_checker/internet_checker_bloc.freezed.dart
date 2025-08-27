// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'internet_checker_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$InternetCheckerEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() internetAccess,
    required TResult Function() noInternetAccess,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? internetAccess,
    TResult? Function()? noInternetAccess,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? internetAccess,
    TResult Function()? noInternetAccess,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InternetAccess value) internetAccess,
    required TResult Function(_NoInternetAccess value) noInternetAccess,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InternetAccess value)? internetAccess,
    TResult? Function(_NoInternetAccess value)? noInternetAccess,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InternetAccess value)? internetAccess,
    TResult Function(_NoInternetAccess value)? noInternetAccess,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InternetCheckerEventCopyWith<$Res> {
  factory $InternetCheckerEventCopyWith(InternetCheckerEvent value,
          $Res Function(InternetCheckerEvent) then) =
      _$InternetCheckerEventCopyWithImpl<$Res, InternetCheckerEvent>;
}

/// @nodoc
class _$InternetCheckerEventCopyWithImpl<$Res,
        $Val extends InternetCheckerEvent>
    implements $InternetCheckerEventCopyWith<$Res> {
  _$InternetCheckerEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InternetCheckerEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InternetAccessImplCopyWith<$Res> {
  factory _$$InternetAccessImplCopyWith(_$InternetAccessImpl value,
          $Res Function(_$InternetAccessImpl) then) =
      __$$InternetAccessImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InternetAccessImplCopyWithImpl<$Res>
    extends _$InternetCheckerEventCopyWithImpl<$Res, _$InternetAccessImpl>
    implements _$$InternetAccessImplCopyWith<$Res> {
  __$$InternetAccessImplCopyWithImpl(
      _$InternetAccessImpl _value, $Res Function(_$InternetAccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of InternetCheckerEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InternetAccessImpl implements _InternetAccess {
  const _$InternetAccessImpl();

  @override
  String toString() {
    return 'InternetCheckerEvent.internetAccess()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InternetAccessImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() internetAccess,
    required TResult Function() noInternetAccess,
  }) {
    return internetAccess();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? internetAccess,
    TResult? Function()? noInternetAccess,
  }) {
    return internetAccess?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? internetAccess,
    TResult Function()? noInternetAccess,
    required TResult orElse(),
  }) {
    if (internetAccess != null) {
      return internetAccess();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InternetAccess value) internetAccess,
    required TResult Function(_NoInternetAccess value) noInternetAccess,
  }) {
    return internetAccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InternetAccess value)? internetAccess,
    TResult? Function(_NoInternetAccess value)? noInternetAccess,
  }) {
    return internetAccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InternetAccess value)? internetAccess,
    TResult Function(_NoInternetAccess value)? noInternetAccess,
    required TResult orElse(),
  }) {
    if (internetAccess != null) {
      return internetAccess(this);
    }
    return orElse();
  }
}

abstract class _InternetAccess implements InternetCheckerEvent {
  const factory _InternetAccess() = _$InternetAccessImpl;
}

/// @nodoc
abstract class _$$NoInternetAccessImplCopyWith<$Res> {
  factory _$$NoInternetAccessImplCopyWith(_$NoInternetAccessImpl value,
          $Res Function(_$NoInternetAccessImpl) then) =
      __$$NoInternetAccessImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NoInternetAccessImplCopyWithImpl<$Res>
    extends _$InternetCheckerEventCopyWithImpl<$Res, _$NoInternetAccessImpl>
    implements _$$NoInternetAccessImplCopyWith<$Res> {
  __$$NoInternetAccessImplCopyWithImpl(_$NoInternetAccessImpl _value,
      $Res Function(_$NoInternetAccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of InternetCheckerEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$NoInternetAccessImpl implements _NoInternetAccess {
  const _$NoInternetAccessImpl();

  @override
  String toString() {
    return 'InternetCheckerEvent.noInternetAccess()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$NoInternetAccessImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() internetAccess,
    required TResult Function() noInternetAccess,
  }) {
    return noInternetAccess();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? internetAccess,
    TResult? Function()? noInternetAccess,
  }) {
    return noInternetAccess?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? internetAccess,
    TResult Function()? noInternetAccess,
    required TResult orElse(),
  }) {
    if (noInternetAccess != null) {
      return noInternetAccess();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InternetAccess value) internetAccess,
    required TResult Function(_NoInternetAccess value) noInternetAccess,
  }) {
    return noInternetAccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InternetAccess value)? internetAccess,
    TResult? Function(_NoInternetAccess value)? noInternetAccess,
  }) {
    return noInternetAccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InternetAccess value)? internetAccess,
    TResult Function(_NoInternetAccess value)? noInternetAccess,
    required TResult orElse(),
  }) {
    if (noInternetAccess != null) {
      return noInternetAccess(this);
    }
    return orElse();
  }
}

abstract class _NoInternetAccess implements InternetCheckerEvent {
  const factory _NoInternetAccess() = _$NoInternetAccessImpl;
}

/// @nodoc
mixin _$InternetCheckerState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() accessInternet,
    required TResult Function() initial,
    required TResult Function() noInternet,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? accessInternet,
    TResult? Function()? initial,
    TResult? Function()? noInternet,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? accessInternet,
    TResult Function()? initial,
    TResult Function()? noInternet,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AccessInternet value) accessInternet,
    required TResult Function(_Initial value) initial,
    required TResult Function(_NoInternet value) noInternet,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AccessInternet value)? accessInternet,
    TResult? Function(_Initial value)? initial,
    TResult? Function(_NoInternet value)? noInternet,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AccessInternet value)? accessInternet,
    TResult Function(_Initial value)? initial,
    TResult Function(_NoInternet value)? noInternet,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InternetCheckerStateCopyWith<$Res> {
  factory $InternetCheckerStateCopyWith(InternetCheckerState value,
          $Res Function(InternetCheckerState) then) =
      _$InternetCheckerStateCopyWithImpl<$Res, InternetCheckerState>;
}

/// @nodoc
class _$InternetCheckerStateCopyWithImpl<$Res,
        $Val extends InternetCheckerState>
    implements $InternetCheckerStateCopyWith<$Res> {
  _$InternetCheckerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InternetCheckerState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$AccessInternetImplCopyWith<$Res> {
  factory _$$AccessInternetImplCopyWith(_$AccessInternetImpl value,
          $Res Function(_$AccessInternetImpl) then) =
      __$$AccessInternetImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AccessInternetImplCopyWithImpl<$Res>
    extends _$InternetCheckerStateCopyWithImpl<$Res, _$AccessInternetImpl>
    implements _$$AccessInternetImplCopyWith<$Res> {
  __$$AccessInternetImplCopyWithImpl(
      _$AccessInternetImpl _value, $Res Function(_$AccessInternetImpl) _then)
      : super(_value, _then);

  /// Create a copy of InternetCheckerState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AccessInternetImpl implements _AccessInternet {
  const _$AccessInternetImpl();

  @override
  String toString() {
    return 'InternetCheckerState.accessInternet()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AccessInternetImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() accessInternet,
    required TResult Function() initial,
    required TResult Function() noInternet,
  }) {
    return accessInternet();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? accessInternet,
    TResult? Function()? initial,
    TResult? Function()? noInternet,
  }) {
    return accessInternet?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? accessInternet,
    TResult Function()? initial,
    TResult Function()? noInternet,
    required TResult orElse(),
  }) {
    if (accessInternet != null) {
      return accessInternet();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AccessInternet value) accessInternet,
    required TResult Function(_Initial value) initial,
    required TResult Function(_NoInternet value) noInternet,
  }) {
    return accessInternet(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AccessInternet value)? accessInternet,
    TResult? Function(_Initial value)? initial,
    TResult? Function(_NoInternet value)? noInternet,
  }) {
    return accessInternet?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AccessInternet value)? accessInternet,
    TResult Function(_Initial value)? initial,
    TResult Function(_NoInternet value)? noInternet,
    required TResult orElse(),
  }) {
    if (accessInternet != null) {
      return accessInternet(this);
    }
    return orElse();
  }
}

abstract class _AccessInternet implements InternetCheckerState {
  const factory _AccessInternet() = _$AccessInternetImpl;
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$InternetCheckerStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of InternetCheckerState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'InternetCheckerState.initial()';
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
    required TResult Function() accessInternet,
    required TResult Function() initial,
    required TResult Function() noInternet,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? accessInternet,
    TResult? Function()? initial,
    TResult? Function()? noInternet,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? accessInternet,
    TResult Function()? initial,
    TResult Function()? noInternet,
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
    required TResult Function(_AccessInternet value) accessInternet,
    required TResult Function(_Initial value) initial,
    required TResult Function(_NoInternet value) noInternet,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AccessInternet value)? accessInternet,
    TResult? Function(_Initial value)? initial,
    TResult? Function(_NoInternet value)? noInternet,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AccessInternet value)? accessInternet,
    TResult Function(_Initial value)? initial,
    TResult Function(_NoInternet value)? noInternet,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements InternetCheckerState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$NoInternetImplCopyWith<$Res> {
  factory _$$NoInternetImplCopyWith(
          _$NoInternetImpl value, $Res Function(_$NoInternetImpl) then) =
      __$$NoInternetImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NoInternetImplCopyWithImpl<$Res>
    extends _$InternetCheckerStateCopyWithImpl<$Res, _$NoInternetImpl>
    implements _$$NoInternetImplCopyWith<$Res> {
  __$$NoInternetImplCopyWithImpl(
      _$NoInternetImpl _value, $Res Function(_$NoInternetImpl) _then)
      : super(_value, _then);

  /// Create a copy of InternetCheckerState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$NoInternetImpl implements _NoInternet {
  const _$NoInternetImpl();

  @override
  String toString() {
    return 'InternetCheckerState.noInternet()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$NoInternetImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() accessInternet,
    required TResult Function() initial,
    required TResult Function() noInternet,
  }) {
    return noInternet();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? accessInternet,
    TResult? Function()? initial,
    TResult? Function()? noInternet,
  }) {
    return noInternet?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? accessInternet,
    TResult Function()? initial,
    TResult Function()? noInternet,
    required TResult orElse(),
  }) {
    if (noInternet != null) {
      return noInternet();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AccessInternet value) accessInternet,
    required TResult Function(_Initial value) initial,
    required TResult Function(_NoInternet value) noInternet,
  }) {
    return noInternet(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AccessInternet value)? accessInternet,
    TResult? Function(_Initial value)? initial,
    TResult? Function(_NoInternet value)? noInternet,
  }) {
    return noInternet?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AccessInternet value)? accessInternet,
    TResult Function(_Initial value)? initial,
    TResult Function(_NoInternet value)? noInternet,
    required TResult orElse(),
  }) {
    if (noInternet != null) {
      return noInternet(this);
    }
    return orElse();
  }
}

abstract class _NoInternet implements InternetCheckerState {
  const factory _NoInternet() = _$NoInternetImpl;
}
