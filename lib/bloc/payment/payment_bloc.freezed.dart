// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PaymentEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadMethods,
    required TResult Function(PaymentMethod method, File proof) submitPayment,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadMethods,
    TResult? Function(PaymentMethod method, File proof)? submitPayment,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadMethods,
    TResult Function(PaymentMethod method, File proof)? submitPayment,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadMethods value) loadMethods,
    required TResult Function(_SubmitPayment value) submitPayment,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadMethods value)? loadMethods,
    TResult? Function(_SubmitPayment value)? submitPayment,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadMethods value)? loadMethods,
    TResult Function(_SubmitPayment value)? submitPayment,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentEventCopyWith<$Res> {
  factory $PaymentEventCopyWith(
          PaymentEvent value, $Res Function(PaymentEvent) then) =
      _$PaymentEventCopyWithImpl<$Res, PaymentEvent>;
}

/// @nodoc
class _$PaymentEventCopyWithImpl<$Res, $Val extends PaymentEvent>
    implements $PaymentEventCopyWith<$Res> {
  _$PaymentEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaymentEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadMethodsImplCopyWith<$Res> {
  factory _$$LoadMethodsImplCopyWith(
          _$LoadMethodsImpl value, $Res Function(_$LoadMethodsImpl) then) =
      __$$LoadMethodsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadMethodsImplCopyWithImpl<$Res>
    extends _$PaymentEventCopyWithImpl<$Res, _$LoadMethodsImpl>
    implements _$$LoadMethodsImplCopyWith<$Res> {
  __$$LoadMethodsImplCopyWithImpl(
      _$LoadMethodsImpl _value, $Res Function(_$LoadMethodsImpl) _then)
      : super(_value, _then);

  /// Create a copy of PaymentEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadMethodsImpl with DiagnosticableTreeMixin implements _LoadMethods {
  const _$LoadMethodsImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PaymentEvent.loadMethods()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'PaymentEvent.loadMethods'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadMethodsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadMethods,
    required TResult Function(PaymentMethod method, File proof) submitPayment,
  }) {
    return loadMethods();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadMethods,
    TResult? Function(PaymentMethod method, File proof)? submitPayment,
  }) {
    return loadMethods?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadMethods,
    TResult Function(PaymentMethod method, File proof)? submitPayment,
    required TResult orElse(),
  }) {
    if (loadMethods != null) {
      return loadMethods();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadMethods value) loadMethods,
    required TResult Function(_SubmitPayment value) submitPayment,
  }) {
    return loadMethods(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadMethods value)? loadMethods,
    TResult? Function(_SubmitPayment value)? submitPayment,
  }) {
    return loadMethods?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadMethods value)? loadMethods,
    TResult Function(_SubmitPayment value)? submitPayment,
    required TResult orElse(),
  }) {
    if (loadMethods != null) {
      return loadMethods(this);
    }
    return orElse();
  }
}

abstract class _LoadMethods implements PaymentEvent {
  const factory _LoadMethods() = _$LoadMethodsImpl;
}

/// @nodoc
abstract class _$$SubmitPaymentImplCopyWith<$Res> {
  factory _$$SubmitPaymentImplCopyWith(
          _$SubmitPaymentImpl value, $Res Function(_$SubmitPaymentImpl) then) =
      __$$SubmitPaymentImplCopyWithImpl<$Res>;
  @useResult
  $Res call({PaymentMethod method, File proof});

  $PaymentMethodCopyWith<$Res> get method;
}

/// @nodoc
class __$$SubmitPaymentImplCopyWithImpl<$Res>
    extends _$PaymentEventCopyWithImpl<$Res, _$SubmitPaymentImpl>
    implements _$$SubmitPaymentImplCopyWith<$Res> {
  __$$SubmitPaymentImplCopyWithImpl(
      _$SubmitPaymentImpl _value, $Res Function(_$SubmitPaymentImpl) _then)
      : super(_value, _then);

  /// Create a copy of PaymentEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? method = null,
    Object? proof = null,
  }) {
    return _then(_$SubmitPaymentImpl(
      null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as PaymentMethod,
      null == proof
          ? _value.proof
          : proof // ignore: cast_nullable_to_non_nullable
              as File,
    ));
  }

  /// Create a copy of PaymentEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PaymentMethodCopyWith<$Res> get method {
    return $PaymentMethodCopyWith<$Res>(_value.method, (value) {
      return _then(_value.copyWith(method: value));
    });
  }
}

