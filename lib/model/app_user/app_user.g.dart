// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppUserImpl _$$AppUserImplFromJson(Map<String, dynamic> json) =>
    _$AppUserImpl(
      id: (json['id'] as num?)?.toInt(),
      accountId: json['account_id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String,
      profilePath: json['profile_path'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      deviceId: json['device_id'] as String?,
      totalTokenUsed: (json['total_token_used'] as num).toInt(),
      isPremiumUser: json['is_premium_user'] as bool?,
    );

Map<String, dynamic> _$$AppUserImplToJson(_$AppUserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'account_id': instance.accountId,
      'name': instance.name,
      'email': instance.email,
      'profile_path': instance.profilePath,
      'created_at': instance.createdAt?.toIso8601String(),
      'device_id': instance.deviceId,
      'total_token_used': instance.totalTokenUsed,
      'is_premium_user': instance.isPremiumUser,
    };
