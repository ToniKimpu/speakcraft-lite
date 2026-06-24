// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_submission.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PaymentSubmission _$PaymentSubmissionFromJson(Map<String, dynamic> json) {
  return _PaymentSubmission.fromJson(json);
}

/// @nodoc
mixin _$PaymentSubmission {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  int get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_method_id')
  int? get paymentMethodId => throw _privateConstructorUsedError;
  @JsonKey(name: 'method_label')
  String get methodLabel => throw _privateConstructorUsedError;
  @JsonKey(name: 'plan_code')
  String get planCode => throw _privateConstructorUsedError;
  num get amount => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  @JsonKey(name: 'proof_path')
  String get proofPath => throw _privateConstructorUsedError;
  String get status =>
      throw _privateConstructorUsedError; // pending | approved | rejected
  @JsonKey(name: 'reject_reason')
  String? get rejectReason => throw _privateConstructorUsedError;
  @JsonKey(name: 'subscription_id')
  int? get subscriptionId => throw _privateConstructorUsedError;
  @JsonKey(name: 'reviewed_at')
  DateTime? get reviewedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this PaymentSubmission to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaymentSubmission
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaymentSubmissionCopyWith<PaymentSubmission> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentSubmissionCopyWith<$Res> {
  factory $PaymentSubmissionCopyWith(
          PaymentSubmission value, $Res Function(PaymentSubmission) then) =
      _$PaymentSubmissionCopyWithImpl<$Res, PaymentSubmission>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'user_id') int userId,
      @JsonKey(name: 'payment_method_id') int? paymentMethodId,
      @JsonKey(name: 'method_label') String methodLabel,
      @JsonKey(name: 'plan_code') String planCode,
      num amount,
      String currency,
      @JsonKey(name: 'proof_path') String proofPath,
      String status,
      @JsonKey(name: 'reject_reason') String? rejectReason,
      @JsonKey(name: 'subscription_id') int? subscriptionId,
      @JsonKey(name: 'reviewed_at') DateTime? reviewedAt,
      @JsonKey(name: 'created_at') DateTime? createdAt});
}

/// @nodoc
class _$PaymentSubmissionCopyWithImpl<$Res, $Val extends PaymentSubmission>
    implements $PaymentSubmissionCopyWith<$Res> {
  _$PaymentSubmissionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaymentSubmission
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? paymentMethodId = freezed,
    Object? methodLabel = null,
    Object? planCode = null,
    Object? amount = null,
    Object? currency = null,
    Object? proofPath = null,
    Object? status = null,
    Object? rejectReason = freezed,
    Object? subscriptionId = freezed,
    Object? reviewedAt = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      paymentMethodId: freezed == paymentMethodId
          ? _value.paymentMethodId
          : paymentMethodId // ignore: cast_nullable_to_non_nullable
              as int?,
      methodLabel: null == methodLabel
          ? _value.methodLabel
          : methodLabel // ignore: cast_nullable_to_non_nullable
              as String,
      planCode: null == planCode
          ? _value.planCode
          : planCode // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as num,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      proofPath: null == proofPath
          ? _value.proofPath
          : proofPath // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      rejectReason: freezed == rejectReason
          ? _value.rejectReason
          : rejectReason // ignore: cast_nullable_to_non_nullable
              as String?,
      subscriptionId: freezed == subscriptionId
          ? _value.subscriptionId
          : subscriptionId // ignore: cast_nullable_to_non_nullable
              as int?,
      reviewedAt: freezed == reviewedAt
          ? _value.reviewedAt
          : reviewedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PaymentSubmissionImplCopyWith<$Res>
    implements $PaymentSubmissionCopyWith<$Res> {
  factory _$$PaymentSubmissionImplCopyWith(_$PaymentSubmissionImpl value,
          $Res Function(_$PaymentSubmissionImpl) then) =
      __$$PaymentSubmissionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'user_id') int userId,
      @JsonKey(name: 'payment_method_id') int? paymentMethodId,
      @JsonKey(name: 'method_label') String methodLabel,
      @JsonKey(name: 'plan_code') String planCode,
      num amount,
      String currency,
      @JsonKey(name: 'proof_path') String proofPath,
      String status,
      @JsonKey(name: 'reject_reason') String? rejectReason,
      @JsonKey(name: 'subscription_id') int? subscriptionId,
      @JsonKey(name: 'reviewed_at') DateTime? reviewedAt,
      @JsonKey(name: 'created_at') DateTime? createdAt});
}

