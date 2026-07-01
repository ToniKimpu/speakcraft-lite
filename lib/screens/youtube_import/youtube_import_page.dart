import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:speakcraft/config/pmp_colors.dart';
import 'package:speakcraft/core/logger/app_logger.dart';
import 'package:speakcraft/config/pmp_routes.dart';
import 'package:speakcraft/config/pmp_text_styles.dart';
import 'package:speakcraft/repositories/youtube_import/youtube_import_repository.dart';
import 'package:speakcraft/screens/youtube_import/downloader_handoff.dart';
import 'package:speakcraft/shared_widgets/glass.dart';
import 'package:speakcraft/shared_widgets/guest_gate.dart';
import 'package:speakcraft/shared_widgets/premium_gate.dart';
import 'package:url_launcher/url_launcher.dart';

/// Turn a YouTube video into a Listening & Shadowing lesson.
///
/// Flow: paste a URL → fetch title/thumbnail/duration (yt-meta) → the two
/// actions unlock → the user grabs the audio (SnapTube/VidMate) and uploads it
/// → yt-transcribe builds the lesson → open it in the existing lesson hub.
class YoutubeImportPage extends StatefulWidget {
  const YoutubeImportPage({super.key});

  @override
  State<YoutubeImportPage> createState() => _YoutubeImportPageState();
}

class _YoutubeImportPageState extends State<YoutubeImportPage> {
  final _repo = YoutubeImportRepository();
  final _urlController = TextEditingController();

  YtMeta? _meta;
  bool _loadingMeta = false;
  bool _importing = false;
  String? _error;
  Timer? _debounce;

  // The user's import-minutes budget + usage. Loaded on open so we can show the
  // plan limit upfront and warn before an over-budget import. Null = not known.
  ImportQuota? _quota;

  /// Remaining import seconds, derived from the quota + premium status.
  int? get _remainingSec => _quota?.remainingSec(hasPremiumAccess());

  /// True once we know both the video length and the remaining budget AND the
  /// video is longer than what's left.
  bool get _overBudget =>
      _meta != null &&
      _remainingSec != null &&
      _meta!.durationSeconds > _remainingSec!;

  @override
  void initState() {
    super.initState();
    _loadQuota();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _urlController.dispose();
    super.dispose();
  }

  Future<void> _loadQuota() async {
    try {
      final q = await _repo.fetchQuota();
      if (mounted) setState(() => _quota = q);
    } catch (_) {/* no quota info; the server still gates at import time */}
  }

  /// Extracts an 11-char YouTube video id from a pasted URL (or a bare id).
  /// Mirrors the server's `extractVideoId` — handles watch, youtu.be, shorts,
  /// embed, live, and a bare id. Returns null if no valid id is present.
  String? _extractYoutubeId(String input) {
    final url = input.trim();
    if (url.isEmpty) return null;
    if (RegExp(r'^[A-Za-z0-9_-]{11}$').hasMatch(url)) return url;
    final patterns = <RegExp>[
      RegExp(r'[?&]v=([A-Za-z0-9_-]{11})'),
      RegExp(r'youtu\.be/([A-Za-z0-9_-]{11})'),
      RegExp(r'/shorts/([A-Za-z0-9_-]{11})'),
      RegExp(r'/embed/([A-Za-z0-9_-]{11})'),
      RegExp(r'/live/([A-Za-z0-9_-]{11})'),
    ];
    for (final p in patterns) {
      final m = p.firstMatch(url);
      if (m != null) return m.group(1);
    }
    return null;
  }