/// @nodoc

class _$SubmitPaymentImpl
    with DiagnosticableTreeMixin
    implements _SubmitPayment {
  const _$SubmitPaymentImpl(this.method, this.proof);

  @override
  final PaymentMethod method;
  @override
  final File proof;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PaymentEvent.submitPayment(method: $method, proof: $proof)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PaymentEvent.submitPayment'))
      ..add(DiagnosticsProperty('method', method))
      ..add(DiagnosticsProperty('proof', proof));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubmitPaymentImpl &&
            (identical(other.method, method) || other.method == method) &&
            (identical(other.proof, proof) || other.proof == proof));
  }

  @override
  int get hashCode => Object.hash(runtimeType, method, proof);

  /// Create a copy of PaymentEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubmitPaymentImplCopyWith<_$SubmitPaymentImpl> get copyWith =>
      __$$SubmitPaymentImplCopyWithImpl<_$SubmitPaymentImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadMethods,
    required TResult Function(PaymentMethod method, File proof) submitPayment,
  }) {
    return submitPayment(method, proof);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadMethods,
    TResult? Function(PaymentMethod method, File proof)? submitPayment,
  }) {
    return submitPayment?.call(method, proof);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadMethods,
    TResult Function(PaymentMethod method, File proof)? submitPayment,
    required TResult orElse(),
  }) {
    if (submitPayment != null) {
      return submitPayment(method, proof);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadMethods value) loadMethods,
    required TResult Function(_SubmitPayment value) submitPayment,
  }) {
    return submitPayment(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadMethods value)? loadMethods,
    TResult? Function(_SubmitPayment value)? submitPayment,
  }) {
    return submitPayment?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadMethods value)? loadMethods,
    TResult Function(_SubmitPayment value)? submitPayment,
    required TResult orElse(),
  }) {
    if (submitPayment != null) {
      return submitPayment(this);
    }
    return orElse();
  }
}

abstract class _SubmitPayment implements PaymentEvent {
  const factory _SubmitPayment(final PaymentMethod method, final File proof) =
      _$SubmitPaymentImpl;

  PaymentMethod get method;
  File get proof;

  /// Create a copy of PaymentEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubmitPaymentImplCopyWith<_$SubmitPaymentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PaymentState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loadingMethods,
    required TResult Function(List<PaymentMethod> methods) methodsLoaded,
    required TResult Function(String message) methodsError,
    required TResult Function() submitting,
    required TResult Function(PaymentSubmission submission) submitted,
    required TResult Function(String message) submitError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loadingMethods,
    TResult? Function(List<PaymentMethod> methods)? methodsLoaded,
    TResult? Function(String message)? methodsError,
    TResult? Function()? submitting,
    TResult? Function(PaymentSubmission submission)? submitted,
    TResult? Function(String message)? submitError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loadingMethods,
    TResult Function(List<PaymentMethod> methods)? methodsLoaded,
    TResult Function(String message)? methodsError,
    TResult Function()? submitting,
    TResult Function(PaymentSubmission submission)? submitted,
    TResult Function(String message)? submitError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_LoadingMethods value) loadingMethods,
    required TResult Function(_MethodsLoaded value) methodsLoaded,
    required TResult Function(_MethodsError value) methodsError,
    required TResult Function(_Submitting value) submitting,
    required TResult Function(_Submitted value) submitted,
    required TResult Function(_SubmitError value) submitError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_LoadingMethods value)? loadingMethods,
    TResult? Function(_MethodsLoaded value)? methodsLoaded,
    TResult? Function(_MethodsError value)? methodsError,
    TResult? Function(_Submitting value)? submitting,
    TResult? Function(_Submitted value)? submitted,
    TResult? Function(_SubmitError value)? submitError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_LoadingMethods value)? loadingMethods,
    TResult Function(_MethodsLoaded value)? methodsLoaded,
    TResult Function(_MethodsError value)? methodsError,
    TResult Function(_Submitting value)? submitting,
    TResult Function(_Submitted value)? submitted,
    TResult Function(_SubmitError value)? submitError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentStateCopyWith<$Res> {
  factory $PaymentStateCopyWith(
          PaymentState value, $Res Function(PaymentState) then) =
      _$PaymentStateCopyWithImpl<$Res, PaymentState>;
}

