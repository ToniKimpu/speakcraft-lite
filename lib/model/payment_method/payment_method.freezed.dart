// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_method.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PaymentMethod _$PaymentMethodFromJson(Map<String, dynamic> json) {
  return _PaymentMethod.fromJson(json);
}

/// @nodoc
mixin _$PaymentMethod {
  int get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'display_name')
  String get displayName => throw _privateConstructorUsedError;
  @JsonKey(name: 'account_name')
  String get accountName => throw _privateConstructorUsedError;
  @JsonKey(name: 'account_number')
  String get accountNumber =>
      throw _privateConstructorUsedError; // Raw filename from the DB; the repository rewrites this to a full public
// URL (contents/payments/qr/<file>) before it reaches the UI.
  @JsonKey(name: 'qr_object_path')
  String? get qrObjectPath => throw _privateConstructorUsedError;
  String? get instructions => throw _privateConstructorUsedError;
  num get amount => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  @JsonKey(name: 'plan_code')
  String get planCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'sort_order')
  int get sortOrder => throw _privateConstructorUsedError;

  /// Serializes this PaymentMethod to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaymentMethod
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaymentMethodCopyWith<PaymentMethod> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentMethodCopyWith<$Res> {
  factory $PaymentMethodCopyWith(
          PaymentMethod value, $Res Function(PaymentMethod) then) =
      _$PaymentMethodCopyWithImpl<$Res, PaymentMethod>;
  @useResult
  $Res call(
      {int id,
      String type,
      @JsonKey(name: 'display_name') String displayName,
      @JsonKey(name: 'account_name') String accountName,
      @JsonKey(name: 'account_number') String accountNumber,
      @JsonKey(name: 'qr_object_path') String? qrObjectPath,
      String? instructions,
      num amount,
      String currency,
      @JsonKey(name: 'plan_code') String planCode,
      @JsonKey(name: 'is_active') bool isActive,
      @JsonKey(name: 'sort_order') int sortOrder});
}

/// @nodoc
class _$PaymentMethodCopyWithImpl<$Res, $Val extends PaymentMethod>
    implements $PaymentMethodCopyWith<$Res> {
  _$PaymentMethodCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaymentMethod
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? displayName = null,
    Object? accountName = null,
    Object? accountNumber = null,
    Object? qrObjectPath = freezed,
    Object? instructions = freezed,
    Object? amount = null,
    Object? currency = null,
    Object? planCode = null,
    Object? isActive = null,
    Object? sortOrder = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      accountName: null == accountName
          ? _value.accountName
          : accountName // ignore: cast_nullable_to_non_nullable
              as String,
      accountNumber: null == accountNumber
          ? _value.accountNumber
          : accountNumber // ignore: cast_nullable_to_non_nullable
              as String,
      qrObjectPath: freezed == qrObjectPath
          ? _value.qrObjectPath
          : qrObjectPath // ignore: cast_nullable_to_non_nullable
              as String?,
      instructions: freezed == instructions
          ? _value.instructions
          : instructions // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as num,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      planCode: null == planCode
          ? _value.planCode
          : planCode // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      sortOrder: null == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PaymentMethodImplCopyWith<$Res>
    implements $PaymentMethodCopyWith<$Res> {
  factory _$$PaymentMethodImplCopyWith(
          _$PaymentMethodImpl value, $Res Function(_$PaymentMethodImpl) then) =
      __$$PaymentMethodImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String type,
      @JsonKey(name: 'display_name') String displayName,
      @JsonKey(name: 'account_name') String accountName,
      @JsonKey(name: 'account_number') String accountNumber,
      @JsonKey(name: 'qr_object_path') String? qrObjectPath,
      String? instructions,
      num amount,
      String currency,
      @JsonKey(name: 'plan_code') String planCode,
      @JsonKey(name: 'is_active') bool isActive,
      @JsonKey(name: 'sort_order') int sortOrder});
}

