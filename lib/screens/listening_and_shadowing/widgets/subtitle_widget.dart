import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:pmp_english/bloc/audio_player/audio_player_bloc.dart';
import 'package:pmp_english/model/subtitle/subtitle.dart';

import '../../../config/pmp_text_styles.dart';

class SubtitleWidget extends StatelessWidget {
  const SubtitleWidget({
    super.key,
    required this.audioPlayer,
    required this.audioPositionTrackerBloc,
    required this.audioDurationTrackerBloc,
    required this.audioPlayerStateTrackerBloc,
    required this.subtitle,
    required this.hasMMSub,
  });
  final AudioPlayer audioPlayer;
  final AudioPlayerBloc audioPositionTrackerBloc,
      audioDurationTrackerBloc,
      audioPlayerStateTrackerBloc;
  final Subtitle subtitle;
  final bool hasMMSub;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            subtitle.english,
            style: PmpTextStyles.body1Regular.copyWith(
              color: Colors.white,
              fontFamily: "English Lyrics",
            ),
          ),
          if (hasMMSub)
            Text(
              subtitle.burmese ?? "",
              style: PmpTextStyles.body2Regular.copyWith(
                color: Colors.amber,
                fontFamily: "MM Lyrics Bold",
              ),
            ),
          const SizedBox(
            height: 24,
          ),
          if (!hasMMSub)
            Align(
              alignment: Alignment.center,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                  color: Colors.transparent,
                ),
                child: Text(
                  "ဘာသာပြန်ဆိုချက်နှင့် ရှင်းပြချက်များ ပုံမှန်ထည့်ပေးသွားပါမည်။",
                  style: PmpTextStyles.body2Semi.copyWith(
                    color: Colors.white,
                    fontFamily: "MM Lyrics Bold",
                  ),
                ),
              ),
            ),
          if (subtitle.audioName.isNotEmpty)
            BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
              bloc: audioPositionTrackerBloc,
              builder: (context, positionState) {
                return BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
                  bloc: audioDurationTrackerBloc,
                  builder: (context, durationState) {
                    return BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
                      bloc: audioPlayerStateTrackerBloc,
                      builder: (context, playerState) {
                        final positionDuration = positionState.maybeWhen(
                          onCurrentPosition: (position) => position,
                          orElse: () => 0,
                        );
                        final totalDuration = durationState.maybeWhen(
                          onTotalDuration: (duration) => duration.inSeconds,
                          orElse: () => 0,
                        );
                        final currentPlayerState = playerState.maybeWhen(
                          onUpdatePlayerState: (playerState) => playerState,
                          orElse: () => null,
                        );
                        debugPrint(
                            "_playerStateSubscription: ${currentPlayerState?.playing} playing from Bloc");
                        final isPlaying = currentPlayerState?.playing == true;
                        final isCompleted =
                            currentPlayerState?.processingState ==
                                ProcessingState.completed;
                        final isPaused = currentPlayerState?.playing == false &&
                            currentPlayerState?.processingState ==
                                ProcessingState.ready;
                        return Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white
                                .withValues(alpha: 0.05), // subtle background
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.4),
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Play Button
                              GestureDetector(
                                onTap: () {
                                  if (isCompleted) {
                                    audioPlayer.seek(Duration.zero); // rewind
                                    audioPlayer.play();
                                  } else if (isPlaying) {
                                    audioPlayer.pause();
                                  } else {
                                    audioPlayer.play();
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white.withOpacity(0.05),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.6),
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Icon(
                                    isCompleted
                                        ? Icons.replay
                                        : isPlaying
                                            ? Icons.pause
                                            : Icons.play_arrow,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ),

                              const SizedBox(width: 16),
                              // Slider and Time
                              Expanded(
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Transform.translate(
                                    offset: const Offset(0, 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SliderTheme(
                                          data:
                                              SliderTheme.of(context).copyWith(
                                            trackHeight: 4,
                                            thumbShape:
                                                const RoundSliderThumbShape(
                                                    enabledThumbRadius: 4),
                                            overlayShape:
                                                SliderComponentShape.noOverlay,
                                          ),
                                          child: Slider(
                                            value: positionDuration
                                                .clamp(0, totalDuration)
                                                .toDouble(),
                                            min: 0,
                                            max: totalDuration > 0
                                                ? totalDuration.toDouble()
                                                : 1,
                                            thumbColor: Colors.white,
                                            activeColor: Colors.orange,
                                            inactiveColor: Colors.white
                                                .withValues(alpha: 0.2),
                                            onChanged: (value) {},
                                            onChangeEnd: (value) {
                                              audioPlayer.seek(Duration(
                                                  seconds: value.toInt()));
                                            },
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              _formatDuration(positionDuration),
                                              style: PmpTextStyles.sub.copyWith(
                                                color: Colors.white
                                                    .withValues(alpha: 0.9),
                                              ),
                                            ),
                                            Text(
                                              _formatDuration(totalDuration),
                                              style: PmpTextStyles.sub.copyWith(
                                                color: Colors.white
                                                    .withValues(alpha: 0.9),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          if (subtitle.audioName.isNotEmpty)
            const SizedBox(
              height: 12,
            ),
          if (hasMMSub && subtitle.vocabularies!.isNotEmpty)
            ...subtitle.vocabularies!.map(
              (voc) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          margin: const EdgeInsets.only(top: 6),
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                voc.english,
                                style: PmpTextStyles.body1Regular.copyWith(
                                  color: Colors.white,
                                  fontFamily: "English Lyrics",
                                ),
                              ),
                              Text(
                                voc.burmese,
                                style: PmpTextStyles.body2Regular.copyWith(
                                  color: Colors.white,
                                  fontFamily: "MM Lyrics Bold",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (voc.explanation != null && voc.explanation!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Text(
                          "(${voc.explanation})",
                          style: PmpTextStyles.body2Regular.copyWith(
                            color: Colors.amber,
                            fontFamily: "MM Lyrics Bold",
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
        ],
      ),
    );
  }

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}
