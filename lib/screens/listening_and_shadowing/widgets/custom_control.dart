import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:speakcraft/config/common_extensions.dart';
import 'package:speakcraft/screens/listening_and_shadowing/widgets/custom_track_shape.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart'
    as yt_player;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../config/pmp_text_styles.dart';

class CustomControl extends StatefulWidget {
  const CustomControl({
    super.key,
    required this.audioPlayer,
    required this.controller,
    required this.startPosition,
    required this.endPosition,
    required this.startDuration,
    required this.endDuration,
    required this.readyToPlay,
    required this.onSeek,
    required this.onVocabulary,
  });
  final AudioPlayer audioPlayer;
  final YoutubePlayerController controller;
  final int startPosition;
  final int endPosition;
  final Duration startDuration;
  final Duration endDuration;
  final bool readyToPlay;
  final VoidCallback onSeek;
  final VoidCallback onVocabulary;

  @override
  State<CustomControl> createState() => _CustomControlState();
}

class _CustomControlState extends State<CustomControl> {
  int sliderPosition = 0;

  void _checkReadyToPlay() {
    if (!widget.readyToPlay) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentPosition =
        widget.controller.value.position - widget.startDuration;
    final adjustedCurrentPosition = currentPosition.isNegative
        ? const Duration(seconds: 0)
        : currentPosition;
    final remainingDuration = widget.endDuration - adjustedCurrentPosition;
    sliderPosition = currentPosition.inSeconds
        .clamp(0, (widget.endPosition - widget.startPosition));
    final playerState = widget.controller.value.playerState;
    final isLoading = playerState == yt_player.PlayerState.buffering ||
        playerState == yt_player.PlayerState.unStarted ||
        playerState == yt_player.PlayerState.cued;
    final colorScheme = Theme.of(context).colorScheme;
    final onSurface = colorScheme.onSurface;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      margin: const EdgeInsets.only(left: 12, right: 12, bottom: 8, top: 8),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: colorScheme.outlineVariant,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Material(
            borderRadius: BorderRadius.circular(100),
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: () {
                _checkReadyToPlay();
                final currentPosition =
                    widget.controller.value.position.inSeconds;
                final newPosition = (currentPosition - 10)
                    .clamp(widget.startPosition, widget.endPosition);
                widget.controller.seekTo(Duration(seconds: newPosition));
              },
              child: Ink(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.replay_10,
                  color: onSurface,
                  size: 18,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Text(
            adjustedCurrentPosition.formatDuration(),
            style: PmpTextStyles.subBold.copyWith(
              color: onSurface,
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Flexible(
            flex: 3,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 220, maxWidth: 400),
              child: SliderTheme(
                data: SliderThemeData(
                  trackShape: CustomTrackShape(),
                  thumbShape: const RoundSliderThumbShape(
                    enabledThumbRadius: 6, // default is 6
                  ),
                ),
                child: Slider(
                  value: sliderPosition.toDouble(),
                  min: 0,
                  max: widget.endPosition.toDouble() -
                      widget.startPosition.toDouble(),
                  thumbColor: onSurface,
                  activeColor: Colors.orange,
                  inactiveColor: onSurface.withValues(alpha: 0.3),
                  onChanged: (value) {
                    _checkReadyToPlay();
                    int seekPosition = value.toInt() + widget.startPosition;
                    widget.controller.seekTo(Duration(seconds: seekPosition));
                  },
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Text(
            '- ${remainingDuration.formatDuration()}',
            style: PmpTextStyles.subBold.copyWith(
              color: onSurface,
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Material(
            borderRadius: BorderRadius.circular(100),
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: () {
                _checkReadyToPlay();
                final currentPosition =
                    widget.controller.value.position.inSeconds;
                final newPosition = (currentPosition + 10)
                    .clamp(widget.startPosition, widget.endPosition);
                widget.controller.seekTo(Duration(seconds: newPosition));
                widget.onSeek();
              },
              child: Ink(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.forward_10,
                  color: onSurface,
                  size: 18,
                ),
              ),
            ),
          ),
          const Spacer(),
          widget.readyToPlay
              ? Material(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () {
                      if (widget.controller.value.isPlaying) {
                        widget.controller.pause();
                      } else {
                        widget.controller.play();
                        widget.audioPlayer.pause();
                      }
                      setState(() {});
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: colorScheme.outlineVariant,
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: isLoading
                            ? SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  color: onSurface,
                                ),
                              )
                            : Icon(
                                widget.controller.value.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                color: onSurface,
                                size: 18,
                              ),
                      ),
                    ),
                  ),
                )
              : SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    color: onSurface,
                  ),
                ),
        ],
      ),
    );
  }
}
