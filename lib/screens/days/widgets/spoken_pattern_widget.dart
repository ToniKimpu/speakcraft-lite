import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:pmp_english/bloc/audio_player/audio_player_bloc.dart';
import 'package:pmp_english/config/pmp_text_styles.dart';
import 'package:pmp_english/model/spoken_pattern/spoken_pattern.dart';
import 'package:pmp_english/screens/days/widgets/pattern_example_list.dart';

class SpokenPatternWidget extends StatelessWidget {
  const SpokenPatternWidget({
    super.key,
    required this.audioPlayer,
    required this.spokenPattern,
    required this.audioPositionTrackerBloc,
    required this.audioPlayerStateTrackerBloc,
  });
  final AudioPlayer audioPlayer;
  final SpokenPattern spokenPattern;
  final AudioPlayerBloc audioPositionTrackerBloc, audioPlayerStateTrackerBloc;
  // final _svgAggreements = "I => am;He,She,It => is;We,You,They => are";

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
                          spokenPattern.pattern,
                          style: PmpTextStyles.body2Semi.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        if (spokenPattern.title != null)
                          Text(
                            spokenPattern.title!,
                            style: PmpTextStyles.body2Semi.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                      ],
                    ),
                    if (spokenPattern.audioPath != null)
                      BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
                        bloc: audioPlayerStateTrackerBloc,
                        builder: (context, audioPlayerState) {
                          final currentPlayerState = audioPlayerState.maybeWhen(
                            onUpdatePlayerState: (playerState) => playerState,
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
                          final isPlaying =
                              currentPlayerState?.playing ?? false;
                          return InkWell(
                            borderRadius: BorderRadius.circular(100),
                            onTap: () {
                              if (loading) {
                                return;
                              }
                              if (isCompleted) {
                                audioPlayer.seek(Duration.zero);
                                audioPlayer.play();
                              } else if (isPlaying) {
                                audioPlayer.pause();
                              } else {
                                audioPlayer.play();
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
                                            Color(0xFFB8860B), // Dark Golden
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
                      ),
                  ],
                ),
                if (spokenPattern.description != null &&
                    spokenPattern.description!.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    spokenPattern.description!,
                    style: PmpTextStyles.body2Semi.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // if (spokenPattern.subjectVerbAgreement != null &&
                  //     spokenPattern.subjectVerbAgreement!.isNotEmpty)
                  //   Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: spokenPattern.subjectVerbAgreement!
                  //         .split(';')
                  //         .map(
                  //           (e) => Padding(
                  //             padding:
                  //                 const EdgeInsets.symmetric(vertical: 4.0),
                  //             child: Text(
                  //               e,
                  //               style: PmpTextStyles.body2Semi.copyWith(
                  //                 color: Colors.white,
                  //                 fontWeight: FontWeight.normal,
                  //               ),
                  //             ),
                  //           ),
                  //         )
                  //         .toList(),
                  //   ),
                ],
              ],
            ),
          ),
        ),
        PatternExampleList(
          spokenPattern: spokenPattern,
          audioPlayer: audioPlayer,
          audioPositionTrackerBloc: audioPositionTrackerBloc,
        ),
      ],
    );
  }
}
