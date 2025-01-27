import 'package:flutter/material.dart' show debugPrint;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pmp_english/config/common_extensions.dart';
import 'package:pmp_english/global_app_state.dart';

import '../../model/app_user/app_user.dart';
import '../../services/supabase_service.dart';

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
  const factory AuthState.onNewVersion(Map<String, dynamic> appVersion) =
      _OnNewVersion;
  const factory AuthState.error(String message) = _Error;
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState.initial()) {
    on<AuthEvent>((event, emit) async {
      try {
        await event.when(
          authCheck: (isLoading) => _mapAuthCheckToState(emit),
          loginWithEmail: (email, password) => _mapLoginWithEmailToState(
            email,
            password,
            emit,
          ),
          signupWithEmail: (email, password, name, profilePath) =>
              _mapSignUpWithEmailToState(
            name,
            email,
            password,
            profilePath,
            emit,
          ),
          logout: () => _mapLogoutToState(emit),
        );
      } catch (e) {
        debugPrint('Auth error: ${e.toString()}');
        emit(AuthState.error(e.toString()));
      }
    });
  }
  _mapAuthCheckToState(Emitter<AuthState> emit) async {
    try {
      emit(const AuthState.loading());
      final user = supabase.auth.currentSession?.user;
      if (user != null) {
        final appUser = await supabase
            .rpc(
              'get_user',
              params: {'user_id_param': user.id},
            )
            .single()
            .withConverter(
              (json) => AppUser.fromJson(json),
            );

        final appVersion = await supabase
            .from('app_versions')
            .select()
            .order('build_number', ascending: false)
            .limit(1)
            .maybeSingle();
        if (appVersion != null) {
          final buildNumber = appVersion['build_number'] as int;
          final packageInfo = await PackageInfo.fromPlatform();
          String code = packageInfo.buildNumber;
          if (buildNumber > int.parse(code)) {
            emit(AuthState.onNewVersion(appVersion));
            return;
          }
        }

        GlobalAppState().currentUser = appUser;
        if (appUser.deviceId != null &&
            appUser.deviceId != GlobalAppState().deviceID) {
          emit(
            const AuthState.deviceIdFailed(),
          );
          return;
        }
        if (!appUser.isPremiumUser!) {
          emit(const AuthState.onFreeUser());
          return;
        }

        emit(const AuthState.authenticated());
      } else {
        emit(const AuthState.unauthenticated());
      }
    } catch (error) {
      emit(AuthState.error(error.toString()));
      debugPrint("_authError: ${error.toString()}");
    }
  }

  _mapSignUpWithEmailToState(String name, String email, String password,
      String? profilePath, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    try {
      final response =
          await supabase.auth.signUp(email: email, password: password);
      if (response.user != null) {
        await supabase.from('users').insert({
          'name': name,
          'email': email,
          'profile_path': profilePath,
          'account_id': ''.generateAccountID(),
          'user_id': response.user?.id,
          'device_id': GlobalAppState().deviceID,
        });
        final appUser = await supabase
            .rpc(
              'get_user',
              params: {'user_id_param': response.user!.id},
            )
            .single()
            .withConverter(
              (json) => AppUser.fromJson(json),
            );
        GlobalAppState().currentUser = appUser;
        if (!appUser.isPremiumUser!) {
          emit(const AuthState.onFreeUser());
          return;
        }
        emit(const AuthState.authenticated());
      }
    } catch (error) {
      debugPrint("_onAuthBlocError: ${error.toString()} Error!");
      emit(AuthState.error(error.toString()));
    }
  }

  _mapLoginWithEmailToState(
      String email, String password, Emitter<AuthState> emit) async {
    try {
      emit(const AuthState.loading());
      await supabase.auth.signInWithPassword(email: email, password: password);
      final user = supabase.auth.currentUser;
      final appUser = await supabase
          .rpc(
            'get_user',
            params: {'user_id_param': user!.id},
          )
          .single()
          .withConverter(
            (json) => AppUser.fromJson(json),
          );
      GlobalAppState().currentUser = appUser;
      if (!appUser.isPremiumUser!) {
        emit(const AuthState.onFreeUser());
        return;
      }
      if (appUser.deviceId != null &&
          appUser.deviceId != GlobalAppState().deviceID) {
        await supabase.auth.signOut();
        emit(const AuthState.deviceIdFailed());
        return;
      }
      emit(const AuthState.authenticated());
    } catch (error) {
      emit(AuthState.error(error.toString()));
    }
  }

  _mapLogoutToState(Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    await supabase.auth.signOut();
    debugPrint("_mapLogoutToState: logout successfully!");
    emit(const AuthState.unauthenticated());
  }
}
