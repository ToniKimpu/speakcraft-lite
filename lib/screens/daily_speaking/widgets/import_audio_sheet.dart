import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:speakcraft/config/pmp_text_styles.dart';
import 'package:speakcraft/l10n/generated/l10n.dart';

import 'session_audio_player.dart';

/// Sensible default limits, mirroring the live recorder's 5-minute cap.
const Duration _kMaxDuration = Duration(minutes: 5);
/// Silent grace on top of [_kMaxDuration] — clips that run a second or two over
/// 5:00 (clock/encoder rounding) should still import. The user-facing message
/// still says "5 minutes"; this just avoids rejecting a 5:01 recording.
const Duration _kDurationTolerance = Duration(seconds: 10);
const Duration _kMinDuration = Duration(seconds: 5);
const int _kMaxBytes = 25 * 1024 * 1024; // 25 MB
const List<String> _kAllowedExt = ['m4a', 'mp3', 'wav', 'aac', 'ogg', 'flac'];

/// Bottom sheet on-ramp: bring your own recording. Lets the learner pick an
/// existing audio file of themselves speaking, validates it (format / length /
/// size), previews it, and returns the validated local path on confirm.
///
/// This is *capture method*, not *topic source*: it sits on each record page
/// (just-talk / own-topic / suggested) as an alternative to the live mic, so the
/// caller keeps its own `onRamp` + `topic` context and merely swaps in the
/// imported `audioPath`. Returns null if the learner cancels.
Future<String?> showImportAudioSheet(BuildContext context) {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    showDragHandle: true,
    builder: (_) => const _ImportAudioSheet(),
  );
}

/// Secondary capture action shown under the mic on each record page: opens the
/// import sheet and, on confirm, hands the validated path back to the caller so
/// it can route into choose-feedback with its own on-ramp / topic context.
class ImportInsteadButton extends StatelessWidget {
  const ImportInsteadButton({
    super.key,
    required this.enabled,
    required this.onImported,
  });

  final bool enabled;
  final ValueChanged<String> onImported;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: enabled
          ? () async {
              final path = await showImportAudioSheet(context);
              if (path != null && context.mounted) onImported(path);
            }
          : null,
      icon: const Icon(Icons.upload_file, size: 18),
      label: Text(AppLocalizations.of(context).txtDsImportInstead),
    );
  }
}

class _ImportAudioSheet extends StatefulWidget {
  const _ImportAudioSheet();

  @override
  State<_ImportAudioSheet> createState() => _ImportAudioSheetState();
}

class _ImportAudioSheetState extends State<_ImportAudioSheet> {
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
      if (duration > _kMaxDuration + _kDurationTolerance) {
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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final hasFile = _path != null;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(Icons.upload_file, size: 20, color: colorScheme.primary),
              const SizedBox(width: 8),
              Text(
                l10n.txtDsImportAudio,
                style: PmpTextStyles.body1Semi
                    .copyWith(color: colorScheme.onSurface),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            l10n.txtDsImportIntro,
            style: PmpTextStyles.body2Regular
                .copyWith(color: colorScheme.onSurfaceVariant, height: 1.5),
          ),
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
            onPressed: hasFile ? () => Navigator.pop(context, _path) : null,
            icon: const Icon(Icons.check),
            label: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(l10n.txtDsImportUseRecording),
            ),
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
