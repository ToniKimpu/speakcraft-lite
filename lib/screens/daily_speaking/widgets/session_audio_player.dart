import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:speakcraft/config/pmp_text_styles.dart';
import 'package:speakcraft/core/logger/app_logger.dart';
import 'package:speakcraft/l10n/generated/l10n.dart';

/// Compact play/pause + scrubber for a locally-saved daily-speaking recording.
///
/// Tier-A of the audio replay feature: just hear the whole clip back. (The
/// richer waveform + tap-a-line-to-seek tier needs word-level timestamps from
/// the AI and is deferred — see `daily_speaking_feature.md`.)
///
/// Owns its own [AudioPlayer] so several can sit on one screen (the A/B
/// "hear your progress" comparison places two side by side). [label] tags the
/// clip (e.g. "v1" / "This version"); null hides the tag.
class SessionAudioPlayer extends StatefulWidget {
  const SessionAudioPlayer({
    super.key,
    required this.audioPath,
    this.label,
    this.compact = false,
  });

  final String audioPath;
  final String? label;

  /// Tighter layout used when two players share a row (A/B comparison).
  final bool compact;

  @override
  State<SessionAudioPlayer> createState() => _SessionAudioPlayerState();
}

class _SessionAudioPlayerState extends State<SessionAudioPlayer> {
  final AudioPlayer _player = AudioPlayer();
  bool _ready = false;
  bool _failed = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      await _player.setFilePath(widget.audioPath);
      // Reset to the start once playback completes so the button shows ▶ again.
      _player.playerStateStream.listen((state) {
        if (state.processingState == ProcessingState.completed) {
          _player.seek(Duration.zero);
          _player.pause();
        }
      });
      if (mounted) setState(() => _ready = true);
    } catch (e) {
      AppLogger.instance.error('SessionAudioPlayer load failed: $e', error: e);
      if (mounted) setState(() => _failed = true);
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  String _fmt(Duration d) {
    final mm = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final ss = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$mm:$ss';
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    if (_failed) {
      return _Shell(
        compact: widget.compact,
        child: Row(
          children: [
            Icon(Icons.error_outline,
                size: 18, color: colorScheme.onSurfaceVariant),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                AppLocalizations.of(context).txtDsRecordingUnavailable,
                style: PmpTextStyles.label2Regular
                    .copyWith(color: colorScheme.onSurfaceVariant),
              ),
            ),
          ],
        ),
      );
    }
    return _Shell(
      compact: widget.compact,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.label != null) ...[
            Text(
              widget.label!,
              style: PmpTextStyles.labelSemi.copyWith(color: colorScheme.primary),
            ),
            const SizedBox(height: 6),
          ],
          Row(
            children: [
              StreamBuilder<PlayerState>(
                stream: _player.playerStateStream,
                builder: (context, snap) {
                  final playing = snap.data?.playing ?? false;
                  return IconButton(
                    onPressed: !_ready
                        ? null
                        : () => playing ? _player.pause() : _player.play(),
                    iconSize: 34,
                    color: colorScheme.primary,
                    icon: Icon(
                      playing
                          ? Icons.pause_circle_filled
                          : Icons.play_circle_fill,
                    ),
                  );
                },
              ),
              Expanded(
                child: StreamBuilder<Duration>(
                  stream: _player.positionStream,
                  builder: (context, posSnap) {
                    final total = _player.duration ?? Duration.zero;
                    var pos = posSnap.data ?? Duration.zero;
                    if (pos > total) pos = total;
                    final maxMs = total.inMilliseconds.toDouble();
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            trackHeight: 3,
                            // Explicit colors so the track stays visible at rest
                            // (position 0, not playing): the played portion is
                            // solid primary, the remaining track a faded primary
                            // that still reads against the card surface.
                            activeTrackColor: colorScheme.primary,
                            inactiveTrackColor:
                                colorScheme.primary.withValues(alpha: 0.28),
                            thumbColor: colorScheme.primary,
                            overlayColor:
                                colorScheme.primary.withValues(alpha: 0.12),
                            thumbShape: const RoundSliderThumbShape(
                                enabledThumbRadius: 6),
                            overlayShape: const RoundSliderOverlayShape(
                                overlayRadius: 12),
                          ),
                          child: Slider(
                            value: maxMs == 0
                                ? 0
                                : pos.inMilliseconds
                                    .clamp(0, total.inMilliseconds)
                                    .toDouble(),
                            max: maxMs == 0 ? 1 : maxMs,
                            onChanged: !_ready || maxMs == 0
                                ? null
                                : (v) => _player
                                    .seek(Duration(milliseconds: v.round())),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(_fmt(pos),
                                  style: PmpTextStyles.sub.copyWith(
                                      color: colorScheme.onSurfaceVariant)),
                              Text(_fmt(total),
                                  style: PmpTextStyles.sub.copyWith(
                                      color: colorScheme.onSurfaceVariant)),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Shell extends StatelessWidget {
  const _Shell({required this.child, required this.compact});
  final Widget child;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(compact ? 10 : 12),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: child,
    );
  }
}
