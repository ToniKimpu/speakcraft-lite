import 'dart:io';

import 'package:speakcraft/model/payment_method/payment_method.dart';
import 'package:speakcraft/model/payment_submission/payment_submission.dart';
import 'package:speakcraft/services/supabase_service.dart';

import 'payment_repository.dart';

class SupabasePaymentRepository implements PaymentRepository {
  static const _proofBucket = 'payment-proofs';

  @override
  Future<List<PaymentMethod>> loadActiveMethods() async {
    final res = await supabase
        .from('payment_methods')
        .select('*')
        .eq('is_active', true)
        .order('sort_order', ascending: true);

    return res.map((e) {
      final method = PaymentMethod.fromJson(e);
      final qr = method.qrObjectPath;
      // Resolve the QR filename to a full public URL, like listening thumbnails.
      return method.copyWith(
        qrObjectPath: (qr == null || qr.isEmpty)
            ? null
            : SupabaseService().getPublicUrl(
                bucketFolder: SupabaseBucketFolders.paymentQr,
                fileName: qr,
              ),
      );
    }).toList();
  }

  @override
  Future<String> uploadProof(File file) async {
    final uid = supabase.auth.currentUser!.id;
    final ext = file.path.split('.').last;
    // uid-first folder satisfies the per-user storage RLS policy.
    final path = '$uid/${DateTime.now().millisecondsSinceEpoch}.$ext';
    await supabase.storage.from(_proofBucket).upload(path, file);
    return path;
  }

  @override
  Future<PaymentSubmission> submitPayment({
    required int userId,
    required PaymentMethod method,
    required String proofPath,
  }) async {
    final res = await supabase
        .from('payment_submissions')
        .insert({
          'user_id': userId,
          'payment_method_id': method.id,
          'method_label': '${method.displayName} (${method.accountNumber})',
          'plan_code': method.planCode,
          'amount': method.amount,
          'currency': method.currency,
          'proof_path': proofPath,
          // status defaults to 'pending' (RLS forbids inserting any other value)
        })
        .select()
        .single();
    return PaymentSubmission.fromJson(res);
  }

  @override
  Stream<List<PaymentSubmission>> watchMySubmissions(int userId) {
    return supabase
        .from('payment_submissions')
        .stream(primaryKey: ['id'])
        .eq('user_id', userId)
        // Ascending (oldest → newest) so the status page's `submissions.last`
        // is the most recent one. `.order()` defaults to DESCENDING, which would
        // otherwise make `.last` the oldest submission.
        .order('created_at', ascending: true)
        .map((rows) => rows.map(PaymentSubmission.fromJson).toList());
  }

  @override
  Future<DateTime?> fetchPremiumUntil() async {
    final uid = supabase.auth.currentUser?.id;
    if (uid == null) return null;
    final res = await supabase
        .from('users')
        .select('premium_until')
        .eq('user_id', uid)
        .maybeSingle();
    final value = res?['premium_until'];
    return value == null ? null : DateTime.parse(value as String).toLocal();
  }
}
