import 'package:flutter/material.dart';

import '../config/pmp_routes.dart';
import '../config/pmp_text_styles.dart';
import '../services/analytics_service.dart';
import '../services/supabase_service.dart';

/// True when the current session is an anonymous ("guest") user. Guests explore
/// Free content but are blocked from AI features until they create an account.
bool isGuestUser() => supabase.auth.currentUser?.isAnonymous == true;

/// Guard for AI entry points. If the current user is a guest, shows the
/// "create an account" sheet and returns `true` (caller should abort the AI
/// action). For real accounts it returns `false`, letting the action proceed.
///
/// Usage at an AI trigger:
/// ```dart
/// if (await blockAiForGuest(context, featureName: 'AI feedback')) return;
/// ```
Future<bool> blockAiForGuest(BuildContext context, {String? featureName}) async {
  if (!isGuestUser()) return false;
  await showGuestAccountSheet(context, featureName: featureName);
  return true;
}

/// Bottom sheet nudging a guest to create an account so they can use AI
/// features. The CTA routes to sign-up.
Future<void> showGuestAccountSheet(
  BuildContext context, {
  String? featureName,
}) {
  AnalyticsService.instance.premiumSheetShown('guest_ai:${featureName ?? 'unknown'}');
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
                      color: cs.primaryContainer,
                    ),
                    alignment: Alignment.center,
                    child: Icon(Icons.auto_awesome, color: cs.onPrimaryContainer),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      featureName == null
                          ? 'Create an account to use AI'
                          : '$featureName needs an account',
                      style: PmpTextStyles.title1SemiBold
                          .copyWith(color: cs.onSurface),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'AI feedback is available once you create a free account. It '
                'also saves your progress so you never lose it.',
                style: PmpTextStyles.body2Regular
                    .copyWith(color: cs.onSurfaceVariant, height: 1.4),
              ),
              const SizedBox(height: 6),
              Text(
                'AI feature တွေကို အသုံးပြုဖို့ အကောင့်ဖွင့်ပါ — သင့်တိုးတက်မှုကိုပါ '
                'သိမ်းထားပေးပါမယ်။',
                style: PmpTextStyles.label2Regular.copyWith(
                    color: cs.onSurfaceVariant, height: 1.5),
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context)
                        .pushNamed(PmpRoutes.convertAccountScreen);
                  },
                  icon: const Icon(Icons.person_add_alt_1),
                  label: const Text('Create account'),
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