/// @nodoc
class __$$PaymentSubmissionImplCopyWithImpl<$Res>
    extends _$PaymentSubmissionCopyWithImpl<$Res, _$PaymentSubmissionImpl>
    implements _$$PaymentSubmissionImplCopyWith<$Res> {
  __$$PaymentSubmissionImplCopyWithImpl(_$PaymentSubmissionImpl _value,
      $Res Function(_$PaymentSubmissionImpl) _then)
      : super(_value, _then);

  /// Create a copy of PaymentSubmission
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? paymentMethodId = freezed,
    Object? methodLabel = null,
    Object? planCode = null,
    Object? amount = null,
    Object? currency = null,
    Object? proofPath = null,
    Object? status = null,
    Object? rejectReason = freezed,
    Object? subscriptionId = freezed,
    Object? reviewedAt = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$PaymentSubmissionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      paymentMethodId: freezed == paymentMethodId
          ? _value.paymentMethodId
          : paymentMethodId // ignore: cast_nullable_to_non_nullable
              as int?,
      methodLabel: null == methodLabel
          ? _value.methodLabel
          : methodLabel // ignore: cast_nullable_to_non_nullable
              as String,
      planCode: null == planCode
          ? _value.planCode
          : planCode // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as num,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      proofPath: null == proofPath
          ? _value.proofPath
          : proofPath // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      rejectReason: freezed == rejectReason
          ? _value.rejectReason
          : rejectReason // ignore: cast_nullable_to_non_nullable
              as String?,
      subscriptionId: freezed == subscriptionId
          ? _value.subscriptionId
          : subscriptionId // ignore: cast_nullable_to_non_nullable
              as int?,
      reviewedAt: freezed == reviewedAt
          ? _value.reviewedAt
          : reviewedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PaymentSubmissionImpl extends _PaymentSubmission {
  const _$PaymentSubmissionImpl(
      {required this.id,
      @JsonKey(name: 'user_id') required this.userId,
      @JsonKey(name: 'payment_method_id') this.paymentMethodId,
      @JsonKey(name: 'method_label') required this.methodLabel,
      @JsonKey(name: 'plan_code') required this.planCode,
      required this.amount,
      this.currency = 'MMK',
      @JsonKey(name: 'proof_path') required this.proofPath,
      this.status = 'pending',
      @JsonKey(name: 'reject_reason') this.rejectReason,
      @JsonKey(name: 'subscription_id') this.subscriptionId,
      @JsonKey(name: 'reviewed_at') this.reviewedAt,
      @JsonKey(name: 'created_at') this.createdAt})
      : super._();

  factory _$PaymentSubmissionImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaymentSubmissionImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'user_id')
  final int userId;
  @override
  @JsonKey(name: 'payment_method_id')
  final int? paymentMethodId;
  @override
  @JsonKey(name: 'method_label')
  final String methodLabel;
  @override
  @JsonKey(name: 'plan_code')
  final String planCode;
  @override
  final num amount;
  @override
  @JsonKey()
  final String currency;
  @override
  @JsonKey(name: 'proof_path')
  final String proofPath;
  @override
  @JsonKey()
  final String status;
// pending | approved | rejected
  @override
  @JsonKey(name: 'reject_reason')
  final String? rejectReason;
  @override
  @JsonKey(name: 'subscription_id')
  final int? subscriptionId;
  @override
  @JsonKey(name: 'reviewed_at')
  final DateTime? reviewedAt;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @override
  String toString() {
    return 'PaymentSubmission(id: $id, userId: $userId, paymentMethodId: $paymentMethodId, methodLabel: $methodLabel, planCode: $planCode, amount: $amount, currency: $currency, proofPath: $proofPath, status: $status, rejectReason: $rejectReason, subscriptionId: $subscriptionId, reviewedAt: $reviewedAt, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentSubmissionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.paymentMethodId, paymentMethodId) ||
                other.paymentMethodId == paymentMethodId) &&
            (identical(other.methodLabel, methodLabel) ||
                other.methodLabel == methodLabel) &&
            (identical(other.planCode, planCode) ||
                other.planCode == planCode) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.proofPath, proofPath) ||
                other.proofPath == proofPath) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.rejectReason, rejectReason) ||
                other.rejectReason == rejectReason) &&
            (identical(other.subscriptionId, subscriptionId) ||
                other.subscriptionId == subscriptionId) &&
            (identical(other.reviewedAt, reviewedAt) ||
                other.reviewedAt == reviewedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      paymentMethodId,
      methodLabel,
      planCode,
      amount,
      currency,
      proofPath,
      status,
      rejectReason,
      subscriptionId,
      reviewedAt,
      createdAt);

  /// Create a copy of PaymentSubmission
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentSubmissionImplCopyWith<_$PaymentSubmissionImpl> get copyWith =>
      __$$PaymentSubmissionImplCopyWithImpl<_$PaymentSubmissionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaymentSubmissionImplToJson(
      this,
    );
  }
}

abstract class _PaymentSubmission extends PaymentSubmission {
  const factory _PaymentSubmission(
          {required final int id,
          @JsonKey(name: 'user_id') required final int userId,
          @JsonKey(name: 'payment_method_id') final int? paymentMethodId,
          @JsonKey(name: 'method_label') required final String methodLabel,
          @JsonKey(name: 'plan_code') required final String planCode,
          required final num amount,
          final String currency,
          @JsonKey(name: 'proof_path') required final String proofPath,
          final String status,
          @JsonKey(name: 'reject_reason') final String? rejectReason,
          @JsonKey(name: 'subscription_id') final int? subscriptionId,
          @JsonKey(name: 'reviewed_at') final DateTime? reviewedAt,
          @JsonKey(name: 'created_at') final DateTime? createdAt}) =
      _$PaymentSubmissionImpl;
  const _PaymentSubmission._() : super._();

  factory _PaymentSubmission.fromJson(Map<String, dynamic> json) =
      _$PaymentSubmissionImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'user_id')
  int get userId;
  @override
  @JsonKey(name: 'payment_method_id')
  int? get paymentMethodId;
  @override
  @JsonKey(name: 'method_label')
  String get methodLabel;
  @override
  @JsonKey(name: 'plan_code')
  String get planCode;
  @override
  num get amount;
  @override
  String get currency;
  @override
  @JsonKey(name: 'proof_path')
  String get proofPath;
  @override
  String get status; // pending | approved | rejected
  @override
  @JsonKey(name: 'reject_reason')
  String? get rejectReason;
  @override
  @JsonKey(name: 'subscription_id')
  int? get subscriptionId;
  @override
  @JsonKey(name: 'reviewed_at')
  DateTime? get reviewedAt;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;

  /// Create a copy of PaymentSubmission
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentSubmissionImplCopyWith<_$PaymentSubmissionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
