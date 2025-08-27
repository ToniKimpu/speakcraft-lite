import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:url_launcher/url_launcher.dart';

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
    final bool forceUpdate = widget.appVersion['force_update'] ?? false;
    final String versionName = widget.appVersion['version_name'] ?? "";
    final String downloadUrl = widget.appVersion['app_path'] ?? "";

    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF1B263B),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.25),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 36,
                      backgroundImage: AssetImage('logo/app_logo.png'),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'New Version Available!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: "ArchivoBlack Regular",
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Version: $versionName',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[300],
                        fontFamily: "ArchivoBlack Regular",
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'အပ်ဒိတ်အသစ်ရလာပါပြီခင်ဗျာ။\nမကြာမီ အပ်ဒိတ်လုပ်ပေးပါ။',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 15,
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          if (await canLaunchUrl(Uri.parse(downloadUrl))) {
                            launchUrl(
                              Uri.parse(downloadUrl),
                              mode: LaunchMode.inAppBrowserView,
                            );
                          } else {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Failed to open browser!"),
                                ),
                              );
                            }
                          }
                        },
                        icon: const Icon(
                          Icons.download_rounded,
                          color: Colors.white,
                        ),
                        label: const Text('Download Now'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFF4CAF50), // A fresh green tone
                          foregroundColor: Colors.white, // Text and icon color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 14),
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: "ArchivoBlack Regular",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'အပ်ဒိတ်မှာပြဿနာရှိပါက Messenger မှတစ်ဆင့် ဆက်သွယ်နိုင်ပါတယ်။',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              if (!forceUpdate)
                TextButton(
                  onPressed: () => Navigator.pushReplacementNamed(
                    context,
                    '/home',
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Skip',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontFamily: "ArchivoBlack Regular",
                        ),
                      ),
                      SizedBox(width: 6),
                      Icon(
                        Icons.chevron_right,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