/// @nodoc
class __$$PaymentMethodImplCopyWithImpl<$Res>
    extends _$PaymentMethodCopyWithImpl<$Res, _$PaymentMethodImpl>
    implements _$$PaymentMethodImplCopyWith<$Res> {
  __$$PaymentMethodImplCopyWithImpl(
      _$PaymentMethodImpl _value, $Res Function(_$PaymentMethodImpl) _then)
      : super(_value, _then);

  /// Create a copy of PaymentMethod
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? displayName = null,
    Object? accountName = null,
    Object? accountNumber = null,
    Object? qrObjectPath = freezed,
    Object? instructions = freezed,
    Object? amount = null,
    Object? currency = null,
    Object? planCode = null,
    Object? isActive = null,
    Object? sortOrder = null,
  }) {
    return _then(_$PaymentMethodImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      accountName: null == accountName
          ? _value.accountName
          : accountName // ignore: cast_nullable_to_non_nullable
              as String,
      accountNumber: null == accountNumber
          ? _value.accountNumber
          : accountNumber // ignore: cast_nullable_to_non_nullable
              as String,
      qrObjectPath: freezed == qrObjectPath
          ? _value.qrObjectPath
          : qrObjectPath // ignore: cast_nullable_to_non_nullable
              as String?,
      instructions: freezed == instructions
          ? _value.instructions
          : instructions // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as num,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      planCode: null == planCode
          ? _value.planCode
          : planCode // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      sortOrder: null == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PaymentMethodImpl implements _PaymentMethod {
  const _$PaymentMethodImpl(
      {required this.id,
      required this.type,
      @JsonKey(name: 'display_name') required this.displayName,
      @JsonKey(name: 'account_name') required this.accountName,
      @JsonKey(name: 'account_number') required this.accountNumber,
      @JsonKey(name: 'qr_object_path') this.qrObjectPath,
      this.instructions,
      required this.amount,
      this.currency = 'MMK',
      @JsonKey(name: 'plan_code') this.planCode = '12_month',
      @JsonKey(name: 'is_active') this.isActive = true,
      @JsonKey(name: 'sort_order') this.sortOrder = 0});

  factory _$PaymentMethodImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaymentMethodImplFromJson(json);

  @override
  final int id;
  @override
  final String type;
  @override
  @JsonKey(name: 'display_name')
  final String displayName;
  @override
  @JsonKey(name: 'account_name')
  final String accountName;
  @override
  @JsonKey(name: 'account_number')
  final String accountNumber;
// Raw filename from the DB; the repository rewrites this to a full public
// URL (contents/payments/qr/<file>) before it reaches the UI.
  @override
  @JsonKey(name: 'qr_object_path')
  final String? qrObjectPath;
  @override
  final String? instructions;
  @override
  final num amount;
  @override
  @JsonKey()
  final String currency;
  @override
  @JsonKey(name: 'plan_code')
  final String planCode;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;
  @override
  @JsonKey(name: 'sort_order')
  final int sortOrder;

  @override
  String toString() {
    return 'PaymentMethod(id: $id, type: $type, displayName: $displayName, accountName: $accountName, accountNumber: $accountNumber, qrObjectPath: $qrObjectPath, instructions: $instructions, amount: $amount, currency: $currency, planCode: $planCode, isActive: $isActive, sortOrder: $sortOrder)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentMethodImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.accountName, accountName) ||
                other.accountName == accountName) &&
            (identical(other.accountNumber, accountNumber) ||
                other.accountNumber == accountNumber) &&
            (identical(other.qrObjectPath, qrObjectPath) ||
                other.qrObjectPath == qrObjectPath) &&
            (identical(other.instructions, instructions) ||
                other.instructions == instructions) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.planCode, planCode) ||
                other.planCode == planCode) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      type,
      displayName,
      accountName,
      accountNumber,
      qrObjectPath,
      instructions,
      amount,
      currency,
      planCode,
      isActive,
      sortOrder);

  /// Create a copy of PaymentMethod
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentMethodImplCopyWith<_$PaymentMethodImpl> get copyWith =>
      __$$PaymentMethodImplCopyWithImpl<_$PaymentMethodImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaymentMethodImplToJson(
      this,
    );
  }
}

abstract class _PaymentMethod implements PaymentMethod {
  const factory _PaymentMethod(
      {required final int id,
      required final String type,
      @JsonKey(name: 'display_name') required final String displayName,
      @JsonKey(name: 'account_name') required final String accountName,
      @JsonKey(name: 'account_number') required final String accountNumber,
      @JsonKey(name: 'qr_object_path') final String? qrObjectPath,
      final String? instructions,
      required final num amount,
      final String currency,
      @JsonKey(name: 'plan_code') final String planCode,
      @JsonKey(name: 'is_active') final bool isActive,
      @JsonKey(name: 'sort_order') final int sortOrder}) = _$PaymentMethodImpl;

  factory _PaymentMethod.fromJson(Map<String, dynamic> json) =
      _$PaymentMethodImpl.fromJson;

  @override
  int get id;
  @override
  String get type;
  @override
  @JsonKey(name: 'display_name')
  String get displayName;
  @override
  @JsonKey(name: 'account_name')
  String get accountName;
  @override
  @JsonKey(name: 'account_number')
  String
      get accountNumber; // Raw filename from the DB; the repository rewrites this to a full public
// URL (contents/payments/qr/<file>) before it reaches the UI.
  @override
  @JsonKey(name: 'qr_object_path')
  String? get qrObjectPath;
  @override
  String? get instructions;
  @override
  num get amount;
  @override
  String get currency;
  @override
  @JsonKey(name: 'plan_code')
  String get planCode;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;
  @override
  @JsonKey(name: 'sort_order')
  int get sortOrder;

  /// Create a copy of PaymentMethod
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentMethodImplCopyWith<_$PaymentMethodImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
