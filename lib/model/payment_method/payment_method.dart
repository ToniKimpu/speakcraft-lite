// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_method.freezed.dart';
part 'payment_method.g.dart';

/// An admin-managed pay destination shown on the premium payment screen
/// (KPay now, bank later). `amount` is the price the user pays via this method;
/// `planCode` is which subscription plan an approval grants.
@freezed
class PaymentMethod with _$PaymentMethod {
  const factory PaymentMethod({
    required int id,
    required String type,
    @JsonKey(name: 'display_name') required String displayName,
    @JsonKey(name: 'account_name') required String accountName,
    @JsonKey(name: 'account_number') required String accountNumber,
    // Raw filename from the DB; the repository rewrites this to a full public
    // URL (contents/payments/qr/<file>) before it reaches the UI.
    @JsonKey(name: 'qr_object_path') String? qrObjectPath,
    String? instructions,
    required num amount,
    @Default('MMK') String currency,
    @JsonKey(name: 'plan_code') @Default('12_month') String planCode,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
    @JsonKey(name: 'sort_order') @Default(0) int sortOrder,
  }) = _PaymentMethod;

  factory PaymentMethod.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodFromJson(json);
}
