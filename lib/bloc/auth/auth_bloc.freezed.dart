// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AuthEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool? withLoading) authCheck,
    required TResult Function(String email, String password) loginWithEmail,
    required TResult Function() loginWithGoogle,
    required TResult Function(
            String email, String password, String name, String? profilePath)
        signupWithEmail,
    required TResult Function(String email, String token) verifyOtp,
    required TResult Function(String email) resendOtp,
    required TResult Function(String email) forgotPassword,
    required TResult Function(String email, String token, String newPassword)
        resetPassword,
    required TResult Function() logout,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool? withLoading)? authCheck,
    TResult? Function(String email, String password)? loginWithEmail,
    TResult? Function()? loginWithGoogle,
    TResult? Function(
            String email, String password, String name, String? profilePath)?
        signupWithEmail,
    TResult? Function(String email, String token)? verifyOtp,
    TResult? Function(String email)? resendOtp,
    TResult? Function(String email)? forgotPassword,
    TResult? Function(String email, String token, String newPassword)?
        resetPassword,
    TResult? Function()? logout,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool? withLoading)? authCheck,
    TResult Function(String email, String password)? loginWithEmail,
    TResult Function()? loginWithGoogle,
    TResult Function(
            String email, String password, String name, String? profilePath)?
        signupWithEmail,
    TResult Function(String email, String token)? verifyOtp,
    TResult Function(String email)? resendOtp,
    TResult Function(String email)? forgotPassword,
    TResult Function(String email, String token, String newPassword)?
        resetPassword,
    TResult Function()? logout,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthCheck value) authCheck,
    required TResult Function(_LoginWithEmail value) loginWithEmail,
    required TResult Function(_LoginWithGoogle value) loginWithGoogle,
    required TResult Function(_SignUpWithEmail value) signupWithEmail,
    required TResult Function(_VerifyOtp value) verifyOtp,
    required TResult Function(_ResendOtp value) resendOtp,
    required TResult Function(_ForgotPassword value) forgotPassword,
    required TResult Function(_ResetPassword value) resetPassword,
    required TResult Function(_Logout value) logout,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AuthCheck value)? authCheck,
    TResult? Function(_LoginWithEmail value)? loginWithEmail,
    TResult? Function(_LoginWithGoogle value)? loginWithGoogle,
    TResult? Function(_SignUpWithEmail value)? signupWithEmail,
    TResult? Function(_VerifyOtp value)? verifyOtp,
    TResult? Function(_ResendOtp value)? resendOtp,
    TResult? Function(_ForgotPassword value)? forgotPassword,
    TResult? Function(_ResetPassword value)? resetPassword,
    TResult? Function(_Logout value)? logout,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthCheck value)? authCheck,
    TResult Function(_LoginWithEmail value)? loginWithEmail,
    TResult Function(_LoginWithGoogle value)? loginWithGoogle,
    TResult Function(_SignUpWithEmail value)? signupWithEmail,
    TResult Function(_VerifyOtp value)? verifyOtp,
    TResult Function(_ResendOtp value)? resendOtp,
    TResult Function(_ForgotPassword value)? forgotPassword,
    TResult Function(_ResetPassword value)? resetPassword,
    TResult Function(_Logout value)? logout,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthEventCopyWith<$Res> {
  factory $AuthEventCopyWith(AuthEvent value, $Res Function(AuthEvent) then) =
      _$AuthEventCopyWithImpl<$Res, AuthEvent>;
}

/// @nodoc
class _$AuthEventCopyWithImpl<$Res, $Val extends AuthEvent>
    implements $AuthEventCopyWith<$Res> {
  _$AuthEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$AuthCheckImplCopyWith<$Res> {
  factory _$$AuthCheckImplCopyWith(
          _$AuthCheckImpl value, $Res Function(_$AuthCheckImpl) then) =
      __$$AuthCheckImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool? withLoading});
}

/// @nodoc
class __$$AuthCheckImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$AuthCheckImpl>
    implements _$$AuthCheckImplCopyWith<$Res> {
  __$$AuthCheckImplCopyWithImpl(
      _$AuthCheckImpl _value, $Res Function(_$AuthCheckImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? withLoading = freezed,
  }) {
    return _then(_$AuthCheckImpl(
      withLoading: freezed == withLoading
          ? _value.withLoading
          : withLoading // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

class _$AuthCheckImpl with DiagnosticableTreeMixin implements _AuthCheck {
  const _$AuthCheckImpl({this.withLoading});

  @override
  final bool? withLoading;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthEvent.authCheck(withLoading: $withLoading)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AuthEvent.authCheck'))
      ..add(DiagnosticsProperty('withLoading', withLoading));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthCheckImpl &&
            (identical(other.withLoading, withLoading) ||
                other.withLoading == withLoading));
  }

  @override
  int get hashCode => Object.hash(runtimeType, withLoading);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthCheckImplCopyWith<_$AuthCheckImpl> get copyWith =>
      __$$AuthCheckImplCopyWithImpl<_$AuthCheckImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool? withLoading) authCheck,
    required TResult Function(String email, String password) loginWithEmail,
    required TResult Function() loginWithGoogle,
    required TResult Function(
            String email, String password, String name, String? profilePath)
        signupWithEmail,
    required TResult Function(String email, String token) verifyOtp,
    required TResult Function(String email) resendOtp,
    required TResult Function(String email) forgotPassword,
    required TResult Function(String email, String token, String newPassword)
        resetPassword,
    required TResult Function() logout,
  }) {
    return authCheck(withLoading);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool? withLoading)? authCheck,
    TResult? Function(String email, String password)? loginWithEmail,
    TResult? Function()? loginWithGoogle,
    TResult? Function(
            String email, String password, String name, String? profilePath)?
        signupWithEmail,
    TResult? Function(String email, String token)? verifyOtp,
    TResult? Function(String email)? resendOtp,
    TResult? Function(String email)? forgotPassword,
    TResult? Function(String email, String token, String newPassword)?
        resetPassword,
    TResult? Function()? logout,
  }) {
    return authCheck?.call(withLoading);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool? withLoading)? authCheck,
    TResult Function(String email, String password)? loginWithEmail,
    TResult Function()? loginWithGoogle,
    TResult Function(
            String email, String password, String name, String? profilePath)?
        signupWithEmail,
    TResult Function(String email, String token)? verifyOtp,
    TResult Function(String email)? resendOtp,
    TResult Function(String email)? forgotPassword,
    TResult Function(String email, String token, String newPassword)?
        resetPassword,
    TResult Function()? logout,
    required TResult orElse(),
  }) {
    if (authCheck != null) {
      return authCheck(withLoading);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthCheck value) authCheck,
    required TResult Function(_LoginWithEmail value) loginWithEmail,
    required TResult Function(_LoginWithGoogle value) loginWithGoogle,
    required TResult Function(_SignUpWithEmail value) signupWithEmail,
    required TResult Function(_VerifyOtp value) verifyOtp,
    required TResult Function(_ResendOtp value) resendOtp,
    required TResult Function(_ForgotPassword value) forgotPassword,
    required TResult Function(_ResetPassword value) resetPassword,
    required TResult Function(_Logout value) logout,
  }) {
    return authCheck(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AuthCheck value)? authCheck,
    TResult? Function(_LoginWithEmail value)? loginWithEmail,
    TResult? Function(_LoginWithGoogle value)? loginWithGoogle,
    TResult? Function(_SignUpWithEmail value)? signupWithEmail,
    TResult? Function(_VerifyOtp value)? verifyOtp,
    TResult? Function(_ResendOtp value)? resendOtp,
    TResult? Function(_ForgotPassword value)? forgotPassword,
    TResult? Function(_ResetPassword value)? resetPassword,
    TResult? Function(_Logout value)? logout,
  }) {
    return authCheck?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthCheck value)? authCheck,
    TResult Function(_LoginWithEmail value)? loginWithEmail,
    TResult Function(_LoginWithGoogle value)? loginWithGoogle,
    TResult Function(_SignUpWithEmail value)? signupWithEmail,
    TResult Function(_VerifyOtp value)? verifyOtp,
    TResult Function(_ResendOtp value)? resendOtp,
    TResult Function(_ForgotPassword value)? forgotPassword,
    TResult Function(_ResetPassword value)? resetPassword,
    TResult Function(_Logout value)? logout,
    required TResult orElse(),
  }) {
    if (authCheck != null) {
      return authCheck(this);
    }
    return orElse();
  }
}

abstract class _AuthCheck implements AuthEvent {
  const factory _AuthCheck({final bool? withLoading}) = _$AuthCheckImpl;

  bool? get withLoading;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthCheckImplCopyWith<_$AuthCheckImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoginWithEmailImplCopyWith<$Res> {
  factory _$$LoginWithEmailImplCopyWith(_$LoginWithEmailImpl value,
          $Res Function(_$LoginWithEmailImpl) then) =
      __$$LoginWithEmailImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String email, String password});
}

/// @nodoc
class __$$LoginWithEmailImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$LoginWithEmailImpl>
    implements _$$LoginWithEmailImplCopyWith<$Res> {
  __$$LoginWithEmailImplCopyWithImpl(
      _$LoginWithEmailImpl _value, $Res Function(_$LoginWithEmailImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
  }) {
    return _then(_$LoginWithEmailImpl(
      null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LoginWithEmailImpl
    with DiagnosticableTreeMixin
    implements _LoginWithEmail {
  const _$LoginWithEmailImpl(this.email, this.password);

  @override
  final String email;
  @override
  final String password;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthEvent.loginWithEmail(email: $email, password: $password)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AuthEvent.loginWithEmail'))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('password', password));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginWithEmailImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email, password);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginWithEmailImplCopyWith<_$LoginWithEmailImpl> get copyWith =>
      __$$LoginWithEmailImplCopyWithImpl<_$LoginWithEmailImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool? withLoading) authCheck,
    required TResult Function(String email, String password) loginWithEmail,
    required TResult Function() loginWithGoogle,
    required TResult Function(
            String email, String password, String name, String? profilePath)
        signupWithEmail,
    required TResult Function(String email, String token) verifyOtp,
    required TResult Function(String email) resendOtp,
    required TResult Function(String email) forgotPassword,
    required TResult Function(String email, String token, String newPassword)
        resetPassword,
    required TResult Function() logout,
  }) {
    return loginWithEmail(email, password);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool? withLoading)? authCheck,
    TResult? Function(String email, String password)? loginWithEmail,
    TResult? Function()? loginWithGoogle,
    TResult? Function(
            String email, String password, String name, String? profilePath)?
        signupWithEmail,
    TResult? Function(String email, String token)? verifyOtp,
    TResult? Function(String email)? resendOtp,
    TResult? Function(String email)? forgotPassword,
    TResult? Function(String email, String token, String newPassword)?
        resetPassword,
    TResult? Function()? logout,
  }) {
    return loginWithEmail?.call(email, password);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool? withLoading)? authCheck,
    TResult Function(String email, String password)? loginWithEmail,
    TResult Function()? loginWithGoogle,
    TResult Function(
            String email, String password, String name, String? profilePath)?
        signupWithEmail,
    TResult Function(String email, String token)? verifyOtp,
    TResult Function(String email)? resendOtp,
    TResult Function(String email)? forgotPassword,
    TResult Function(String email, String token, String newPassword)?
        resetPassword,
    TResult Function()? logout,
    required TResult orElse(),
  }) {
    if (loginWithEmail != null) {
      return loginWithEmail(email, password);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthCheck value) authCheck,
    required TResult Function(_LoginWithEmail value) loginWithEmail,
    required TResult Function(_LoginWithGoogle value) loginWithGoogle,
    required TResult Function(_SignUpWithEmail value) signupWithEmail,
    required TResult Function(_VerifyOtp value) verifyOtp,
    required TResult Function(_ResendOtp value) resendOtp,
    required TResult Function(_ForgotPassword value) forgotPassword,
    required TResult Function(_ResetPassword value) resetPassword,
    required TResult Function(_Logout value) logout,
  }) {
    return loginWithEmail(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AuthCheck value)? authCheck,
    TResult? Function(_LoginWithEmail value)? loginWithEmail,
    TResult? Function(_LoginWithGoogle value)? loginWithGoogle,
    TResult? Function(_SignUpWithEmail value)? signupWithEmail,
    TResult? Function(_VerifyOtp value)? verifyOtp,
    TResult? Function(_ResendOtp value)? resendOtp,
    TResult? Function(_ForgotPassword value)? forgotPassword,
    TResult? Function(_ResetPassword value)? resetPassword,
    TResult? Function(_Logout value)? logout,
  }) {
    return loginWithEmail?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthCheck value)? authCheck,
    TResult Function(_LoginWithEmail value)? loginWithEmail,
    TResult Function(_LoginWithGoogle value)? loginWithGoogle,
    TResult Function(_SignUpWithEmail value)? signupWithEmail,
    TResult Function(_VerifyOtp value)? verifyOtp,
    TResult Function(_ResendOtp value)? resendOtp,
    TResult Function(_ForgotPassword value)? forgotPassword,
    TResult Function(_ResetPassword value)? resetPassword,
    TResult Function(_Logout value)? logout,
    required TResult orElse(),
  }) {
    if (loginWithEmail != null) {
      return loginWithEmail(this);
    }
    return orElse();
  }
}

