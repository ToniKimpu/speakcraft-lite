import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmp_english/bloc/user_activity/user_activity_bloc.dart';
import 'package:pmp_english/config/pmp_routes.dart';
import 'package:pmp_english/config/pmp_text_styles.dart';
import 'package:pmp_english/core/di/service_locator.dart';
import 'package:pmp_english/model/app_user/app_user.dart';
import 'package:pmp_english/screens/main/widgets/app_version_widget.dart';
import 'package:pmp_english/screens/main/widgets/profile_item_row.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config/env.dart';
import '../../l10n/generated/l10n.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static BoxDecoration _cardDecoration(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BoxDecoration(
      color: colorScheme.surfaceContainerHighest,
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      border: Border.fromBorderSide(
        BorderSide(color: colorScheme.outlineVariant),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
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
                _SettingsCard(appUser: appUser),
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
            appUser.name?.isNotEmpty == true ? appUser.name! : appUser.email,
            style: PmpTextStyles.title1SemiBold.copyWith(
              color: colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 2),
          if (appUser.name?.isNotEmpty == true)
            Text(
              appUser.email,
              style: PmpTextStyles.body2Regular.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
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
                child: _StatCard(value: daysLabel, label: 'Days Learned'),
              ),
              VerticalDivider(
                color: Theme.of(context).colorScheme.outlineVariant,
                width: 1,
                thickness: 1,
              ),
              Expanded(
                child: _StatCard(value: streakLabel, label: 'Day Streak'),
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: PmpTextStyles.inter.copyWith(
            fontSize: 28,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: PmpTextStyles.labelSemi.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
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
                    const SnackBar(
                      content: Text('Failed to open browser!'),
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
                const SnackBar(
                  content: Text('Coming soon....'),
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
