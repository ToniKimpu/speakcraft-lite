import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../../../bloc/audio_player/audio_player_bloc.dart';
import '../../../config/pmp_text_styles.dart';
import '../../../model/spoken_pattern/spoken_pattern.dart';
import '../widgets/playing_indicator_widget.dart';
import 'widgets/spoken_pattern_example.dart';

class SpokenPatternWidget extends StatefulWidget {
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

  @override
  State<SpokenPatternWidget> createState() => _SpokenPatternWidgetState();
}

class _SpokenPatternWidgetState extends State<SpokenPatternWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 8,
                spreadRadius: 2,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Wrap(
                    direction: Axis.vertical,
                    children: [
                      const Text(
                        "I want to + V1",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          fontFamily: "ArchivoBlack Regular",
                        ),
                      ),
                      Text(
                        "ကျွန်တော် ...... ချင်တယ်",
                        style: PmpTextStyles.body2Semi.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  Padding(
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
                            color: Colors.black.withValues(alpha: 0.2),
                            spreadRadius: 3,
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.pause,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                "တစ်ခုခုကို လုပ်ဆောင်ချင်တယ်လို့ ပြောချင်တဲ့အခါ သည်စကားစုကို အသုံးပြုပြီးတော့ ပြောလို့ရပါတယ်။",
                style: PmpTextStyles.body2Semi.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 12),
              Ink(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Icon(
                    //   Icons.circle,
                    //   size: 12,
                    //   color: selected ? Colors.amber : PmpColors.white,
                    // ),
                    const PlayingIndicator(
                      isPlaying: false,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "I want to meet her.",
                            style: PmpTextStyles.body2Semi.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "ကျွန်တော် သူမကို တွေ့ချင်တယ်။",
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
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) {
              return const SpokenPatternExample();
            },
            separatorBuilder: (_, __) => const SizedBox(
              height: 8,
            ),
            itemCount: 3,
          ),
        ),
      ],
    );
  }
}
