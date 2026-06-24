// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_method.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PaymentMethodImpl _$$PaymentMethodImplFromJson(Map<String, dynamic> json) =>
    _$PaymentMethodImpl(
      id: (json['id'] as num).toInt(),
      type: json['type'] as String,
      displayName: json['display_name'] as String,
      accountName: json['account_name'] as String,
      accountNumber: json['account_number'] as String,
      qrObjectPath: json['qr_object_path'] as String?,
      instructions: json['instructions'] as String?,
      amount: json['amount'] as num,
      currency: json['currency'] as String? ?? 'MMK',
      planCode: json['plan_code'] as String? ?? '12_month',
      isActive: json['is_active'] as bool? ?? true,
      sortOrder: (json['sort_order'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$PaymentMethodImplToJson(_$PaymentMethodImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'display_name': instance.displayName,
      'account_name': instance.accountName,
      'account_number': instance.accountNumber,
      'qr_object_path': instance.qrObjectPath,
      'instructions': instance.instructions,
      'amount': instance.amount,
      'currency': instance.currency,
      'plan_code': instance.planCode,
      'is_active': instance.isActive,
      'sort_order': instance.sortOrder,
    };
