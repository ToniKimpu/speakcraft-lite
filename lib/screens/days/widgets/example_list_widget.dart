import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:speakcraft/model/pattern_example/pattern_example.dart';
import 'package:speakcraft/screens/days/widgets/playing_indicator_widget.dart';

import '../../../config/pmp_text_styles.dart';

class ExampleListWidget extends StatelessWidget {
  const ExampleListWidget({
    super.key,
    required this.audioPlayer,
    required this.patternExamples,
    required this.currentPosition,
  });
  final AudioPlayer audioPlayer;
  final List<PatternExample> patternExamples;
  final int currentPosition;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: patternExamples.length,
      padding: const EdgeInsets.only(top: 12),
      itemBuilder: (context, index) {
        final patternExample = patternExamples[index];
        bool selected;
        if (index >= patternExamples.length - 1) {
          selected = currentPosition >= patternExample.startAt;
        } else {
          int end = patternExample.startAt;
          int nextEnd = patternExamples[index + 1].startAt;
          selected = currentPosition >= end && currentPosition < nextEnd;
        }
        return Material(
          color: selected
              ? Colors.white.withValues(alpha: 0.5)
              : Colors.transparent,
          child: InkWell(
            onTap: () {
              bool isLoading =
                  audioPlayer.processingState == ProcessingState.loading ||
                      audioPlayer.processingState == ProcessingState.buffering;
              if (isLoading) {
                return;
              }
              audioPlayer.seek(
                Duration(seconds: patternExample.startAt),
              );
              if (!audioPlayer.playing) {
                audioPlayer.play();
              }
            },
            child: Ink(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Icon(
                  //   Icons.circle,
                  //   size: 12,
                  //   color: selected ? Colors.amber : PmpColors.white,
                  // ),
                  PlayingIndicator(
                    isPlaying: (selected &&
                        audioPlayer.playing &&
                        audioPlayer.processingState !=
                            ProcessingState.completed),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          patternExample.englishText,
                          style: PmpTextStyles.body2Semi.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        if (patternExample.burmeseText != null)
                          Text(
                            patternExample.burmeseText!,
                            style: PmpTextStyles.body2Semi.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
