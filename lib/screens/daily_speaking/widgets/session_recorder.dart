import 'dart:async';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:speakcraft/config/pmp_colors.dart';
import 'package:speakcraft/config/pmp_text_styles.dart';
import 'package:speakcraft/core/logger/app_logger.dart';
import 'package:speakcraft/l10n/generated/l10n.dart';

/// Hard cap: per memory, sessions are limited to 5 min.
const int kMaxDailySpeakingSeconds = 300;

/// Drives a `record` `AudioRecorder` for the Daily Speaking flow.
///
/// Differs from `listening_and_shadowing/recording_voice_widgets/recorder.dart`
/// in two ways:
///   1. Auto-stops at [kMaxDailySpeakingSeconds] so the learner can't blow
///      past the 5-min cap (which also keeps token cost predictable).
///   2. On stop, surfaces the final `audioPath` directly to the parent — no
///      save-dialog interleaving — because the parent immediately dispatches
///      it to the BLoC for review.
class SessionRecorder extends StatefulWidget {
  const SessionRecorder({
    super.key,
    required this.onComplete,
    this.disabled = false,
    this.disabledMessage,
  });

  /// Called once with the final audio file path after the user (or the cap)
  /// stops the recording.
  final void Function(String audioPath, int durationSeconds) onComplete;

  /// Disables the mic button — used when the daily session quota is exhausted.
  final bool disabled;
  final String? disabledMessage;

  @override
  State<SessionRecorder> createState() => _SessionRecorderState();
}

class _SessionRecorderState extends State<SessionRecorder> {
  final AudioRecorder _audioRecorder = AudioRecorder();
  final ValueNotifier<int> _durationNotifier = ValueNotifier(0);
  final ValueNotifier<RecordState> _stateNotifier =
      ValueNotifier(RecordState.stop);

  StreamSubscription<RecordState>? _stateSub;
  Timer? _timer;
  String? _activePath;

  @override
  void initState() {
    super.initState();
    _stateSub = _audioRecorder.onStateChanged().listen((state) {
      _stateNotifier.value = state;
      if (state == RecordState.record) {
        _startTimer();
      } else if (state == RecordState.stop) {
        _timer?.cancel();
      } else if (state == RecordState.pause) {
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _stateSub?.cancel();
    _audioRecorder.dispose();
    _durationNotifier.dispose();
    _stateNotifier.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _durationNotifier.value = _durationNotifier.value + 1;
      if (_durationNotifier.value >= kMaxDailySpeakingSeconds) {
        _stop();
      }
    });
  }

  Future<bool> _ensureMicPermission() async {
    final status = await Permission.microphone.request();
    if (status.isGranted) return true;
    if (status.isPermanentlyDenied) {
      await openAppSettings();
    }
    return false;
  }

  Future<void> _start() async {
    if (widget.disabled) return;
    try {
      if (!await _ensureMicPermission()) return;
      if (!await _audioRecorder.hasPermission()) return;

      final dir = await getApplicationDocumentsDirectory();
      final path =
          '${dir.path}/daily_speaking_${DateTime.now().millisecondsSinceEpoch}.m4a';
      _activePath = path;
      _durationNotifier.value = 0;
      await _audioRecorder.start(
        const RecordConfig(
          encoder: AudioEncoder.aacLc,
          numChannels: 1,
          bitRate: 128000,
        ),
        path: path,
      );
    } catch (e) {
      AppLogger.instance.error('SessionRecorder start failed: $e', error: e);
    }
  }

  Future<void> _stop() async {
    try {
      final path = await _audioRecorder.stop();
      _timer?.cancel();
      final duration = _durationNotifier.value;
      _durationNotifier.value = 0;
      final finalPath = path ?? _activePath;
      if (finalPath != null && duration > 0) {
        widget.onComplete(finalPath, duration);
      }
    } catch (e) {
      AppLogger.instance.error('SessionRecorder stop failed: $e', error: e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ValueListenableBuilder<RecordState>(
      valueListenable: _stateNotifier,
      builder: (_, recordState, __) {
        final isRecording = recordState == RecordState.record;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ValueListenableBuilder<int>(
              valueListenable: _durationNotifier,
              builder: (_, secs, __) {
                final mm = (secs ~/ 60).toString().padLeft(2, '0');
                final ss = (secs % 60).toString().padLeft(2, '0');
                final capMM =
                    (kMaxDailySpeakingSeconds ~/ 60).toString().padLeft(2, '0');
                return Column(
                  children: [
                    Text(
                      '$mm:$ss',
                      style: const TextStyle(
                        fontSize: 56,
                        fontFamily: 'ArchivoBlack Regular',
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      AppLocalizations.of(context)
                          .txtDsMaxDuration('$capMM:00'),
                      style: PmpTextStyles.label2Regular.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 32),
            _MicButton(
              isRecording: isRecording,
              disabled: widget.disabled,
              onTap: () {
                if (widget.disabled) return;
                isRecording ? _stop() : _start();
              },
            ),
            const SizedBox(height: 20),
            Text(
              widget.disabled
                  ? (widget.disabledMessage ??
                      AppLocalizations.of(context).txtDsRecordingUnavailable)
                  : isRecording
                      ? AppLocalizations.of(context).txtDsTapToStop
                      : AppLocalizations.of(context).txtDsTapToStart,
              style: PmpTextStyles.body1Regular.copyWith(
                color: widget.disabled
                    ? colorScheme.onSurfaceVariant
                    : colorScheme.onSurface,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _MicButton extends StatelessWidget {
  const _MicButton({
    required this.isRecording,
    required this.disabled,
    required this.onTap,
  });
  final bool isRecording;
  final bool disabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final bg = disabled
        ? colorScheme.surfaceContainerHighest
        : isRecording
            ? colorScheme.error
            : colorScheme.primary;
    // Pair the icon with its background via the scheme's on* roles so it stays
    // visible in both themes. (In dark mode `primary` is white, so a hardcoded
    // white icon vanished — onPrimary is black there.)
    final fg = disabled
        ? colorScheme.onSurfaceVariant
        : isRecording
            ? colorScheme.onError
            : colorScheme.onPrimary;
    return Material(
      color: bg,
      shape: const CircleBorder(),
      elevation: disabled ? 0 : 4,
      shadowColor: PmpColors.black.withValues(alpha: 0.3),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: disabled ? null : onTap,
        child: SizedBox(
          width: 120,
          height: 120,
          child: Icon(
            isRecording ? Icons.stop : Icons.mic,
            size: 56,
            color: fg,
          ),
        ),
      ),
    );
  }
}