abstract class _LoginWithEmail implements AuthEvent {
  const factory _LoginWithEmail(final String email, final String password) =
      _$LoginWithEmailImpl;

  String get email;
  String get password;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginWithEmailImplCopyWith<_$LoginWithEmailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoginWithGoogleImplCopyWith<$Res> {
  factory _$$LoginWithGoogleImplCopyWith(_$LoginWithGoogleImpl value,
          $Res Function(_$LoginWithGoogleImpl) then) =
      __$$LoginWithGoogleImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoginWithGoogleImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$LoginWithGoogleImpl>
    implements _$$LoginWithGoogleImplCopyWith<$Res> {
  __$$LoginWithGoogleImplCopyWithImpl(
      _$LoginWithGoogleImpl _value, $Res Function(_$LoginWithGoogleImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoginWithGoogleImpl
    with DiagnosticableTreeMixin
    implements _LoginWithGoogle {
  const _$LoginWithGoogleImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthEvent.loginWithGoogle()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'AuthEvent.loginWithGoogle'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoginWithGoogleImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool? withLoading) authCheck,
    required TResult Function(String email, String password) loginWithEmail,
    required TResult Function() loginWithGoogle,
    required TResult Function(
            String email, String password, String name, String? profilePath)
        signupWithEmail,
    required TResult Function(String email, String token) verifyOtp,
    required TResult Function(String email) resendOtp,
    required TResult Function(String email) forgotPassword,
    required TResult Function(String email, String token, String newPassword)
        resetPassword,
    required TResult Function() logout,
  }) {
    return loginWithGoogle();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool? withLoading)? authCheck,
    TResult? Function(String email, String password)? loginWithEmail,
    TResult? Function()? loginWithGoogle,
    TResult? Function(
            String email, String password, String name, String? profilePath)?
        signupWithEmail,
    TResult? Function(String email, String token)? verifyOtp,
    TResult? Function(String email)? resendOtp,
    TResult? Function(String email)? forgotPassword,
    TResult? Function(String email, String token, String newPassword)?
        resetPassword,
    TResult? Function()? logout,
  }) {
    return loginWithGoogle?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool? withLoading)? authCheck,
    TResult Function(String email, String password)? loginWithEmail,
    TResult Function()? loginWithGoogle,
    TResult Function(
            String email, String password, String name, String? profilePath)?
        signupWithEmail,
    TResult Function(String email, String token)? verifyOtp,
    TResult Function(String email)? resendOtp,
    TResult Function(String email)? forgotPassword,
    TResult Function(String email, String token, String newPassword)?
        resetPassword,
    TResult Function()? logout,
    required TResult orElse(),
  }) {
    if (loginWithGoogle != null) {
      return loginWithGoogle();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthCheck value) authCheck,
    required TResult Function(_LoginWithEmail value) loginWithEmail,
    required TResult Function(_LoginWithGoogle value) loginWithGoogle,
    required TResult Function(_SignUpWithEmail value) signupWithEmail,
    required TResult Function(_VerifyOtp value) verifyOtp,
    required TResult Function(_ResendOtp value) resendOtp,
    required TResult Function(_ForgotPassword value) forgotPassword,
    required TResult Function(_ResetPassword value) resetPassword,
    required TResult Function(_Logout value) logout,
  }) {
    return loginWithGoogle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AuthCheck value)? authCheck,
    TResult? Function(_LoginWithEmail value)? loginWithEmail,
    TResult? Function(_LoginWithGoogle value)? loginWithGoogle,
    TResult? Function(_SignUpWithEmail value)? signupWithEmail,
    TResult? Function(_VerifyOtp value)? verifyOtp,
    TResult? Function(_ResendOtp value)? resendOtp,
    TResult? Function(_ForgotPassword value)? forgotPassword,
    TResult? Function(_ResetPassword value)? resetPassword,
    TResult? Function(_Logout value)? logout,
  }) {
    return loginWithGoogle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthCheck value)? authCheck,
    TResult Function(_LoginWithEmail value)? loginWithEmail,
    TResult Function(_LoginWithGoogle value)? loginWithGoogle,
    TResult Function(_SignUpWithEmail value)? signupWithEmail,
    TResult Function(_VerifyOtp value)? verifyOtp,
    TResult Function(_ResendOtp value)? resendOtp,
    TResult Function(_ForgotPassword value)? forgotPassword,
    TResult Function(_ResetPassword value)? resetPassword,
    TResult Function(_Logout value)? logout,
    required TResult orElse(),
  }) {
    if (loginWithGoogle != null) {
      return loginWithGoogle(this);
    }
    return orElse();
  }
}

abstract class _LoginWithGoogle implements AuthEvent {
  const factory _LoginWithGoogle() = _$LoginWithGoogleImpl;
}

/// @nodoc
abstract class _$$SignUpWithEmailImplCopyWith<$Res> {
  factory _$$SignUpWithEmailImplCopyWith(_$SignUpWithEmailImpl value,
          $Res Function(_$SignUpWithEmailImpl) then) =
      __$$SignUpWithEmailImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String email, String password, String name, String? profilePath});
}

/// @nodoc
class __$$SignUpWithEmailImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$SignUpWithEmailImpl>
    implements _$$SignUpWithEmailImplCopyWith<$Res> {
  __$$SignUpWithEmailImplCopyWithImpl(
      _$SignUpWithEmailImpl _value, $Res Function(_$SignUpWithEmailImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
    Object? name = null,
    Object? profilePath = freezed,
  }) {
    return _then(_$SignUpWithEmailImpl(
      null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      freezed == profilePath
          ? _value.profilePath
          : profilePath // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$SignUpWithEmailImpl
    with DiagnosticableTreeMixin
    implements _SignUpWithEmail {
  const _$SignUpWithEmailImpl(
      this.email, this.password, this.name, this.profilePath);

  @override
  final String email;
  @override
  final String password;
  @override
  final String name;
  @override
  final String? profilePath;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthEvent.signupWithEmail(email: $email, password: $password, name: $name, profilePath: $profilePath)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AuthEvent.signupWithEmail'))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('password', password))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('profilePath', profilePath));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignUpWithEmailImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.profilePath, profilePath) ||
                other.profilePath == profilePath));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, email, password, name, profilePath);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SignUpWithEmailImplCopyWith<_$SignUpWithEmailImpl> get copyWith =>
      __$$SignUpWithEmailImplCopyWithImpl<_$SignUpWithEmailImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool? withLoading) authCheck,
    required TResult Function(String email, String password) loginWithEmail,
    required TResult Function() loginWithGoogle,
    required TResult Function(
            String email, String password, String name, String? profilePath)
        signupWithEmail,
    required TResult Function(String email, String token) verifyOtp,
    required TResult Function(String email) resendOtp,
    required TResult Function(String email) forgotPassword,
    required TResult Function(String email, String token, String newPassword)
        resetPassword,
    required TResult Function() logout,
  }) {
    return signupWithEmail(email, password, name, profilePath);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool? withLoading)? authCheck,
    TResult? Function(String email, String password)? loginWithEmail,
    TResult? Function()? loginWithGoogle,
    TResult? Function(
            String email, String password, String name, String? profilePath)?
        signupWithEmail,
    TResult? Function(String email, String token)? verifyOtp,
    TResult? Function(String email)? resendOtp,
    TResult? Function(String email)? forgotPassword,
    TResult? Function(String email, String token, String newPassword)?
        resetPassword,
    TResult? Function()? logout,
  }) {
    return signupWithEmail?.call(email, password, name, profilePath);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool? withLoading)? authCheck,
    TResult Function(String email, String password)? loginWithEmail,
    TResult Function()? loginWithGoogle,
    TResult Function(
            String email, String password, String name, String? profilePath)?
        signupWithEmail,
    TResult Function(String email, String token)? verifyOtp,
    TResult Function(String email)? resendOtp,
    TResult Function(String email)? forgotPassword,
    TResult Function(String email, String token, String newPassword)?
        resetPassword,
    TResult Function()? logout,
    required TResult orElse(),
  }) {
    if (signupWithEmail != null) {
      return signupWithEmail(email, password, name, profilePath);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthCheck value) authCheck,
    required TResult Function(_LoginWithEmail value) loginWithEmail,
    required TResult Function(_LoginWithGoogle value) loginWithGoogle,
    required TResult Function(_SignUpWithEmail value) signupWithEmail,
    required TResult Function(_VerifyOtp value) verifyOtp,
    required TResult Function(_ResendOtp value) resendOtp,
    required TResult Function(_ForgotPassword value) forgotPassword,
    required TResult Function(_ResetPassword value) resetPassword,
    required TResult Function(_Logout value) logout,
  }) {
    return signupWithEmail(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AuthCheck value)? authCheck,
    TResult? Function(_LoginWithEmail value)? loginWithEmail,
    TResult? Function(_LoginWithGoogle value)? loginWithGoogle,
    TResult? Function(_SignUpWithEmail value)? signupWithEmail,
    TResult? Function(_VerifyOtp value)? verifyOtp,
    TResult? Function(_ResendOtp value)? resendOtp,
    TResult? Function(_ForgotPassword value)? forgotPassword,
    TResult? Function(_ResetPassword value)? resetPassword,
    TResult? Function(_Logout value)? logout,
  }) {
    return signupWithEmail?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthCheck value)? authCheck,
    TResult Function(_LoginWithEmail value)? loginWithEmail,
    TResult Function(_LoginWithGoogle value)? loginWithGoogle,
    TResult Function(_SignUpWithEmail value)? signupWithEmail,
    TResult Function(_VerifyOtp value)? verifyOtp,
    TResult Function(_ResendOtp value)? resendOtp,
    TResult Function(_ForgotPassword value)? forgotPassword,
    TResult Function(_ResetPassword value)? resetPassword,
    TResult Function(_Logout value)? logout,
    required TResult orElse(),
  }) {
    if (signupWithEmail != null) {
      return signupWithEmail(this);
    }
    return orElse();
  }
}

abstract class _SignUpWithEmail implements AuthEvent {
  const factory _SignUpWithEmail(final String email, final String password,
      final String name, final String? profilePath) = _$SignUpWithEmailImpl;

  String get email;
  String get password;
  String get name;
  String? get profilePath;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SignUpWithEmailImplCopyWith<_$SignUpWithEmailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$VerifyOtpImplCopyWith<$Res> {
  factory _$$VerifyOtpImplCopyWith(
          _$VerifyOtpImpl value, $Res Function(_$VerifyOtpImpl) then) =
      __$$VerifyOtpImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String email, String token});
}

