import 'package:flutter/material.dart';

import '../../config/pmp_colors.dart';
import '../../config/pmp_routes.dart';
import '../../config/pmp_text_styles.dart';
import '../../core/di/service_locator.dart';
import '../../services/reminder_service.dart';
import '../../services/share_preference_utils.dart';
import '../../shared_widgets/glass.dart';

/// First-launch onboarding (shown once, before login). Captures level + daily
/// goal + reminder opt-in, teases premium, then routes to the login screen.
/// Selections persist via [SharedPreferenceUtils]; the premium CTA sets a
/// `pending_upgrade` flag the home screen consumes after first login.
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  // Pref keys (shared with splash gate + home upgrade deep-link).
  static const kDone = 'onboarding_done';
  static const kLevel = 'onboarding_level';
  static const kGoal = 'onboarding_goal_min';
  static const kReminders = 'onboarding_reminders';
  static const kPendingUpgrade = 'pending_upgrade';

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _controller = PageController();
  int _index = 0;
  String _level = 'beginner';
  int _goal = 10;
  bool _reminders = true;

  static const _pages = 5;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _next() {
    if (_index < _pages - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> _finish({required bool upgrade}) async {
    await SharedPreferenceUtils.saveBool(OnboardingPage.kDone, true);
    await SharedPreferenceUtils.saveString(OnboardingPage.kLevel, _level);
    await SharedPreferenceUtils.saveInt(OnboardingPage.kGoal, _goal);
    await SharedPreferenceUtils.saveBool(OnboardingPage.kReminders, _reminders);
    if (_reminders) {
      // Schedules the daily reminder at the default time (8 PM) and requests
      // notification permission. Users change/disable it later in Profile.
      await sl<ReminderService>().enable(
        const TimeOfDay(
          hour: ReminderService.defaultHour,
          minute: ReminderService.defaultMinute,
        ),
      );
    } else {
      await sl<ReminderService>().disable();
    }
    if (upgrade) {
      await SharedPreferenceUtils.saveBool(
          OnboardingPage.kPendingUpgrade, true);
    }
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, PmpRoutes.loginScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
            child: Column(
              children: [
                // Top bar — Skip (hidden on the last page).
                SizedBox(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: _index < _pages - 1
                        ? TextButton(
                            onPressed: () => _finish(upgrade: false),
                            child: const Text('Skip'),
                          )
                        : null,
                  ),
                ),
                Expanded(
                  child: PageView(
                    controller: _controller,
                    onPageChanged: (i) => setState(() => _index = i),
                    children: [
                      const _WelcomePage(),
                      const _HowItWorksPage(),
                      _LevelPage(
                        value: _level,
                        onChanged: (v) => setState(() => _level = v),
                      ),
                      _HabitPage(
                        goal: _goal,
                        reminders: _reminders,
                        onGoal: (g) => setState(() => _goal = g),
                        onReminders: (v) => setState(() => _reminders = v),
                      ),
                      const _PremiumPage(),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                _Dots(count: _pages, index: _index),
                const SizedBox(height: 16),
                _bottomCta(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _bottomCta() {
    if (_index < _pages - 1) {
      return _GoldlessCta(label: 'Continue · ရှေ့ဆက်မယ်', onTap: _next);
    }
    return Column(
      children: [
        _PremiumCta(onTap: () => _finish(upgrade: true)),
        const SizedBox(height: 10),
        TextButton(
          onPressed: () => _finish(upgrade: false),
          child: Text(
            'Start free · အခမဲ့ စတင်မယ်',
            style: PmpTextStyles.body2Semi.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }
}

// ---------- Pages ----------

class _WelcomePage extends StatelessWidget {
  const _WelcomePage();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Image.asset('logo/app_logo.png', width: 96, height: 96),
        ),
        const SizedBox(height: 24),
        Text('Speak English\nwith confidence',
            textAlign: TextAlign.center,
            style: PmpTextStyles.h1
                .copyWith(color: cs.onSurface, fontWeight: FontWeight.w800)),
        const SizedBox(height: 10),
        Text('ယုံကြည်မှုရှိရှိ အင်္ဂလိပ်လို ပြောဆိုပါ',
            textAlign: TextAlign.center,
            style: PmpTextStyles.title2SemiBold
                .copyWith(color: PmpColors.brandCyanBright)),
        const SizedBox(height: 18),
        Text(
          'Listen, shadow, and write your way to fluent, natural English.',
          textAlign: TextAlign.center,
          style:
              PmpTextStyles.body2Regular.copyWith(color: cs.onSurfaceVariant),
        ),
      ],
    );
  }
}

class _HowItWorksPage extends StatelessWidget {
  const _HowItWorksPage();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _PageTitle(en: 'How it works', mm: 'ဘယ်လို အလုပ်လုပ်လဲ'),
        SizedBox(height: 24),
        _StepCard(
          icon: Icons.headphones_rounded,
          color: PmpColors.brandCyanBright,
          title: '1. Listen & Shadow',
          mm: 'နားထောင်ပြီး လိုက်ပြောပါ',
        ),
        SizedBox(height: 12),
        _StepCard(
          icon: Icons.mic_rounded,
          color: PmpColors.brandOrangeBright,
          title: '2. Speak & record',
          mm: 'ကိုယ့်အသံ ဖမ်းပြီး ပြန်နှိုင်းယှဉ်ပါ',
        ),
        SizedBox(height: 12),
        _StepCard(
          icon: Icons.edit_rounded,
          color: PmpColors.premiumGold,
          title: '3. Write & practice',
          mm: 'သဒ္ဒါ လေ့ကျင့်ခန်းတွေနဲ့ ချက်ချင်း စစ်ဆေးပါ',
        ),
      ],
    );
  }
}

class _LevelPage extends StatelessWidget {
  const _LevelPage({required this.value, required this.onChanged});
  final String value;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const _PageTitle(en: "What's your level?", mm: 'သင့်အဆင့်က ဘယ်လောက်လဲ'),
        const SizedBox(height: 24),
        _OptionTile(
          title: 'Beginner',
          mm: 'အခြေခံ — အခုမှ စတင်သူ',
          selected: value == 'beginner',
          onTap: () => onChanged('beginner'),
        ),
        const SizedBox(height: 12),
        _OptionTile(
          title: 'Intermediate',
          mm: 'အလယ်အလတ် — အခြေခံ ရှိပြီးသား',
          selected: value == 'intermediate',
          onTap: () => onChanged('intermediate'),
        ),
        const SizedBox(height: 12),
        _OptionTile(
          title: 'Advanced',
          mm: 'အဆင့်မြင့် — ပိုကောင်းအောင်',
          selected: value == 'advanced',
          onTap: () => onChanged('advanced'),
        ),
      ],
    );
  }
}

class _HabitPage extends StatelessWidget {
  const _HabitPage({
    required this.goal,
    required this.reminders,
    required this.onGoal,
    required this.onReminders,
  });
  final int goal;
  final bool reminders;
  final ValueChanged<int> onGoal;
  final ValueChanged<bool> onReminders;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const _PageTitle(en: 'Build the habit', mm: 'နေ့စဉ် အလေ့အထ တည်ဆောက်ပါ'),
        const SizedBox(height: 24),
        Text('Daily goal · နေ့စဉ် ပန်းတိုင်',
            style: PmpTextStyles.body1Semi.copyWith(color: cs.onSurface)),
        const SizedBox(height: 10),
        Row(
          children: [
            for (final m in const [5, 10, 20]) ...[
              Expanded(
                child: _GoalChip(
                  minutes: m,
                  selected: goal == m,
                  onTap: () => onGoal(m),
                ),
              ),
              if (m != 20) const SizedBox(width: 10),
            ],
          ],
        ),
        const SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            color: cs.surfaceContainerHighest.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: cs.outlineVariant),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  color: PmpColors.brandCyanBright.withValues(alpha: 0.16),
                ),
                child: const Icon(Icons.notifications_active_rounded,
                    color: PmpColors.brandCyanBright, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Daily reminder',
                        style: PmpTextStyles.body2Semi
                            .copyWith(color: cs.onSurface)),
                    Text('အချိန်မှန် သတိပေးချက်',
                        style: PmpTextStyles.label2Regular
                            .copyWith(color: cs.onSurfaceVariant)),
                  ],
                ),
              ),
              Switch(value: reminders, onChanged: onReminders),
            ],
          ),
        ),
      ],
    );
  }
}

