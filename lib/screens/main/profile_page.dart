import 'package:flutter/material.dart';
import 'package:pmp_english/config/common_extensions.dart';
import 'package:pmp_english/config/pmp_routes.dart';
import 'package:pmp_english/global_app_state.dart';
import 'package:pmp_english/screens/main/widgets/app_version_widget.dart';
import 'package:pmp_english/screens/main/widgets/profile_item_row.dart';
import 'package:pmp_english/shared_widgets/main_scaffold.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config/env.dart';
import '../../config/pmp_colors.dart';
import '../../config/pmp_text_styles.dart';
import '../../l10n/generated/l10n.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appUser = GlobalAppState().currentUser;
    return MainScaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(
              appUser.profilePath != null && appUser.profilePath!.isNotEmpty
                  ? 'assets/images/profiles/${appUser.profilePath}'
                  : "assets/images/app_logo.png",
              width: 100,
              height: 100,
            ),
          ),
          Text(
            appUser.name,
            style: PmpTextStyles.body2Semi.copyWith(
              color: PmpColors.neutral100,
            ),
          ),
          const AppVersionWidget(),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color:
                  Colors.white.withOpacity(0.08), // Dark card with transparency
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                  color: Colors.white.withOpacity(0.4)), // Subtle border
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 8,
                  spreadRadius: 2,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ProfileItemRow(
                  label: AppLocalizations.of(context).txtChangeName,
                  icon: "assets/images/ic_profile_white.png",
                  onTap: () async {
                    if (!context.mounted) return;
                    final result = await Navigator.pushNamed(
                        context, PmpRoutes.updateUserName) as bool?;
                    if (result != null && result == true) {
                      setState(() {});
                    }
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                ProfileItemRow(
                  label: AppLocalizations.of(context).txtChangeAvatar,
                  icon: "assets/images/ic_change_avator.png",
                  onTap: () async {
                    final result = await Navigator.pushNamed(
                        context, PmpRoutes.updateAvatarPage) as bool?;
                    if (result != null && result == true) {
                      setState(() {});
                    }
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                ProfileItemRow(
                  label: AppLocalizations.of(context).txtAccountID,
                  icon: "assets/images/ic_account_id.png",
                  accountId: GlobalAppState().currentUser.accountId,
                  onTap: () {
                    appUser.accountId.copyToClipboard();
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                ProfileItemRow(
                  label: AppLocalizations.of(context).txtPrivacyPolicy,
                  icon: "assets/images/ic_privacy_policy.png",
                  onTap: () async {
                    if (await canLaunchUrl(Uri.parse(Env.privacyPolicyUrl))) {
                      launchUrl(
                        Uri.parse(Env.privacyPolicyUrl),
                        mode: LaunchMode.inAppBrowserView,
                      );
                    } else {
                      showErrorSnackbar("Failed to open browser!");
                    }
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                // ProfileItemRow(
                //   label: AppLocalizations.of(context).txtContentRequest,
                //   icon: "assets/images/ic_content_request.png",
                //   onTap: () {},
                // ),
                // const SizedBox(
                //   height: 8,
                // ),
                ProfileItemRow(
                  label: AppLocalizations.of(context).txtFeedback,
                  icon: "assets/images/ic_feedback.png",
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