/// @nodoc
class __$$VerifyOtpImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$VerifyOtpImpl>
    implements _$$VerifyOtpImplCopyWith<$Res> {
  __$$VerifyOtpImplCopyWithImpl(
      _$VerifyOtpImpl _value, $Res Function(_$VerifyOtpImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? token = null,
  }) {
    return _then(_$VerifyOtpImpl(
      null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$VerifyOtpImpl with DiagnosticableTreeMixin implements _VerifyOtp {
  const _$VerifyOtpImpl(this.email, this.token);

  @override
  final String email;
  @override
  final String token;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthEvent.verifyOtp(email: $email, token: $token)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AuthEvent.verifyOtp'))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('token', token));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VerifyOtpImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.token, token) || other.token == token));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email, token);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VerifyOtpImplCopyWith<_$VerifyOtpImpl> get copyWith =>
      __$$VerifyOtpImplCopyWithImpl<_$VerifyOtpImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool? withLoading) authCheck,
    required TResult Function(String email, String password) loginWithEmail,
    required TResult Function() loginWithGoogle,
    required TResult Function(
            String email, String password, String name, String? profilePath)
        signupWithEmail,
    required TResult Function(String email, String token) verifyOtp,
    required TResult Function(String email) resendOtp,
    required TResult Function(String email) forgotPassword,
    required TResult Function(String email, String token, String newPassword)
        resetPassword,
    required TResult Function() logout,
  }) {
    return verifyOtp(email, token);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool? withLoading)? authCheck,
    TResult? Function(String email, String password)? loginWithEmail,
    TResult? Function()? loginWithGoogle,
    TResult? Function(
            String email, String password, String name, String? profilePath)?
        signupWithEmail,
    TResult? Function(String email, String token)? verifyOtp,
    TResult? Function(String email)? resendOtp,
    TResult? Function(String email)? forgotPassword,
    TResult? Function(String email, String token, String newPassword)?
        resetPassword,
    TResult? Function()? logout,
  }) {
    return verifyOtp?.call(email, token);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool? withLoading)? authCheck,
    TResult Function(String email, String password)? loginWithEmail,
    TResult Function()? loginWithGoogle,
    TResult Function(
            String email, String password, String name, String? profilePath)?
        signupWithEmail,
    TResult Function(String email, String token)? verifyOtp,
    TResult Function(String email)? resendOtp,
    TResult Function(String email)? forgotPassword,
    TResult Function(String email, String token, String newPassword)?
        resetPassword,
    TResult Function()? logout,
    required TResult orElse(),
  }) {
    if (verifyOtp != null) {
      return verifyOtp(email, token);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthCheck value) authCheck,
    required TResult Function(_LoginWithEmail value) loginWithEmail,
    required TResult Function(_LoginWithGoogle value) loginWithGoogle,
    required TResult Function(_SignUpWithEmail value) signupWithEmail,
    required TResult Function(_VerifyOtp value) verifyOtp,
    required TResult Function(_ResendOtp value) resendOtp,
    required TResult Function(_ForgotPassword value) forgotPassword,
    required TResult Function(_ResetPassword value) resetPassword,
    required TResult Function(_Logout value) logout,
  }) {
    return verifyOtp(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AuthCheck value)? authCheck,
    TResult? Function(_LoginWithEmail value)? loginWithEmail,
    TResult? Function(_LoginWithGoogle value)? loginWithGoogle,
    TResult? Function(_SignUpWithEmail value)? signupWithEmail,
    TResult? Function(_VerifyOtp value)? verifyOtp,
    TResult? Function(_ResendOtp value)? resendOtp,
    TResult? Function(_ForgotPassword value)? forgotPassword,
    TResult? Function(_ResetPassword value)? resetPassword,
    TResult? Function(_Logout value)? logout,
  }) {
    return verifyOtp?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthCheck value)? authCheck,
    TResult Function(_LoginWithEmail value)? loginWithEmail,
    TResult Function(_LoginWithGoogle value)? loginWithGoogle,
    TResult Function(_SignUpWithEmail value)? signupWithEmail,
    TResult Function(_VerifyOtp value)? verifyOtp,
    TResult Function(_ResendOtp value)? resendOtp,
    TResult Function(_ForgotPassword value)? forgotPassword,
    TResult Function(_ResetPassword value)? resetPassword,
    TResult Function(_Logout value)? logout,
    required TResult orElse(),
  }) {
    if (verifyOtp != null) {
      return verifyOtp(this);
    }
    return orElse();
  }
}

abstract class _VerifyOtp implements AuthEvent {
  const factory _VerifyOtp(final String email, final String token) =
      _$VerifyOtpImpl;

  String get email;
  String get token;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VerifyOtpImplCopyWith<_$VerifyOtpImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ResendOtpImplCopyWith<$Res> {
  factory _$$ResendOtpImplCopyWith(
          _$ResendOtpImpl value, $Res Function(_$ResendOtpImpl) then) =
      __$$ResendOtpImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String email});
}

/// @nodoc
class __$$ResendOtpImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$ResendOtpImpl>
    implements _$$ResendOtpImplCopyWith<$Res> {
  __$$ResendOtpImplCopyWithImpl(
      _$ResendOtpImpl _value, $Res Function(_$ResendOtpImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
  }) {
    return _then(_$ResendOtpImpl(
      null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ResendOtpImpl with DiagnosticableTreeMixin implements _ResendOtp {
  const _$ResendOtpImpl(this.email);

  @override
  final String email;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthEvent.resendOtp(email: $email)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AuthEvent.resendOtp'))
      ..add(DiagnosticsProperty('email', email));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResendOtpImpl &&
            (identical(other.email, email) || other.email == email));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ResendOtpImplCopyWith<_$ResendOtpImpl> get copyWith =>
      __$$ResendOtpImplCopyWithImpl<_$ResendOtpImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool? withLoading) authCheck,
    required TResult Function(String email, String password) loginWithEmail,
    required TResult Function() loginWithGoogle,
    required TResult Function(
            String email, String password, String name, String? profilePath)
        signupWithEmail,
    required TResult Function(String email, String token) verifyOtp,
    required TResult Function(String email) resendOtp,
    required TResult Function(String email) forgotPassword,
    required TResult Function(String email, String token, String newPassword)
        resetPassword,
    required TResult Function() logout,
  }) {
    return resendOtp(email);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool? withLoading)? authCheck,
    TResult? Function(String email, String password)? loginWithEmail,
    TResult? Function()? loginWithGoogle,
    TResult? Function(
            String email, String password, String name, String? profilePath)?
        signupWithEmail,
    TResult? Function(String email, String token)? verifyOtp,
    TResult? Function(String email)? resendOtp,
    TResult? Function(String email)? forgotPassword,
    TResult? Function(String email, String token, String newPassword)?
        resetPassword,
    TResult? Function()? logout,
  }) {
    return resendOtp?.call(email);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool? withLoading)? authCheck,
    TResult Function(String email, String password)? loginWithEmail,
    TResult Function()? loginWithGoogle,
    TResult Function(
            String email, String password, String name, String? profilePath)?
        signupWithEmail,
    TResult Function(String email, String token)? verifyOtp,
    TResult Function(String email)? resendOtp,
    TResult Function(String email)? forgotPassword,
    TResult Function(String email, String token, String newPassword)?
        resetPassword,
    TResult Function()? logout,
    required TResult orElse(),
  }) {
    if (resendOtp != null) {
      return resendOtp(email);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthCheck value) authCheck,
    required TResult Function(_LoginWithEmail value) loginWithEmail,
    required TResult Function(_LoginWithGoogle value) loginWithGoogle,
    required TResult Function(_SignUpWithEmail value) signupWithEmail,
    required TResult Function(_VerifyOtp value) verifyOtp,
    required TResult Function(_ResendOtp value) resendOtp,
    required TResult Function(_ForgotPassword value) forgotPassword,
    required TResult Function(_ResetPassword value) resetPassword,
    required TResult Function(_Logout value) logout,
  }) {
    return resendOtp(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AuthCheck value)? authCheck,
    TResult? Function(_LoginWithEmail value)? loginWithEmail,
    TResult? Function(_LoginWithGoogle value)? loginWithGoogle,
    TResult? Function(_SignUpWithEmail value)? signupWithEmail,
    TResult? Function(_VerifyOtp value)? verifyOtp,
    TResult? Function(_ResendOtp value)? resendOtp,
    TResult? Function(_ForgotPassword value)? forgotPassword,
    TResult? Function(_ResetPassword value)? resetPassword,
    TResult? Function(_Logout value)? logout,
  }) {
    return resendOtp?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthCheck value)? authCheck,
    TResult Function(_LoginWithEmail value)? loginWithEmail,
    TResult Function(_LoginWithGoogle value)? loginWithGoogle,
    TResult Function(_SignUpWithEmail value)? signupWithEmail,
    TResult Function(_VerifyOtp value)? verifyOtp,
    TResult Function(_ResendOtp value)? resendOtp,
    TResult Function(_ForgotPassword value)? forgotPassword,
    TResult Function(_ResetPassword value)? resetPassword,
    TResult Function(_Logout value)? logout,
    required TResult orElse(),
  }) {
    if (resendOtp != null) {
      return resendOtp(this);
    }
    return orElse();
  }
}

abstract class _ResendOtp implements AuthEvent {
  const factory _ResendOtp(final String email) = _$ResendOtpImpl;

  String get email;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ResendOtpImplCopyWith<_$ResendOtpImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ForgotPasswordImplCopyWith<$Res> {
  factory _$$ForgotPasswordImplCopyWith(_$ForgotPasswordImpl value,
          $Res Function(_$ForgotPasswordImpl) then) =
      __$$ForgotPasswordImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String email});
}

/// @nodoc
class __$$ForgotPasswordImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$ForgotPasswordImpl>
    implements _$$ForgotPasswordImplCopyWith<$Res> {
  __$$ForgotPasswordImplCopyWithImpl(
      _$ForgotPasswordImpl _value, $Res Function(_$ForgotPasswordImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
  }) {
    return _then(_$ForgotPasswordImpl(
      null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ForgotPasswordImpl
    with DiagnosticableTreeMixin
    implements _ForgotPassword {
  const _$ForgotPasswordImpl(this.email);

  @override
  final String email;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthEvent.forgotPassword(email: $email)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AuthEvent.forgotPassword'))
      ..add(DiagnosticsProperty('email', email));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ForgotPasswordImpl &&
            (identical(other.email, email) || other.email == email));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ForgotPasswordImplCopyWith<_$ForgotPasswordImpl> get copyWith =>
      __$$ForgotPasswordImplCopyWithImpl<_$ForgotPasswordImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool? withLoading) authCheck,
    required TResult Function(String email, String password) loginWithEmail,
    required TResult Function() loginWithGoogle,
    required TResult Function(
            String email, String password, String name, String? profilePath)
        signupWithEmail,
    required TResult Function(String email, String token) verifyOtp,
    required TResult Function(String email) resendOtp,
    required TResult Function(String email) forgotPassword,
    required TResult Function(String email, String token, String newPassword)
        resetPassword,
    required TResult Function() logout,
  }) {
    return forgotPassword(email);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool? withLoading)? authCheck,
    TResult? Function(String email, String password)? loginWithEmail,
    TResult? Function()? loginWithGoogle,
    TResult? Function(
            String email, String password, String name, String? profilePath)?
        signupWithEmail,
    TResult? Function(String email, String token)? verifyOtp,
    TResult? Function(String email)? resendOtp,
    TResult? Function(String email)? forgotPassword,
    TResult? Function(String email, String token, String newPassword)?
        resetPassword,
    TResult? Function()? logout,
  }) {
    return forgotPassword?.call(email);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool? withLoading)? authCheck,
    TResult Function(String email, String password)? loginWithEmail,
    TResult Function()? loginWithGoogle,
    TResult Function(
            String email, String password, String name, String? profilePath)?
        signupWithEmail,
    TResult Function(String email, String token)? verifyOtp,
    TResult Function(String email)? resendOtp,
    TResult Function(String email)? forgotPassword,
    TResult Function(String email, String token, String newPassword)?
        resetPassword,
    TResult Function()? logout,
    required TResult orElse(),
  }) {
    if (forgotPassword != null) {
      return forgotPassword(email);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthCheck value) authCheck,
    required TResult Function(_LoginWithEmail value) loginWithEmail,
    required TResult Function(_LoginWithGoogle value) loginWithGoogle,
    required TResult Function(_SignUpWithEmail value) signupWithEmail,
    required TResult Function(_VerifyOtp value) verifyOtp,
    required TResult Function(_ResendOtp value) resendOtp,
    required TResult Function(_ForgotPassword value) forgotPassword,
    required TResult Function(_ResetPassword value) resetPassword,
    required TResult Function(_Logout value) logout,
  }) {
    return forgotPassword(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AuthCheck value)? authCheck,
    TResult? Function(_LoginWithEmail value)? loginWithEmail,
    TResult? Function(_LoginWithGoogle value)? loginWithGoogle,
    TResult? Function(_SignUpWithEmail value)? signupWithEmail,
    TResult? Function(_VerifyOtp value)? verifyOtp,
    TResult? Function(_ResendOtp value)? resendOtp,
    TResult? Function(_ForgotPassword value)? forgotPassword,
    TResult? Function(_ResetPassword value)? resetPassword,
    TResult? Function(_Logout value)? logout,
  }) {
    return forgotPassword?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthCheck value)? authCheck,
    TResult Function(_LoginWithEmail value)? loginWithEmail,
    TResult Function(_LoginWithGoogle value)? loginWithGoogle,
    TResult Function(_SignUpWithEmail value)? signupWithEmail,
    TResult Function(_VerifyOtp value)? verifyOtp,
    TResult Function(_ResendOtp value)? resendOtp,
    TResult Function(_ForgotPassword value)? forgotPassword,
    TResult Function(_ResetPassword value)? resetPassword,
    TResult Function(_Logout value)? logout,
    required TResult orElse(),
  }) {
    if (forgotPassword != null) {
      return forgotPassword(this);
    }
    return orElse();
  }
}

abstract class _ForgotPassword implements AuthEvent {
  const factory _ForgotPassword(final String email) = _$ForgotPasswordImpl;

  String get email;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ForgotPasswordImplCopyWith<_$ForgotPasswordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ResetPasswordImplCopyWith<$Res> {
  factory _$$ResetPasswordImplCopyWith(
          _$ResetPasswordImpl value, $Res Function(_$ResetPasswordImpl) then) =
      __$$ResetPasswordImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String email, String token, String newPassword});
}

