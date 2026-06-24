import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../config/pmp_colors.dart';
import '../config/pmp_routes.dart';
import '../config/pmp_text_styles.dart';
import '../core/di/service_locator.dart';
import '../model/app_user/app_user.dart';
import '../repositories/payment/payment_repository.dart';
import 'glass.dart';

bool _isPremium(AppUser u) => u.isPremiumUser == true;

/// Profile card showing premium status. Premium → badge + expiry + tap to the
/// status screen; free → an upgrade CTA. Reactive to the cached user.
class PremiumStatusCard extends StatelessWidget {
  const PremiumStatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppUser>(
      valueListenable: sl<ValueNotifier<AppUser>>(),
      builder: (context, appUser, _) {
        return _isPremium(appUser)
            ? const _PremiumCard()
            : const _FreeCard();
      },
    );
  }
}

class _PremiumCard extends StatelessWidget {
  const _PremiumCard();

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      highlight: true,
      onTap: () =>
          Navigator.pushNamed(context, PmpRoutes.paymentStatusPage),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [PmpColors.premiumGold, PmpColors.premiumGoldDeep],
              ),
            ),
            child: const Icon(Icons.workspace_premium_rounded,
                color: PmpColors.onPremium, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Premium', style: PmpTextStyles.body1Semi),
                const SizedBox(height: 2),
                FutureBuilder<DateTime?>(
                  future: sl<PaymentRepository>().fetchPremiumUntil(),
                  builder: (context, snap) {
                    final until = snap.data;
                    return Text(
                      until == null
                          ? 'Active'
                          : 'Active until ${DateFormat.yMMMMd().format(until)}',
                      style: PmpTextStyles.label2Regular.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right,
              color: Theme.of(context).colorScheme.onSurfaceVariant),
        ],
      ),
    );
  }
}

class _FreeCard extends StatelessWidget {
  const _FreeCard();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.workspace_premium_outlined,
                  color: PmpColors.premiumGoldDeep, size: 22),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Free plan', style: PmpTextStyles.body1Semi),
                    const SizedBox(height: 2),
                    Text(
                      'Unlock shadowing, speech practice & sentence explanations.',
                      style: PmpTextStyles.label2Regular
                          .copyWith(color: cs.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () =>
                  Navigator.pushNamed(context, PmpRoutes.premiumPaymentPage),
              icon: const Icon(Icons.workspace_premium_rounded, size: 18),
              label: const Text('Upgrade to Premium'),
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(46),
                backgroundColor: PmpColors.premiumGold,
                foregroundColor: PmpColors.onPremium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Home-screen banner nudging free users to upgrade. Renders nothing once the
/// user is premium.
class HomeUpgradeBanner extends StatelessWidget {
  const HomeUpgradeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppUser>(
      valueListenable: sl<ValueNotifier<AppUser>>(),
      builder: (context, appUser, _) {
        if (_isPremium(appUser)) return const SizedBox.shrink();
        return Padding(
          padding: const EdgeInsets.only(bottom: 22),
          child: InkWell(
            onTap: () =>
                Navigator.pushNamed(context, PmpRoutes.premiumPaymentPage),
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [PmpColors.premiumGold, PmpColors.premiumGoldDeep],
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.workspace_premium_rounded,
                      color: PmpColors.onPremium, size: 28),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Get Premium',
                            style: PmpTextStyles.body1Semi
                                .copyWith(color: PmpColors.onPremium)),
                        const SizedBox(height: 2),
                        Text(
                          'Unlock every feature on every video.',
                          style: PmpTextStyles.label2Regular.copyWith(
                            color: PmpColors.onPremium.withValues(alpha: 0.85),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right, color: PmpColors.onPremium),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
