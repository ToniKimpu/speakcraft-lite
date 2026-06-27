import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:speakcraft/core/di/service_locator.dart';
import 'package:speakcraft/core/logger/app_logger.dart';
import 'package:speakcraft/repositories/auth/auth_repository.dart';
import 'package:speakcraft/services/supabase_service.dart';

import '../../model/app_user/app_user.dart';

part 'auth_bloc.freezed.dart';

@freezed
abstract class AuthEvent with _$AuthEvent {
  const factory AuthEvent.authCheck({bool? withLoading}) = _AuthCheck;
  const factory AuthEvent.refreshUser() = _RefreshUser;
  const factory AuthEvent.loginWithEmail(String email, String password) =
      _LoginWithEmail;
  const factory AuthEvent.loginWithGoogle() = _LoginWithGoogle;
  const factory AuthEvent.signupWithEmail(
          String email, String password, String name, String? profilePath) =
      _SignUpWithEmail;
  const factory AuthEvent.verifyOtp(String email, String token) = _VerifyOtp;
  const factory AuthEvent.resendOtp(String email) = _ResendOtp;
  const factory AuthEvent.forgotPassword(String email) = _ForgotPassword;
  const factory AuthEvent.resetPassword(
          String email, String token, String newPassword) =
      _ResetPassword;
  const factory AuthEvent.logout() = _Logout;
}

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.authenticated() = _Authenticated;
  const factory AuthState.unauthenticated() = _Unauthenticated;
  const factory AuthState.otpRequired(String email) = _OtpRequired;
  const factory AuthState.otpResent() = _OtpResent;
  const factory AuthState.passwordResetOtpSent(String email) =
      _PasswordResetOtpSent;
  const factory AuthState.deviceIdFailed() = _DeviceIdFailed;
  const factory AuthState.onNewPath() = _OnNewPath;
  const factory AuthState.onNewVersion(Map<String, dynamic> appVersion) =
      _OnNewVersion;
  const factory AuthState.socketError(String message) = _SocketError;
  const factory AuthState.error(String message) = _Error;
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repository;

  /// Realtime subscription to the signed-in user's own `users` row. When the
  /// admin approves a payment (extends `premium_until`), this fires and we
  /// silently refresh the cached user so premium unlocks live.
  RealtimeChannel? _userChannel;

  AuthBloc({AuthRepository? repository})
      : _repository = repository ?? sl<AuthRepository>(),
        super(const AuthState.initial()) {
    on<AuthEvent>(
      (event, emit) async {
        await event.when(
          authCheck: (withLoading) =>
              _mapAuthCheckToState(emit, withLoading: withLoading ?? true),
          refreshUser: () => _mapRefreshUserToState(emit),
          loginWithEmail: (email, password) =>
              _mapLoginWithEmailToState(email, password, emit),
          loginWithGoogle: () => _mapLoginWithGoogleToState(emit),
          signupWithEmail: (email, password, name, profilePath) =>
              _mapSignUpWithEmailToState(
                  name, email, password, profilePath, emit),
          verifyOtp: (email, token) =>
              _mapVerifyOtpToState(email, token, emit),
          resendOtp: (email) => _mapResendOtpToState(email, emit),
          forgotPassword: (email) => _mapForgotPasswordToState(email, emit),
          resetPassword: (email, token, newPassword) =>
              _mapResetPasswordToState(email, token, newPassword, emit),
          logout: () => _mapLogoutToState(emit),
        );
      },
    );
  }

  Future<void> _mapAuthCheckToState(Emitter<AuthState> emit,
      {bool withLoading = true}) async {
    try {
      if (withLoading) emit(const AuthState.loading());
      final appUser = await _repository.getCurrentUser();
      if (appUser == null) {
        emit(const AuthState.unauthenticated());
        return;
      }
      sl<ValueNotifier<AppUser>>().value = appUser;

      // Force-update gate. Tolerant parsing — a malformed version row must not
      // lock an otherwise-valid session out; just skip the gate in that case.
      final appVersion = await _repository.getLatestAppVersion();
      if (appVersion != null) {
        final latest = (appVersion['build_number'] as num?)?.toInt();
        final current =
            int.tryParse((await PackageInfo.fromPlatform()).buildNumber);
        if (latest != null && current != null && latest > current) {
          emit(AuthState.onNewVersion(appVersion));
          return;
        }
      }

      AppLogger.instance
          .debug('_mapAuthCheckToState: appUser: ${appUser.toJson()}');
      if (await _enforceDeviceLock(appUser, emit)) return;
      _subscribeUserRealtime();
      emit(const AuthState.authenticated());
    } catch (error) {
      if (_isOffline(error)) {
        emit(const AuthState.socketError('Please check your connection.'));
      } else {
        emit(AuthState.error(error.toString()));
      }
      AppLogger.instance.error('_authError: ${error.toString()}', error: error);
    }
  }

  Future<void> _mapLoginWithGoogleToState(Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    try {
      final appUser = await _repository.loginWithGoogle();
      // Null → the user dismissed the Google picker; return to the login screen.
      if (appUser == null) {
        emit(const AuthState.unauthenticated());
        return;
      }
      await _resolveAuthenticatedState(appUser, emit);
    } catch (error) {
      if (_isOffline(error)) {
        emit(const AuthState.socketError('Please check your connection.'));
      } else {
        emit(const AuthState.error(
            'Google sign-in failed. Please try again.'));
      }
      AppLogger.instance
          .error('_loginWithGoogleError: ${error.toString()}', error: error);
    }
  }

  Future<void> _mapSignUpWithEmailToState(String name, String email,
      String password, String? profilePath, Emitter<AuthState> emit) async {
    final emailRegex =
        RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      emit(const AuthState.error('All fields are required.'));
      return;
    }
    if (!emailRegex.hasMatch(email)) {
      emit(const AuthState.error('Invalid email format.'));
      return;
    }
    emit(const AuthState.loading());
    try {
      final appUser =
          await _repository.signUpWithEmail(email, password, name, profilePath);
      // No session yet → email confirmation is on and an OTP was sent.
      if (appUser == null) {
        emit(AuthState.otpRequired(email));
        return;
      }
      // Confirmation disabled → already signed in.
      await _resolveAuthenticatedState(appUser, emit);
    } catch (error) {
      if (_isOffline(error)) {
        emit(const AuthState.socketError('Please check your connection.'));
      } else {
        emit(AuthState.error(error.toString()));
      }
      AppLogger.instance
          .error('_signUpError: ${error.toString()}', error: error);
    }
  }

  Future<void> _mapVerifyOtpToState(
      String email, String token, Emitter<AuthState> emit) async {
    if (token.trim().length < 6) {
      emit(const AuthState.error('Please enter the 6-digit code.'));
      return;
    }
    emit(const AuthState.loading());
    try {
      final appUser = await _repository.verifySignUpOtp(email, token.trim());
      await _resolveAuthenticatedState(appUser, emit);
    } catch (error) {
      if (_isOffline(error)) {
        emit(const AuthState.socketError('Please check your connection.'));
      } else {
        emit(const AuthState.error(
            'Invalid or expired code. Please try again.'));
      }
      AppLogger.instance
          .error('_verifyOtpError: ${error.toString()}', error: error);
    }
  }

  Future<void> _mapResendOtpToState(
      String email, Emitter<AuthState> emit) async {
    try {
      await _repository.resendSignUpOtp(email);
      emit(const AuthState.otpResent());
    } catch (error) {
      if (_isOffline(error)) {
        emit(const AuthState.socketError('Please check your connection.'));
      } else {
        emit(const AuthState.error(
            'Could not resend the code. Please try again.'));
      }
      AppLogger.instance
          .error('_resendOtpError: ${error.toString()}', error: error);
    }
  }

  Future<void> _mapForgotPasswordToState(
      String email, Emitter<AuthState> emit) async {
    final emailRegex =
        RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    if (email.isEmpty || !emailRegex.hasMatch(email)) {
      emit(const AuthState.error('Invalid email format.'));
      return;
    }
    emit(const AuthState.loading());
    try {
      await _repository.sendPasswordResetOtp(email);
      emit(AuthState.passwordResetOtpSent(email));
    } catch (error) {
      if (_isOffline(error)) {
        emit(const AuthState.socketError('Please check your connection.'));
      } else {
        emit(const AuthState.error(
            'Could not send the reset code. Please try again.'));
      }
      AppLogger.instance
          .error('_forgotPasswordError: ${error.toString()}', error: error);
    }
  }

  Future<void> _mapResetPasswordToState(String email, String token,
      String newPassword, Emitter<AuthState> emit) async {
    if (token.trim().length < 6) {
      emit(const AuthState.error('Please enter the 6-digit code.'));
      return;
    }
    if (newPassword.length < 6) {
      emit(const AuthState.error('Password must be at least 6 characters.'));
      return;
    }
    emit(const AuthState.loading());
    try {
      final appUser =
          await _repository.resetPassword(email, token.trim(), newPassword);
      await _resolveAuthenticatedState(appUser, emit);
    } catch (error) {
      if (_isOffline(error)) {
        emit(const AuthState.socketError('Please check your connection.'));
      } else {
        emit(const AuthState.error(
            'Invalid or expired code. Please try again.'));
      }
      AppLogger.instance
          .error('_resetPasswordError: ${error.toString()}', error: error);
    }
  }

  /// Shared post-authentication resolution: premium gate, single-device lock,
  /// and first-login device binding. Used by login, OTP verify, and the
  /// confirmation-disabled signup path.
  Future<void> _resolveAuthenticatedState(
      AppUser appUser, Emitter<AuthState> emit) async {
    sl<ValueNotifier<AppUser>>().value = appUser;
    if (await _enforceDeviceLock(appUser, emit)) return;
    _subscribeUserRealtime();
    emit(const AuthState.authenticated());
  }

  /// Single-device lock, shared by `authCheck` and [_resolveAuthenticatedState]
  /// so the two can't drift. Returns `true` if it emitted a terminal state and
  /// the caller should stop.
  Future<bool> _enforceDeviceLock(
      AppUser appUser, Emitter<AuthState> emit) async {
    final localDeviceId =
        sl<ValueNotifier<String?>>(instanceName: 'deviceId').value;

    // Couldn't read this device's id (provider hiccup) — don't evict a valid
    // session over a transient failure; skip the lock for this run.
    if (localDeviceId == null) {
      AppLogger.instance.error(
          '_enforceDeviceLock: local deviceId is null — skipping device lock');
      return false;
    }
    // Bound to a different device → block and sign out.
    if (appUser.deviceId != null && appUser.deviceId != localDeviceId) {
      await _repository.logout();
      emit(const AuthState.deviceIdFailed());
      return true;
    }
    // First recognition on this device → bind it now.
    if (appUser.deviceId == null) {
      await _repository.updateDeviceId(localDeviceId);
      sl<ValueNotifier<AppUser>>().value =
          appUser.copyWith(deviceId: localDeviceId);
    }
    return false;
  }

  /// True for connectivity-style failures, so we can show the friendly
  /// "check your connection" state instead of a raw error. Supabase/PostgREST
  /// surface these as more than just [SocketException].
  bool _isOffline(Object error) {
    if (error is SocketException || error is TimeoutException) return true;
    final msg = error.toString().toLowerCase();
    return msg.contains('socketexception') ||
        msg.contains('failed host lookup') ||
        msg.contains('clientexception') ||
        msg.contains('connection closed') ||
        msg.contains('connection reset') ||
        msg.contains('connection refused') ||
        msg.contains('network is unreachable') ||
        msg.contains('retryable');
  }

  /// Silent re-fetch of the current user → updates the cached [AppUser] without
  /// emitting loading / version / device side effects. Used by the app-resume
  /// lifecycle hook and the premium realtime subscription.
  Future<void> _mapRefreshUserToState(Emitter<AuthState> emit) async {
    try {
      final appUser = await _repository.getCurrentUser();
      if (appUser != null) {
        sl<ValueNotifier<AppUser>>().value = appUser;
      }
    } catch (e) {
      AppLogger.instance.error('_refreshUserError: ${e.toString()}', error: e);
    }
  }

  void _subscribeUserRealtime() {
    final uid = supabase.auth.currentUser?.id;
    if (uid == null) return;
    _userChannel?.unsubscribe();
    _userChannel = supabase.channel('public:users:$uid')
      ..onPostgresChanges(
        event: PostgresChangeEvent.update,
        schema: 'public',
        table: 'users',
        filter: PostgresChangeFilter(
          type: PostgresChangeFilterType.eq,
          column: 'user_id',
          value: uid,
        ),
        callback: (_) => add(const AuthEvent.refreshUser()),
      )
      ..subscribe();
  }

  void _unsubscribeUserRealtime() {
    _userChannel?.unsubscribe();
    _userChannel = null;
  }

  @override
  Future<void> close() {
    _unsubscribeUserRealtime();
    return super.close();
  }

  Future<void> _mapLoginWithEmailToState(
      String email, String password, Emitter<AuthState> emit) async {
    if (email.isEmpty || password.isEmpty) {
      emit(const AuthState.error('Please enter email and password.'));
      return;
    }
    emit(const AuthState.loading());
    try {
      final appUser = await _repository.loginWithEmail(email, password);
      await _resolveAuthenticatedState(appUser, emit);
    } catch (error) {
      if (_isOffline(error)) {
        emit(const AuthState.socketError('Please check your connection.'));
      } else {
        debugPrint("_mapLoginWithEmailToState: ${error.toString()}");
        emit(const AuthState.error('Something went wrong. Please try again.'));
      }
      AppLogger.instance
          .error('_loginError: ${error.toString()}', error: error);
    }
  }

  Future<void> _mapLogoutToState(Emitter<AuthState> emit) async {
    try {
      emit(const AuthState.loading());
      _unsubscribeUserRealtime();
      await _repository.logout();
      AppLogger.instance.debug('_mapLogoutToState: logout successfully!');
      emit(const AuthState.unauthenticated());
    } catch (error) {
      if (_isOffline(error)) {
        emit(const AuthState.socketError('Please check your connection.'));
      } else {
        emit(AuthState.error(error.toString()));
      }
      AppLogger.instance
          .error('_logoutError: ${error.toString()}', error: error);
    }
  }
}