/// @nodoc
class __$$ResetPasswordImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$ResetPasswordImpl>
    implements _$$ResetPasswordImplCopyWith<$Res> {
  __$$ResetPasswordImplCopyWithImpl(
      _$ResetPasswordImpl _value, $Res Function(_$ResetPasswordImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? token = null,
    Object? newPassword = null,
  }) {
    return _then(_$ResetPasswordImpl(
      null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      null == newPassword
          ? _value.newPassword
          : newPassword // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ResetPasswordImpl
    with DiagnosticableTreeMixin
    implements _ResetPassword {
  const _$ResetPasswordImpl(this.email, this.token, this.newPassword);

  @override
  final String email;
  @override
  final String token;
  @override
  final String newPassword;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthEvent.resetPassword(email: $email, token: $token, newPassword: $newPassword)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AuthEvent.resetPassword'))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('token', token))
      ..add(DiagnosticsProperty('newPassword', newPassword));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResetPasswordImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.newPassword, newPassword) ||
                other.newPassword == newPassword));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email, token, newPassword);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ResetPasswordImplCopyWith<_$ResetPasswordImpl> get copyWith =>
      __$$ResetPasswordImplCopyWithImpl<_$ResetPasswordImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool? withLoading) authCheck,
    required TResult Function(String email, String password) loginWithEmail,
    required TResult Function() loginWithGoogle,
    required TResult Function(
            String email, String password, String name, String? profilePath)
        signupWithEmail,
    required TResult Function(String email, String token) verifyOtp,
    required TResult Function(String email) resendOtp,
    required TResult Function(String email) forgotPassword,
    required TResult Function(String email, String token, String newPassword)
        resetPassword,
    required TResult Function() logout,
  }) {
    return resetPassword(email, token, newPassword);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool? withLoading)? authCheck,
    TResult? Function(String email, String password)? loginWithEmail,
    TResult? Function()? loginWithGoogle,
    TResult? Function(
            String email, String password, String name, String? profilePath)?
        signupWithEmail,
    TResult? Function(String email, String token)? verifyOtp,
    TResult? Function(String email)? resendOtp,
    TResult? Function(String email)? forgotPassword,
    TResult? Function(String email, String token, String newPassword)?
        resetPassword,
    TResult? Function()? logout,
  }) {
    return resetPassword?.call(email, token, newPassword);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool? withLoading)? authCheck,
    TResult Function(String email, String password)? loginWithEmail,
    TResult Function()? loginWithGoogle,
    TResult Function(
            String email, String password, String name, String? profilePath)?
        signupWithEmail,
    TResult Function(String email, String token)? verifyOtp,
    TResult Function(String email)? resendOtp,
    TResult Function(String email)? forgotPassword,
    TResult Function(String email, String token, String newPassword)?
        resetPassword,
    TResult Function()? logout,
    required TResult orElse(),
  }) {
    if (resetPassword != null) {
      return resetPassword(email, token, newPassword);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthCheck value) authCheck,
    required TResult Function(_LoginWithEmail value) loginWithEmail,
    required TResult Function(_LoginWithGoogle value) loginWithGoogle,
    required TResult Function(_SignUpWithEmail value) signupWithEmail,
    required TResult Function(_VerifyOtp value) verifyOtp,
    required TResult Function(_ResendOtp value) resendOtp,
    required TResult Function(_ForgotPassword value) forgotPassword,
    required TResult Function(_ResetPassword value) resetPassword,
    required TResult Function(_Logout value) logout,
  }) {
    return resetPassword(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AuthCheck value)? authCheck,
    TResult? Function(_LoginWithEmail value)? loginWithEmail,
    TResult? Function(_LoginWithGoogle value)? loginWithGoogle,
    TResult? Function(_SignUpWithEmail value)? signupWithEmail,
    TResult? Function(_VerifyOtp value)? verifyOtp,
    TResult? Function(_ResendOtp value)? resendOtp,
    TResult? Function(_ForgotPassword value)? forgotPassword,
    TResult? Function(_ResetPassword value)? resetPassword,
    TResult? Function(_Logout value)? logout,
  }) {
    return resetPassword?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthCheck value)? authCheck,
    TResult Function(_LoginWithEmail value)? loginWithEmail,
    TResult Function(_LoginWithGoogle value)? loginWithGoogle,
    TResult Function(_SignUpWithEmail value)? signupWithEmail,
    TResult Function(_VerifyOtp value)? verifyOtp,
    TResult Function(_ResendOtp value)? resendOtp,
    TResult Function(_ForgotPassword value)? forgotPassword,
    TResult Function(_ResetPassword value)? resetPassword,
    TResult Function(_Logout value)? logout,
    required TResult orElse(),
  }) {
    if (resetPassword != null) {
      return resetPassword(this);
    }
    return orElse();
  }
}

abstract class _ResetPassword implements AuthEvent {
  const factory _ResetPassword(
          final String email, final String token, final String newPassword) =
      _$ResetPasswordImpl;

  String get email;
  String get token;
  String get newPassword;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ResetPasswordImplCopyWith<_$ResetPasswordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LogoutImplCopyWith<$Res> {
  factory _$$LogoutImplCopyWith(
          _$LogoutImpl value, $Res Function(_$LogoutImpl) then) =
      __$$LogoutImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LogoutImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$LogoutImpl>
    implements _$$LogoutImplCopyWith<$Res> {
  __$$LogoutImplCopyWithImpl(
      _$LogoutImpl _value, $Res Function(_$LogoutImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LogoutImpl with DiagnosticableTreeMixin implements _Logout {
  const _$LogoutImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthEvent.logout()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'AuthEvent.logout'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LogoutImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool? withLoading) authCheck,
    required TResult Function(String email, String password) loginWithEmail,
    required TResult Function() loginWithGoogle,
    required TResult Function(
            String email, String password, String name, String? profilePath)
        signupWithEmail,
    required TResult Function(String email, String token) verifyOtp,
    required TResult Function(String email) resendOtp,
    required TResult Function(String email) forgotPassword,
    required TResult Function(String email, String token, String newPassword)
        resetPassword,
    required TResult Function() logout,
  }) {
    return logout();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool? withLoading)? authCheck,
    TResult? Function(String email, String password)? loginWithEmail,
    TResult? Function()? loginWithGoogle,
    TResult? Function(
            String email, String password, String name, String? profilePath)?
        signupWithEmail,
    TResult? Function(String email, String token)? verifyOtp,
    TResult? Function(String email)? resendOtp,
    TResult? Function(String email)? forgotPassword,
    TResult? Function(String email, String token, String newPassword)?
        resetPassword,
    TResult? Function()? logout,
  }) {
    return logout?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool? withLoading)? authCheck,
    TResult Function(String email, String password)? loginWithEmail,
    TResult Function()? loginWithGoogle,
    TResult Function(
            String email, String password, String name, String? profilePath)?
        signupWithEmail,
    TResult Function(String email, String token)? verifyOtp,
    TResult Function(String email)? resendOtp,
    TResult Function(String email)? forgotPassword,
    TResult Function(String email, String token, String newPassword)?
        resetPassword,
    TResult Function()? logout,
    required TResult orElse(),
  }) {
    if (logout != null) {
      return logout();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthCheck value) authCheck,
    required TResult Function(_LoginWithEmail value) loginWithEmail,
    required TResult Function(_LoginWithGoogle value) loginWithGoogle,
    required TResult Function(_SignUpWithEmail value) signupWithEmail,
    required TResult Function(_VerifyOtp value) verifyOtp,
    required TResult Function(_ResendOtp value) resendOtp,
    required TResult Function(_ForgotPassword value) forgotPassword,
    required TResult Function(_ResetPassword value) resetPassword,
    required TResult Function(_Logout value) logout,
  }) {
    return logout(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AuthCheck value)? authCheck,
    TResult? Function(_LoginWithEmail value)? loginWithEmail,
    TResult? Function(_LoginWithGoogle value)? loginWithGoogle,
    TResult? Function(_SignUpWithEmail value)? signupWithEmail,
    TResult? Function(_VerifyOtp value)? verifyOtp,
    TResult? Function(_ResendOtp value)? resendOtp,
    TResult? Function(_ForgotPassword value)? forgotPassword,
    TResult? Function(_ResetPassword value)? resetPassword,
    TResult? Function(_Logout value)? logout,
  }) {
    return logout?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthCheck value)? authCheck,
    TResult Function(_LoginWithEmail value)? loginWithEmail,
    TResult Function(_LoginWithGoogle value)? loginWithGoogle,
    TResult Function(_SignUpWithEmail value)? signupWithEmail,
    TResult Function(_VerifyOtp value)? verifyOtp,
    TResult Function(_ResendOtp value)? resendOtp,
    TResult Function(_ForgotPassword value)? forgotPassword,
    TResult Function(_ResetPassword value)? resetPassword,
    TResult Function(_Logout value)? logout,
    required TResult orElse(),
  }) {
    if (logout != null) {
      return logout(this);
    }
    return orElse();
  }
}

abstract class _Logout implements AuthEvent {
  const factory _Logout() = _$LogoutImpl;
}

