// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_submission.freezed.dart';
part 'payment_submission.g.dart';

/// A user's payment proof and its review state. Mirrors the
/// `payment_submissions` table; the user can read/insert their own rows but
/// never change `status` (admin-only via RPC).
@freezed
class PaymentSubmission with _$PaymentSubmission {
  const PaymentSubmission._();

  const factory PaymentSubmission({
    required int id,
    @JsonKey(name: 'user_id') required int userId,
    @JsonKey(name: 'payment_method_id') int? paymentMethodId,
    @JsonKey(name: 'method_label') required String methodLabel,
    @JsonKey(name: 'plan_code') required String planCode,
    required num amount,
    @Default('MMK') String currency,
    @JsonKey(name: 'proof_path') required String proofPath,
    @Default('pending') String status, // pending | approved | rejected
    @JsonKey(name: 'reject_reason') String? rejectReason,
    @JsonKey(name: 'subscription_id') int? subscriptionId,
    @JsonKey(name: 'reviewed_at') DateTime? reviewedAt,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _PaymentSubmission;

  bool get isPending => status == 'pending';
  bool get isApproved => status == 'approved';
  bool get isRejected => status == 'rejected';

  factory PaymentSubmission.fromJson(Map<String, dynamic> json) =>
      _$PaymentSubmissionFromJson(json);
}
