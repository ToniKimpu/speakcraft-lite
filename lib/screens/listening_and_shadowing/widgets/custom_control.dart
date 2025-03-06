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
  });
  final YoutubePlayerController controller;
  final int startPosition;
  final int endPosition;
  final Duration startDuration;
  final Duration endDuration;
  final bool readyToPlay;
  final VoidCallback onSeek;

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
          color: PmpColors.primary400,
          child: Row(
            children: [
              Material(
                color: PmpColors.white,
                borderRadius: BorderRadius.circular(100),
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
                  child: const SizedBox(
                    width: 24,
                    height: 24,
                    child: Icon(
                      Icons.replay_10,
                      color: PmpColors.primary400,
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
              Material(
                color: PmpColors.white,
                borderRadius: BorderRadius.circular(100),
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
                  child: const SizedBox(
                    width: 24,
                    height: 24,
                    child: Icon(
                      Icons.forward_10,
                      color: PmpColors.primary400,
                      size: 18,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              widget.readyToPlay
                  ? Material(
                      color: PmpColors.white,
                      borderRadius: BorderRadius.circular(100),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: () {
                          widget.controller.value.isPlaying
                              ? widget.controller.pause()
                              : widget.controller.play();
                          setState(() {});
                        },
                        child: SizedBox(
                          width: 24,
                          height: 24,
                          child: Icon(
                            widget.controller.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                            color: PmpColors.primary400,
                            size: 18,
                          ),
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