/// @nodoc
mixin _$AuthState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(String email) otpRequired,
    required TResult Function() otpResent,
    required TResult Function(String email) passwordResetOtpSent,
    required TResult Function() deviceIdFailed,
    required TResult Function() onFreeUser,
    required TResult Function() onNewPath,
    required TResult Function(Map<String, dynamic> appVersion) onNewVersion,
    required TResult Function(String message) socketError,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(String email)? otpRequired,
    TResult? Function()? otpResent,
    TResult? Function(String email)? passwordResetOtpSent,
    TResult? Function()? deviceIdFailed,
    TResult? Function()? onFreeUser,
    TResult? Function()? onNewPath,
    TResult? Function(Map<String, dynamic> appVersion)? onNewVersion,
    TResult? Function(String message)? socketError,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? authenticated,
    TResult Function()? unauthenticated,
    TResult Function(String email)? otpRequired,
    TResult Function()? otpResent,
    TResult Function(String email)? passwordResetOtpSent,
    TResult Function()? deviceIdFailed,
    TResult Function()? onFreeUser,
    TResult Function()? onNewPath,
    TResult Function(Map<String, dynamic> appVersion)? onNewVersion,
    TResult Function(String message)? socketError,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_Unauthenticated value) unauthenticated,
    required TResult Function(_OtpRequired value) otpRequired,
    required TResult Function(_OtpResent value) otpResent,
    required TResult Function(_PasswordResetOtpSent value) passwordResetOtpSent,
    required TResult Function(_DeviceIdFailed value) deviceIdFailed,
    required TResult Function(_OnFreeUser value) onFreeUser,
    required TResult Function(_OnNewPath value) onNewPath,
    required TResult Function(_OnNewVersion value) onNewVersion,
    required TResult Function(_SocketError value) socketError,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_Unauthenticated value)? unauthenticated,
    TResult? Function(_OtpRequired value)? otpRequired,
    TResult? Function(_OtpResent value)? otpResent,
    TResult? Function(_PasswordResetOtpSent value)? passwordResetOtpSent,
    TResult? Function(_DeviceIdFailed value)? deviceIdFailed,
    TResult? Function(_OnFreeUser value)? onFreeUser,
    TResult? Function(_OnNewPath value)? onNewPath,
    TResult? Function(_OnNewVersion value)? onNewVersion,
    TResult? Function(_SocketError value)? socketError,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_Unauthenticated value)? unauthenticated,
    TResult Function(_OtpRequired value)? otpRequired,
    TResult Function(_OtpResent value)? otpResent,
    TResult Function(_PasswordResetOtpSent value)? passwordResetOtpSent,
    TResult Function(_DeviceIdFailed value)? deviceIdFailed,
    TResult Function(_OnFreeUser value)? onFreeUser,
    TResult Function(_OnNewPath value)? onNewPath,
    TResult Function(_OnNewVersion value)? onNewVersion,
    TResult Function(_SocketError value)? socketError,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res, AuthState>;
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res, $Val extends AuthState>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthState
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
    extends _$AuthStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl with DiagnosticableTreeMixin implements _Initial {
  const _$InitialImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthState.initial()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'AuthState.initial'));
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
    required TResult Function() authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(String email) otpRequired,
    required TResult Function() otpResent,
    required TResult Function(String email) passwordResetOtpSent,
    required TResult Function() deviceIdFailed,
    required TResult Function() onFreeUser,
    required TResult Function() onNewPath,
    required TResult Function(Map<String, dynamic> appVersion) onNewVersion,
    required TResult Function(String message) socketError,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(String email)? otpRequired,
    TResult? Function()? otpResent,
    TResult? Function(String email)? passwordResetOtpSent,
    TResult? Function()? deviceIdFailed,
    TResult? Function()? onFreeUser,
    TResult? Function()? onNewPath,
    TResult? Function(Map<String, dynamic> appVersion)? onNewVersion,
    TResult? Function(String message)? socketError,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? authenticated,
    TResult Function()? unauthenticated,
    TResult Function(String email)? otpRequired,
    TResult Function()? otpResent,
    TResult Function(String email)? passwordResetOtpSent,
    TResult Function()? deviceIdFailed,
    TResult Function()? onFreeUser,
    TResult Function()? onNewPath,
    TResult Function(Map<String, dynamic> appVersion)? onNewVersion,
    TResult Function(String message)? socketError,
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
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_Unauthenticated value) unauthenticated,
    required TResult Function(_OtpRequired value) otpRequired,
    required TResult Function(_OtpResent value) otpResent,
    required TResult Function(_PasswordResetOtpSent value) passwordResetOtpSent,
    required TResult Function(_DeviceIdFailed value) deviceIdFailed,
    required TResult Function(_OnFreeUser value) onFreeUser,
    required TResult Function(_OnNewPath value) onNewPath,
    required TResult Function(_OnNewVersion value) onNewVersion,
    required TResult Function(_SocketError value) socketError,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_Unauthenticated value)? unauthenticated,
    TResult? Function(_OtpRequired value)? otpRequired,
    TResult? Function(_OtpResent value)? otpResent,
    TResult? Function(_PasswordResetOtpSent value)? passwordResetOtpSent,
    TResult? Function(_DeviceIdFailed value)? deviceIdFailed,
    TResult? Function(_OnFreeUser value)? onFreeUser,
    TResult? Function(_OnNewPath value)? onNewPath,
    TResult? Function(_OnNewVersion value)? onNewVersion,
    TResult? Function(_SocketError value)? socketError,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_Unauthenticated value)? unauthenticated,
    TResult Function(_OtpRequired value)? otpRequired,
    TResult Function(_OtpResent value)? otpResent,
    TResult Function(_PasswordResetOtpSent value)? passwordResetOtpSent,
    TResult Function(_DeviceIdFailed value)? deviceIdFailed,
    TResult Function(_OnFreeUser value)? onFreeUser,
    TResult Function(_OnNewPath value)? onNewPath,
    TResult Function(_OnNewVersion value)? onNewVersion,
    TResult Function(_SocketError value)? socketError,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements AuthState {
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
    extends _$AuthStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl with DiagnosticableTreeMixin implements _Loading {
  const _$LoadingImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthState.loading()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'AuthState.loading'));
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
    required TResult Function() authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(String email) otpRequired,
    required TResult Function() otpResent,
    required TResult Function(String email) passwordResetOtpSent,
    required TResult Function() deviceIdFailed,
    required TResult Function() onFreeUser,
    required TResult Function() onNewPath,
    required TResult Function(Map<String, dynamic> appVersion) onNewVersion,
    required TResult Function(String message) socketError,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(String email)? otpRequired,
    TResult? Function()? otpResent,
    TResult? Function(String email)? passwordResetOtpSent,
    TResult? Function()? deviceIdFailed,
    TResult? Function()? onFreeUser,
    TResult? Function()? onNewPath,
    TResult? Function(Map<String, dynamic> appVersion)? onNewVersion,
    TResult? Function(String message)? socketError,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? authenticated,
    TResult Function()? unauthenticated,
    TResult Function(String email)? otpRequired,
    TResult Function()? otpResent,
    TResult Function(String email)? passwordResetOtpSent,
    TResult Function()? deviceIdFailed,
    TResult Function()? onFreeUser,
    TResult Function()? onNewPath,
    TResult Function(Map<String, dynamic> appVersion)? onNewVersion,
    TResult Function(String message)? socketError,
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
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_Unauthenticated value) unauthenticated,
    required TResult Function(_OtpRequired value) otpRequired,
    required TResult Function(_OtpResent value) otpResent,
    required TResult Function(_PasswordResetOtpSent value) passwordResetOtpSent,
    required TResult Function(_DeviceIdFailed value) deviceIdFailed,
    required TResult Function(_OnFreeUser value) onFreeUser,
    required TResult Function(_OnNewPath value) onNewPath,
    required TResult Function(_OnNewVersion value) onNewVersion,
    required TResult Function(_SocketError value) socketError,
    required TResult Function(_Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_Unauthenticated value)? unauthenticated,
    TResult? Function(_OtpRequired value)? otpRequired,
    TResult? Function(_OtpResent value)? otpResent,
    TResult? Function(_PasswordResetOtpSent value)? passwordResetOtpSent,
    TResult? Function(_DeviceIdFailed value)? deviceIdFailed,
    TResult? Function(_OnFreeUser value)? onFreeUser,
    TResult? Function(_OnNewPath value)? onNewPath,
    TResult? Function(_OnNewVersion value)? onNewVersion,
    TResult? Function(_SocketError value)? socketError,
    TResult? Function(_Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_Unauthenticated value)? unauthenticated,
    TResult Function(_OtpRequired value)? otpRequired,
    TResult Function(_OtpResent value)? otpResent,
    TResult Function(_PasswordResetOtpSent value)? passwordResetOtpSent,
    TResult Function(_DeviceIdFailed value)? deviceIdFailed,
    TResult Function(_OnFreeUser value)? onFreeUser,
    TResult Function(_OnNewPath value)? onNewPath,
    TResult Function(_OnNewVersion value)? onNewVersion,
    TResult Function(_SocketError value)? socketError,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements AuthState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$AuthenticatedImplCopyWith<$Res> {
  factory _$$AuthenticatedImplCopyWith(
          _$AuthenticatedImpl value, $Res Function(_$AuthenticatedImpl) then) =
      __$$AuthenticatedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthenticatedImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthenticatedImpl>
    implements _$$AuthenticatedImplCopyWith<$Res> {
  __$$AuthenticatedImplCopyWithImpl(
      _$AuthenticatedImpl _value, $Res Function(_$AuthenticatedImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AuthenticatedImpl
    with DiagnosticableTreeMixin
    implements _Authenticated {
  const _$AuthenticatedImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthState.authenticated()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'AuthState.authenticated'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AuthenticatedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(String email) otpRequired,
    required TResult Function() otpResent,
    required TResult Function(String email) passwordResetOtpSent,
    required TResult Function() deviceIdFailed,
    required TResult Function() onFreeUser,
    required TResult Function() onNewPath,
    required TResult Function(Map<String, dynamic> appVersion) onNewVersion,
    required TResult Function(String message) socketError,
    required TResult Function(String message) error,
  }) {
    return authenticated();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(String email)? otpRequired,
    TResult? Function()? otpResent,
    TResult? Function(String email)? passwordResetOtpSent,
    TResult? Function()? deviceIdFailed,
    TResult? Function()? onFreeUser,
    TResult? Function()? onNewPath,
    TResult? Function(Map<String, dynamic> appVersion)? onNewVersion,
    TResult? Function(String message)? socketError,
    TResult? Function(String message)? error,
  }) {
    return authenticated?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? authenticated,
    TResult Function()? unauthenticated,
    TResult Function(String email)? otpRequired,
    TResult Function()? otpResent,
    TResult Function(String email)? passwordResetOtpSent,
    TResult Function()? deviceIdFailed,
    TResult Function()? onFreeUser,
    TResult Function()? onNewPath,
    TResult Function(Map<String, dynamic> appVersion)? onNewVersion,
    TResult Function(String message)? socketError,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_Unauthenticated value) unauthenticated,
    required TResult Function(_OtpRequired value) otpRequired,
    required TResult Function(_OtpResent value) otpResent,
    required TResult Function(_PasswordResetOtpSent value) passwordResetOtpSent,
    required TResult Function(_DeviceIdFailed value) deviceIdFailed,
    required TResult Function(_OnFreeUser value) onFreeUser,
    required TResult Function(_OnNewPath value) onNewPath,
    required TResult Function(_OnNewVersion value) onNewVersion,
    required TResult Function(_SocketError value) socketError,
    required TResult Function(_Error value) error,
  }) {
    return authenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_Unauthenticated value)? unauthenticated,
    TResult? Function(_OtpRequired value)? otpRequired,
    TResult? Function(_OtpResent value)? otpResent,
    TResult? Function(_PasswordResetOtpSent value)? passwordResetOtpSent,
    TResult? Function(_DeviceIdFailed value)? deviceIdFailed,
    TResult? Function(_OnFreeUser value)? onFreeUser,
    TResult? Function(_OnNewPath value)? onNewPath,
    TResult? Function(_OnNewVersion value)? onNewVersion,
    TResult? Function(_SocketError value)? socketError,
    TResult? Function(_Error value)? error,
  }) {
    return authenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_Unauthenticated value)? unauthenticated,
    TResult Function(_OtpRequired value)? otpRequired,
    TResult Function(_OtpResent value)? otpResent,
    TResult Function(_PasswordResetOtpSent value)? passwordResetOtpSent,
    TResult Function(_DeviceIdFailed value)? deviceIdFailed,
    TResult Function(_OnFreeUser value)? onFreeUser,
    TResult Function(_OnNewPath value)? onNewPath,
    TResult Function(_OnNewVersion value)? onNewVersion,
    TResult Function(_SocketError value)? socketError,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(this);
    }
    return orElse();
  }
}

abstract class _Authenticated implements AuthState {
  const factory _Authenticated() = _$AuthenticatedImpl;
}

/// @nodoc
abstract class _$$UnauthenticatedImplCopyWith<$Res> {
  factory _$$UnauthenticatedImplCopyWith(_$UnauthenticatedImpl value,
          $Res Function(_$UnauthenticatedImpl) then) =
      __$$UnauthenticatedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UnauthenticatedImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$UnauthenticatedImpl>
    implements _$$UnauthenticatedImplCopyWith<$Res> {
  __$$UnauthenticatedImplCopyWithImpl(
      _$UnauthenticatedImpl _value, $Res Function(_$UnauthenticatedImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$UnauthenticatedImpl
    with DiagnosticableTreeMixin
    implements _Unauthenticated {
  const _$UnauthenticatedImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthState.unauthenticated()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'AuthState.unauthenticated'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UnauthenticatedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(String email) otpRequired,
    required TResult Function() otpResent,
    required TResult Function(String email) passwordResetOtpSent,
    required TResult Function() deviceIdFailed,
    required TResult Function() onFreeUser,
    required TResult Function() onNewPath,
    required TResult Function(Map<String, dynamic> appVersion) onNewVersion,
    required TResult Function(String message) socketError,
    required TResult Function(String message) error,
  }) {
    return unauthenticated();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(String email)? otpRequired,
    TResult? Function()? otpResent,
    TResult? Function(String email)? passwordResetOtpSent,
    TResult? Function()? deviceIdFailed,
    TResult? Function()? onFreeUser,
    TResult? Function()? onNewPath,
    TResult? Function(Map<String, dynamic> appVersion)? onNewVersion,
    TResult? Function(String message)? socketError,
    TResult? Function(String message)? error,
  }) {
    return unauthenticated?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? authenticated,
    TResult Function()? unauthenticated,
    TResult Function(String email)? otpRequired,
    TResult Function()? otpResent,
    TResult Function(String email)? passwordResetOtpSent,
    TResult Function()? deviceIdFailed,
    TResult Function()? onFreeUser,
    TResult Function()? onNewPath,
    TResult Function(Map<String, dynamic> appVersion)? onNewVersion,
    TResult Function(String message)? socketError,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_Unauthenticated value) unauthenticated,
    required TResult Function(_OtpRequired value) otpRequired,
    required TResult Function(_OtpResent value) otpResent,
    required TResult Function(_PasswordResetOtpSent value) passwordResetOtpSent,
    required TResult Function(_DeviceIdFailed value) deviceIdFailed,
    required TResult Function(_OnFreeUser value) onFreeUser,
    required TResult Function(_OnNewPath value) onNewPath,
    required TResult Function(_OnNewVersion value) onNewVersion,
    required TResult Function(_SocketError value) socketError,
    required TResult Function(_Error value) error,
  }) {
    return unauthenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_Unauthenticated value)? unauthenticated,
    TResult? Function(_OtpRequired value)? otpRequired,
    TResult? Function(_OtpResent value)? otpResent,
    TResult? Function(_PasswordResetOtpSent value)? passwordResetOtpSent,
    TResult? Function(_DeviceIdFailed value)? deviceIdFailed,
    TResult? Function(_OnFreeUser value)? onFreeUser,
    TResult? Function(_OnNewPath value)? onNewPath,
    TResult? Function(_OnNewVersion value)? onNewVersion,
    TResult? Function(_SocketError value)? socketError,
    TResult? Function(_Error value)? error,
  }) {
    return unauthenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_Unauthenticated value)? unauthenticated,
    TResult Function(_OtpRequired value)? otpRequired,
    TResult Function(_OtpResent value)? otpResent,
    TResult Function(_PasswordResetOtpSent value)? passwordResetOtpSent,
    TResult Function(_DeviceIdFailed value)? deviceIdFailed,
    TResult Function(_OnFreeUser value)? onFreeUser,
    TResult Function(_OnNewPath value)? onNewPath,
    TResult Function(_OnNewVersion value)? onNewVersion,
    TResult Function(_SocketError value)? socketError,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated(this);
    }
    return orElse();
  }
}

