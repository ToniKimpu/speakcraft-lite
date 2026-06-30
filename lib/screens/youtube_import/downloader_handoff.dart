import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/foundation.dart';

/// A third-party audio downloader we can hand a YouTube link off to.
class Downloader {
  const Downloader({
    required this.name,
    required this.package,
    required this.siteUrl,
  });

  final String name;

  /// Android package id — used both to detect the app and to target the share
  /// intent. Must be listed in AndroidManifest `<queries>` for Android 11+
  /// package visibility, or detection/launch silently fails.
  final String package;

  /// Where to send the user if the app isn't installed.
  final String siteUrl;
}

// `com.snaptube.premium` is the package of the NORMAL SnapTube app — "premium"
// is just historical naming, the free version uses it too (VIP is an in-app
// unlock). Neither app is on the Play Store, so the install fallback is the
// official site.
const kSnapTube = Downloader(
  name: 'SnapTube',
  package: 'com.snaptube.premium',
  siteUrl: 'https://www.snaptube.com/',
);

const kVidMate = Downloader(
  name: 'VidMate',
  package: 'com.nemo.vidmate',
  siteUrl: 'https://www.vidmate-official.com/',
);

const kDownloaders = [kSnapTube, kVidMate];

/// The link hand-off is Android-only (these are Android apps). On iOS we fall
/// back to copy-link / open-in-browser.
bool get downloaderHandoffSupported =>
    defaultTargetPlatform == TargetPlatform.android;

/// Whether [d] is installed and can receive a shared link. Used to route: if
/// false we send the user to install it instead of opening a chooser.
///
/// Relies on the `<queries>` package entries in AndroidManifest, so it only
/// returns the right answer in a build that includes them — a fresh build/
/// reinstall, NOT a hot reload/restart. Never throws.
Future<bool> isDownloaderInstalled(Downloader d) async {
  if (!downloaderHandoffSupported) return false;
  try {
    final intent = AndroidIntent(
      action: 'android.intent.action.SEND',
      type: 'text/plain',
      package: d.package,
      arguments: <String, dynamic>{'android.intent.extra.TEXT': ''},
    );
    return await intent.canResolveActivity() ?? false;
  } catch (_) {
    return false;
  }
}

/// Share [url] into [d] so the user can download its audio. Throws if the app
/// isn't installed / can't be launched — the caller catches this and offers to
/// install instead. (We deliberately do NOT pre-check with canResolveActivity:
/// it's unreliable, and on Android 11+ it — like the launch itself — only works
/// once the app has been rebuilt with the `<queries>` package entries.)
Future<void> shareLinkToDownloader(Downloader d, String url) => AndroidIntent(
      // Canonical action string — the 'action_send' shorthand isn't mapped by
      // android_intent_plus, so it would launch a bogus action no app handles.
      action: 'android.intent.action.SEND',
      type: 'text/plain',
      package: d.package,
      arguments: <String, dynamic>{'android.intent.extra.TEXT': url},
    ).launch();

/// Open the system share sheet for [url] (no target package). Robust fallback:
/// the chooser is rendered by the OS and lists every app that handles a
/// text/plain link — SnapTube, VidMate, anything — regardless of our hardcoded
/// package ids or `<queries>` visibility.
Future<void> shareLinkViaChooser(String url) => AndroidIntent(
      action: 'android.intent.action.SEND',
      type: 'text/plain',
      arguments: <String, dynamic>{'android.intent.extra.TEXT': url},
    ).launchChooser('Send link to');
