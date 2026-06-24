import 'dart:io';

import 'package:speakcraft/model/payment_method/payment_method.dart';
import 'package:speakcraft/model/payment_submission/payment_submission.dart';

abstract class PaymentRepository {
  /// Active payment methods (RLS only exposes `is_active = true`), ordered.
  Future<List<PaymentMethod>> loadActiveMethods();

  /// Uploads a receipt screenshot to the private `payment-proofs` bucket and
  /// returns the stored object path (`{auth.uid()}/<file>`).
  Future<String> uploadProof(File file);

  /// Inserts a `pending` submission snapshotting the method's amount/plan.
  Future<PaymentSubmission> submitPayment({
    required int userId,
    required PaymentMethod method,
    required String proofPath,
  });

  /// Live stream of the signed-in user's submissions (latest last). Powers the
  /// status screen — flips automatically when the admin approves/rejects.
  Stream<List<PaymentSubmission>> watchMySubmissions(int userId);

  /// The user's current premium expiry (read straight from their row).
  Future<DateTime?> fetchPremiumUntil();
}
