import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config/pmp_colors.dart';

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
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool forceUpdate = widget.appVersion['force_update'] ?? false;
    final String versionName = widget.appVersion['version_name'] ?? "";
    final String downloadUrl = widget.appVersion['app_path'] ?? "";
    final String telegramUrl = widget.appVersion['telegram_path'] ?? "";
    final String releaseNotes =
        (widget.appVersion['release_notes'] ?? "").toString().trim();
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
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
                  color: colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: colorScheme.outlineVariant),
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.shadow.withValues(alpha: 0.12),
                      blurRadius: 12,
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
                    Text(
                      'New Version Available!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                        fontFamily: "ArchivoBlack Regular",
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Version: $versionName',
                      style: TextStyle(
                        fontSize: 16,
                        color: colorScheme.onSurfaceVariant,
                        fontFamily: "ArchivoBlack Regular",
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (releaseNotes.isNotEmpty)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: colorScheme.surface,
                          borderRadius: BorderRadius.circular(12),
                          border:
                              Border.all(color: colorScheme.outlineVariant),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.auto_awesome,
                                    size: 16, color: colorScheme.primary),
                                const SizedBox(width: 6),
                                Text(
                                  "What's new",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: colorScheme.onSurface,
                                    fontFamily: "ArchivoBlack Regular",
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              releaseNotes,
                              style: TextStyle(
                                color: colorScheme.onSurfaceVariant,
                                fontSize: 14,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      Text(
                        'အပ်ဒိတ်အသစ်ရလာပါပြီခင်ဗျာ။\nမကြာမီ အပ်ဒိတ်လုပ်ပေးပါ။',
                        style: TextStyle(
                          color: colorScheme.onSurfaceVariant,
                          fontSize: 15,
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    const SizedBox(height: 20),
                    if (downloadUrl.isNotEmpty)
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton.icon(
                          onPressed: () => _launchUrl(
                            downloadUrl,
                            LaunchMode.inAppBrowserView,
                            "Failed to open browser!",
                          ),
                          icon: const Icon(Icons.download_rounded),
                          label: const Text('Download Now'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: PmpColors.success500,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: "ArchivoBlack Regular",
                            ),
                          ),
                        ),
                      ),
                    if (telegramUrl.isNotEmpty) const SizedBox(height: 12),
                    if (telegramUrl.isNotEmpty)
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: OutlinedButton.icon(
                          onPressed: () => _launchUrl(
                            telegramUrl,
                            LaunchMode.externalApplication,
                            "Failed to open Telegram!",
                          ),
                          icon: const Icon(
                            Icons.telegram,
                            color: Color(0xFF229ED9),
                          ),
                          label: const Text('Download via Telegram'),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFF229ED9)),
                            foregroundColor: colorScheme.onSurface,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontFamily: "ArchivoBlack Regular",
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'အပ်ဒိတ်မှာပြဿနာရှိပါက Messenger မှတစ်ဆင့် ဆက်သွယ်နိုင်ပါတယ်။',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: colorScheme.onSurfaceVariant,
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
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Skip',
                        style: TextStyle(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.w500,
                          fontFamily: "ArchivoBlack Regular",
                        ),
                      ),
                      const SizedBox(width: 6),
                      Icon(
                        Icons.chevron_right,
                        color: colorScheme.onSurface,
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

  Future<void> _launchUrl(
    String url,
    LaunchMode mode,
    String errorMessage,
  ) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      launchUrl(Uri.parse(url), mode: mode);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    }
  }
}
