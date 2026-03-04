import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pmp_english/core/logger/app_logger.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../config/pmp_text_styles.dart';
import '../../../model/listening/listening.dart';

class ShadowingPlayer extends StatelessWidget {
  const ShadowingPlayer({
    super.key,
    required this.listening,
    required this.controller,
    required this.player,
    required this.position,
    required this.totalDuration,
    required this.onTogglePlay,
  });
  final Listening listening;
  final YoutubePlayerController controller;
  final Widget player;
  final Duration position;
  final Duration totalDuration;
  final VoidCallback onTogglePlay;

  @override
  Widget build(BuildContext context) {
    final loading = controller.value.playerState == PlayerState.buffering ||
        !controller.value.isReady;
    final startLoading = loading && position.inSeconds == 0;
    final playing = controller.value.isPlaying;
    final paused = controller.value.playerState == PlayerState.paused;
    final complete = controller.value.playerState == PlayerState.ended;
    AppLogger.instance.debug(
        "_currentPlayerState: ${controller.value.playerState.name} playerState!");
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white.withValues(alpha: 0.04),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.2),
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
                            color: const Color(0xFF203A43),
                            child: const Center(
                              child: SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: const Color(0xFF203A43),
                            child: const Icon(
                              Icons.broken_image,
                              size: 20,
                              color: Colors.white,
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
                    child: Slider(
                      value: position.inMilliseconds.toDouble(),
                      min: 0,
                      max: totalDuration.inMilliseconds.toDouble(),
                      thumbColor: Colors.white,
                      activeColor: Colors.orange,
                      inactiveColor: Colors.white.withValues(alpha: 0.2),
                      onChanged: (value) {},
                      onChangeEnd: (value) {
                        controller
                            .seekTo(Duration(milliseconds: value.round()));
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _formatDuration(position),
                        style: PmpTextStyles.subBold.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        _formatDuration(totalDuration),
                        style: PmpTextStyles.subBold.copyWith(
                          color: Colors.white,
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
                  color: Colors.white.withValues(alpha: 0.05),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.4),
                    width: 1.5,
                  ),
                ),
                child: Center(
                  child: loading
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : Icon(
                          (controller.value.playerState == PlayerState.ended)
                              ? Icons.replay
                              : controller.value.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow,
                          color: Colors.white,
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
