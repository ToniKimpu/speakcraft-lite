import '../../model/app_user/app_user.dart';

abstract class AuthRepository {
  Future<AppUser?> getCurrentUser();
  Future<AppUser> loginWithEmail(String email, String password);

  /// Native Google sign-in. Returns the [AppUser] on success, or `null` if the
  /// user dismissed the Google account picker.
  Future<AppUser?> loginWithGoogle();

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
