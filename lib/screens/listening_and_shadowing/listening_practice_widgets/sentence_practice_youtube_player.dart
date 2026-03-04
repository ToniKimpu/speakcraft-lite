import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pmp_english/core/logger/app_logger.dart';
import 'package:pmp_english/model/listening/listening.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SentencePracticeYoutubePlayer extends StatelessWidget {
  const SentencePracticeYoutubePlayer({
    super.key,
    required this.player,
    required this.listening,
    required this.controller,
    required this.currentPage,
    required this.onTap,
  });
  final Widget player;
  final Listening listening;
  final YoutubePlayerController controller;
  final int currentPage;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    bool loading = controller.value.playerState == PlayerState.buffering ||
        !controller.value.isReady;
    AppLogger.instance.debug("_playerStateLogs: $loading loading!");
    final startLoading = loading && currentPage == 0;
    final playing = controller.value.isPlaying;
    final paused = controller.value.playerState == PlayerState.paused;
    final complete = controller.value.playerState == PlayerState.ended;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Container(
            width: 220,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.amber.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: player,
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Offstage(
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
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: onTap,
            child: Ink(
              width: 220,
              height: 44,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.amber.withValues(alpha: 0.8),
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
                        controller.value.playerState == PlayerState.ended
                            ? Icons.replay
                            : controller.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                        color: Colors.white,
                        size: 20,
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