/// @nodoc
class _$PaymentStateCopyWithImpl<$Res, $Val extends PaymentState>
    implements $PaymentStateCopyWith<$Res> {
  _$PaymentStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaymentState
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
    extends _$PaymentStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of PaymentState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl with DiagnosticableTreeMixin implements _Initial {
  const _$InitialImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PaymentState.initial()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'PaymentState.initial'));
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
    required TResult Function() loadingMethods,
    required TResult Function(List<PaymentMethod> methods) methodsLoaded,
    required TResult Function(String message) methodsError,
    required TResult Function() submitting,
    required TResult Function(PaymentSubmission submission) submitted,
    required TResult Function(String message) submitError,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loadingMethods,
    TResult? Function(List<PaymentMethod> methods)? methodsLoaded,
    TResult? Function(String message)? methodsError,
    TResult? Function()? submitting,
    TResult? Function(PaymentSubmission submission)? submitted,
    TResult? Function(String message)? submitError,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loadingMethods,
    TResult Function(List<PaymentMethod> methods)? methodsLoaded,
    TResult Function(String message)? methodsError,
    TResult Function()? submitting,
    TResult Function(PaymentSubmission submission)? submitted,
    TResult Function(String message)? submitError,
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
    required TResult Function(_LoadingMethods value) loadingMethods,
    required TResult Function(_MethodsLoaded value) methodsLoaded,
    required TResult Function(_MethodsError value) methodsError,
    required TResult Function(_Submitting value) submitting,
    required TResult Function(_Submitted value) submitted,
    required TResult Function(_SubmitError value) submitError,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_LoadingMethods value)? loadingMethods,
    TResult? Function(_MethodsLoaded value)? methodsLoaded,
    TResult? Function(_MethodsError value)? methodsError,
    TResult? Function(_Submitting value)? submitting,
    TResult? Function(_Submitted value)? submitted,
    TResult? Function(_SubmitError value)? submitError,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_LoadingMethods value)? loadingMethods,
    TResult Function(_MethodsLoaded value)? methodsLoaded,
    TResult Function(_MethodsError value)? methodsError,
    TResult Function(_Submitting value)? submitting,
    TResult Function(_Submitted value)? submitted,
    TResult Function(_SubmitError value)? submitError,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements PaymentState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingMethodsImplCopyWith<$Res> {
  factory _$$LoadingMethodsImplCopyWith(_$LoadingMethodsImpl value,
          $Res Function(_$LoadingMethodsImpl) then) =
      __$$LoadingMethodsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingMethodsImplCopyWithImpl<$Res>
    extends _$PaymentStateCopyWithImpl<$Res, _$LoadingMethodsImpl>
    implements _$$LoadingMethodsImplCopyWith<$Res> {
  __$$LoadingMethodsImplCopyWithImpl(
      _$LoadingMethodsImpl _value, $Res Function(_$LoadingMethodsImpl) _then)
      : super(_value, _then);

  /// Create a copy of PaymentState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingMethodsImpl
    with DiagnosticableTreeMixin
    implements _LoadingMethods {
  const _$LoadingMethodsImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PaymentState.loadingMethods()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'PaymentState.loadingMethods'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingMethodsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loadingMethods,
    required TResult Function(List<PaymentMethod> methods) methodsLoaded,
    required TResult Function(String message) methodsError,
    required TResult Function() submitting,
    required TResult Function(PaymentSubmission submission) submitted,
    required TResult Function(String message) submitError,
  }) {
    return loadingMethods();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loadingMethods,
    TResult? Function(List<PaymentMethod> methods)? methodsLoaded,
    TResult? Function(String message)? methodsError,
    TResult? Function()? submitting,
    TResult? Function(PaymentSubmission submission)? submitted,
    TResult? Function(String message)? submitError,
  }) {
    return loadingMethods?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loadingMethods,
    TResult Function(List<PaymentMethod> methods)? methodsLoaded,
    TResult Function(String message)? methodsError,
    TResult Function()? submitting,
    TResult Function(PaymentSubmission submission)? submitted,
    TResult Function(String message)? submitError,
    required TResult orElse(),
  }) {
    if (loadingMethods != null) {
      return loadingMethods();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_LoadingMethods value) loadingMethods,
    required TResult Function(_MethodsLoaded value) methodsLoaded,
    required TResult Function(_MethodsError value) methodsError,
    required TResult Function(_Submitting value) submitting,
    required TResult Function(_Submitted value) submitted,
    required TResult Function(_SubmitError value) submitError,
  }) {
    return loadingMethods(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_LoadingMethods value)? loadingMethods,
    TResult? Function(_MethodsLoaded value)? methodsLoaded,
    TResult? Function(_MethodsError value)? methodsError,
    TResult? Function(_Submitting value)? submitting,
    TResult? Function(_Submitted value)? submitted,
    TResult? Function(_SubmitError value)? submitError,
  }) {
    return loadingMethods?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_LoadingMethods value)? loadingMethods,
    TResult Function(_MethodsLoaded value)? methodsLoaded,
    TResult Function(_MethodsError value)? methodsError,
    TResult Function(_Submitting value)? submitting,
    TResult Function(_Submitted value)? submitted,
    TResult Function(_SubmitError value)? submitError,
    required TResult orElse(),
  }) {
    if (loadingMethods != null) {
      return loadingMethods(this);
    }
    return orElse();
  }
}

