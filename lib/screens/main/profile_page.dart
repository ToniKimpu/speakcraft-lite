import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmp_english/bloc/user_activity/user_activity_bloc.dart';
import 'package:pmp_english/config/pmp_colors.dart';
import 'package:pmp_english/config/pmp_routes.dart';
import 'package:pmp_english/config/pmp_text_styles.dart';
import 'package:pmp_english/core/di/service_locator.dart';
import 'package:pmp_english/model/app_user/app_user.dart';
import 'package:pmp_english/screens/main/widgets/app_version_widget.dart';
import 'package:pmp_english/screens/main/widgets/profile_item_row.dart';
import 'package:pmp_english/shared_widgets/main_scaffold.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config/env.dart';
import '../../l10n/generated/l10n.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static const _cardDecoration = BoxDecoration(
    color: Color(0x14FFFFFF), // white 8% opacity
    borderRadius: BorderRadius.all(Radius.circular(12)),
    border: Border.fromBorderSide(
      BorderSide(color: Color(0x66FFFFFF)), // white 40% opacity
    ),
    boxShadow: [
      BoxShadow(
        color: Color(0x4D000000),
        blurRadius: 8,
        spreadRadius: 2,
        offset: Offset(0, 4),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
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

// ---------------------------------------------------------------------------
// Hero card: avatar + name + email + version + stats
// ---------------------------------------------------------------------------

class _HeroCard extends StatelessWidget {
  const _HeroCard({required this.appUser});

  final AppUser appUser;

  @override
  Widget build(BuildContext context) {
    debugPrint("_appUserInfo: ${appUser.profilePath} profile Path");
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: ProfilePage._cardDecoration,
      child: Column(
        children: [
          // Avatar with primary-color ring
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: PmpColors.primary400, width: 2.5),
            ),
            child: CircleAvatar(
              radius: 44,
              backgroundImage: AssetImage(
                appUser.profilePath != null && appUser.profilePath!.isNotEmpty
                    ? 'assets/images/profiles/${appUser.profilePath}'
                    : 'logo/app_logo.png',
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Name
          Text(
            appUser.name?.isNotEmpty == true ? appUser.name! : appUser.email,
            style: PmpTextStyles.title1SemiBold.copyWith(
              color: PmpColors.neutral100,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 2),
          // Email (only show if name is available)
          if (appUser.name?.isNotEmpty == true)
            Text(
              appUser.email,
              style: PmpTextStyles.body2Regular.copyWith(
                color: Colors.white54,
              ),
              textAlign: TextAlign.center,
            ),
          const SizedBox(height: 4),
          const AppVersionWidget(),
          const SizedBox(height: 20),
          const Divider(color: Colors.white12, height: 1),
          const SizedBox(height: 16),
          // Learning stats
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
              const VerticalDivider(
                color: Colors.white12,
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: PmpTextStyles.inter.copyWith(
            fontSize: 28,
            color: PmpColors.primary400,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: PmpTextStyles.labelSemi.copyWith(color: Colors.white54),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Settings card: action rows
// ---------------------------------------------------------------------------

class _SettingsCard extends StatelessWidget {
  const _SettingsCard({required this.appUser});

  final AppUser appUser;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      width: double.infinity,
      decoration: ProfilePage._cardDecoration,
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
          const Divider(color: Colors.white12, height: 1, indent: 16, endIndent: 16),
          ProfileItemRow(
            label: l10n.txtChangeAvatar,
            icon: 'assets/images/ic_change_avator.png',
            onTap: () async {
              await Navigator.pushNamed(context, PmpRoutes.updateAvatarPage);
            },
          ),
          const Divider(color: Colors.white12, height: 1, indent: 16, endIndent: 16),
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
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              }
            },
          ),
          const Divider(color: Colors.white12, height: 1, indent: 16, endIndent: 16),
          ProfileItemRow(
            last: true,
            label: l10n.txtFeedback,
            icon: 'assets/images/ic_feedback.png',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Coming soon....'),
                backgroundColor: Colors.green,
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
