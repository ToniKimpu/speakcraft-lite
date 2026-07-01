import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:speakcraft/config/env.dart';
import 'package:speakcraft/core/logger/app_logger.dart';
import 'package:speakcraft/model/app_user/app_user.dart';
import 'package:speakcraft/services/supabase_service.dart';

import 'auth_repository.dart';

class SupabaseAuthRepository implements AuthRepository {
  @override
  Future<AppUser?> getCurrentUser() async {
    final user = supabase.auth.currentSession?.user;
    if (user == null) return null;
    // Read the RPC result as a LIST, not .single()/.maybeSingle(): get_user is a
    // set-returning function called over POST, and postgrest's maybeSingle
    // PGRST116 workaround only applies to GET — so .maybeSingle() here still
    // throws "0 rows" (PGRST116) instead of returning null. A list avoids it.
    // Empty list = the session's profile row is missing (stale/deleted user);
    // sign out so the app falls back to login rather than dead-ending on a
    // "something went wrong" error with no way forward.
    final res =
        await supabase.rpc('get_user', params: {'user_id_param': user.id});
    final rows = (res as List?) ?? const [];
    if (rows.isEmpty) {
      await logout();
      return null;
    }
    return AppUser.fromJson(Map<String, dynamic>.from(rows.first as Map));
  }

  @override
  Future<AppUser> loginWithEmail(String email, String password) async {
    await supabase.auth.signInWithPassword(email: email, password: password);
    final user = supabase.auth.currentUser!;
    return await supabase
        .rpc('get_user', params: {'user_id_param': user.id})
        .single()
        .withConverter((json) => AppUser.fromJson(json));
  }

  @override
  Future<AppUser?> signUpWithEmail(
    String email,
    String password,
    String name,
    String? profilePath,
  ) async {
    // Name/avatar go in user metadata; the handle_new_user DB trigger reads
    // raw_user_meta_data to create the public.users profile row (account_id and
    // all). device_id is intentionally set on first login, not signup.
    final response = await supabase.auth.signUp(
      email: email,
      password: password,
      data: {
        'name': name,
        if (profilePath != null) 'profile_path': profilePath,
      },
    );
    if (response.user == null) {
      throw Exception('Sign up failed: no user returned');
    }
    // Email confirmation ON → no session yet; an OTP was emailed. The caller
    // routes to the OTP screen and finishes via verifySignUpOtp.
    if (response.session == null) return null;
    // Email confirmation OFF → already signed in.
    return await supabase
        .rpc('get_user', params: {'user_id_param': response.user!.id})
        .single()
        .withConverter((json) => AppUser.fromJson(json));
  }

  @override
  Future<AppUser> verifySignUpOtp(String email, String token) async {
    try {
      final res = await supabase.auth.verifyOTP(
        type: OtpType.signup,
        email: email,
        token: token,
      );
      final user = res.user ?? supabase.auth.currentUser;
      if (user == null) {
        throw Exception('Verification failed: no session');
      }
      return await supabase
          .rpc('get_user', params: {'user_id_param': user.id})
          .single()
          .withConverter((json) => AppUser.fromJson(json));
    } on AuthException catch (e) {
      throw Exception(e.message);
    }
  }

  @override
  Future<void> resendSignUpOtp(String email) async {
    try {
      await supabase.auth.resend(type: OtpType.signup, email: email);
    } on AuthException catch (e) {
      throw Exception(e.message);
    }
  }

  @override
  Future<void> sendPasswordResetOtp(String email) async {
    try {
      await supabase.auth.resetPasswordForEmail(email);
    } on AuthException catch (e) {
      throw Exception(e.message);
    }
  }

  @override
  Future<AppUser> resetPassword(
      String email, String token, String newPassword) async {
    try {
      // Recovery OTP verification establishes a session, after which we can
      // update the password.
      await supabase.auth.verifyOTP(
        type: OtpType.recovery,
        email: email,
        token: token,
      );
      await supabase.auth.updateUser(UserAttributes(password: newPassword));
      final user = supabase.auth.currentUser;
      if (user == null) {
        throw Exception('Reset failed: no session');
      }
      return await supabase
          .rpc('get_user', params: {'user_id_param': user.id})
          .single()
          .withConverter((json) => AppUser.fromJson(json));
    } on AuthException catch (e) {
      throw Exception(e.message);
    }
  }

  @override
  Future<AppUser> loginAsGuest() async {
    try {
      final res = await supabase.auth.signInAnonymously();
      final user = res.user ?? supabase.auth.currentUser;
      if (user == null) {
        throw Exception('Guest sign-in failed: no session.');
      }
      // handle_new_user provisions the profile row on this first insert.
      return await supabase
          .rpc('get_user', params: {'user_id_param': user.id})
          .single()
          .withConverter((json) => AppUser.fromJson(json));
    } on AuthException catch (e) {
      throw Exception(e.message);
    }
  }

  /// Runs the native Google picker and returns its ID/access tokens. Shared by
  /// [loginWithGoogle] and [convertGuestWithGoogle]. Throws
  /// [GoogleSignInException] (code `canceled` when the user dismisses it).
  Future<({String idToken, String? accessToken})> _googleCredential() async {
    final webClientId = Env.googleWebClientId;
    if (webClientId == null || webClientId.isEmpty) {
      throw Exception('Google sign-in is not configured.');
    }
    const scopes = ['email', 'profile'];
    final googleSignIn = GoogleSignIn.instance;
    await googleSignIn.initialize(serverClientId: webClientId);

    // Try silent sign-in first, then fall back to the interactive picker.
    var googleUser = await googleSignIn.attemptLightweightAuthentication();
    googleUser ??= await googleSignIn.authenticate(scopeHint: scopes);

    final authorization =
        await googleUser.authorizationClient.authorizationForScopes(scopes) ??
            await googleUser.authorizationClient.authorizeScopes(scopes);
    final idToken = googleUser.authentication.idToken;
    if (idToken == null) {
      throw Exception('Google sign-in failed: no ID token.');
    }
    return (idToken: idToken, accessToken: authorization.accessToken);
  }