abstract class _LoadingMethods implements PaymentState {
  const factory _LoadingMethods() = _$LoadingMethodsImpl;
}

/// @nodoc
abstract class _$$MethodsLoadedImplCopyWith<$Res> {
  factory _$$MethodsLoadedImplCopyWith(
          _$MethodsLoadedImpl value, $Res Function(_$MethodsLoadedImpl) then) =
      __$$MethodsLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<PaymentMethod> methods});
}

/// @nodoc
class __$$MethodsLoadedImplCopyWithImpl<$Res>
    extends _$PaymentStateCopyWithImpl<$Res, _$MethodsLoadedImpl>
    implements _$$MethodsLoadedImplCopyWith<$Res> {
  __$$MethodsLoadedImplCopyWithImpl(
      _$MethodsLoadedImpl _value, $Res Function(_$MethodsLoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of PaymentState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? methods = null,
  }) {
    return _then(_$MethodsLoadedImpl(
      null == methods
          ? _value._methods
          : methods // ignore: cast_nullable_to_non_nullable
              as List<PaymentMethod>,
    ));
  }
}

/// @nodoc

class _$MethodsLoadedImpl
    with DiagnosticableTreeMixin
    implements _MethodsLoaded {
  const _$MethodsLoadedImpl(final List<PaymentMethod> methods)
      : _methods = methods;

  final List<PaymentMethod> _methods;
  @override
  List<PaymentMethod> get methods {
    if (_methods is EqualUnmodifiableListView) return _methods;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_methods);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PaymentState.methodsLoaded(methods: $methods)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PaymentState.methodsLoaded'))
      ..add(DiagnosticsProperty('methods', methods));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MethodsLoadedImpl &&
            const DeepCollectionEquality().equals(other._methods, _methods));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_methods));

  /// Create a copy of PaymentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MethodsLoadedImplCopyWith<_$MethodsLoadedImpl> get copyWith =>
      __$$MethodsLoadedImplCopyWithImpl<_$MethodsLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loadingMethods,
    required TResult Function(List<PaymentMethod> methods) methodsLoaded,
    required TResult Function(String message) methodsError,
    required TResult Function() submitting,
    required TResult Function(PaymentSubmission submission) submitted,
    required TResult Function(String message) submitError,
  }) {
    return methodsLoaded(methods);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loadingMethods,
    TResult? Function(List<PaymentMethod> methods)? methodsLoaded,
    TResult? Function(String message)? methodsError,
    TResult? Function()? submitting,
    TResult? Function(PaymentSubmission submission)? submitted,
    TResult? Function(String message)? submitError,
  }) {
    return methodsLoaded?.call(methods);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loadingMethods,
    TResult Function(List<PaymentMethod> methods)? methodsLoaded,
    TResult Function(String message)? methodsError,
    TResult Function()? submitting,
    TResult Function(PaymentSubmission submission)? submitted,
    TResult Function(String message)? submitError,
    required TResult orElse(),
  }) {
    if (methodsLoaded != null) {
      return methodsLoaded(methods);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_LoadingMethods value) loadingMethods,
    required TResult Function(_MethodsLoaded value) methodsLoaded,
    required TResult Function(_MethodsError value) methodsError,
    required TResult Function(_Submitting value) submitting,
    required TResult Function(_Submitted value) submitted,
    required TResult Function(_SubmitError value) submitError,
  }) {
    return methodsLoaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_LoadingMethods value)? loadingMethods,
    TResult? Function(_MethodsLoaded value)? methodsLoaded,
    TResult? Function(_MethodsError value)? methodsError,
    TResult? Function(_Submitting value)? submitting,
    TResult? Function(_Submitted value)? submitted,
    TResult? Function(_SubmitError value)? submitError,
  }) {
    return methodsLoaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_LoadingMethods value)? loadingMethods,
    TResult Function(_MethodsLoaded value)? methodsLoaded,
    TResult Function(_MethodsError value)? methodsError,
    TResult Function(_Submitting value)? submitting,
    TResult Function(_Submitted value)? submitted,
    TResult Function(_SubmitError value)? submitError,
    required TResult orElse(),
  }) {
    if (methodsLoaded != null) {
      return methodsLoaded(this);
    }
    return orElse();
  }
}

