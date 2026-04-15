import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../config/pmp_text_styles.dart';
import '../../../model/listening/listening.dart';

class ShadowingPlayer extends StatelessWidget {
  const ShadowingPlayer({
    super.key,
    required this.listening,
    required this.controller,
    required this.player,
    required this.positionListenable,
    required this.totalDuration,
    required this.onTogglePlay,
  });
  final Listening listening;
  final YoutubePlayerController controller;
  final Widget player;
  final ValueListenable<Duration> positionListenable;
  final Duration totalDuration;
  final VoidCallback onTogglePlay;

  @override
  Widget build(BuildContext context) {
    // Rebuilds on controller state changes (play/pause/ready/ended) at the
    // controller's native ~4Hz rate — not the 60fps ticker. Slider + time
    // text still update at 60fps via the inner ValueListenableBuilder below.
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) => _buildPlayer(context),
    );
  }

  Widget _buildPlayer(BuildContext context) {
    final loading = controller.value.playerState == PlayerState.buffering ||
        !controller.value.isReady;
    final startLoading =
        loading && controller.value.position.inSeconds == 0;
    final playing = controller.value.isPlaying;
    final paused = controller.value.playerState == PlayerState.paused;
    final complete = controller.value.playerState == PlayerState.ended;
    final colorScheme = Theme.of(context).colorScheme;
    final onSurface = colorScheme.onSurface;
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: colorScheme.surfaceContainerHighest,
          border: Border.all(
            color: colorScheme.outlineVariant,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Stack(
                    children: [
                      player,
                      Offstage(
                        offstage: (playing || paused || loading) &&
                            !complete &&
                            !startLoading,
                        child: CachedNetworkImage(
                          imageUrl: listening.thumbnail,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: colorScheme.surfaceContainerHigh,
                            child: Center(
                              child: SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  color: onSurface,
                                ),
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: colorScheme.surfaceContainerHigh,
                            child: Icon(
                              Icons.broken_image,
                              size: 20,
                              color: onSurface,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Slider + Time
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 4,
                      thumbShape: const RoundSliderThumbShape(
                        enabledThumbRadius: 5,
                      ),
                      overlayShape: SliderComponentShape.noOverlay,
                    ),
                    child: ValueListenableBuilder<Duration>(
                      valueListenable: positionListenable,
                      builder: (context, position, _) => Slider(
                        value: position.inMilliseconds
                            .clamp(0, totalDuration.inMilliseconds)
                            .toDouble(),
                        min: 0,
                        max: totalDuration.inMilliseconds.toDouble(),
                        thumbColor: onSurface,
                        activeColor: Colors.orange,
                        inactiveColor: onSurface.withValues(alpha: 0.2),
                        onChanged: (value) {},
                        onChangeEnd: (value) {
                          controller
                              .seekTo(Duration(milliseconds: value.round()));
                        },
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ValueListenableBuilder<Duration>(
                        valueListenable: positionListenable,
                        builder: (context, position, _) => Text(
                          _formatDuration(position),
                          style: PmpTextStyles.subBold.copyWith(
                            color: onSurface,
                          ),
                        ),
                      ),
                      Text(
                        _formatDuration(totalDuration),
                        style: PmpTextStyles.subBold.copyWith(
                          color: onSurface,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: () {
                onTogglePlay();
              },
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: onSurface.withValues(alpha: 0.05),
                  border: Border.all(
                    color: colorScheme.outlineVariant,
                    width: 1.5,
                  ),
                ),
                child: Center(
                  child: loading
                      ? SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            color: onSurface,
                          ),
                        )
                      : Icon(
                          (controller.value.playerState == PlayerState.ended)
                              ? Icons.replay
                              : controller.value.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow,
                          color: onSurface,
                          size: 22,
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(1, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }
}
