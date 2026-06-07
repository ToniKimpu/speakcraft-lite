import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:speakcraft/config/env.dart';
import 'package:speakcraft/model/app_user/app_user.dart';
import 'package:speakcraft/services/supabase_service.dart';

import 'auth_repository.dart';

class SupabaseAuthRepository implements AuthRepository {
  @override
  Future<AppUser?> getCurrentUser() async {
    final user = supabase.auth.currentSession?.user;
    if (user == null) return null;
    final dataRes = await supabase
        .rpc('get_user', params: {'user_id_param': user.id})
        .single();
    return AppUser.fromJson(dataRes);
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
  Future<AppUser?> loginWithGoogle() async {
    final webClientId = Env.googleWebClientId;
    if (webClientId == null || webClientId.isEmpty) {
      throw Exception('Google sign-in is not configured.');
    }
    try {
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

      final res = await supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: authorization.accessToken,
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
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) {
        return null; // user dismissed the picker
      }
      throw Exception(e.toString());
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