abstract class _MethodsLoaded implements PaymentState {
  const factory _MethodsLoaded(final List<PaymentMethod> methods) =
      _$MethodsLoadedImpl;

  List<PaymentMethod> get methods;

  /// Create a copy of PaymentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MethodsLoadedImplCopyWith<_$MethodsLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MethodsErrorImplCopyWith<$Res> {
  factory _$$MethodsErrorImplCopyWith(
          _$MethodsErrorImpl value, $Res Function(_$MethodsErrorImpl) then) =
      __$$MethodsErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$MethodsErrorImplCopyWithImpl<$Res>
    extends _$PaymentStateCopyWithImpl<$Res, _$MethodsErrorImpl>
    implements _$$MethodsErrorImplCopyWith<$Res> {
  __$$MethodsErrorImplCopyWithImpl(
      _$MethodsErrorImpl _value, $Res Function(_$MethodsErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of PaymentState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$MethodsErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$MethodsErrorImpl with DiagnosticableTreeMixin implements _MethodsError {
  const _$MethodsErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PaymentState.methodsError(message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PaymentState.methodsError'))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MethodsErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of PaymentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MethodsErrorImplCopyWith<_$MethodsErrorImpl> get copyWith =>
      __$$MethodsErrorImplCopyWithImpl<_$MethodsErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loadingMethods,
    required TResult Function(List<PaymentMethod> methods) methodsLoaded,
    required TResult Function(String message) methodsError,
    required TResult Function() submitting,
    required TResult Function(PaymentSubmission submission) submitted,
    required TResult Function(String message) submitError,
  }) {
    return methodsError(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loadingMethods,
    TResult? Function(List<PaymentMethod> methods)? methodsLoaded,
    TResult? Function(String message)? methodsError,
    TResult? Function()? submitting,
    TResult? Function(PaymentSubmission submission)? submitted,
    TResult? Function(String message)? submitError,
  }) {
    return methodsError?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loadingMethods,
    TResult Function(List<PaymentMethod> methods)? methodsLoaded,
    TResult Function(String message)? methodsError,
    TResult Function()? submitting,
    TResult Function(PaymentSubmission submission)? submitted,
    TResult Function(String message)? submitError,
    required TResult orElse(),
  }) {
    if (methodsError != null) {
      return methodsError(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_LoadingMethods value) loadingMethods,
    required TResult Function(_MethodsLoaded value) methodsLoaded,
    required TResult Function(_MethodsError value) methodsError,
    required TResult Function(_Submitting value) submitting,
    required TResult Function(_Submitted value) submitted,
    required TResult Function(_SubmitError value) submitError,
  }) {
    return methodsError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_LoadingMethods value)? loadingMethods,
    TResult? Function(_MethodsLoaded value)? methodsLoaded,
    TResult? Function(_MethodsError value)? methodsError,
    TResult? Function(_Submitting value)? submitting,
    TResult? Function(_Submitted value)? submitted,
    TResult? Function(_SubmitError value)? submitError,
  }) {
    return methodsError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_LoadingMethods value)? loadingMethods,
    TResult Function(_MethodsLoaded value)? methodsLoaded,
    TResult Function(_MethodsError value)? methodsError,
    TResult Function(_Submitting value)? submitting,
    TResult Function(_Submitted value)? submitted,
    TResult Function(_SubmitError value)? submitError,
    required TResult orElse(),
  }) {
    if (methodsError != null) {
      return methodsError(this);
    }
    return orElse();
  }
}

