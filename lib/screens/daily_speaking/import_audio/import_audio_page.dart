import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:speakcraft/bloc/daily_speaking/daily_speaking_history_bloc.dart';
import 'package:speakcraft/config/pmp_text_styles.dart';
import 'package:speakcraft/config/pmp_routes.dart';
import 'package:speakcraft/l10n/generated/l10n.dart';
import 'package:speakcraft/model/daily_speaking/daily_speaking_session.dart';

import '../daily_speaking_entry_page.dart' show kDailySessionLimit;
import '../widgets/session_audio_player.dart';

/// On-ramp: bring your own recording. The learner picks an existing audio file
/// of themselves speaking English; we validate it (format / length / size) and
/// then run it through the *same* pipeline as a live recording — a free-talk
/// session where the AI infers the topic (`onRamp == just_talk`).
///
/// Sensible default limits, mirroring the live recorder's 5-minute cap.
const Duration _kMaxDuration = Duration(minutes: 5);
const Duration _kMinDuration = Duration(seconds: 5);
const int _kMaxBytes = 25 * 1024 * 1024; // 25 MB
const List<String> _kAllowedExt = ['m4a', 'mp3', 'wav', 'aac', 'ogg', 'flac'];

class ImportAudioPage extends StatefulWidget {
  const ImportAudioPage({super.key});

  @override
  State<ImportAudioPage> createState() => _ImportAudioPageState();
}

class _ImportAudioPageState extends State<ImportAudioPage> {
  String? _path;
  String? _name;
  Duration? _duration;
  int? _sizeBytes;
  String? _error;
  bool _busy = false;

  Future<void> _pickFile() async {
    final l10n = AppLocalizations.of(context);
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: _kAllowedExt,
      );
      if (result == null || result.files.isEmpty) {
        // Cancelled — keep any previous selection.
        return;
      }
      final file = result.files.single;
      final path = file.path;
      final ext = (file.extension ?? '').toLowerCase();
      if (path == null || !_kAllowedExt.contains(ext)) {
        _fail(l10n.txtDsImportUnsupported);
        return;
      }
      if (file.size > _kMaxBytes) {
        _fail(l10n.txtDsImportTooBig(_kMaxBytes ~/ (1024 * 1024)));
        return;
      }
      final duration = await _readDuration(path);
      if (duration == null) {
        _fail(l10n.txtDsImportUnreadable);
        return;
      }
      if (duration > _kMaxDuration) {
        _fail(l10n.txtDsImportTooLong(_kMaxDuration.inMinutes));
        return;
      }
      if (duration < _kMinDuration) {
        _fail(l10n.txtDsImportTooShort);
        return;
      }
      if (!mounted) return;
      setState(() {
        _path = path;
        _name = file.name;
        _duration = duration;
        _sizeBytes = file.size;
        _error = null;
      });
    } catch (_) {
      _fail(AppLocalizations.of(context).txtDsImportUnreadable);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  /// Reads the clip's length with a throwaway player. Returns null if the file
  /// can't be decoded (corrupt / not really audio).
  Future<Duration?> _readDuration(String path) async {
    final player = AudioPlayer();
    try {
      return await player.setFilePath(path);
    } catch (_) {
      return null;
    } finally {
      await player.dispose();
    }
  }

  void _fail(String message) {
    if (!mounted) return;
    setState(() {
      _path = null;
      _name = null;
      _duration = null;
      _sizeBytes = null;
      _error = message;
    });
  }

  void _submit() {
    final path = _path;
    if (path == null) return;
    Navigator.pushNamed(
      context,
      PmpRoutes.dailySpeakingChooseFeedback,
      arguments: {
        'inputMode': DailySpeakingInputMode.voice,
        'onRamp': DailySpeakingOnRamp.justTalk,
        'audioPath': path,
        'revisionNumber': 1,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.txtDsImportAudio)),
      body: SafeArea(
        child: BlocBuilder<DailySpeakingHistoryBloc, DailySpeakingHistoryState>(
          builder: (context, historyState) {
            final used = historyState.maybeWhen(
              loaded: (_, n) => n,
              orElse: () => 0,
            );
            final exhausted = used >= kDailySessionLimit;
            final hasFile = _path != null;
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _IntroCard(text: l10n.txtDsImportIntro),
                  const SizedBox(height: 20),
                  if (hasFile)
                    _SelectedFileCard(
                      name: _name!,
                      duration: _duration!,
                      sizeBytes: _sizeBytes!,
                      path: _path!,
                    ),
                  if (_error != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      _error!,
                      style: PmpTextStyles.body2Regular
                          .copyWith(color: colorScheme.error),
                    ),
                  ],
                  const SizedBox(height: 16),
                  OutlinedButton.icon(
                    onPressed: _busy ? null : _pickFile,
                    icon: _busy
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.folder_open),
                    label: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(hasFile
                          ? l10n.txtDsImportChangeFile
                          : l10n.txtDsImportChooseFile),
                    ),
                  ),
                  const SizedBox(height: 10),
                  FilledButton.icon(
                    onPressed: (hasFile && !exhausted) ? _submit : null,
                    icon: const Icon(Icons.auto_awesome),
                    label: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(exhausted
                          ? l10n.txtDsDailyLimitReachedShort
                          : l10n.txtDsGetFeedback),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _IntroCard extends StatelessWidget {
  const _IntroCard({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.upload_file, size: 18, color: colorScheme.primary),
              const SizedBox(width: 8),
              Text(
                l10n.txtDsImportAudio,
                style: PmpTextStyles.body2Semi
                    .copyWith(color: colorScheme.onSurface),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            text,
            style: PmpTextStyles.body2Regular
                .copyWith(color: colorScheme.onSurfaceVariant, height: 1.5),
          ),
        ],
      ),
    );
  }
}

class _SelectedFileCard extends StatelessWidget {
  const _SelectedFileCard({
    required this.name,
    required this.duration,
    required this.sizeBytes,
    required this.path,
  });

  final String name;
  final Duration duration;
  final int sizeBytes;
  final String path;

  String get _meta {
    final mm = duration.inMinutes.toString().padLeft(2, '0');
    final ss = (duration.inSeconds % 60).toString().padLeft(2, '0');
    final mb = (sizeBytes / (1024 * 1024)).toStringAsFixed(1);
    return '$mm:$ss · $mb MB';
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.audio_file, size: 18, color: colorScheme.primary),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: PmpTextStyles.body1Semi
                      .copyWith(color: colorScheme.onSurface),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            _meta,
            style: PmpTextStyles.label2Regular
                .copyWith(color: colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 12),
          SessionAudioPlayer(audioPath: path),
        ],
      ),
    );
  }
}
