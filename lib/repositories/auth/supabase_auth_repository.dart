import 'package:pmp_english/model/app_user/app_user.dart';
import 'package:pmp_english/services/supabase_service.dart';

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
  Future<AppUser> signUpWithEmail(
    String email,
    String password,
    String name,
    String? profilePath,
    String? deviceId,
  ) async {
    final response =
        await supabase.auth.signUp(email: email, password: password);
    if (response.user == null) throw Exception('Sign up failed: no user returned');
    await supabase.from('users').insert({
      'name': name,
      'email': email,
      'profile_path': profilePath,
      'user_id': response.user!.id,
      'device_id': deviceId,
    });
    return await supabase
        .rpc('get_user', params: {'user_id_param': response.user!.id})
        .single()
        .withConverter((json) => AppUser.fromJson(json));
  }

  @override
  Future<void> logout() async {
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