abstract class _MethodsError implements PaymentState {
  const factory _MethodsError(final String message) = _$MethodsErrorImpl;

  String get message;

  /// Create a copy of PaymentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MethodsErrorImplCopyWith<_$MethodsErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SubmittingImplCopyWith<$Res> {
  factory _$$SubmittingImplCopyWith(
          _$SubmittingImpl value, $Res Function(_$SubmittingImpl) then) =
      __$$SubmittingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SubmittingImplCopyWithImpl<$Res>
    extends _$PaymentStateCopyWithImpl<$Res, _$SubmittingImpl>
    implements _$$SubmittingImplCopyWith<$Res> {
  __$$SubmittingImplCopyWithImpl(
      _$SubmittingImpl _value, $Res Function(_$SubmittingImpl) _then)
      : super(_value, _then);

  /// Create a copy of PaymentState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SubmittingImpl with DiagnosticableTreeMixin implements _Submitting {
  const _$SubmittingImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PaymentState.submitting()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'PaymentState.submitting'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SubmittingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loadingMethods,
    required TResult Function(List<PaymentMethod> methods) methodsLoaded,
    required TResult Function(String message) methodsError,
    required TResult Function() submitting,
    required TResult Function(PaymentSubmission submission) submitted,
    required TResult Function(String message) submitError,
  }) {
    return submitting();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loadingMethods,
    TResult? Function(List<PaymentMethod> methods)? methodsLoaded,
    TResult? Function(String message)? methodsError,
    TResult? Function()? submitting,
    TResult? Function(PaymentSubmission submission)? submitted,
    TResult? Function(String message)? submitError,
  }) {
    return submitting?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loadingMethods,
    TResult Function(List<PaymentMethod> methods)? methodsLoaded,
    TResult Function(String message)? methodsError,
    TResult Function()? submitting,
    TResult Function(PaymentSubmission submission)? submitted,
    TResult Function(String message)? submitError,
    required TResult orElse(),
  }) {
    if (submitting != null) {
      return submitting();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_LoadingMethods value) loadingMethods,
    required TResult Function(_MethodsLoaded value) methodsLoaded,
    required TResult Function(_MethodsError value) methodsError,
    required TResult Function(_Submitting value) submitting,
    required TResult Function(_Submitted value) submitted,
    required TResult Function(_SubmitError value) submitError,
  }) {
    return submitting(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_LoadingMethods value)? loadingMethods,
    TResult? Function(_MethodsLoaded value)? methodsLoaded,
    TResult? Function(_MethodsError value)? methodsError,
    TResult? Function(_Submitting value)? submitting,
    TResult? Function(_Submitted value)? submitted,
    TResult? Function(_SubmitError value)? submitError,
  }) {
    return submitting?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_LoadingMethods value)? loadingMethods,
    TResult Function(_MethodsLoaded value)? methodsLoaded,
    TResult Function(_MethodsError value)? methodsError,
    TResult Function(_Submitting value)? submitting,
    TResult Function(_Submitted value)? submitted,
    TResult Function(_SubmitError value)? submitError,
    required TResult orElse(),
  }) {
    if (submitting != null) {
      return submitting(this);
    }
    return orElse();
  }
}

