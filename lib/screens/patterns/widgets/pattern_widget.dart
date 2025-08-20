import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:pmp_english/bloc/audio_player/audio_player_bloc.dart';
import 'package:pmp_english/config/pmp_text_styles.dart';
import 'package:pmp_english/screens/patterns/widgets/example_list_widget.dart';

import '../../../model/pattern/pattern.dart';
import '../../../model/pattern_example/pattern_example.dart';

class PatternWidget extends StatelessWidget {
  const PatternWidget({
    super.key,
    required this.audioPlayer,
    required this.pattern,
    required this.audioPlayerBloc,
    required this.audioPositionTrackerBloc,
    required this.audioPlayerStateTrackerBloc,
  });
  final AudioPlayer audioPlayer;
  final Pattern pattern;
  final AudioPlayerBloc audioPlayerBloc,
      audioPositionTrackerBloc,
      audioPlayerStateTrackerBloc;
  // final svAggreements = "I => am;He,She,It => is;We,You,They => are";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Card(
          elevation: 4, // Adds shadow effect
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: const Color(0xFF1C2C3C), // Background color
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Wrap(
                      direction: Axis.vertical,
                      children: [
                        Text(
                          pattern.pattern,
                          style: PmpTextStyles.body2Semi.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        if (pattern.title != null)
                          Text(
                            pattern.title!,
                            style: PmpTextStyles.body2Semi.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                      ],
                    ),
                    if (pattern.audioPath != null)
                      BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
                        bloc: audioPlayerStateTrackerBloc,
                        builder: (context, audioPlayerState) {
                          return BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
                            bloc: audioPlayerBloc,
                            builder: (context, state) {
                              final currentPlayerState =
                                  audioPlayerState.maybeWhen(
                                onUpdatePlayerState: (playerState) =>
                                    playerState,
                                orElse: () => null,
                              );
                              final loading =
                                  (currentPlayerState?.processingState ==
                                          ProcessingState.loading ||
                                      currentPlayerState?.processingState ==
                                          ProcessingState.buffering);
                              final isCompleted =
                                  currentPlayerState?.processingState ==
                                      ProcessingState.completed;

                              final isPlaying = state.maybeWhen(
                                initial: () => false,
                                onPause: () => false,
                                onPlay: () => true,
                                onStop: () => false,
                                orElse: () => false,
                              );

                              return InkWell(
                                borderRadius: BorderRadius.circular(100),
                                onTap: () {
                                  if (loading) {
                                    return;
                                  }
                                  if (isPlaying) {
                                    audioPlayerBloc
                                        .add(const AudioPlayerEvent.pause());
                                  } else {
                                    audioPlayerBloc
                                        .add(const AudioPlayerEvent.play());
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: loading
                                      ? const SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        )
                                      : Container(
                                          width: 24,
                                          height: 24,
                                          decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                              colors: [
                                                Color(0xFFFFD700), // Gold
                                                Color(0xFFFFA500), // Deep Gold
                                                Color(
                                                    0xFFB8860B), // Dark Golden
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            ),
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withValues(alpha: 0.2),
                                                spreadRadius: 3,
                                                blurRadius: 8,
                                                offset: const Offset(0, 4),
                                              ),
                                            ],
                                          ),
                                          child: Icon(
                                            isCompleted
                                                ? Icons.replay
                                                : isPlaying
                                                    ? Icons.pause
                                                    : Icons.play_arrow,
                                            color: Colors.white,
                                            size: 22,
                                          ),
                                        ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                  ],
                ),
                if (pattern.description != null &&
                    pattern.description!.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      pattern.description!,
                      style: PmpTextStyles.body2Semi.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ],
            ),
          ),
        ),
        // if (pattern.subjectVerbAgreement != null ||
        //     pattern.subjectVerbAgreement!.isNotEmpty) ...[
        //   Container(
        //     width: double.infinity,
        //     margin: const EdgeInsets.symmetric(horizontal: 24),
        //     decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(8),
        //         color: Colors.white,
        //         boxShadow: [
        //           BoxShadow(
        //             color: Colors.grey.withOpacity(0.2),
        //             spreadRadius: 2,
        //             blurRadius: 2,
        //             offset: const Offset(0, 2),
        //           ),
        //         ]),
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: pattern.subjectVerbAgreement!
        //           .split(';')
        //           .map((e) => Padding(
        //                 padding: const EdgeInsets.all(8.0),
        //                 child: Text(
        //                   e,
        //                   style: PmpTextStyles.body2Semi.copyWith(
        //                     color: Colors.black,
        //                     fontWeight: FontWeight.normal,
        //                   ),
        //                 ),
        //               ))
        //           .toList(),
        //     ),
        //   ),
        //   const SizedBox(
        //     height: 12,
        //   ),
        // ],
        Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, top: 12),
          child: Text(
            'Examples',
            style: PmpTextStyles.body2Semi.copyWith(
              color: Colors.white,
            ),
          ),
        ),
        if (pattern.patternExamples!.isNotEmpty)
          Expanded(
            child: BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
              bloc: audioPositionTrackerBloc,
              builder: (context, state) {
                final currentPosition = state.maybeWhen(
                  onCurrentPosition: (position) => position,
                  orElse: () => 0,
                );
                final patternExamples =
                    List<PatternExample>.from(pattern.patternExamples!)
                      ..sort((a, b) => a.createdAt!.compareTo(b.createdAt!));

                return ExampleListWidget(
                  audioPlayer: audioPlayer,
                  patternExamples: patternExamples,
                  currentPosition: currentPosition,
                );
              },
            ),
          ),
      ],
    );
  }
}
