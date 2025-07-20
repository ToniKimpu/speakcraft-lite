// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user.freezed.dart';
part 'app_user.g.dart';

@freezed
class AppUser with _$AppUser {
  const factory AppUser({
    int? id,
    String? name,
    required String email,
    @JsonKey(name: 'profile_path') String? profilePath,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'device_id') String? deviceId,
    @JsonKey(name: 'is_premium_user') bool? isPremiumUser,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);

  factory AppUser.empty() {
    return AppUser(
      id: null,
      name: '',
      email: '',
      profilePath: '',
      isPremiumUser: false,
      createdAt: DateTime.now(),
    );
  }
}
