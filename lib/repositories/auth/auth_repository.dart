import '../../model/app_user/app_user.dart';

abstract class AuthRepository {
  Future<AppUser?> getCurrentUser();
  Future<AppUser> loginWithEmail(String email, String password);
  Future<AppUser> signUpWithEmail(
    String email,
    String password,
    String name,
    String? profilePath,
    String? deviceId,
  );
  Future<void> logout();
  Future<Map<String, dynamic>?> getLatestAppVersion();
  Future<void> updateDeviceId(String deviceId);
}
