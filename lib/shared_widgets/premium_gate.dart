import 'package:flutter/material.dart';

import '../config/pmp_colors.dart';
import '../config/pmp_routes.dart';
import '../config/pmp_text_styles.dart';
import '../core/di/service_locator.dart';
import '../model/app_user/app_user.dart';
import '../services/analytics_service.dart';

/// True when the signed-in user currently has premium access. Derived
/// server-side from `users.premium_until` and surfaced as
/// [AppUser.isPremiumUser] on the cached current user.
bool hasPremiumAccess() =>
    sl<ValueNotifier<AppUser>>().value.isPremiumUser == true;

/// A gated item is unlocked when its content is marked free OR the user is
/// premium. Per-video gating: `isUnlocked(isFree: listening.isFree)`.
bool isUnlocked({required bool isFree}) => isFree || hasPremiumAccess();

/// A small "PREMIUM" lock chip to mark a gated entry point.
class PremiumLockBadge extends StatelessWidget {
  const PremiumLockBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [PmpColors.premiumGold, PmpColors.premiumGoldDeep],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.lock_rounded, size: 12, color: PmpColors.white),
          const SizedBox(width: 4),
          Text('PREMIUM',
              style: PmpTextStyles.sub.copyWith(
                color: PmpColors.white,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              )),
        ],
      ),
    );
  }
}

/// A tiny corner tag for a content thumbnail: "FREE" (green) or "PREMIUM"
/// (warm gold). Minimal text on a small pill.
class FreePremiumBadge extends StatelessWidget {
  const FreePremiumBadge({super.key, required this.isFree});
  final bool isFree;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        color: isFree ? PmpColors.success500 : null,
        gradient: isFree
            ? null
            : const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [PmpColors.premiumGold, PmpColors.premiumGoldDeep],
              ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        isFree ? 'FREE' : 'PREMIUM',
        style: TextStyle(
          color: isFree ? Colors.white : PmpColors.onPremium,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.3,
          fontSize: 8.5,
          height: 1.0,
        ),
      ),
    );
  }
}

/// Bottom sheet shown when a free user taps a premium-gated feature. Explains
/// the value and offers an upgrade. The actual purchase flow (manual grant /
/// IAP) is wired separately; [onGetPremium] runs when the user taps the CTA.
Future<void> showPremiumSheet(
  BuildContext context, {
  String? featureName,
  VoidCallback? onGetPremium,
}) {
  AnalyticsService.instance.premiumSheetShown(featureName ?? 'unknown');
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) {
      final cs = Theme.of(context).colorScheme;
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: cs.tertiaryContainer,
                    ),
                    alignment: Alignment.center,
                    child: Icon(Icons.workspace_premium_rounded,
                        color: cs.onTertiaryContainer),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      featureName == null
                          ? 'Premium feature'
                          : '$featureName is Premium',
                      style: PmpTextStyles.title1SemiBold
                          .copyWith(color: cs.onSurface),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'Unlock it — and every level across every module:',
                style: PmpTextStyles.body2Regular
                    .copyWith(color: cs.onSurfaceVariant, height: 1.4),
              ),
              const SizedBox(height: 14),
              ...const [
                'Speak Your Mind — Levels 2 & 3, plus more daily AI feedback',
                'Vocabulary — Intermediate & Upper word sets',
                'Grammar — every level beyond the basics',
                'Listening — shadowing, speech practice & explanations',
              ].map(
                (b) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.check_circle,
                          size: 18, color: PmpColors.premiumGold),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(b,
                            style: PmpTextStyles.body2Regular.copyWith(
                                color: cs.onSurface, height: 1.4)),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () {
                    AnalyticsService.instance
                        .premiumUpgradeTapped('premium_sheet');
                    Navigator.of(context).pop();
                    // Default: route to the manual payment flow. Callers may
                    // still override with [onGetPremium] (e.g. for IAP later).
                    if (onGetPremium != null) {
                      onGetPremium();
                    } else {
                      Navigator.of(context)
                          .pushNamed(PmpRoutes.premiumPaymentPage);
                    }
                  },
                  icon: const Icon(Icons.workspace_premium_rounded),
                  label: const Text('Get Premium'),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Maybe later'),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
