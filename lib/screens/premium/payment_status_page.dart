import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:speakcraft/bloc/auth/auth_bloc.dart';
import 'package:speakcraft/config/pmp_colors.dart';
import 'package:speakcraft/config/pmp_routes.dart';
import 'package:speakcraft/config/pmp_text_styles.dart';
import 'package:speakcraft/core/di/service_locator.dart';
import 'package:speakcraft/model/app_user/app_user.dart';
import 'package:speakcraft/model/payment_submission/payment_submission.dart';
import 'package:speakcraft/repositories/payment/payment_repository.dart';
import 'package:speakcraft/shared_widgets/glass.dart';

class PaymentStatusPage extends StatefulWidget {
  const PaymentStatusPage({super.key});

  @override
  State<PaymentStatusPage> createState() => _PaymentStatusPageState();
}

class _PaymentStatusPageState extends State<PaymentStatusPage> {
  final PaymentRepository _repository = sl<PaymentRepository>();
  late final int? _userId;
  int? _refreshedForId;

  @override
  void initState() {
    super.initState();
    _userId = sl<ValueNotifier<AppUser>>().value.id;
  }

  // When a submission flips to approved, refresh the cached user once so the
  // premium gates unlock app-wide without a restart.
  void _onApproved(int submissionId) {
    if (_refreshedForId == submissionId) return;
    _refreshedForId = submissionId;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      sl<AuthBloc>().add(const AuthEvent.refreshUser());
    });
  }

  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      title: const Text('Payment status'),
      body: _userId == null
          ? const Center(child: Text('Please sign in again.'))
          : StreamBuilder<List<PaymentSubmission>>(
              stream: _repository.watchMySubmissions(_userId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting &&
                    !snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final submissions = snapshot.data ?? [];
                if (submissions.isEmpty) {
                  return _NoSubmission(
                    onStart: () => Navigator.pushReplacementNamed(
                        context, PmpRoutes.premiumPaymentPage),
                  );
                }
                final latest = submissions.last;
                if (latest.isApproved) _onApproved(latest.id);
                return _StatusView(submission: latest, repository: _repository);
              },
            ),
    );
  }
}

class _StatusView extends StatelessWidget {
  const _StatusView({required this.submission, required this.repository});
  final PaymentSubmission submission;
  final PaymentRepository repository;

  String _money(num amount, String currency) =>
      '${NumberFormat.decimalPattern().format(amount)} $currency';

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 28),
      children: [
        if (submission.isPending)
          const _StatusHero(
            icon: Icons.hourglass_top_rounded,
            color: PmpColors.warning500,
            title: 'Payment under review',
            subtitle:
                'We\'re checking your screenshot. Premium unlocks automatically once it\'s confirmed — you can leave this screen.',
          )
        else if (submission.isApproved)
          const _StatusHero(
            icon: Icons.workspace_premium_rounded,
            color: PmpColors.premiumGold,
            title: 'You\'re Premium! 🎉',
            subtitle: 'Everything is unlocked. Enjoy your learning.',
          )
        else
          _StatusHero(
            icon: Icons.error_outline_rounded,
            color: cs.error,
            title: 'Payment not approved',
            subtitle: 'See the reason below and submit again.',
          ),
        const SizedBox(height: 20),
        GlassCard(
          child: Column(
            children: [
              _row(context, 'Amount',
                  _money(submission.amount, submission.currency)),
              const Divider(height: 18),
              _row(context, 'Method', submission.methodLabel),
              if (submission.createdAt != null) ...[
                const Divider(height: 18),
                _row(context, 'Submitted',
                    DateFormat.yMMMd().add_jm().format(submission.createdAt!)),
              ],
            ],
          ),
        ),
        if (submission.isRejected &&
            (submission.rejectReason?.trim().isNotEmpty ?? false)) ...[
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: cs.errorContainer.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text('Reason: ${submission.rejectReason!.trim()}',
                style:
                    PmpTextStyles.body2Regular.copyWith(color: cs.onSurface)),
          ),
        ],
        if (submission.isApproved) ...[
          const SizedBox(height: 14),
          FutureBuilder<DateTime?>(
            future: repository.fetchPremiumUntil(),
            builder: (context, snap) {
              if (snap.data == null) return const SizedBox.shrink();
              return Text(
                'Premium active until ${DateFormat.yMMMMd().format(snap.data!)}',
                textAlign: TextAlign.center,
                style: PmpTextStyles.body2Semi
                    .copyWith(color: PmpColors.premiumGoldDeep),
              );
            },
          ),
        ],
        const SizedBox(height: 24),
        if (submission.isApproved)
          FilledButton(
            onPressed: () => Navigator.popUntil(context, (r) => r.isFirst),
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(52),
              backgroundColor: PmpColors.premiumGold,
              foregroundColor: PmpColors.onPremium,
            ),
            child: const Text('Continue'),
          )
        else if (submission.isRejected)
          FilledButton(
            onPressed: () => Navigator.pushReplacementNamed(
                context, PmpRoutes.premiumPaymentPage),
            style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(52)),
            child: const Text('Submit again'),
          ),
      ],
    );
  }

  Widget _row(BuildContext context, String label, String value) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: PmpTextStyles.label2Regular
                .copyWith(color: cs.onSurfaceVariant)),
        const Spacer(),
        Flexible(
          child: Text(value,
              textAlign: TextAlign.right,
              style: PmpTextStyles.body2Semi.copyWith(color: cs.onSurface)),
        ),
      ],
    );
  }
}

class _StatusHero extends StatelessWidget {
  const _StatusHero({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
  });
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      children: [
        CircleAvatar(
          radius: 36,
          backgroundColor: color.withValues(alpha: 0.15),
          child: Icon(icon, color: color, size: 38),
        ),
        const SizedBox(height: 16),
        Text(title,
            textAlign: TextAlign.center, style: PmpTextStyles.title1SemiBold),
        const SizedBox(height: 8),
        Text(subtitle,
            textAlign: TextAlign.center,
            style: PmpTextStyles.body2Regular
                .copyWith(color: cs.onSurfaceVariant)),
      ],
    );
  }
}

class _NoSubmission extends StatelessWidget {
  const _NoSubmission({required this.onStart});
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.receipt_long_outlined, size: 48),
            const SizedBox(height: 12),
            Text('No payment yet',
                style: PmpTextStyles.title2SemiBold),
            const SizedBox(height: 6),
            Text('Once you submit a payment, its status shows here.',
                textAlign: TextAlign.center,
                style: PmpTextStyles.body2Regular),
            const SizedBox(height: 16),
            FilledButton(
                onPressed: onStart, child: const Text('Get Premium')),
          ],
        ),
      ),
    );
  }
}
