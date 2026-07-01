import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speakcraft/bloc/auth/auth_bloc.dart';
import 'package:speakcraft/bloc/user_activity/user_activity_bloc.dart';
import 'package:speakcraft/config/pmp_colors.dart';
import 'package:speakcraft/config/pmp_routes.dart';
import 'package:speakcraft/config/pmp_text_styles.dart';
import 'package:speakcraft/core/di/service_locator.dart';
import 'package:speakcraft/model/app_user/app_user.dart';
import 'package:speakcraft/screens/main/widgets/app_version_widget.dart';
import 'package:speakcraft/screens/main/widgets/profile_item_row.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speakcraft/services/reminder_service.dart';
import 'package:speakcraft/services/supabase_service.dart';
import 'package:speakcraft/services/theme_controller.dart';
import 'package:speakcraft/shared_widgets/glass.dart';
import 'package:speakcraft/shared_widgets/premium_status.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config/env.dart';
import '../../l10n/generated/l10n.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static BoxDecoration _cardDecoration(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return BoxDecoration(
      color: dark
          ? Colors.white.withValues(alpha: 0.055)
          : Colors.white.withValues(alpha: 0.92),
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      border: Border.fromBorderSide(
        BorderSide(
          color: dark
              ? Colors.white.withValues(alpha: 0.10)
              : const Color(0xFF0D3147).withValues(alpha: 0.08),
        ),
      ),
      boxShadow: [
        BoxShadow(
          color: dark
              ? Colors.black.withValues(alpha: 0.30)
              : const Color(0xFF1E3A4C).withValues(alpha: 0.10),
          blurRadius: dark ? 22 : 18,
          offset: const Offset(0, 8),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      title: Text(AppLocalizations.of(context).txtProfile),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        child: ValueListenableBuilder<AppUser>(
          valueListenable: sl<ValueNotifier<AppUser>>(),
          builder: (context, appUser, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _HeroCard(appUser: appUser),
                const SizedBox(height: 16),
                const PremiumStatusCard(),
                const SizedBox(height: 16),
                const _AppearanceCard(),
                const SizedBox(height: 16),
                const _ReminderCard(),
                const SizedBox(height: 16),
                _SettingsCard(appUser: appUser),
                const SizedBox(height: 16),
                const _LogoutCard(),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({required this.appUser});

  final AppUser appUser;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isGuest = supabase.auth.currentUser?.isAnonymous == true;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: ProfilePage._cardDecoration(context),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: colorScheme.primary, width: 2.5),
            ),
            child: CircleAvatar(
              radius: 44,
              backgroundColor: colorScheme.surface,
              backgroundImage: AssetImage(
                appUser.profilePath != null && appUser.profilePath!.isNotEmpty
                    ? 'assets/images/profiles/${appUser.profilePath}'
                    : 'logo/app_logo.png',
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            isGuest
                ? 'Guest'
                : (appUser.name?.isNotEmpty == true
                    ? appUser.name!
                    : appUser.email),
            style: PmpTextStyles.title1SemiBold.copyWith(
              color: colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 2),
          if (!isGuest && appUser.name?.isNotEmpty == true)
            Text(
              appUser.email,
              style: PmpTextStyles.body2Regular.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          if (appUser.accountId?.isNotEmpty == true) ...[
            const SizedBox(height: 8),
            _AccountIdChip(accountId: appUser.accountId!),
          ],
          if (isGuest) ...[
            const SizedBox(height: 12),
            _GuestConvertNote(),
          ],
          const SizedBox(height: 4),
          const AppVersionWidget(),
          const SizedBox(height: 20),
          Divider(color: colorScheme.outlineVariant, height: 1),
          const SizedBox(height: 16),
          _StatsRow(),
        ],
      ),
    );
  }
}

class _AccountIdChip extends StatelessWidget {
  const _AccountIdChip({required this.accountId});