abstract class _Submitting implements PaymentState {
  const factory _Submitting() = _$SubmittingImpl;
}

/// @nodoc
abstract class _$$SubmittedImplCopyWith<$Res> {
  factory _$$SubmittedImplCopyWith(
          _$SubmittedImpl value, $Res Function(_$SubmittedImpl) then) =
      __$$SubmittedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({PaymentSubmission submission});

  $PaymentSubmissionCopyWith<$Res> get submission;
}

/// @nodoc
class __$$SubmittedImplCopyWithImpl<$Res>
    extends _$PaymentStateCopyWithImpl<$Res, _$SubmittedImpl>
    implements _$$SubmittedImplCopyWith<$Res> {
  __$$SubmittedImplCopyWithImpl(
      _$SubmittedImpl _value, $Res Function(_$SubmittedImpl) _then)
      : super(_value, _then);

  /// Create a copy of PaymentState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? submission = null,
  }) {
    return _then(_$SubmittedImpl(
      null == submission
          ? _value.submission
          : submission // ignore: cast_nullable_to_non_nullable
              as PaymentSubmission,
    ));
  }

  /// Create a copy of PaymentState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PaymentSubmissionCopyWith<$Res> get submission {
    return $PaymentSubmissionCopyWith<$Res>(_value.submission, (value) {
      return _then(_value.copyWith(submission: value));
    });
  }
}

/// @nodoc

class _$SubmittedImpl with DiagnosticableTreeMixin implements _Submitted {
  const _$SubmittedImpl(this.submission);

  @override
  final PaymentSubmission submission;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PaymentState.submitted(submission: $submission)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PaymentState.submitted'))
      ..add(DiagnosticsProperty('submission', submission));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubmittedImpl &&
            (identical(other.submission, submission) ||
                other.submission == submission));
  }

  @override
  int get hashCode => Object.hash(runtimeType, submission);

  /// Create a copy of PaymentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubmittedImplCopyWith<_$SubmittedImpl> get copyWith =>
      __$$SubmittedImplCopyWithImpl<_$SubmittedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loadingMethods,
    required TResult Function(List<PaymentMethod> methods) methodsLoaded,
    required TResult Function(String message) methodsError,
    required TResult Function() submitting,
    required TResult Function(PaymentSubmission submission) submitted,
    required TResult Function(String message) submitError,
  }) {
    return submitted(submission);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loadingMethods,
    TResult? Function(List<PaymentMethod> methods)? methodsLoaded,
    TResult? Function(String message)? methodsError,
    TResult? Function()? submitting,
    TResult? Function(PaymentSubmission submission)? submitted,
    TResult? Function(String message)? submitError,
  }) {
    return submitted?.call(submission);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loadingMethods,
    TResult Function(List<PaymentMethod> methods)? methodsLoaded,
    TResult Function(String message)? methodsError,
    TResult Function()? submitting,
    TResult Function(PaymentSubmission submission)? submitted,
    TResult Function(String message)? submitError,
    required TResult orElse(),
  }) {
    if (submitted != null) {
      return submitted(submission);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_LoadingMethods value) loadingMethods,
    required TResult Function(_MethodsLoaded value) methodsLoaded,
    required TResult Function(_MethodsError value) methodsError,
    required TResult Function(_Submitting value) submitting,
    required TResult Function(_Submitted value) submitted,
    required TResult Function(_SubmitError value) submitError,
  }) {
    return submitted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_LoadingMethods value)? loadingMethods,
    TResult? Function(_MethodsLoaded value)? methodsLoaded,
    TResult? Function(_MethodsError value)? methodsError,
    TResult? Function(_Submitting value)? submitting,
    TResult? Function(_Submitted value)? submitted,
    TResult? Function(_SubmitError value)? submitError,
  }) {
    return submitted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_LoadingMethods value)? loadingMethods,
    TResult Function(_MethodsLoaded value)? methodsLoaded,
    TResult Function(_MethodsError value)? methodsError,
    TResult Function(_Submitting value)? submitting,
    TResult Function(_Submitted value)? submitted,
    TResult Function(_SubmitError value)? submitError,
    required TResult orElse(),
  }) {
    if (submitted != null) {
      return submitted(this);
    }
    return orElse();
  }
}