abstract class _Unauthenticated implements AuthState {
  const factory _Unauthenticated() = _$UnauthenticatedImpl;
}

/// @nodoc
abstract class _$$OtpRequiredImplCopyWith<$Res> {
  factory _$$OtpRequiredImplCopyWith(
          _$OtpRequiredImpl value, $Res Function(_$OtpRequiredImpl) then) =
      __$$OtpRequiredImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String email});
}

/// @nodoc
class __$$OtpRequiredImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$OtpRequiredImpl>
    implements _$$OtpRequiredImplCopyWith<$Res> {
  __$$OtpRequiredImplCopyWithImpl(
      _$OtpRequiredImpl _value, $Res Function(_$OtpRequiredImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
  }) {
    return _then(_$OtpRequiredImpl(
      null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$OtpRequiredImpl with DiagnosticableTreeMixin implements _OtpRequired {
  const _$OtpRequiredImpl(this.email);

  @override
  final String email;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthState.otpRequired(email: $email)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AuthState.otpRequired'))
      ..add(DiagnosticsProperty('email', email));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OtpRequiredImpl &&
            (identical(other.email, email) || other.email == email));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OtpRequiredImplCopyWith<_$OtpRequiredImpl> get copyWith =>
      __$$OtpRequiredImplCopyWithImpl<_$OtpRequiredImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(String email) otpRequired,
    required TResult Function() otpResent,
    required TResult Function(String email) passwordResetOtpSent,
    required TResult Function() deviceIdFailed,
    required TResult Function() onFreeUser,
    required TResult Function() onNewPath,
    required TResult Function(Map<String, dynamic> appVersion) onNewVersion,
    required TResult Function(String message) socketError,
    required TResult Function(String message) error,
  }) {
    return otpRequired(email);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(String email)? otpRequired,
    TResult? Function()? otpResent,
    TResult? Function(String email)? passwordResetOtpSent,
    TResult? Function()? deviceIdFailed,
    TResult? Function()? onFreeUser,
    TResult? Function()? onNewPath,
    TResult? Function(Map<String, dynamic> appVersion)? onNewVersion,
    TResult? Function(String message)? socketError,
    TResult? Function(String message)? error,
  }) {
    return otpRequired?.call(email);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? authenticated,
    TResult Function()? unauthenticated,
    TResult Function(String email)? otpRequired,
    TResult Function()? otpResent,
    TResult Function(String email)? passwordResetOtpSent,
    TResult Function()? deviceIdFailed,
    TResult Function()? onFreeUser,
    TResult Function()? onNewPath,
    TResult Function(Map<String, dynamic> appVersion)? onNewVersion,
    TResult Function(String message)? socketError,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (otpRequired != null) {
      return otpRequired(email);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_Unauthenticated value) unauthenticated,
    required TResult Function(_OtpRequired value) otpRequired,
    required TResult Function(_OtpResent value) otpResent,
    required TResult Function(_PasswordResetOtpSent value) passwordResetOtpSent,
    required TResult Function(_DeviceIdFailed value) deviceIdFailed,
    required TResult Function(_OnFreeUser value) onFreeUser,
    required TResult Function(_OnNewPath value) onNewPath,
    required TResult Function(_OnNewVersion value) onNewVersion,
    required TResult Function(_SocketError value) socketError,
    required TResult Function(_Error value) error,
  }) {
    return otpRequired(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_Unauthenticated value)? unauthenticated,
    TResult? Function(_OtpRequired value)? otpRequired,
    TResult? Function(_OtpResent value)? otpResent,
    TResult? Function(_PasswordResetOtpSent value)? passwordResetOtpSent,
    TResult? Function(_DeviceIdFailed value)? deviceIdFailed,
    TResult? Function(_OnFreeUser value)? onFreeUser,
    TResult? Function(_OnNewPath value)? onNewPath,
    TResult? Function(_OnNewVersion value)? onNewVersion,
    TResult? Function(_SocketError value)? socketError,
    TResult? Function(_Error value)? error,
  }) {
    return otpRequired?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_Unauthenticated value)? unauthenticated,
    TResult Function(_OtpRequired value)? otpRequired,
    TResult Function(_OtpResent value)? otpResent,
    TResult Function(_PasswordResetOtpSent value)? passwordResetOtpSent,
    TResult Function(_DeviceIdFailed value)? deviceIdFailed,
    TResult Function(_OnFreeUser value)? onFreeUser,
    TResult Function(_OnNewPath value)? onNewPath,
    TResult Function(_OnNewVersion value)? onNewVersion,
    TResult Function(_SocketError value)? socketError,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (otpRequired != null) {
      return otpRequired(this);
    }
    return orElse();
  }
}

abstract class _OtpRequired implements AuthState {
  const factory _OtpRequired(final String email) = _$OtpRequiredImpl;

  String get email;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OtpRequiredImplCopyWith<_$OtpRequiredImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OtpResentImplCopyWith<$Res> {
  factory _$$OtpResentImplCopyWith(
          _$OtpResentImpl value, $Res Function(_$OtpResentImpl) then) =
      __$$OtpResentImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OtpResentImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$OtpResentImpl>
    implements _$$OtpResentImplCopyWith<$Res> {
  __$$OtpResentImplCopyWithImpl(
      _$OtpResentImpl _value, $Res Function(_$OtpResentImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$OtpResentImpl with DiagnosticableTreeMixin implements _OtpResent {
  const _$OtpResentImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthState.otpResent()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'AuthState.otpResent'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$OtpResentImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(String email) otpRequired,
    required TResult Function() otpResent,
    required TResult Function(String email) passwordResetOtpSent,
    required TResult Function() deviceIdFailed,
    required TResult Function() onFreeUser,
    required TResult Function() onNewPath,
    required TResult Function(Map<String, dynamic> appVersion) onNewVersion,
    required TResult Function(String message) socketError,
    required TResult Function(String message) error,
  }) {
    return otpResent();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(String email)? otpRequired,
    TResult? Function()? otpResent,
    TResult? Function(String email)? passwordResetOtpSent,
    TResult? Function()? deviceIdFailed,
    TResult? Function()? onFreeUser,
    TResult? Function()? onNewPath,
    TResult? Function(Map<String, dynamic> appVersion)? onNewVersion,
    TResult? Function(String message)? socketError,
    TResult? Function(String message)? error,
  }) {
    return otpResent?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? authenticated,
    TResult Function()? unauthenticated,
    TResult Function(String email)? otpRequired,
    TResult Function()? otpResent,
    TResult Function(String email)? passwordResetOtpSent,
    TResult Function()? deviceIdFailed,
    TResult Function()? onFreeUser,
    TResult Function()? onNewPath,
    TResult Function(Map<String, dynamic> appVersion)? onNewVersion,
    TResult Function(String message)? socketError,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (otpResent != null) {
      return otpResent();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_Unauthenticated value) unauthenticated,
    required TResult Function(_OtpRequired value) otpRequired,
    required TResult Function(_OtpResent value) otpResent,
    required TResult Function(_PasswordResetOtpSent value) passwordResetOtpSent,
    required TResult Function(_DeviceIdFailed value) deviceIdFailed,
    required TResult Function(_OnFreeUser value) onFreeUser,
    required TResult Function(_OnNewPath value) onNewPath,
    required TResult Function(_OnNewVersion value) onNewVersion,
    required TResult Function(_SocketError value) socketError,
    required TResult Function(_Error value) error,
  }) {
    return otpResent(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_Unauthenticated value)? unauthenticated,
    TResult? Function(_OtpRequired value)? otpRequired,
    TResult? Function(_OtpResent value)? otpResent,
    TResult? Function(_PasswordResetOtpSent value)? passwordResetOtpSent,
    TResult? Function(_DeviceIdFailed value)? deviceIdFailed,
    TResult? Function(_OnFreeUser value)? onFreeUser,
    TResult? Function(_OnNewPath value)? onNewPath,
    TResult? Function(_OnNewVersion value)? onNewVersion,
    TResult? Function(_SocketError value)? socketError,
    TResult? Function(_Error value)? error,
  }) {
    return otpResent?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_Unauthenticated value)? unauthenticated,
    TResult Function(_OtpRequired value)? otpRequired,
    TResult Function(_OtpResent value)? otpResent,
    TResult Function(_PasswordResetOtpSent value)? passwordResetOtpSent,
    TResult Function(_DeviceIdFailed value)? deviceIdFailed,
    TResult Function(_OnFreeUser value)? onFreeUser,
    TResult Function(_OnNewPath value)? onNewPath,
    TResult Function(_OnNewVersion value)? onNewVersion,
    TResult Function(_SocketError value)? socketError,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (otpResent != null) {
      return otpResent(this);
    }
    return orElse();
  }
}

abstract class _OtpResent implements AuthState {
  const factory _OtpResent() = _$OtpResentImpl;
}

/// @nodoc
abstract class _$$PasswordResetOtpSentImplCopyWith<$Res> {
  factory _$$PasswordResetOtpSentImplCopyWith(_$PasswordResetOtpSentImpl value,
          $Res Function(_$PasswordResetOtpSentImpl) then) =
      __$$PasswordResetOtpSentImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String email});
}

/// @nodoc
class __$$PasswordResetOtpSentImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$PasswordResetOtpSentImpl>
    implements _$$PasswordResetOtpSentImplCopyWith<$Res> {
  __$$PasswordResetOtpSentImplCopyWithImpl(_$PasswordResetOtpSentImpl _value,
      $Res Function(_$PasswordResetOtpSentImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
  }) {
    return _then(_$PasswordResetOtpSentImpl(
      null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PasswordResetOtpSentImpl
    with DiagnosticableTreeMixin
    implements _PasswordResetOtpSent {
  const _$PasswordResetOtpSentImpl(this.email);

  @override
  final String email;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthState.passwordResetOtpSent(email: $email)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AuthState.passwordResetOtpSent'))
      ..add(DiagnosticsProperty('email', email));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PasswordResetOtpSentImpl &&
            (identical(other.email, email) || other.email == email));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PasswordResetOtpSentImplCopyWith<_$PasswordResetOtpSentImpl>
      get copyWith =>
          __$$PasswordResetOtpSentImplCopyWithImpl<_$PasswordResetOtpSentImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(String email) otpRequired,
    required TResult Function() otpResent,
    required TResult Function(String email) passwordResetOtpSent,
    required TResult Function() deviceIdFailed,
    required TResult Function() onFreeUser,
    required TResult Function() onNewPath,
    required TResult Function(Map<String, dynamic> appVersion) onNewVersion,
    required TResult Function(String message) socketError,
    required TResult Function(String message) error,
  }) {
    return passwordResetOtpSent(email);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(String email)? otpRequired,
    TResult? Function()? otpResent,
    TResult? Function(String email)? passwordResetOtpSent,
    TResult? Function()? deviceIdFailed,
    TResult? Function()? onFreeUser,
    TResult? Function()? onNewPath,
    TResult? Function(Map<String, dynamic> appVersion)? onNewVersion,
    TResult? Function(String message)? socketError,
    TResult? Function(String message)? error,
  }) {
    return passwordResetOtpSent?.call(email);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? authenticated,
    TResult Function()? unauthenticated,
    TResult Function(String email)? otpRequired,
    TResult Function()? otpResent,
    TResult Function(String email)? passwordResetOtpSent,
    TResult Function()? deviceIdFailed,
    TResult Function()? onFreeUser,
    TResult Function()? onNewPath,
    TResult Function(Map<String, dynamic> appVersion)? onNewVersion,
    TResult Function(String message)? socketError,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (passwordResetOtpSent != null) {
      return passwordResetOtpSent(email);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_Unauthenticated value) unauthenticated,
    required TResult Function(_OtpRequired value) otpRequired,
    required TResult Function(_OtpResent value) otpResent,
    required TResult Function(_PasswordResetOtpSent value) passwordResetOtpSent,
    required TResult Function(_DeviceIdFailed value) deviceIdFailed,
    required TResult Function(_OnFreeUser value) onFreeUser,
    required TResult Function(_OnNewPath value) onNewPath,
    required TResult Function(_OnNewVersion value) onNewVersion,
    required TResult Function(_SocketError value) socketError,
    required TResult Function(_Error value) error,
  }) {
    return passwordResetOtpSent(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_Unauthenticated value)? unauthenticated,
    TResult? Function(_OtpRequired value)? otpRequired,
    TResult? Function(_OtpResent value)? otpResent,
    TResult? Function(_PasswordResetOtpSent value)? passwordResetOtpSent,
    TResult? Function(_DeviceIdFailed value)? deviceIdFailed,
    TResult? Function(_OnFreeUser value)? onFreeUser,
    TResult? Function(_OnNewPath value)? onNewPath,
    TResult? Function(_OnNewVersion value)? onNewVersion,
    TResult? Function(_SocketError value)? socketError,
    TResult? Function(_Error value)? error,
  }) {
    return passwordResetOtpSent?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_Unauthenticated value)? unauthenticated,
    TResult Function(_OtpRequired value)? otpRequired,
    TResult Function(_OtpResent value)? otpResent,
    TResult Function(_PasswordResetOtpSent value)? passwordResetOtpSent,
    TResult Function(_DeviceIdFailed value)? deviceIdFailed,
    TResult Function(_OnFreeUser value)? onFreeUser,
    TResult Function(_OnNewPath value)? onNewPath,
    TResult Function(_OnNewVersion value)? onNewVersion,
    TResult Function(_SocketError value)? socketError,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (passwordResetOtpSent != null) {
      return passwordResetOtpSent(this);
    }
    return orElse();
  }
}