class _PremiumPage extends StatelessWidget {
  const _PremiumPage();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const _PageTitle(
            en: 'Unlock everything', mm: 'Premium နဲ့ အားလုံး ဖွင့်လှစ်ပါ'),
        const SizedBox(height: 20),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
                color: PmpColors.premiumGold.withValues(alpha: 0.35)),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                PmpColors.premiumGold.withValues(alpha: 0.16),
                PmpColors.premiumGoldDeep.withValues(alpha: 0.05),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Premium — 1 year',
                  style: PmpTextStyles.body1Semi
                      .copyWith(color: PmpColors.premiumGold)),
              const SizedBox(height: 10),
              const _Feature('Shadowing & speech practice'),
              const _Feature('Sentence explanations on every video'),
              const _Feature('အကုန် ဖွင့်ထား — ကန့်သတ်မရှိ'),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Text('Start free anytime — upgrade whenever you\'re ready.',
            style: PmpTextStyles.label2Regular
                .copyWith(color: cs.onSurfaceVariant)),
      ],
    );
  }
}

// ---------- Shared bits ----------

class _PageTitle extends StatelessWidget {
  const _PageTitle({required this.en, required this.mm});
  final String en;
  final String mm;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(en,
            style: PmpTextStyles.h1
                .copyWith(color: cs.onSurface, fontWeight: FontWeight.w800)),
        const SizedBox(height: 4),
        Text(mm,
            style: PmpTextStyles.body2Regular
                .copyWith(color: cs.onSurfaceVariant)),
      ],
    );
  }
}

