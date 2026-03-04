import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pmp_english/core/di/service_locator.dart';
import 'package:pmp_english/core/logger/app_logger.dart';
import 'package:pmp_english/global_app_state.dart';
import 'package:pmp_english/repositories/auth/auth_repository.dart';

import '../../model/app_user/app_user.dart';

part 'auth_bloc.freezed.dart';

@freezed
abstract class AuthEvent with _$AuthEvent {
  const factory AuthEvent.authCheck({bool? withLoading}) = _AuthCheck;
  const factory AuthEvent.loginWithEmail(String email, String password) =
      _LoginWithEmail;
  const factory AuthEvent.signupWithEmail(
          String email, String password, String name, String? profilePath) =
      _SignUpWithEmail;
  const factory AuthEvent.logout() = _Logout;
}

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.authenticated() = _Authenticated;
  const factory AuthState.unauthenticated() = _Unauthenticated;
  const factory AuthState.deviceIdFailed() = _DeviceIdFailed;
  const factory AuthState.onFreeUser() = _OnFreeUser;
  const factory AuthState.onNewPath() = _OnNewPath;
  const factory AuthState.onNewVersion(Map<String, dynamic> appVersion) =
      _OnNewVersion;
  const factory AuthState.socketError(String message) = _SocketError;
  const factory AuthState.error(String message) = _Error;
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repository;

  AuthBloc({AuthRepository? repository})
      : _repository = repository ?? sl<AuthRepository>(),
        super(const AuthState.initial()) {
    on<AuthEvent>(
      (event, emit) async {
        await event.when(
          authCheck: (_) => _mapAuthCheckToState(emit),
          loginWithEmail: (email, password) =>
              _mapLoginWithEmailToState(email, password, emit),
          signupWithEmail: (email, password, name, profilePath) =>
              _mapSignUpWithEmailToState(name, email, password, profilePath, emit),
          logout: () => _mapLogoutToState(emit),
        );
      },
    );
  }

  Future<void> _mapAuthCheckToState(Emitter<AuthState> emit) async {
    try {
      emit(const AuthState.loading());
      final appUser = await _repository.getCurrentUser();
      if (appUser == null) {
        emit(const AuthState.unauthenticated());
        return;
      }
      GlobalAppState().currentUser = appUser;
      if (!appUser.isPremiumUser!) {
        emit(const AuthState.onFreeUser());
        return;
      }
      final appVersion = await _repository.getLatestAppVersion();
      if (appVersion != null) {
        final buildNumber = appVersion['build_number'] as int;
        final packageInfo = await PackageInfo.fromPlatform();
        if (buildNumber > int.parse(packageInfo.buildNumber)) {
          emit(AuthState.onNewVersion(appVersion));
          return;
        }
      }
      AppLogger.instance.debug('_mapAuthCheckToState: appUser: ${appUser.toJson()}');
      if (appUser.deviceId != null &&
          appUser.deviceId != GlobalAppState().deviceID) {
        await _repository.logout();
        emit(const AuthState.deviceIdFailed());
        return;
      }
      emit(const AuthState.authenticated());
    } catch (error) {
      if (error is SocketException || error is TimeoutException) {
        emit(const AuthState.socketError('Please check your connection.'));
      } else {
        emit(AuthState.error(error.toString()));
      }
      AppLogger.instance.error('_authError: ${error.toString()}', error: error);
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
      final appUser = await _repository.signUpWithEmail(
          email, password, name, profilePath, GlobalAppState().deviceID);
      GlobalAppState().currentUser = appUser;
      if (!appUser.isPremiumUser!) {
        emit(const AuthState.onFreeUser());
        return;
      }
      emit(const AuthState.authenticated());
    } catch (error) {
      if (error is SocketException || error is TimeoutException) {
        emit(const AuthState.socketError('Please check your connection.'));
      } else {
        emit(AuthState.error(error.toString()));
      }
      AppLogger.instance.error('_signUpError: ${error.toString()}', error: error);
    }
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
      GlobalAppState().currentUser = appUser;
      if (!appUser.isPremiumUser!) {
        emit(const AuthState.onFreeUser());
        return;
      }
      if (appUser.deviceId != null &&
          appUser.deviceId != GlobalAppState().deviceID) {
        await _repository.logout();
        emit(const AuthState.deviceIdFailed());
        return;
      }
      if (appUser.deviceId == null && GlobalAppState().deviceID != null) {
        await _repository.updateDeviceId(GlobalAppState().deviceID!);
        GlobalAppState().currentUser =
            appUser.copyWith(deviceId: GlobalAppState().deviceID);
      }
      emit(const AuthState.authenticated());
    } catch (error) {
      if (error is SocketException || error is TimeoutException) {
        emit(const AuthState.socketError('Please check your connection.'));
      } else {
        emit(const AuthState.error('Something went wrong. Please try again.'));
      }
      AppLogger.instance.error('_loginError: ${error.toString()}', error: error);
    }
  }

  Future<void> _mapLogoutToState(Emitter<AuthState> emit) async {
    try {
      emit(const AuthState.loading());
      await _repository.logout();
      AppLogger.instance.debug('_mapLogoutToState: logout successfully!');
      emit(const AuthState.unauthenticated());
    } catch (error) {
      if (error is SocketException || error is TimeoutException) {
        emit(const AuthState.socketError('Please check your connection.'));
      } else {
        emit(AuthState.error(error.toString()));
      }
      AppLogger.instance.error('_logoutError: ${error.toString()}', error: error);
    }
  }
}