abstract class _PasswordResetOtpSent implements AuthState {
  const factory _PasswordResetOtpSent(final String email) =
      _$PasswordResetOtpSentImpl;

  String get email;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PasswordResetOtpSentImplCopyWith<_$PasswordResetOtpSentImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeviceIdFailedImplCopyWith<$Res> {
  factory _$$DeviceIdFailedImplCopyWith(_$DeviceIdFailedImpl value,
          $Res Function(_$DeviceIdFailedImpl) then) =
      __$$DeviceIdFailedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DeviceIdFailedImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$DeviceIdFailedImpl>
    implements _$$DeviceIdFailedImplCopyWith<$Res> {
  __$$DeviceIdFailedImplCopyWithImpl(
      _$DeviceIdFailedImpl _value, $Res Function(_$DeviceIdFailedImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$DeviceIdFailedImpl
    with DiagnosticableTreeMixin
    implements _DeviceIdFailed {
  const _$DeviceIdFailedImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthState.deviceIdFailed()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'AuthState.deviceIdFailed'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$DeviceIdFailedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(String email) otpRequired,
    required TResult Function() otpResent,
    required TResult Function(String email) passwordResetOtpSent,
    required TResult Function() deviceIdFailed,
    required TResult Function() onFreeUser,
    required TResult Function() onNewPath,
    required TResult Function(Map<String, dynamic> appVersion) onNewVersion,
    required TResult Function(String message) socketError,
    required TResult Function(String message) error,
  }) {
    return deviceIdFailed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(String email)? otpRequired,
    TResult? Function()? otpResent,
    TResult? Function(String email)? passwordResetOtpSent,
    TResult? Function()? deviceIdFailed,
    TResult? Function()? onFreeUser,
    TResult? Function()? onNewPath,
    TResult? Function(Map<String, dynamic> appVersion)? onNewVersion,
    TResult? Function(String message)? socketError,
    TResult? Function(String message)? error,
  }) {
    return deviceIdFailed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? authenticated,
    TResult Function()? unauthenticated,
    TResult Function(String email)? otpRequired,
    TResult Function()? otpResent,
    TResult Function(String email)? passwordResetOtpSent,
    TResult Function()? deviceIdFailed,
    TResult Function()? onFreeUser,
    TResult Function()? onNewPath,
    TResult Function(Map<String, dynamic> appVersion)? onNewVersion,
    TResult Function(String message)? socketError,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (deviceIdFailed != null) {
      return deviceIdFailed();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_Unauthenticated value) unauthenticated,
    required TResult Function(_OtpRequired value) otpRequired,
    required TResult Function(_OtpResent value) otpResent,
    required TResult Function(_PasswordResetOtpSent value) passwordResetOtpSent,
    required TResult Function(_DeviceIdFailed value) deviceIdFailed,
    required TResult Function(_OnFreeUser value) onFreeUser,
    required TResult Function(_OnNewPath value) onNewPath,
    required TResult Function(_OnNewVersion value) onNewVersion,
    required TResult Function(_SocketError value) socketError,
    required TResult Function(_Error value) error,
  }) {
    return deviceIdFailed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_Unauthenticated value)? unauthenticated,
    TResult? Function(_OtpRequired value)? otpRequired,
    TResult? Function(_OtpResent value)? otpResent,
    TResult? Function(_PasswordResetOtpSent value)? passwordResetOtpSent,
    TResult? Function(_DeviceIdFailed value)? deviceIdFailed,
    TResult? Function(_OnFreeUser value)? onFreeUser,
    TResult? Function(_OnNewPath value)? onNewPath,
    TResult? Function(_OnNewVersion value)? onNewVersion,
    TResult? Function(_SocketError value)? socketError,
    TResult? Function(_Error value)? error,
  }) {
    return deviceIdFailed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_Unauthenticated value)? unauthenticated,
    TResult Function(_OtpRequired value)? otpRequired,
    TResult Function(_OtpResent value)? otpResent,
    TResult Function(_PasswordResetOtpSent value)? passwordResetOtpSent,
    TResult Function(_DeviceIdFailed value)? deviceIdFailed,
    TResult Function(_OnFreeUser value)? onFreeUser,
    TResult Function(_OnNewPath value)? onNewPath,
    TResult Function(_OnNewVersion value)? onNewVersion,
    TResult Function(_SocketError value)? socketError,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (deviceIdFailed != null) {
      return deviceIdFailed(this);
    }
    return orElse();
  }
}

abstract class _DeviceIdFailed implements AuthState {
  const factory _DeviceIdFailed() = _$DeviceIdFailedImpl;
}

/// @nodoc
abstract class _$$OnFreeUserImplCopyWith<$Res> {
  factory _$$OnFreeUserImplCopyWith(
          _$OnFreeUserImpl value, $Res Function(_$OnFreeUserImpl) then) =
      __$$OnFreeUserImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OnFreeUserImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$OnFreeUserImpl>
    implements _$$OnFreeUserImplCopyWith<$Res> {
  __$$OnFreeUserImplCopyWithImpl(
      _$OnFreeUserImpl _value, $Res Function(_$OnFreeUserImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$OnFreeUserImpl with DiagnosticableTreeMixin implements _OnFreeUser {
  const _$OnFreeUserImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthState.onFreeUser()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'AuthState.onFreeUser'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$OnFreeUserImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(String email) otpRequired,
    required TResult Function() otpResent,
    required TResult Function(String email) passwordResetOtpSent,
    required TResult Function() deviceIdFailed,
    required TResult Function() onFreeUser,
    required TResult Function() onNewPath,
    required TResult Function(Map<String, dynamic> appVersion) onNewVersion,
    required TResult Function(String message) socketError,
    required TResult Function(String message) error,
  }) {
    return onFreeUser();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(String email)? otpRequired,
    TResult? Function()? otpResent,
    TResult? Function(String email)? passwordResetOtpSent,
    TResult? Function()? deviceIdFailed,
    TResult? Function()? onFreeUser,
    TResult? Function()? onNewPath,
    TResult? Function(Map<String, dynamic> appVersion)? onNewVersion,
    TResult? Function(String message)? socketError,
    TResult? Function(String message)? error,
  }) {
    return onFreeUser?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? authenticated,
    TResult Function()? unauthenticated,
    TResult Function(String email)? otpRequired,
    TResult Function()? otpResent,
    TResult Function(String email)? passwordResetOtpSent,
    TResult Function()? deviceIdFailed,
    TResult Function()? onFreeUser,
    TResult Function()? onNewPath,
    TResult Function(Map<String, dynamic> appVersion)? onNewVersion,
    TResult Function(String message)? socketError,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (onFreeUser != null) {
      return onFreeUser();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_Unauthenticated value) unauthenticated,
    required TResult Function(_OtpRequired value) otpRequired,
    required TResult Function(_OtpResent value) otpResent,
    required TResult Function(_PasswordResetOtpSent value) passwordResetOtpSent,
    required TResult Function(_DeviceIdFailed value) deviceIdFailed,
    required TResult Function(_OnFreeUser value) onFreeUser,
    required TResult Function(_OnNewPath value) onNewPath,
    required TResult Function(_OnNewVersion value) onNewVersion,
    required TResult Function(_SocketError value) socketError,
    required TResult Function(_Error value) error,
  }) {
    return onFreeUser(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_Unauthenticated value)? unauthenticated,
    TResult? Function(_OtpRequired value)? otpRequired,
    TResult? Function(_OtpResent value)? otpResent,
    TResult? Function(_PasswordResetOtpSent value)? passwordResetOtpSent,
    TResult? Function(_DeviceIdFailed value)? deviceIdFailed,
    TResult? Function(_OnFreeUser value)? onFreeUser,
    TResult? Function(_OnNewPath value)? onNewPath,
    TResult? Function(_OnNewVersion value)? onNewVersion,
    TResult? Function(_SocketError value)? socketError,
    TResult? Function(_Error value)? error,
  }) {
    return onFreeUser?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_Unauthenticated value)? unauthenticated,
    TResult Function(_OtpRequired value)? otpRequired,
    TResult Function(_OtpResent value)? otpResent,
    TResult Function(_PasswordResetOtpSent value)? passwordResetOtpSent,
    TResult Function(_DeviceIdFailed value)? deviceIdFailed,
    TResult Function(_OnFreeUser value)? onFreeUser,
    TResult Function(_OnNewPath value)? onNewPath,
    TResult Function(_OnNewVersion value)? onNewVersion,
    TResult Function(_SocketError value)? socketError,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (onFreeUser != null) {
      return onFreeUser(this);
    }
    return orElse();
  }
}

abstract class _OnFreeUser implements AuthState {
  const factory _OnFreeUser() = _$OnFreeUserImpl;
}

/// @nodoc
abstract class _$$OnNewPathImplCopyWith<$Res> {
  factory _$$OnNewPathImplCopyWith(
          _$OnNewPathImpl value, $Res Function(_$OnNewPathImpl) then) =
      __$$OnNewPathImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OnNewPathImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$OnNewPathImpl>
    implements _$$OnNewPathImplCopyWith<$Res> {
  __$$OnNewPathImplCopyWithImpl(
      _$OnNewPathImpl _value, $Res Function(_$OnNewPathImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$OnNewPathImpl with DiagnosticableTreeMixin implements _OnNewPath {
  const _$OnNewPathImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthState.onNewPath()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'AuthState.onNewPath'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$OnNewPathImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(String email) otpRequired,
    required TResult Function() otpResent,
    required TResult Function(String email) passwordResetOtpSent,
    required TResult Function() deviceIdFailed,
    required TResult Function() onFreeUser,
    required TResult Function() onNewPath,
    required TResult Function(Map<String, dynamic> appVersion) onNewVersion,
    required TResult Function(String message) socketError,
    required TResult Function(String message) error,
  }) {
    return onNewPath();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(String email)? otpRequired,
    TResult? Function()? otpResent,
    TResult? Function(String email)? passwordResetOtpSent,
    TResult? Function()? deviceIdFailed,
    TResult? Function()? onFreeUser,
    TResult? Function()? onNewPath,
    TResult? Function(Map<String, dynamic> appVersion)? onNewVersion,
    TResult? Function(String message)? socketError,
    TResult? Function(String message)? error,
  }) {
    return onNewPath?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? authenticated,
    TResult Function()? unauthenticated,
    TResult Function(String email)? otpRequired,
    TResult Function()? otpResent,
    TResult Function(String email)? passwordResetOtpSent,
    TResult Function()? deviceIdFailed,
    TResult Function()? onFreeUser,
    TResult Function()? onNewPath,
    TResult Function(Map<String, dynamic> appVersion)? onNewVersion,
    TResult Function(String message)? socketError,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (onNewPath != null) {
      return onNewPath();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_Unauthenticated value) unauthenticated,
    required TResult Function(_OtpRequired value) otpRequired,
    required TResult Function(_OtpResent value) otpResent,
    required TResult Function(_PasswordResetOtpSent value) passwordResetOtpSent,
    required TResult Function(_DeviceIdFailed value) deviceIdFailed,
    required TResult Function(_OnFreeUser value) onFreeUser,
    required TResult Function(_OnNewPath value) onNewPath,
    required TResult Function(_OnNewVersion value) onNewVersion,
    required TResult Function(_SocketError value) socketError,
    required TResult Function(_Error value) error,
  }) {
    return onNewPath(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_Unauthenticated value)? unauthenticated,
    TResult? Function(_OtpRequired value)? otpRequired,
    TResult? Function(_OtpResent value)? otpResent,
    TResult? Function(_PasswordResetOtpSent value)? passwordResetOtpSent,
    TResult? Function(_DeviceIdFailed value)? deviceIdFailed,
    TResult? Function(_OnFreeUser value)? onFreeUser,
    TResult? Function(_OnNewPath value)? onNewPath,
    TResult? Function(_OnNewVersion value)? onNewVersion,
    TResult? Function(_SocketError value)? socketError,
    TResult? Function(_Error value)? error,
  }) {
    return onNewPath?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_Unauthenticated value)? unauthenticated,
    TResult Function(_OtpRequired value)? otpRequired,
    TResult Function(_OtpResent value)? otpResent,
    TResult Function(_PasswordResetOtpSent value)? passwordResetOtpSent,
    TResult Function(_DeviceIdFailed value)? deviceIdFailed,
    TResult Function(_OnFreeUser value)? onFreeUser,
    TResult Function(_OnNewPath value)? onNewPath,
    TResult Function(_OnNewVersion value)? onNewVersion,
    TResult Function(_SocketError value)? socketError,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (onNewPath != null) {
      return onNewPath(this);
    }
    return orElse();
  }
}

