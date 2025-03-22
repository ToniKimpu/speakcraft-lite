import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:pmp_english/config/pmp_colors.dart';
import 'package:pmp_english/config/pmp_routes.dart';
import 'package:pmp_english/config/pmp_text_styles.dart';
import 'package:pmp_english/global_app_state.dart';
import 'package:pmp_english/shared_widgets/default_profile.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config/common_extensions.dart';
import '../../shared_widgets/main_scaffold.dart';

class NewVersionScreen extends StatefulWidget {
  const NewVersionScreen({
    super.key,
    required this.appVersion,
  });
  final Map<String, dynamic> appVersion;

  @override
  State<NewVersionScreen> createState() => _NewVersionScreenState();
}

class _NewVersionScreenState extends State<NewVersionScreen> {
  final _player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    if (widget.appVersion['audio_path'] != null) {
      _player.setUrl(widget.appVersion['audio_path']);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appUser = GlobalAppState().currentUser;
    return MainScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            const Spacer(),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              constraints: const BoxConstraints(
                maxHeight: 220,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(9999),
                    child: Image.asset(
                      'assets/images/app_logo.png',
                      width: 60,
                      height: 60,
                    ),
                  ),
                  if (appUser.profilePath == null) const DefaultProfile(),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    'Version : ${widget.appVersion['version_name']}',
                    style:
                        PmpTextStyles.body2Semi.copyWith(color: Colors.black),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    'App version အသစ်ထွက်ပါပြီခင်ဗျာ...',
                    style: PmpTextStyles.body2Semi.copyWith(
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: 40,
                child: Material(
                  borderRadius: BorderRadius.circular(12),
                  color: PmpColors.primary400,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () async {
                      String url = widget.appVersion['app_web_path'];
                      if (await canLaunchUrl(Uri.parse(url))) {
                        launchUrl(
                          Uri.parse(url),
                          mode: LaunchMode.inAppBrowserView,
                        );
                      } else {
                        showErrorSnackbar("Failed to open browser!");
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            'Download Now',
                            style: PmpTextStyles.body1Semi
                                .copyWith(color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Icon(
                          Icons.chevron_right,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'App version အသစ်တင်လို့အဆင်မပြေပါက Messengerကနေတစ်ဆင့် လာရောက်မေးမြန်းနိုင်ပါတယ်ခင်ဗျ။',
                style: PmpTextStyles.label2Regular.copyWith(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(),
            if (!widget.appVersion['force_update'])
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, PmpRoutes.home);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Skip',
                        style: PmpTextStyles.body1Semi
                            .copyWith(color: PmpColors.white),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Icon(
                        Icons.chevron_right,
                        color: PmpColors.white,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