abstract class _Submitted implements PaymentState {
  const factory _Submitted(final PaymentSubmission submission) =
      _$SubmittedImpl;

  PaymentSubmission get submission;

  /// Create a copy of PaymentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubmittedImplCopyWith<_$SubmittedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SubmitErrorImplCopyWith<$Res> {
  factory _$$SubmitErrorImplCopyWith(
          _$SubmitErrorImpl value, $Res Function(_$SubmitErrorImpl) then) =
      __$$SubmitErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$SubmitErrorImplCopyWithImpl<$Res>
    extends _$PaymentStateCopyWithImpl<$Res, _$SubmitErrorImpl>
    implements _$$SubmitErrorImplCopyWith<$Res> {
  __$$SubmitErrorImplCopyWithImpl(
      _$SubmitErrorImpl _value, $Res Function(_$SubmitErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of PaymentState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$SubmitErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SubmitErrorImpl with DiagnosticableTreeMixin implements _SubmitError {
  const _$SubmitErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PaymentState.submitError(message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PaymentState.submitError'))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubmitErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of PaymentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubmitErrorImplCopyWith<_$SubmitErrorImpl> get copyWith =>
      __$$SubmitErrorImplCopyWithImpl<_$SubmitErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loadingMethods,
    required TResult Function(List<PaymentMethod> methods) methodsLoaded,
    required TResult Function(String message) methodsError,
    required TResult Function() submitting,
    required TResult Function(PaymentSubmission submission) submitted,
    required TResult Function(String message) submitError,
  }) {
    return submitError(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loadingMethods,
    TResult? Function(List<PaymentMethod> methods)? methodsLoaded,
    TResult? Function(String message)? methodsError,
    TResult? Function()? submitting,
    TResult? Function(PaymentSubmission submission)? submitted,
    TResult? Function(String message)? submitError,
  }) {
    return submitError?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loadingMethods,
    TResult Function(List<PaymentMethod> methods)? methodsLoaded,
    TResult Function(String message)? methodsError,
    TResult Function()? submitting,
    TResult Function(PaymentSubmission submission)? submitted,
    TResult Function(String message)? submitError,
    required TResult orElse(),
  }) {
    if (submitError != null) {
      return submitError(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_LoadingMethods value) loadingMethods,
    required TResult Function(_MethodsLoaded value) methodsLoaded,
    required TResult Function(_MethodsError value) methodsError,
    required TResult Function(_Submitting value) submitting,
    required TResult Function(_Submitted value) submitted,
    required TResult Function(_SubmitError value) submitError,
  }) {
    return submitError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_LoadingMethods value)? loadingMethods,
    TResult? Function(_MethodsLoaded value)? methodsLoaded,
    TResult? Function(_MethodsError value)? methodsError,
    TResult? Function(_Submitting value)? submitting,
    TResult? Function(_Submitted value)? submitted,
    TResult? Function(_SubmitError value)? submitError,
  }) {
    return submitError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_LoadingMethods value)? loadingMethods,
    TResult Function(_MethodsLoaded value)? methodsLoaded,
    TResult Function(_MethodsError value)? methodsError,
    TResult Function(_Submitting value)? submitting,
    TResult Function(_Submitted value)? submitted,
    TResult Function(_SubmitError value)? submitError,
    required TResult orElse(),
  }) {
    if (submitError != null) {
      return submitError(this);
    }
    return orElse();
  }
}

abstract class _SubmitError implements PaymentState {
  const factory _SubmitError(final String message) = _$SubmitErrorImpl;

  String get message;

  /// Create a copy of PaymentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubmitErrorImplCopyWith<_$SubmitErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
