// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AppUser _$AppUserFromJson(Map<String, dynamic> json) {
  return _AppUser.fromJson(json);
}

/// @nodoc
mixin _$AppUser {
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'account_id')
  String? get accountId => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'profile_path')
  String? get profilePath => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'device_id')
  String? get deviceId => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_token_used')
  int get totalTokenUsed => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_premium_user')
  bool? get isPremiumUser => throw _privateConstructorUsedError;

  /// Serializes this AppUser to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppUserCopyWith<AppUser> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppUserCopyWith<$Res> {
  factory $AppUserCopyWith(AppUser value, $Res Function(AppUser) then) =
      _$AppUserCopyWithImpl<$Res, AppUser>;
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'account_id') String? accountId,
      String? name,
      String email,
      @JsonKey(name: 'profile_path') String? profilePath,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'device_id') String? deviceId,
      @JsonKey(name: 'total_token_used') int totalTokenUsed,
      @JsonKey(name: 'is_premium_user') bool? isPremiumUser});
}

/// @nodoc
class _$AppUserCopyWithImpl<$Res, $Val extends AppUser>
    implements $AppUserCopyWith<$Res> {
  _$AppUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? accountId = freezed,
    Object? name = freezed,
    Object? email = null,
    Object? profilePath = freezed,
    Object? createdAt = freezed,
    Object? deviceId = freezed,
    Object? totalTokenUsed = null,
    Object? isPremiumUser = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      accountId: freezed == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      profilePath: freezed == profilePath
          ? _value.profilePath
          : profilePath // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deviceId: freezed == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String?,
      totalTokenUsed: null == totalTokenUsed
          ? _value.totalTokenUsed
          : totalTokenUsed // ignore: cast_nullable_to_non_nullable
              as int,
      isPremiumUser: freezed == isPremiumUser
          ? _value.isPremiumUser
          : isPremiumUser // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppUserImplCopyWith<$Res> implements $AppUserCopyWith<$Res> {
  factory _$$AppUserImplCopyWith(
          _$AppUserImpl value, $Res Function(_$AppUserImpl) then) =
      __$$AppUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      @JsonKey(name: 'account_id') String? accountId,
      String? name,
      String email,
      @JsonKey(name: 'profile_path') String? profilePath,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'device_id') String? deviceId,
      @JsonKey(name: 'total_token_used') int totalTokenUsed,
      @JsonKey(name: 'is_premium_user') bool? isPremiumUser});
}

/// @nodoc
class __$$AppUserImplCopyWithImpl<$Res>
    extends _$AppUserCopyWithImpl<$Res, _$AppUserImpl>
    implements _$$AppUserImplCopyWith<$Res> {
  __$$AppUserImplCopyWithImpl(
      _$AppUserImpl _value, $Res Function(_$AppUserImpl) _then)
      : super(_value, _then);

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? accountId = freezed,
    Object? name = freezed,
    Object? email = null,
    Object? profilePath = freezed,
    Object? createdAt = freezed,
    Object? deviceId = freezed,
    Object? totalTokenUsed = null,
    Object? isPremiumUser = freezed,
  }) {
    return _then(_$AppUserImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      accountId: freezed == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      profilePath: freezed == profilePath
          ? _value.profilePath
          : profilePath // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deviceId: freezed == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String?,
      totalTokenUsed: null == totalTokenUsed
          ? _value.totalTokenUsed
          : totalTokenUsed // ignore: cast_nullable_to_non_nullable
              as int,
      isPremiumUser: freezed == isPremiumUser
          ? _value.isPremiumUser
          : isPremiumUser // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppUserImpl implements _AppUser {
  const _$AppUserImpl(
      {this.id,
      @JsonKey(name: 'account_id') this.accountId,
      this.name,
      required this.email,
      @JsonKey(name: 'profile_path') this.profilePath,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'device_id') this.deviceId,
      @JsonKey(name: 'total_token_used') required this.totalTokenUsed,
      @JsonKey(name: 'is_premium_user') this.isPremiumUser});

  factory _$AppUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppUserImplFromJson(json);

  @override
  final int? id;
  @override
  @JsonKey(name: 'account_id')
  final String? accountId;
  @override
  final String? name;
  @override
  final String email;
  @override
  @JsonKey(name: 'profile_path')
  final String? profilePath;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'device_id')
  final String? deviceId;
  @override
  @JsonKey(name: 'total_token_used')
  final int totalTokenUsed;
  @override
  @JsonKey(name: 'is_premium_user')
  final bool? isPremiumUser;

  @override
  String toString() {
    return 'AppUser(id: $id, accountId: $accountId, name: $name, email: $email, profilePath: $profilePath, createdAt: $createdAt, deviceId: $deviceId, totalTokenUsed: $totalTokenUsed, isPremiumUser: $isPremiumUser)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppUserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.accountId, accountId) ||
                other.accountId == accountId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.profilePath, profilePath) ||
                other.profilePath == profilePath) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId) &&
            (identical(other.totalTokenUsed, totalTokenUsed) ||
                other.totalTokenUsed == totalTokenUsed) &&
            (identical(other.isPremiumUser, isPremiumUser) ||
                other.isPremiumUser == isPremiumUser));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, accountId, name, email,
      profilePath, createdAt, deviceId, totalTokenUsed, isPremiumUser);

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppUserImplCopyWith<_$AppUserImpl> get copyWith =>
      __$$AppUserImplCopyWithImpl<_$AppUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppUserImplToJson(
      this,
    );
  }
}

abstract class _AppUser implements AppUser {
  const factory _AppUser(
          {final int? id,
          @JsonKey(name: 'account_id') final String? accountId,
          final String? name,
          required final String email,
          @JsonKey(name: 'profile_path') final String? profilePath,
          @JsonKey(name: 'created_at') final DateTime? createdAt,
          @JsonKey(name: 'device_id') final String? deviceId,
          @JsonKey(name: 'total_token_used') required final int totalTokenUsed,
          @JsonKey(name: 'is_premium_user') final bool? isPremiumUser}) =
      _$AppUserImpl;

  factory _AppUser.fromJson(Map<String, dynamic> json) = _$AppUserImpl.fromJson;

  @override
  int? get id;
  @override
  @JsonKey(name: 'account_id')
  String? get accountId;
  @override
  String? get name;
  @override
  String get email;
  @override
  @JsonKey(name: 'profile_path')
  String? get profilePath;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'device_id')
  String? get deviceId;
  @override
  @JsonKey(name: 'total_token_used')
  int get totalTokenUsed;
  @override
  @JsonKey(name: 'is_premium_user')
  bool? get isPremiumUser;

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppUserImplCopyWith<_$AppUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