  /// Fetches the current user via get_user.
  Future<AppUser> _fetchCurrentUser() async {
    final user = supabase.auth.currentUser;
    if (user == null) throw Exception('No session.');
    return await supabase
        .rpc('get_user', params: {'user_id_param': user.id})
        .single()
        .withConverter((json) => AppUser.fromJson(json));
  }

  @override
  Future<AppUser?> convertGuestWithGoogle() async {
    try {
      final cred = await _googleCredential();
      try {
        // Link Google to the CURRENT anonymous user (same uid → progress kept).
        await supabase.auth.linkIdentityWithIdToken(
          provider: OAuthProvider.google,
          idToken: cred.idToken,
          accessToken: cred.accessToken,
        );
      } on AuthException catch (e) {
        // Already tied to another account → can't link. Let the UI confirm and
        // sign into that existing account instead.
        if (e.code == 'identity_already_exists') {
          throw const GuestIdentityExistsException();
        }
        rethrow;
      }
      // The on_auth_user_updated trigger syncs email/name into public.users.
      return await _fetchCurrentUser();
    } on GoogleSignInException catch (e, st) {
      AppLogger.instance.error(
        '[GuestConvertGoogle] code=${e.code} description=${e.description}',
        error: e,
        stackTrace: st,
      );
      if (e.code == GoogleSignInExceptionCode.canceled) return null;
      throw Exception(e.toString());
    } on AuthException catch (e) {
      throw Exception(e.message);
    }
  }

  @override
  Future<void> convertGuestWithEmail(
      String email, String password, String name) async {
    try {
      // Attach email + password to the current anonymous user. Password applies
      // immediately; the email requires confirmation (OTP), same as signup. Name
      // goes to user_metadata and is copied into public.users after verification.
      await supabase.auth.updateUser(
        UserAttributes(email: email, password: password, data: {'name': name}),
      );
    } on AuthException catch (e) {
      // A prior attempt already set this password (updateUser applies the
      // password immediately, not atomically with the email confirmation), so a
      // retry fails with same_password. The password is already correct — just
      // (re)issue the email OTP without touching the password.
      if (e.code == 'same_password') {
        try {
          await supabase.auth.updateUser(
            UserAttributes(email: email, data: {'name': name}),
          );
          return;
        } on AuthException catch (e2) {
          throw Exception(e2.message);
        }
      }
      throw Exception(e.message);
    }
  }

  @override
  Future<AppUser> verifyGuestConvertOtp(
      String email, String token, String name) async {
    try {
      await supabase.auth.verifyOTP(
        type: OtpType.emailChange,
        email: email,
        token: token,
      );
      // The on_auth_user_updated trigger syncs email/name into public.users.
      return await _fetchCurrentUser();
    } on AuthException catch (e) {
      throw Exception(e.message);
    }
  }

  @override
  Future<void> resendGuestConvertOtp(String email) async {
    try {
      await supabase.auth.resend(type: OtpType.emailChange, email: email);
    } on AuthException catch (e) {
      throw Exception(e.message);
    }
  }

  @override
  Future<AppUser?> loginWithGoogle() async {
    try {
      final cred = await _googleCredential();
      final res = await supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: cred.idToken,
        accessToken: cred.accessToken,
      );
      final user = res.user ?? supabase.auth.currentUser;
      if (user == null) {
        throw Exception('Google sign-in failed: no session.');
      }
      // The handle_new_user trigger creates the profile row on first sign-in,
      // reading the Google display name from raw_user_meta_data.
      return await supabase
          .rpc('get_user', params: {'user_id_param': user.id})
          .single()
          .withConverter((json) => AppUser.fromJson(json));
    } on GoogleSignInException catch (e, st) {
      // Log every case, including "canceled" — on Android a config/SHA mismatch
      // is surfaced through Credential Manager as a cancel, so a silent pop with
      // code=canceled can mean the OAuth client doesn't match the build.
      AppLogger.instance.error(
        '[GoogleLogin] GoogleSignInException code=${e.code} '
        'description=${e.description} details=${e.details}',
        error: e,
        stackTrace: st,
      );
      if (e.code == GoogleSignInExceptionCode.canceled) {
        return null; // user dismissed the picker (or unmatched OAuth client)
      }
      throw Exception(e.toString());
    } catch (e, st) {
      // Anything else (PlatformException, AuthException, network, get_user RLS…).
      AppLogger.instance.error('[GoogleLogin] ${e.runtimeType}: $e',
          error: e, stackTrace: st);
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await GoogleSignIn.instance.signOut();
    } catch (_) {
      // Ignore — the user may not have signed in with Google.
    }
    await supabase.auth.signOut();
  }

  @override
  Future<Map<String, dynamic>?> getLatestAppVersion() async {
    return await supabase
        .from('app_versions')
        .select()
        .order('build_number', ascending: false)
        .limit(1)
        .maybeSingle();
  }

  @override
  Future<void> updateDeviceId(String deviceId) async {
    final userId = supabase.auth.currentUser!.id;
    await supabase
        .from('users')
        .update({'device_id': deviceId}).eq('user_id', userId);
  }
}