  final String accountId;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () async {
        await Clipboard.setData(ClipboardData(text: accountId));
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Account ID copied'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Account ID: $accountId',
              style: PmpTextStyles.label2Regular.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(width: 6),
            Icon(
              Icons.copy_rounded,
              size: 14,
              color: colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}

/// Shown on the profile only while signed in as a guest. Converting links an
/// email/Google identity to this same anonymous user, so progress + account_id
/// are preserved (see ConvertAccountScreen).
class _GuestConvertNote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cs.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cs.primary.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline_rounded, size: 18, color: cs.primary),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'You\'re exploring as a guest.',
                      style: PmpTextStyles.body2Semi
                          .copyWith(color: cs.onSurface),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Create an account to save your progress and unlock premium.',
                      style: PmpTextStyles.label2Regular
                          .copyWith(color: cs.onSurfaceVariant, height: 1.35),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () => Navigator.of(context)
                  .pushNamed(PmpRoutes.convertAccountScreen),
              icon: const Icon(Icons.person_add_alt_1, size: 18),
              label: const Text('Create account'),
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(44),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserActivityBloc, UserActivityState>(
      builder: (context, state) {
        final int days = state.maybeWhen(
          loaded: (data) => data.totalLearningDays,
          sessionRecorded: (data) => data.totalLearningDays,
          orElse: () => 0,
        );
        final int streak = state.maybeWhen(
          loaded: (data) => data.currentStreak,
          sessionRecorded: (data) => data.currentStreak,
          orElse: () => 0,
        );

        final daysLabel = days == 0 ? '—' : '$days';
        final streakLabel = streak == 0
            ? '—'
            : streak > 1
                ? '$streak 🔥'
                : '$streak';

        return IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                child: _StatCard(
                    value: daysLabel,
                    label: AppLocalizations.of(context).txtDaysLearned),
              ),
              VerticalDivider(
                color: Theme.of(context).colorScheme.outlineVariant,
                width: 1,
                thickness: 1,
              ),
              Expanded(
                child: _StatCard(
                    value: streakLabel,
                    label: AppLocalizations.of(context).txtDayStreak),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: PmpTextStyles.inter.copyWith(
              fontSize: 28,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: PmpTextStyles.labelSemi.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _AppearanceCard extends StatelessWidget {
  const _AppearanceCard();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final controller = sl<ThemeController>();

    return Container(
      width: double.infinity,
      decoration: ProfilePage._cardDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
            child: Text(
              AppLocalizations.of(context).txtAppearance,
              style: PmpTextStyles.body1Semi.copyWith(
                color: colorScheme.onSurface,
              ),
            ),
          ),
          ValueListenableBuilder<ThemeMode>(
            valueListenable: controller,
            builder: (context, mode, _) {
              return Column(
                children: [
                  _ThemeOptionTile(
                    icon: Icons.light_mode_outlined,
                    label: AppLocalizations.of(context).txtThemeLight,
                    selected: mode == ThemeMode.light,
                    onTap: () => controller.setMode(ThemeMode.light),
                  ),
                  Divider(
                    color: colorScheme.outlineVariant,
                    height: 1,
                    indent: 16,
                    endIndent: 16,
                  ),
                  _ThemeOptionTile(
                    icon: Icons.dark_mode_outlined,
                    label: AppLocalizations.of(context).txtThemeDark,
                    selected: mode == ThemeMode.dark,
                    onTap: () => controller.setMode(ThemeMode.dark),
                  ),
                  Divider(
                    color: colorScheme.outlineVariant,
                    height: 1,
                    indent: 16,
                    endIndent: 16,
                  ),
                  _ThemeOptionTile(
                    icon: Icons.brightness_auto_outlined,
                    label: AppLocalizations.of(context).txtThemeSystem,
                    selected: mode == ThemeMode.system,
                    onTap: () => controller.setMode(ThemeMode.system),
                    isLast: true,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ThemeOptionTile extends StatelessWidget {
  const _ThemeOptionTile({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
    this.isLast = false,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.vertical(
        bottom: isLast ? const Radius.circular(12) : Radius.zero,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(icon, size: 20, color: colorScheme.onSurface),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: PmpTextStyles.body2Semi.copyWith(
                  color: colorScheme.onSurface,
                ),
              ),
            ),
            if (selected)
              Icon(
                Icons.check_circle,
                size: 20,
                color: colorScheme.primary,
              )
            else
              Icon(
                Icons.circle_outlined,
                size: 20,
                color: colorScheme.outline,
              ),
          ],
        ),
      ),
    );
  }
}

class _ReminderCard extends StatefulWidget {
  const _ReminderCard();

  @override
  State<_ReminderCard> createState() => _ReminderCardState();
}

class _ReminderCardState extends State<_ReminderCard> {
  final ReminderService _service = sl<ReminderService>();
  late bool _enabled = _service.isEnabled;
  late TimeOfDay _time = _service.time;
  bool _busy = false;

  Future<void> _toggle(bool value) async {
    setState(() => _busy = true);
    bool granted = true;
    if (value) {
      granted = await _service.enable(_time);
    } else {
      await _service.disable();
    }
    if (!mounted) return;
    setState(() {
      _enabled = value;
      _busy = false;
    });
    if (value && !granted) _promptSettings();
  }

  Future<void> _pickTime() async {
    final picked =
        await showTimePicker(context: context, initialTime: _time);
    if (picked == null || !mounted) return;
    setState(() => _time = picked);
    if (_enabled) await _service.enable(_time);
  }

  void _promptSettings() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content:
            Text('Turn on notifications in settings to receive reminders.'),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(label: 'Settings', onPressed: openAppSettings),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      decoration: ProfilePage._cardDecoration(context),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 6),
            child: Row(
              children: [
                Icon(Icons.notifications_active_outlined,
                    size: 20, color: cs.onSurface),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Daily reminder',
                          style: PmpTextStyles.body2Semi
                              .copyWith(color: cs.onSurface)),
                      Text('နေ့စဉ် သတိပေးချက်',
                          style: PmpTextStyles.label2Regular
                              .copyWith(color: cs.onSurfaceVariant)),
                    ],
                  ),
                ),
                if (_busy)
                  const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                else
                  Switch(value: _enabled, onChanged: _toggle),
              ],
            ),
          ),
          if (_enabled) ...[
            Divider(
                color: cs.outlineVariant, height: 1, indent: 16, endIndent: 16),
            InkWell(
              onTap: _pickTime,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Row(
                  children: [
                    Icon(Icons.schedule_rounded,
                        size: 20, color: cs.onSurfaceVariant),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text('Reminder time',
                          style: PmpTextStyles.body2Semi
                              .copyWith(color: cs.onSurface)),
                    ),
                    Text(_time.format(context),
                        style: PmpTextStyles.body2Semi
                            .copyWith(color: cs.primary)),
                    const SizedBox(width: 4),
                    Icon(Icons.chevron_right, color: cs.onSurfaceVariant),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  const _SettingsCard({required this.appUser});

  final AppUser appUser;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      decoration: ProfilePage._cardDecoration(context),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ProfileItemRow(
            first: true,
            label: l10n.txtChangeName,
            icon: 'assets/images/ic_profile_white.png',
            onTap: () async {
              if (!context.mounted) return;
              await Navigator.pushNamed(context, PmpRoutes.updateUserName);
            },
          ),
          Divider(
              color: colorScheme.outlineVariant,
              height: 1,
              indent: 16,
              endIndent: 16),
          ProfileItemRow(
            label: l10n.txtChangeAvatar,
            icon: 'assets/images/ic_change_avator.png',
            onTap: () async {
              await Navigator.pushNamed(context, PmpRoutes.updateAvatarPage);
            },
          ),
          Divider(
              color: colorScheme.outlineVariant,
              height: 1,
              indent: 16,
              endIndent: 16),
          ProfileItemRow(
            label: l10n.txtPrivacyPolicy,
            icon: 'assets/images/ic_privacy_policy.png',
            onTap: () async {
              if (await canLaunchUrl(Uri.parse(Env.privacyPolicyUrl))) {
                launchUrl(
                  Uri.parse(Env.privacyPolicyUrl),
                  mode: LaunchMode.inAppBrowserView,
                );
              } else {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(l10n.txtFailedToOpenBrowser),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              }
            },
          ),
          Divider(
              color: colorScheme.outlineVariant,
              height: 1,
              indent: 16,
              endIndent: 16),
          ProfileItemRow(
            last: true,
            label: l10n.txtFeedback,
            icon: 'assets/images/ic_feedback.png',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(l10n.txtComingSoonDots),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _LogoutCard extends StatefulWidget {
  const _LogoutCard();

  @override
  State<_LogoutCard> createState() => _LogoutCardState();
}

class _LogoutCardState extends State<_LogoutCard> {
  bool _loggingOut = false;

  Future<void> _confirmAndLogout() async {
    final l10n = AppLocalizations.of(context);

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        final colorScheme = Theme.of(dialogContext).colorScheme;
        return Dialog(
          backgroundColor: colorScheme.surface,
          insetPadding: const EdgeInsets.symmetric(horizontal: 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: BorderSide(color: colorScheme.outlineVariant),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 12, 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Text(
                    l10n.txtLogoutConfirmTitle,
                    style: PmpTextStyles.body1Semi.copyWith(
                      color: colorScheme.onSurface,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Text(
                    l10n.txtLogoutConfirmMessage,
                    style: PmpTextStyles.body2Regular.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      height: 1.35,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(dialogContext, false),
                      style: TextButton.styleFrom(
                        foregroundColor: colorScheme.onSurfaceVariant,
                      ),
                      child: Text(l10n.txtCancel),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(dialogContext, true),
                      style: TextButton.styleFrom(
                        foregroundColor: PmpColors.destructive500,
                      ),
                      child: Text(l10n.txtLogout),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );

    if (confirmed != true || !mounted) return;
    setState(() => _loggingOut = true);
    context.read<AuthBloc>().add(const AuthEvent.logout());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        // Only react to logout we initiated from this screen.
        if (!_loggingOut) return;
        state.maybeWhen(
          unauthenticated: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              PmpRoutes.loginScreen,
              (route) => false,
            );
          },
          error: (_) => _onLogoutFailed(l10n),
          socketError: (_) => _onLogoutFailed(l10n),
          orElse: () {},
        );
      },
      child: Container(
        width: double.infinity,
        decoration: ProfilePage._cardDecoration(context),
        child: Material(
          color: Colors.transparent,
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          child: InkWell(
            onTap: _loggingOut ? null : _confirmAndLogout,
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                children: [
                  Container(
                    height: 36,
                    width: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: PmpColors.destructive500,
                    ),
                    child: Icon(
                      Icons.logout_rounded,
                      size: 20,
                      color: colorScheme.onInverseSurface,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      l10n.txtLogout,
                      style: PmpTextStyles.body2Semi.copyWith(
                        color: PmpColors.destructive500,
                      ),
                    ),
                  ),
                  if (_loggingOut)
                    const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: PmpColors.destructive500,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onLogoutFailed(AppLocalizations l10n) {
    if (!mounted) return;
    setState(() => _loggingOut = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.txtLogoutFailed),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
