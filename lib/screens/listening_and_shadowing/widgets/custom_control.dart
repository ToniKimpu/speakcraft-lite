import 'package:flutter/material.dart';
import 'package:pmp_english/config/common_extensions.dart';
import 'package:pmp_english/screens/listening_and_shadowing/widgets/custom_track_shape.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../config/pmp_colors.dart';
import '../../../config/pmp_text_styles.dart';

class CustomControl extends StatefulWidget {
  const CustomControl({
    super.key,
    required this.controller,
    required this.startPosition,
    required this.endPosition,
    required this.startDuration,
    required this.endDuration,
    required this.readyToPlay,
    required this.onSeek,
    required this.onVocabulary,
  });
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 40,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: const BoxDecoration(
            color: Color(0xFF2C5364),
          ),
          child: Row(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(100),
                onTap: () {
                  _checkReadyToPlay();
                  final currentPosition =
                      widget.controller.value.position.inSeconds;
                  final newPosition = (currentPosition - 10)
                      .clamp(widget.startPosition, widget.endPosition);
                  widget.controller.seekTo(Duration(seconds: newPosition));
                },
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFFFD700), // Gold
                        Color(0xFFFFA500), // Deep Gold
                        Color(0xFFB8860B), // Dark Golden
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 3,
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.replay_10,
                    color: PmpColors.white,
                    size: 18,
                  ),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Text(
                adjustedCurrentPosition.formatDuration(),
                style: PmpTextStyles.body2Regular.copyWith(
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: SliderTheme(
                  data: SliderThemeData(
                    trackShape: CustomTrackShape(),
                  ),
                  child: Slider(
                    value: sliderPosition.toDouble(),
                    min: 0,
                    max: widget.endPosition.toDouble() -
                        widget.startPosition.toDouble(),
                    thumbColor: Colors.orange,
                    activeColor: Colors.orange,
                    onChanged: (value) {
                      _checkReadyToPlay();
                      int seekPosition = value.toInt() + widget.startPosition;
                      widget.controller.seekTo(Duration(seconds: seekPosition));
                    },
                  ),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Text(
                '- ${remainingDuration.formatDuration()}',
                style: PmpTextStyles.body2Regular.copyWith(
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              InkWell(
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
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFFFD700), // Gold
                        Color(0xFFFFA500), // Deep Gold
                        Color(0xFFB8860B), // Dark Golden
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 3,
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.forward_10,
                    color: PmpColors.white,
                    size: 18,
                  ),
                ),
              ),
              const Spacer(),
              InkWell(
                borderRadius: BorderRadius.circular(6),
                onTap: () => widget.onVocabulary(),
                child: Container(
                  height: 24,
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFFFD700), // Gold
                        Color(0xFFFFA500), // Deep Gold
                        Color(0xFFB8860B), // Dark Golden
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 3,
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      "voc",
                      style:
                          PmpTextStyles.labelSemi.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              widget.readyToPlay
                  ? InkWell(
                      borderRadius: BorderRadius.circular(100),
                      onTap: () {
                        widget.controller.value.isPlaying
                            ? widget.controller.pause()
                            : widget.controller.play();
                        setState(() {});
                      },
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFFFFD700), // Gold
                              Color(0xFFFFA500), // Deep Gold
                              Color(0xFFB8860B), // Dark Golden
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 3,
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Icon(
                          widget.controller.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: PmpColors.white,
                          size: 18,
                        ),
                      ),
                    )
                  : const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        color: PmpColors.white,
                      ),
                    ),
            ],
          ),
        ),
      ],
    );
  }
}