  /// Auto-fetch once a complete, valid YouTube link appears (e.g. on paste), so
  /// the user doesn't have to tap the arrow. Debounced to avoid firing mid-type;
  /// the arrow stays as a manual trigger. Skips if we already have this video or
  /// a fetch is already running.
  void _onUrlChanged(String value) {
    setState(() {}); // refresh the arrow's enabled state as the text changes
    final id = _extractYoutubeId(value);
    if (id == null || id == _meta?.youtubeId || _loadingMeta) return;
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (mounted) _fetchMeta();
    });
  }

  String _fmtDuration(int s) {
    if (s <= 0) return '';
    final h = s ~/ 3600, m = (s % 3600) ~/ 60, sec = s % 60;
    final ss = sec.toString().padLeft(2, '0');
    return h > 0 ? '$h:${m.toString().padLeft(2, '0')}:$ss' : '$m:$ss';
  }

  /// The arrow is enabled only when there's a valid YouTube id in the field
  /// that we haven't already loaded (and we're not mid-fetch).
  bool get _canFetch {
    if (_loadingMeta) return false;
    final id = _extractYoutubeId(_urlController.text);
    if (id == null) return false;
    return _meta == null || id != _meta!.youtubeId;
  }

  Future<void> _fetchMeta() async {
    final url = _urlController.text.trim();
    if (url.isEmpty) return;
    // Don't re-fetch a video we already have (arrow tap / submit on the same
    // link) — only a changed link triggers a new fetch.
    final id = _extractYoutubeId(url);
    if (id != null && _meta != null && id == _meta!.youtubeId && !_loadingMeta) {
      return;
    }
    FocusScope.of(context).unfocus();
    setState(() {
      _loadingMeta = true;
      _error = null;
      _meta = null;
    });
    try {
      final meta = await _repo.fetchMeta(url);
      if (!mounted) return;
      setState(() => _meta = meta);
      // Refresh remaining budget so the over-budget check is current.
      await _loadQuota();
    } on YoutubeImportException catch (e, st) {
      AppLogger.instance.error(
        'YT_META failed: code=${e.code} message=${e.message}',
        error: e,
        stackTrace: st,
      );
      if (!mounted) return;
      setState(() => _error = _metaErrorText(e.code));
    } catch (e, st) {
      AppLogger.instance.error('YT_META failed (unexpected): $e',
          error: e, stackTrace: st);
      if (!mounted) return;
      setState(() => _error = 'Could not reach the server. Please try again.');
    } finally {
      if (mounted) setState(() => _loadingMeta = false);
    }
  }

  String _metaErrorText(String code) {
    switch (code) {
      case 'invalid_url':
      case 'missing_url':
        return "That doesn't look like a valid YouTube link.";
      case 'video_not_found':
        return "We couldn't find that video. Check the link and try again.";
      case 'youtube_api_error':
      case 'youtube_unreachable':
        return 'The video service is unavailable right now. Please try again.';
      default:
        return 'Something went wrong. Please try again.';
    }
  }

  Future<void> _pickAndImport() async {
    final meta = _meta;
    if (meta == null) return;

    // Import runs Whisper + Gemini; guests must create an account first.
    if (await blockAiForGuest(context, featureName: 'YouTube import')) return;
    if (!mounted) return;

    final picked = await FilePicker.platform.pickFiles(
      type: FileType.audio,
      withData: true,
    );
    if (picked == null || picked.files.isEmpty) return;
    final file = picked.files.single;
    final bytes = file.bytes;
    if (bytes == null) {
      setState(() => _error = "Couldn't read that file. Try another.");
      return;
    }

    // Read the real audio length on-device: lets us warn if the file doesn't
    // match the video, and lets the server gate Whisper cost on the actual
    // audio (not just the URL's duration).
    final audioSec = await _readAudioDurationSec(file.path);
    if (!mounted) return;

    // Budget check against the ACTUAL audio: the paste-time check used the
    // YouTube length, but the uploaded file may be longer. Block before
    // uploading (the server would reject it anyway).
    if (audioSec > 0 && _remainingSec != null && audioSec > _remainingSec!) {
      setState(() => _error =
          'This audio is ${_fmtDuration(audioSec)}, longer than your remaining '
          '${_fmtDuration(_remainingSec!)} of import time.');
      return;
    }

    if (audioSec > 0 && meta.durationSeconds > 0) {
      final diff = (audioSec - meta.durationSeconds).abs();
      if (diff > 60 && diff > meta.durationSeconds * 0.15) {
        final proceed =
            await _confirmDurationMismatch(audioSec, meta.durationSeconds);
        if (proceed != true) return;
      }
    }

    setState(() {
      _importing = true;
      _error = null;
    });
    try {
      final imp = await _repo.transcribe(
        audioBytes: bytes,
        filename: file.name,
        meta: meta,
        audioDurationSec: audioSec,
      );
      if (!mounted) return;
      // Replace this screen with the lesson so Back returns to where they came
      // from, not the import form.
      Navigator.pushReplacementNamed(
        context,
        PmpRoutes.listeningHub,
        arguments: {'listening': imp.toListening()},
      );
    } on YoutubeImportException catch (e, st) {
      AppLogger.instance.error(
        'YT_IMPORT transcribe failed: code=${e.code} message=${e.message}',
        error: e,
        stackTrace: st,
      );
      if (!mounted) return;
      setState(() => _error = _importErrorText(e));
    } catch (e, st) {
      AppLogger.instance.error('YT_IMPORT transcribe failed (unexpected): $e',
          error: e, stackTrace: st);
      if (!mounted) return;
      setState(() => _error = _friendlyTranscribeError(e));
    } finally {
      if (mounted) setState(() => _importing = false);
    }
  }

  /// Friendly copy for non-typed transcribe failures (network/timeout). The raw
  /// error is logged separately.
  String _friendlyTranscribeError(Object e) {
    if (e is TimeoutException) {
      return 'This took too long. The audio may be long — please try again.';
    }
    final s = e.toString().toLowerCase();
    if (s.contains('socket') ||
        s.contains('connection') ||
        s.contains('network') ||
        s.contains('clientexception') ||
        s.contains('handshake')) {
      return 'Network problem. Check your connection and try again.';
    }
    return 'Import failed. Please try again.';
  }

  /// Reads the picked audio's duration in seconds (0 if unavailable, e.g. the
  /// picker gave us bytes but no file path). Best-effort — never throws.
  Future<int> _readAudioDurationSec(String? path) async {
    if (path == null || path.isEmpty) return 0;
    final player = AudioPlayer();
    try {
      final d = await player.setFilePath(path);
      return d == null ? 0 : (d.inMilliseconds / 1000).round();
    } catch (_) {
      return 0;
    } finally {
      await player.dispose();
    }
  }

  Future<bool?> _confirmDurationMismatch(int audioSec, int videoSec) {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Audio may not match the video'),
        content: Text(
          'The audio you picked is ${_fmtDuration(audioSec)} long, but the '
          'video is ${_fmtDuration(videoSec)}. If this is the wrong file, the '
          'subtitles won\'t line up with the video.\n\nImport it anyway?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Pick another'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Import anyway'),
          ),
        ],
      ),
    );
  }

  String _importErrorText(YoutubeImportException e) {
    if (e.isQuota) {
      final budgetMin = (e.budgetSec / 60).round();
      if (e.remainingSec <= 0) {
        return e.isPremium
            ? "You've used all $budgetMin minutes of import time."
            : "You've used all $budgetMin free minutes of import time. "
                'Upgrade to Premium for more.';
      }
      final remainMin = (e.remainingSec / 60).floor();
      final thisMin = (e.thisSec / 60).ceil();
      final left = remainMin >= 1 ? '$remainMin min' : '${e.remainingSec}s';
      return 'This video is about $thisMin min, but you only have $left of '
              'import time left.${e.isPremium ? '' : ' Upgrade to Premium for more.'}';
    }
    if (e.isTooLarge) {
      return 'That audio file is too large (max 25 MB). Try a shorter video or lower-quality audio.';
    }
    switch (e.code) {
      case 'empty_transcript':
        return "We couldn't hear any speech in that audio. Make sure it's the right file.";
      case 'transcription_failed':
        return 'Transcription failed. Please try again in a moment.';
      default:
        return 'Import failed. Please try again.';
    }
  }

  Future<void> _showGetAudioSheet() async {
    final meta = _meta;
    if (meta == null) return;

    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        final cs = Theme.of(ctx).colorScheme;
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Get the audio',
                  style: PmpTextStyles.body1Semi.copyWith(color: cs.onSurface)),
              const SizedBox(height: 10),
              Text(
                downloaderHandoffSupported
                    ? 'Send the link to a downloader, save the audio, then come '
                        'back and tap "Import audio".'
                    : 'Copy the link, download the audio with your downloader, '
                        'then come back and tap "Import audio".',
                style: PmpTextStyles.body2Regular
                    .copyWith(color: cs.onSurfaceVariant, height: 1.5),
              ),
              const SizedBox(height: 16),
              if (downloaderHandoffSupported)
                for (final d in kDownloaders) ...[
                  _DownloaderButton(
                    downloader: d,
                    onSend: () => _sendToDownloader(ctx, d, meta.sourceUrl),
                  ),
                  const SizedBox(height: 10),
                ],
              const SizedBox(height: 4),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.copy, size: 18),
                      label: const Text('Copy link'),
                      onPressed: () async {
                        await Clipboard.setData(
                            ClipboardData(text: meta.sourceUrl));
                        if (ctx.mounted) Navigator.pop(ctx);
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Link copied')),
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.open_in_new, size: 18),
                      label: const Text('Open video'),
                      onPressed: () => _openExternal(meta.sourceUrl),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _sendToDownloader(
      BuildContext sheetCtx, Downloader d, String url) async {
    // Detect-then-route: if the app is installed, hand the link off; if not,
    // send the user to install it instead of opening an empty share sheet.
    final installed = await isDownloaderInstalled(d);
    if (sheetCtx.mounted) Navigator.pop(sheetCtx);
    if (!mounted) return;

    if (!installed) {
      await _openExternal(d.siteUrl);
      return;
    }

    try {
      await shareLinkToDownloader(d, url);
    } catch (_) {
      // Installed but the direct launch hiccuped — let the OS share sheet
      // handle it (the app will be in the list).
      try {
        await shareLinkViaChooser(url);
      } catch (_) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Couldn't open ${d.name}.")),
        );
      }
    }
  }

  Future<void> _openExternal(String url) async {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GlassScaffold(
      title: const Text('Import from YouTube'),
      body: AbsorbPointer(
        absorbing: _importing,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
          children: [
            Text(
              'Turn any YouTube video into a listening & shadowing lesson.',
              style: PmpTextStyles.body2Regular
                  .copyWith(color: cs.onSurfaceVariant),
            ),
            if (_quota != null) ...[
              const SizedBox(height: 14),
              _QuotaInfo(
                quota: _quota!,
                isPremium: hasPremiumAccess(),
              ),
            ],
            const SizedBox(height: 16),
            TextField(
              controller: _urlController,
              keyboardType: TextInputType.url,
              textInputAction: TextInputAction.go,
              onChanged: _onUrlChanged,
              onSubmitted: (_) => _fetchMeta(),
              decoration: InputDecoration(
                hintText: 'Paste a YouTube link',
                prefixIcon: const Icon(Icons.link),
                suffixIcon: _loadingMeta
                    ? const Padding(
                        padding: EdgeInsets.all(12),
                        child: SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      )
                    : IconButton(
                        icon: const Icon(Icons.arrow_forward),
                        onPressed: _canFetch ? _fetchMeta : null,
                      ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
            if (_error != null) ...[
              const SizedBox(height: 14),
              _ErrorBanner(message: _error!),
            ],
            if (_meta != null) ...[
              const SizedBox(height: 18),
              _PreviewCard(meta: _meta!, durationText: _fmtDuration(_meta!.durationSeconds)),
              if (_overBudget) ...[
                const SizedBox(height: 12),
                _BudgetWarning(
                  videoSec: _meta!.durationSeconds,
                  remainingSec: _remainingSec!,
                  isPremium: hasPremiumAccess(),
                  fmt: _fmtDuration,
                  onUpgrade: () => Navigator.pushNamed(
                      context, PmpRoutes.premiumPaymentPage),
                ),
              ],
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.download_rounded, size: 18),
                      label: const Text('Get audio'),
                      onPressed: _importing ? null : _showGetAudioSheet,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton.icon(
                      icon: const Icon(Icons.upload_file, size: 18),
                      label: const Text('Import audio'),
                      // Disabled when the video is longer than the user's
                      // remaining minutes — no point uploading; it would fail.
                      onPressed:
                          (_importing || _overBudget) ? null : _pickAndImport,
                    ),
                  ),
                ],
              ),
            ],
            if (_importing) ...[
              const SizedBox(height: 24),
              Column(
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 14),
                  Text(
                    'Transcribing… this can take up to a minute.',
                    textAlign: TextAlign.center,
                    style: PmpTextStyles.body2Regular
                        .copyWith(color: cs.onSurfaceVariant),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _PreviewCard extends StatelessWidget {
  const _PreviewCard({required this.meta, required this.durationText});

  final YtMeta meta;
  final String durationText;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GlassCard(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                CachedNetworkImage(
                  imageUrl: meta.thumbnailUrl,
                  width: 120,
                  height: 72,
                  fit: BoxFit.cover,
                  errorWidget: (_, __, ___) => Container(
                    width: 120,
                    height: 72,
                    color: cs.surface,
                    child: Icon(Icons.broken_image,
                        color: cs.onSurfaceVariant, size: 20),
                  ),
                ),
                if (durationText.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.all(4),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.75),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(durationText,
                        style: PmpTextStyles.subBold
                            .copyWith(color: Colors.white)),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  meta.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: PmpTextStyles.body1Semi.copyWith(color: cs.onSurface),
                ),
                if (meta.channelTitle.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    meta.channelTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: PmpTextStyles.labelMedium
                        .copyWith(color: cs.onSurfaceVariant),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// One downloader row in the "Get the audio" sheet: a filled "Send to <app>"
/// action. If the app isn't installed the launch fails and the caller offers an
/// install link, so we don't need to pre-detect.
class _DownloaderButton extends StatelessWidget {
  const _DownloaderButton({required this.downloader, required this.onSend});

  final Downloader downloader;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        icon: const Icon(Icons.send_rounded, size: 18),
        label: Text('Send to ${downloader.name}'),
        onPressed: onSend,
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(46),
        ),
      ),
    );
  }
}

/// Always-visible line stating the user's plan limit + how much import time is
/// left, so they know the 10-min (free) / 300-min (premium) cap upfront.
class _QuotaInfo extends StatelessWidget {
  const _QuotaInfo({required this.quota, required this.isPremium});

  final ImportQuota quota;
  final bool isPremium;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final budgetMin = (quota.budgetSec(isPremium) / 60).round();
    final remainMin = (quota.remainingSec(isPremium) / 60).floor();
    final plan = isPremium ? 'Premium' : 'Free plan';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Row(
        children: [
          Icon(Icons.schedule_rounded, size: 18, color: cs.onSurfaceVariant),
          const SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: PmpTextStyles.body2Regular.copyWith(color: cs.onSurface),
                children: [
                  TextSpan(
                    text: '$plan — ',
                    style: PmpTextStyles.body2Semi.copyWith(color: cs.onSurface),
                  ),
                  TextSpan(text: '$remainMin of $budgetMin min left to import'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Shown under the preview when the video is longer than the user's remaining
/// import minutes — explains why "Import audio" is disabled. Orange, white text.
class _BudgetWarning extends StatelessWidget {
  const _BudgetWarning({
    required this.videoSec,
    required this.remainingSec,
    required this.isPremium,
    required this.fmt,
    required this.onUpgrade,
  });

  final int videoSec;
  final int remainingSec;
  final bool isPremium;
  final String Function(int) fmt;
  final VoidCallback onUpgrade;

  @override
  Widget build(BuildContext context) {
    final String title;
    final String body;
    if (remainingSec <= 0) {
      title = isPremium ? 'Import limit reached' : 'Free import limit reached';
      body = isPremium
          ? "You've used all your import minutes."
          : 'Upgrade to Premium for 5 hours of imports.';
    } else {
      title = 'Not enough time left';
      body = 'This video is ${fmt(videoSec)}, but you only have '
          '${fmt(remainingSec)} left to import${isPremium ? '.' : ' on the free plan.'}';
    }
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: PmpColors.brandOrange.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: PmpColors.brandOrange.withValues(alpha: 0.55)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.timelapse_rounded,
                  color: PmpColors.brandOrange, size: 22),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: PmpTextStyles.body1Semi
                          .copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      body,
                      style: PmpTextStyles.body2Regular.copyWith(
                        color: Colors.white.withValues(alpha: 0.85),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (!isPremium) ...[
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: onUpgrade,
                icon: const Icon(Icons.workspace_premium_rounded, size: 18),
                label: const Text('Upgrade to Premium'),
                style: FilledButton.styleFrom(
                  backgroundColor: PmpColors.brandOrange,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(46),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  const _ErrorBanner({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cs.error.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cs.error.withValues(alpha: 0.35)),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: cs.error, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: PmpTextStyles.body2Regular.copyWith(color: cs.onSurface),
            ),
          ),
        ],
      ),
    );
  }
}