abstract class _OnNewPath implements AuthState {
  const factory _OnNewPath() = _$OnNewPathImpl;
}

/// @nodoc
abstract class _$$OnNewVersionImplCopyWith<$Res> {
  factory _$$OnNewVersionImplCopyWith(
          _$OnNewVersionImpl value, $Res Function(_$OnNewVersionImpl) then) =
      __$$OnNewVersionImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Map<String, dynamic> appVersion});
}

/// @nodoc
class __$$OnNewVersionImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$OnNewVersionImpl>
    implements _$$OnNewVersionImplCopyWith<$Res> {
  __$$OnNewVersionImplCopyWithImpl(
      _$OnNewVersionImpl _value, $Res Function(_$OnNewVersionImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appVersion = null,
  }) {
    return _then(_$OnNewVersionImpl(
      null == appVersion
          ? _value._appVersion
          : appVersion // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc

class _$OnNewVersionImpl with DiagnosticableTreeMixin implements _OnNewVersion {
  const _$OnNewVersionImpl(final Map<String, dynamic> appVersion)
      : _appVersion = appVersion;

  final Map<String, dynamic> _appVersion;
  @override
  Map<String, dynamic> get appVersion {
    if (_appVersion is EqualUnmodifiableMapView) return _appVersion;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_appVersion);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthState.onNewVersion(appVersion: $appVersion)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AuthState.onNewVersion'))
      ..add(DiagnosticsProperty('appVersion', appVersion));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnNewVersionImpl &&
            const DeepCollectionEquality()
                .equals(other._appVersion, _appVersion));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_appVersion));

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OnNewVersionImplCopyWith<_$OnNewVersionImpl> get copyWith =>
      __$$OnNewVersionImplCopyWithImpl<_$OnNewVersionImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(String email) otpRequired,
    required TResult Function() otpResent,
    required TResult Function(String email) passwordResetOtpSent,
    required TResult Function() deviceIdFailed,
    required TResult Function() onFreeUser,
    required TResult Function() onNewPath,
    required TResult Function(Map<String, dynamic> appVersion) onNewVersion,
    required TResult Function(String message) socketError,
    required TResult Function(String message) error,
  }) {
    return onNewVersion(appVersion);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(String email)? otpRequired,
    TResult? Function()? otpResent,
    TResult? Function(String email)? passwordResetOtpSent,
    TResult? Function()? deviceIdFailed,
    TResult? Function()? onFreeUser,
    TResult? Function()? onNewPath,
    TResult? Function(Map<String, dynamic> appVersion)? onNewVersion,
    TResult? Function(String message)? socketError,
    TResult? Function(String message)? error,
  }) {
    return onNewVersion?.call(appVersion);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? authenticated,
    TResult Function()? unauthenticated,
    TResult Function(String email)? otpRequired,
    TResult Function()? otpResent,
    TResult Function(String email)? passwordResetOtpSent,
    TResult Function()? deviceIdFailed,
    TResult Function()? onFreeUser,
    TResult Function()? onNewPath,
    TResult Function(Map<String, dynamic> appVersion)? onNewVersion,
    TResult Function(String message)? socketError,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (onNewVersion != null) {
      return onNewVersion(appVersion);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_Unauthenticated value) unauthenticated,
    required TResult Function(_OtpRequired value) otpRequired,
    required TResult Function(_OtpResent value) otpResent,
    required TResult Function(_PasswordResetOtpSent value) passwordResetOtpSent,
    required TResult Function(_DeviceIdFailed value) deviceIdFailed,
    required TResult Function(_OnFreeUser value) onFreeUser,
    required TResult Function(_OnNewPath value) onNewPath,
    required TResult Function(_OnNewVersion value) onNewVersion,
    required TResult Function(_SocketError value) socketError,
    required TResult Function(_Error value) error,
  }) {
    return onNewVersion(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_Unauthenticated value)? unauthenticated,
    TResult? Function(_OtpRequired value)? otpRequired,
    TResult? Function(_OtpResent value)? otpResent,
    TResult? Function(_PasswordResetOtpSent value)? passwordResetOtpSent,
    TResult? Function(_DeviceIdFailed value)? deviceIdFailed,
    TResult? Function(_OnFreeUser value)? onFreeUser,
    TResult? Function(_OnNewPath value)? onNewPath,
    TResult? Function(_OnNewVersion value)? onNewVersion,
    TResult? Function(_SocketError value)? socketError,
    TResult? Function(_Error value)? error,
  }) {
    return onNewVersion?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_Unauthenticated value)? unauthenticated,
    TResult Function(_OtpRequired value)? otpRequired,
    TResult Function(_OtpResent value)? otpResent,
    TResult Function(_PasswordResetOtpSent value)? passwordResetOtpSent,
    TResult Function(_DeviceIdFailed value)? deviceIdFailed,
    TResult Function(_OnFreeUser value)? onFreeUser,
    TResult Function(_OnNewPath value)? onNewPath,
    TResult Function(_OnNewVersion value)? onNewVersion,
    TResult Function(_SocketError value)? socketError,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (onNewVersion != null) {
      return onNewVersion(this);
    }
    return orElse();
  }
}

abstract class _OnNewVersion implements AuthState {
  const factory _OnNewVersion(final Map<String, dynamic> appVersion) =
      _$OnNewVersionImpl;

  Map<String, dynamic> get appVersion;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OnNewVersionImplCopyWith<_$OnNewVersionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SocketErrorImplCopyWith<$Res> {
  factory _$$SocketErrorImplCopyWith(
          _$SocketErrorImpl value, $Res Function(_$SocketErrorImpl) then) =
      __$$SocketErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$SocketErrorImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$SocketErrorImpl>
    implements _$$SocketErrorImplCopyWith<$Res> {
  __$$SocketErrorImplCopyWithImpl(
      _$SocketErrorImpl _value, $Res Function(_$SocketErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$SocketErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SocketErrorImpl with DiagnosticableTreeMixin implements _SocketError {
  const _$SocketErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthState.socketError(message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AuthState.socketError'))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SocketErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SocketErrorImplCopyWith<_$SocketErrorImpl> get copyWith =>
      __$$SocketErrorImplCopyWithImpl<_$SocketErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(String email) otpRequired,
    required TResult Function() otpResent,
    required TResult Function(String email) passwordResetOtpSent,
    required TResult Function() deviceIdFailed,
    required TResult Function() onFreeUser,
    required TResult Function() onNewPath,
    required TResult Function(Map<String, dynamic> appVersion) onNewVersion,
    required TResult Function(String message) socketError,
    required TResult Function(String message) error,
  }) {
    return socketError(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(String email)? otpRequired,
    TResult? Function()? otpResent,
    TResult? Function(String email)? passwordResetOtpSent,
    TResult? Function()? deviceIdFailed,
    TResult? Function()? onFreeUser,
    TResult? Function()? onNewPath,
    TResult? Function(Map<String, dynamic> appVersion)? onNewVersion,
    TResult? Function(String message)? socketError,
    TResult? Function(String message)? error,
  }) {
    return socketError?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? authenticated,
    TResult Function()? unauthenticated,
    TResult Function(String email)? otpRequired,
    TResult Function()? otpResent,
    TResult Function(String email)? passwordResetOtpSent,
    TResult Function()? deviceIdFailed,
    TResult Function()? onFreeUser,
    TResult Function()? onNewPath,
    TResult Function(Map<String, dynamic> appVersion)? onNewVersion,
    TResult Function(String message)? socketError,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (socketError != null) {
      return socketError(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_Unauthenticated value) unauthenticated,
    required TResult Function(_OtpRequired value) otpRequired,
    required TResult Function(_OtpResent value) otpResent,
    required TResult Function(_PasswordResetOtpSent value) passwordResetOtpSent,
    required TResult Function(_DeviceIdFailed value) deviceIdFailed,
    required TResult Function(_OnFreeUser value) onFreeUser,
    required TResult Function(_OnNewPath value) onNewPath,
    required TResult Function(_OnNewVersion value) onNewVersion,
    required TResult Function(_SocketError value) socketError,
    required TResult Function(_Error value) error,
  }) {
    return socketError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_Unauthenticated value)? unauthenticated,
    TResult? Function(_OtpRequired value)? otpRequired,
    TResult? Function(_OtpResent value)? otpResent,
    TResult? Function(_PasswordResetOtpSent value)? passwordResetOtpSent,
    TResult? Function(_DeviceIdFailed value)? deviceIdFailed,
    TResult? Function(_OnFreeUser value)? onFreeUser,
    TResult? Function(_OnNewPath value)? onNewPath,
    TResult? Function(_OnNewVersion value)? onNewVersion,
    TResult? Function(_SocketError value)? socketError,
    TResult? Function(_Error value)? error,
  }) {
    return socketError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_Unauthenticated value)? unauthenticated,
    TResult Function(_OtpRequired value)? otpRequired,
    TResult Function(_OtpResent value)? otpResent,
    TResult Function(_PasswordResetOtpSent value)? passwordResetOtpSent,
    TResult Function(_DeviceIdFailed value)? deviceIdFailed,
    TResult Function(_OnFreeUser value)? onFreeUser,
    TResult Function(_OnNewPath value)? onNewPath,
    TResult Function(_OnNewVersion value)? onNewVersion,
    TResult Function(_SocketError value)? socketError,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (socketError != null) {
      return socketError(this);
    }
    return orElse();
  }
}

abstract class _SocketError implements AuthState {
  const factory _SocketError(final String message) = _$SocketErrorImpl;

  String get message;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SocketErrorImplCopyWith<_$SocketErrorImpl> get copyWith =>
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
    extends _$AuthStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
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
    return 'AuthState.error(message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AuthState.error'))
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

  /// Create a copy of AuthState
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
    required TResult Function() authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(String email) otpRequired,
    required TResult Function() otpResent,
    required TResult Function(String email) passwordResetOtpSent,
    required TResult Function() deviceIdFailed,
    required TResult Function() onFreeUser,
    required TResult Function() onNewPath,
    required TResult Function(Map<String, dynamic> appVersion) onNewVersion,
    required TResult Function(String message) socketError,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(String email)? otpRequired,
    TResult? Function()? otpResent,
    TResult? Function(String email)? passwordResetOtpSent,
    TResult? Function()? deviceIdFailed,
    TResult? Function()? onFreeUser,
    TResult? Function()? onNewPath,
    TResult? Function(Map<String, dynamic> appVersion)? onNewVersion,
    TResult? Function(String message)? socketError,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? authenticated,
    TResult Function()? unauthenticated,
    TResult Function(String email)? otpRequired,
    TResult Function()? otpResent,
    TResult Function(String email)? passwordResetOtpSent,
    TResult Function()? deviceIdFailed,
    TResult Function()? onFreeUser,
    TResult Function()? onNewPath,
    TResult Function(Map<String, dynamic> appVersion)? onNewVersion,
    TResult Function(String message)? socketError,
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
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_Unauthenticated value) unauthenticated,
    required TResult Function(_OtpRequired value) otpRequired,
    required TResult Function(_OtpResent value) otpResent,
    required TResult Function(_PasswordResetOtpSent value) passwordResetOtpSent,
    required TResult Function(_DeviceIdFailed value) deviceIdFailed,
    required TResult Function(_OnFreeUser value) onFreeUser,
    required TResult Function(_OnNewPath value) onNewPath,
    required TResult Function(_OnNewVersion value) onNewVersion,
    required TResult Function(_SocketError value) socketError,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_Unauthenticated value)? unauthenticated,
    TResult? Function(_OtpRequired value)? otpRequired,
    TResult? Function(_OtpResent value)? otpResent,
    TResult? Function(_PasswordResetOtpSent value)? passwordResetOtpSent,
    TResult? Function(_DeviceIdFailed value)? deviceIdFailed,
    TResult? Function(_OnFreeUser value)? onFreeUser,
    TResult? Function(_OnNewPath value)? onNewPath,
    TResult? Function(_OnNewVersion value)? onNewVersion,
    TResult? Function(_SocketError value)? socketError,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_Unauthenticated value)? unauthenticated,
    TResult Function(_OtpRequired value)? otpRequired,
    TResult Function(_OtpResent value)? otpResent,
    TResult Function(_PasswordResetOtpSent value)? passwordResetOtpSent,
    TResult Function(_DeviceIdFailed value)? deviceIdFailed,
    TResult Function(_OnFreeUser value)? onFreeUser,
    TResult Function(_OnNewPath value)? onNewPath,
    TResult Function(_OnNewVersion value)? onNewVersion,
    TResult Function(_SocketError value)? socketError,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements AuthState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
