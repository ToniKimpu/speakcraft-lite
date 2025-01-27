import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:pmp_english/config/pmp_colors.dart';
import 'package:pmp_english/config/pmp_routes.dart';
import 'package:pmp_english/config/pmp_text_styles.dart';
import 'package:pmp_english/global_app_state.dart';
import 'package:pmp_english/shared_widgets/default_profile.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config/common_extensions.dart';

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
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
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
              child: Stack(
                children: [
                  Column(
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
                        style: PmpTextStyles.body2Semi
                            .copyWith(color: Colors.black),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        'App version အသစ်ထွက်ပါပြီခင်ဗျာ...',
                        style: PmpTextStyles.body2Semi
                            .copyWith(color: Colors.black),
                      ),
                      Text(
                        '(Version အသစ်ကို ဒေါင်းလုတ်ဖို့အတွက် အောက်က ကျွန်တော်တို့ရဲ့ telegram ကိုတစ်ချက်နှိပ်လိုက်ပါ။)',
                        style: PmpTextStyles.label2Regular
                            .copyWith(color: Colors.black),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                  if (widget.appVersion['audio_path'] != null)
                    Positioned(
                      top: 2,
                      right: 2,
                      child: Material(
                        borderRadius: BorderRadius.circular(12),
                        color: PmpColors.primary400,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            if (_player.playing) {
                              _player.pause();
                            } else {
                              _player.play();
                            }
                          },
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: StreamBuilder<PlayerState>(
                              stream: _player.playerStateStream,
                              builder: (context, snapshot) {
                                final playerState = snapshot.data;
                                final isPlaying = playerState?.playing ?? false;
                                return Icon(
                                  isPlaying ? Icons.pause : Icons.play_arrow,
                                  color: Colors.white,
                                  size: 16,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
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
                      String url = widget.appVersion['app_path'];
                      if (await canLaunchUrl(Uri.parse(url))) {
                        launchUrl(Uri.parse(url));
                      } else {
                        showErrorSnackbar("Failed to open telegram link");
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            'Open Telegram',
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
            const Spacer(),
            if (!widget.appVersion['force_update'])
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, PmpRoutes.home);
                  },
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Skip'),
                      SizedBox(
                        width: 8,
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: PmpColors.primary400,
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
