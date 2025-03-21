import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmp_english/bloc/audio_player/audio_player_bloc.dart';
import 'package:pmp_english/config/pmp_text_styles.dart';
import 'package:pmp_english/screens/patterns/widgets/example_widget.dart';

import '../../../model/pattern/pattern.dart';

class PatternWidget extends StatelessWidget {
  const PatternWidget({
    super.key,
    required this.pattern,
    required this.audioPlayerBloc,
  });
  final Pattern pattern;
  final AudioPlayerBloc audioPlayerBloc;
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
                        bloc: audioPlayerBloc,
                        builder: (context, state) {
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
                                  isPlaying ? Icons.pause : Icons.play_arrow,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
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
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Text(
            'Examples',
            style: PmpTextStyles.body2Semi.copyWith(
              color: Colors.white,
            ),
          ),
        ),
        if (pattern.patternExamples!.isNotEmpty)
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: pattern.patternExamples!.length,
            itemBuilder: (context, index) {
              return ExampleWidget(
                patternExample: pattern.patternExamples![index],
              );
            },
          ),
      ],
    );
  }
}
