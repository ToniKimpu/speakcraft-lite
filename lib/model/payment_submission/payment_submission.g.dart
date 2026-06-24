// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_submission.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PaymentSubmissionImpl _$$PaymentSubmissionImplFromJson(
        Map<String, dynamic> json) =>
    _$PaymentSubmissionImpl(
      id: (json['id'] as num).toInt(),
      userId: (json['user_id'] as num).toInt(),
      paymentMethodId: (json['payment_method_id'] as num?)?.toInt(),
      methodLabel: json['method_label'] as String,
      planCode: json['plan_code'] as String,
      amount: json['amount'] as num,
      currency: json['currency'] as String? ?? 'MMK',
      proofPath: json['proof_path'] as String,
      status: json['status'] as String? ?? 'pending',
      rejectReason: json['reject_reason'] as String?,
      subscriptionId: (json['subscription_id'] as num?)?.toInt(),
      reviewedAt: json['reviewed_at'] == null
          ? null
          : DateTime.parse(json['reviewed_at'] as String),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$PaymentSubmissionImplToJson(
        _$PaymentSubmissionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'payment_method_id': instance.paymentMethodId,
      'method_label': instance.methodLabel,
      'plan_code': instance.planCode,
      'amount': instance.amount,
      'currency': instance.currency,
      'proof_path': instance.proofPath,
      'status': instance.status,
      'reject_reason': instance.rejectReason,
      'subscription_id': instance.subscriptionId,
      'reviewed_at': instance.reviewedAt?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
    };
