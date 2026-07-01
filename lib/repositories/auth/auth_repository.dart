import '../../model/app_user/app_user.dart';

abstract class AuthRepository {
  Future<AppUser?> getCurrentUser();
  Future<AppUser> loginWithEmail(String email, String password);

  /// Native Google sign-in. Returns the [AppUser] on success, or `null` if the
  /// user dismissed the Google account picker.
  Future<AppUser?> loginWithGoogle();

  /// Anonymous ("guest") sign-in — creates a real Supabase session with no
  /// email/password so the user can reach home and explore Free features. The
  /// handle_new_user trigger provisions the matching profile row (account_id and
  /// all). Requires Anonymous sign-ins to be enabled in Supabase Auth settings.
  Future<AppUser> loginAsGuest();

  /// Converts the current guest (anonymous) user into a permanent one by linking
  /// a Google identity to the SAME auth user — so account_id and all progress
  /// survive. Returns the refreshed [AppUser], or `null` if the user dismissed
  /// the Google picker.
  Future<AppUser?> convertGuestWithGoogle();

  /// Converts the current guest into a permanent email/password account on the
  /// SAME auth user (progress preserved). The password applies immediately but
  /// the email needs confirmation, so this returns without a finished profile;
  /// the caller collects the OTP and calls [verifyGuestConvertOtp].
  Future<void> convertGuestWithEmail(String email, String password, String name);

  /// Verifies the email-change OTP from [convertGuestWithEmail], finalising the
  /// conversion, and returns the refreshed [AppUser].
  Future<AppUser> verifyGuestConvertOtp(String email, String token, String name);

  /// Re-sends the email-change confirmation OTP during guest conversion.
  Future<void> resendGuestConvertOtp(String email);

  /// Initiates email signup. Returns the [AppUser] when a session is already
  /// active (email confirmation disabled), or `null` when an OTP was emailed and
  /// the caller must collect it via [verifySignUpOtp].
  Future<AppUser?> signUpWithEmail(
    String email,
    String password,
    String name,
    String? profilePath,
  );

  /// Verifies the signup OTP, establishing a session, and returns the [AppUser].
  Future<AppUser> verifySignUpOtp(String email, String token);

  /// Re-sends the signup OTP to [email].
  Future<void> resendSignUpOtp(String email);

  /// Sends a password-reset (recovery) OTP to [email].
  Future<void> sendPasswordResetOtp(String email);

  /// Verifies the recovery OTP, sets [newPassword], and returns the [AppUser]
  /// (the recovery verification establishes a session).
  Future<AppUser> resetPassword(String email, String token, String newPassword);

  Future<void> logout();
  Future<Map<String, dynamic>?> getLatestAppVersion();
  Future<void> updateDeviceId(String deviceId);
}