class _StepCard extends StatelessWidget {
  const _StepCard({
    required this.icon,
    required this.color,
    required this.title,
    required this.mm,
  });
  final IconData icon;
  final Color color;
  final String title;
  final String mm;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: cs.outlineVariant),
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: color.withValues(alpha: 0.16),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style:
                        PmpTextStyles.body1Semi.copyWith(color: cs.onSurface)),
                const SizedBox(height: 2),
                Text(mm,
                    style: PmpTextStyles.label2Regular
                        .copyWith(color: cs.onSurfaceVariant)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.title,
    required this.mm,
    required this.selected,
    required this.onTap,
  });
  final String title;
  final String mm;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              color: selected ? PmpColors.brandCyanBright : cs.outlineVariant,
              width: selected ? 1.5 : 1),
          color: selected
              ? PmpColors.brandCyanBright.withValues(alpha: 0.10)
              : cs.surfaceContainerHighest.withValues(alpha: 0.20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: PmpTextStyles.body1Semi
                          .copyWith(color: cs.onSurface)),
                  const SizedBox(height: 2),
                  Text(mm,
                      style: PmpTextStyles.label2Regular
                          .copyWith(color: cs.onSurfaceVariant)),
                ],
              ),
            ),
            Icon(
              selected ? Icons.check_circle_rounded : Icons.circle_outlined,
              color: selected ? PmpColors.brandCyanBright : cs.outline,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}

class _GoalChip extends StatelessWidget {
  const _GoalChip({
    required this.minutes,
    required this.selected,
    required this.onTap,
  });
  final int minutes;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
              color: selected ? PmpColors.brandCyanBright : cs.outlineVariant,
              width: selected ? 1.5 : 1),
          color: selected
              ? PmpColors.brandCyanBright.withValues(alpha: 0.10)
              : cs.surfaceContainerHighest.withValues(alpha: 0.20),
        ),
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Column(
          children: [
            Text('$minutes',
                style: PmpTextStyles.h2.copyWith(
                    color: cs.onSurface, fontWeight: FontWeight.w800)),
            Text('မိနစ်',
                style: PmpTextStyles.sub.copyWith(color: cs.onSurfaceVariant)),
          ],
        ),
      ),
    );
  }
}

class _Feature extends StatelessWidget {
  const _Feature(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(top: 9),
      child: Row(
        children: [
          Container(
            width: 18,
            height: 18,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: PmpColors.premiumGold),
            child: const Icon(Icons.check_rounded,
                size: 12, color: PmpColors.onPremium),
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Text(text,
                style:
                    PmpTextStyles.body2Regular.copyWith(color: cs.onSurface)),
          ),
        ],
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  const _Dots({required this.count, required this.index});
  final int count;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < count; i++)
          AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            margin: const EdgeInsets.symmetric(horizontal: 3.5),
            width: i == index ? 22 : 7,
            height: 7,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: i == index
                  ? PmpColors.brandCyanBright
                  : Theme.of(context)
                      .colorScheme
                      .outline
                      .withValues(alpha: 0.5),
            ),
          ),
      ],
    );
  }
}

class _GoldlessCta extends StatelessWidget {
  const _GoldlessCta({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: FilledButton(
        onPressed: onTap,
        style: FilledButton.styleFrom(
          backgroundColor: PmpColors.brandCyanBright,
          foregroundColor: const Color(0xFF04222E),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: Text(label,
            style: PmpTextStyles.body1Semi
                .copyWith(color: const Color(0xFF04222E))),
      ),
    );
  }
}

class _PremiumCta extends StatelessWidget {
  const _PremiumCta({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: FilledButton.icon(
        onPressed: onTap,
        icon: const Icon(Icons.workspace_premium_rounded, size: 18),
        label: const Text('Get Premium · Premium ယူမယ်'),
        style: FilledButton.styleFrom(
          backgroundColor: PmpColors.premiumGold,
          foregroundColor: PmpColors.onPremium,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
    );
  }
}
