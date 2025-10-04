import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:pmp_english/model/spoken_pattern/spoken_pattern.dart';

import '../../../bloc/audio_player/audio_player_bloc.dart';
import '../../../config/pmp_text_styles.dart';
import '../../../model/pattern_example/pattern_example.dart';
import 'example_list_widget.dart';

class PatternExampleList extends StatelessWidget {
  const PatternExampleList({
    super.key,
    required this.spokenPattern,
    required this.audioPlayer,
    required this.audioPositionTrackerBloc,
  });
  final SpokenPattern spokenPattern;
  final AudioPlayer audioPlayer;
  final AudioPlayerBloc audioPositionTrackerBloc;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, top: 12),
            child: Text(
              'Examples',
              style: PmpTextStyles.body2Semi.copyWith(
                color: Colors.white,
              ),
            ),
          ),
          if (spokenPattern.patternExamples!.isNotEmpty)
            Expanded(
              child: BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
                bloc: audioPositionTrackerBloc,
                builder: (context, state) {
                  final currentPosition = state.maybeWhen(
                    onCurrentPosition: (position) => position,
                    orElse: () => Duration.zero,
                  );
                  final patternExamples =
                      List<PatternExample>.from(spokenPattern.patternExamples!)
                        ..sort((a, b) => a.createdAt!.compareTo(b.createdAt!));

                  return ExampleListWidget(
                    audioPlayer: audioPlayer,
                    patternExamples: patternExamples,
                    currentPosition: currentPosition.inSeconds,
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
