import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:speakcraft/core/di/service_locator.dart';
import 'package:speakcraft/core/logger/app_logger.dart';
import 'package:speakcraft/core/network/network_error.dart';
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
  const factory AuthEvent.loginAsGuest() = _LoginAsGuest;
  const factory AuthEvent.convertGuestWithGoogle() = _ConvertGuestWithGoogle;
  const factory AuthEvent.convertGuestWithEmail(
      String email, String password, String name) = _ConvertGuestWithEmail;
  const factory AuthEvent.verifyGuestConvertOtp(
      String email, String token, String name) = _VerifyGuestConvertOtp;
  const factory AuthEvent.resendGuestConvertOtp(String email) =
      _ResendGuestConvertOtp;
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
          authCheck: (_) => _mapAuthCheckToState(emit),
          refreshUser: () => _mapRefreshUserToState(emit),
          loginWithEmail: (email, password) =>
              _mapLoginWithEmailToState(email, password, emit),
          loginWithGoogle: () => _mapLoginWithGoogleToState(emit),
          loginAsGuest: () => _mapLoginAsGuestToState(emit),
          convertGuestWithGoogle: () => _mapConvertGuestWithGoogleToState(emit),
          convertGuestWithEmail: (email, password, name) =>
              _mapConvertGuestWithEmailToState(email, password, name, emit),
          verifyGuestConvertOtp: (email, token, name) =>
              _mapVerifyGuestConvertOtpToState(email, token, name, emit),
          resendGuestConvertOtp: (email) =>
              _mapResendGuestConvertOtpToState(email, emit),
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

  Future<void> _mapAuthCheckToState(Emitter<AuthState> emit) async {
    try {
      emit(const AuthState.loading());
      // Fail fast on a dead/slow network instead of waiting out the ~30s
      // platform socket timeout on the splash screen.
      final appUser = await _repository
          .getCurrentUser()
          .timeout(const Duration(seconds: 15));
      if (appUser == null) {
        emit(const AuthState.unauthenticated());
        return;
      }
      sl<ValueNotifier<AppUser>>().value = appUser;
      final appVersion = await _repository
          .getLatestAppVersion()
          .timeout(const Duration(seconds: 15));
      if (appVersion != null) {
        final buildNumber = appVersion['build_number'] as int;
        final packageInfo = await PackageInfo.fromPlatform();
        if (buildNumber > int.parse(packageInfo.buildNumber)) {
          emit(AuthState.onNewVersion(appVersion));
          return;
        }
      }
      AppLogger.instance
          .debug('_mapAuthCheckToState: appUser: ${appUser.toJson()}');
      if (appUser.deviceId != null &&
          appUser.deviceId !=
              sl<ValueNotifier<String?>>(instanceName: 'deviceId').value) {
        await _repository.logout();
        emit(const AuthState.deviceIdFailed());
        return;
      }
      _subscribeUserRealtime();
      emit(const AuthState.authenticated());
    } catch (error) {
      if (isOfflineError(error)) {
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
      if (isOfflineError(error)) {
        emit(const AuthState.socketError('Please check your connection.'));
      } else {
        emit(const AuthState.error(
            'Google sign-in failed. Please try again.'));
      }
      AppLogger.instance
          .error('_loginWithGoogleError: ${error.toString()}', error: error);
    }
  }

  Future<void> _mapLoginAsGuestToState(Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    try {
      final appUser = await _repository.loginAsGuest();
      await _resolveAuthenticatedState(appUser, emit);
    } catch (error) {
      if (isOfflineError(error)) {
        emit(const AuthState.socketError('Please check your connection.'));
      } else {
        emit(const AuthState.error(
            'Could not continue as guest. Please try again.'));
      }
      AppLogger.instance
          .error('_loginAsGuestError: ${error.toString()}', error: error);
    }
  }

  Future<void> _mapConvertGuestWithGoogleToState(
      Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    try {
      final appUser = await _repository.convertGuestWithGoogle();
      // Null → the user dismissed the Google picker; stay on the convert screen.
      if (appUser == null) {
        emit(const AuthState.unauthenticated());
        return;
      }
      await _resolveAuthenticatedState(appUser, emit);
    } catch (error) {
      if (isOfflineError(error)) {
        emit(const AuthState.socketError('Please check your connection.'));
      } else {
        emit(AuthState.error(error.toString().replaceFirst('Exception: ', '')));
      }
      AppLogger.instance
          .error('_convertGoogleError: ${error.toString()}', error: error);
    }
  }

  Future<void> _mapConvertGuestWithEmailToState(String email, String password,
      String name, Emitter<AuthState> emit) async {
    final emailRegex =
        RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    if (name.trim().isEmpty || email.isEmpty || password.isEmpty) {
      emit(const AuthState.error('All fields are required.'));
      return;
    }
    if (!emailRegex.hasMatch(email)) {
      emit(const AuthState.error('Invalid email format.'));
      return;
    }
    if (password.length < 6) {
      emit(const AuthState.error('Password must be at least 6 characters.'));
      return;
    }
    emit(const AuthState.loading());
    try {
      await _repository.convertGuestWithEmail(email, password, name.trim());
      // Email needs confirmation → collect the OTP, then verify.
      emit(AuthState.otpRequired(email));
    } catch (error) {
      if (isOfflineError(error)) {
        emit(const AuthState.socketError('Please check your connection.'));
      } else {
        emit(AuthState.error(error.toString().replaceFirst('Exception: ', '')));
      }
      AppLogger.instance
          .error('_convertEmailError: ${error.toString()}', error: error);
    }
  }

  Future<void> _mapVerifyGuestConvertOtpToState(
      String email, String token, String name, Emitter<AuthState> emit) async {
    if (token.trim().length < 6) {
      emit(const AuthState.error('Please enter the 6-digit code.'));
      return;
    }
    emit(const AuthState.loading());
    try {
      final appUser =
          await _repository.verifyGuestConvertOtp(email, token.trim(), name);
      await _resolveAuthenticatedState(appUser, emit);
    } catch (error) {
      if (isOfflineError(error)) {
        emit(const AuthState.socketError('Please check your connection.'));
      } else {
        emit(const AuthState.error(
            'Invalid or expired code. Please try again.'));
      }
      AppLogger.instance
          .error('_verifyConvertOtpError: ${error.toString()}', error: error);
    }
  }

  Future<void> _mapResendGuestConvertOtpToState(
      String email, Emitter<AuthState> emit) async {
    try {
      await _repository.resendGuestConvertOtp(email);
      emit(const AuthState.otpResent());
    } catch (error) {
      if (isOfflineError(error)) {
        emit(const AuthState.socketError('Please check your connection.'));
      } else {
        emit(const AuthState.error(
            'Could not resend the code. Please try again.'));
      }
      AppLogger.instance
          .error('_resendConvertOtpError: ${error.toString()}', error: error);
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
      if (isOfflineError(error)) {
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
      if (isOfflineError(error)) {
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
      if (isOfflineError(error)) {
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
      if (isOfflineError(error)) {
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
      if (isOfflineError(error)) {
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
    // Guests skip single-device binding: it's zero-friction "just try it", and
    // the lock only makes sense once they convert to a real account.
    if (supabase.auth.currentUser?.isAnonymous == true) {
      _subscribeUserRealtime();
      emit(const AuthState.authenticated());
      return;
    }
    final localDeviceId =
        sl<ValueNotifier<String?>>(instanceName: 'deviceId').value;
    if (appUser.deviceId != null && appUser.deviceId != localDeviceId) {
      await _repository.logout();
      emit(const AuthState.deviceIdFailed());
      return;
    }
    if (appUser.deviceId == null && localDeviceId != null) {
      await _repository.updateDeviceId(localDeviceId);
      sl<ValueNotifier<AppUser>>().value =
          appUser.copyWith(deviceId: localDeviceId);
    }
    _subscribeUserRealtime();
    emit(const AuthState.authenticated());
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
      if (isOfflineError(error)) {
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
      if (isOfflineError(error)) {
        emit(const AuthState.socketError('Please check your connection.'));
      } else {
        emit(AuthState.error(error.toString()));
      }
      AppLogger.instance
          .error('_logoutError: ${error.toString()}', error: error);
    }
  }
}
