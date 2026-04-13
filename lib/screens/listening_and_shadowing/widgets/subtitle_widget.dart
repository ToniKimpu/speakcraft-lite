import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:pmp_english/bloc/audio_player/audio_player_bloc.dart';
import 'package:pmp_english/model/sentence_explanation/sentence_explanation.dart';
import 'package:pmp_english/model/subtitle/subtitle.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../config/pmp_routes.dart';
import '../../../config/pmp_text_styles.dart';
import '../../../l10n/generated/l10n.dart';

class SubtitleWidget extends StatelessWidget {
  const SubtitleWidget({
    super.key,
    required this.youtubeController,
    required this.audioPlayer,
    required this.audioPositionTrackerBloc,
    required this.audioDurationTrackerBloc,
    required this.audioPlayerStateTrackerBloc,
    required this.hasVocabularies,
    required this.subtitle,
    required this.hasMMSub,
  });

  final YoutubePlayerController youtubeController;
  final AudioPlayer audioPlayer;
  final AudioPlayerBloc audioPositionTrackerBloc,
      audioDurationTrackerBloc,
      audioPlayerStateTrackerBloc;
  final bool hasVocabularies;
  final Subtitle subtitle;
  final bool hasMMSub;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // English Subtitle
          Text(
            subtitle.english,
            style: PmpTextStyles.body1Regular.copyWith(
              color: Colors.white,
              fontSize: 20,
              height: 1.6,
              fontFamily: "ArchivoBlack Regular",
            ),
          ),
          const SizedBox(height: 6),
          if (hasMMSub &&
              subtitle.burmese != null &&
              subtitle.burmese!.isNotEmpty)
            Text(
              subtitle.burmese ?? "",
              style: PmpTextStyles.body2Regular.copyWith(
                // color: Colors.amberAccent,
                color: const Color(0xFFFFE0B2),
                fontSize: 18,
                height: 1.8,
                fontFamily: "MM Lyrics Bold",
              ),
            ),
          // Info Box if no MM Sub
          // if (!hasMMSub) ...[
          //   const SizedBox(height: 24),
          //   Container(
          //     width: double.infinity,
          //     padding: const EdgeInsets.all(16),
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(12),
          //       color: Colors.white.withValues(alpha: 0.05),
          //       border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
          //     ),
          //     child: Text(
          //       "ဘာသာပြန်ဆိုချက်နှင့် ရှင်းပြချက်များ ပုံမှန်ထည့်ပေးသွားပါမယ်။",
          //       textAlign: TextAlign.center,
          //       style: PmpTextStyles.body2Semi.copyWith(
          //         color: Colors.white,
          //         fontFamily: "MM Lyrics Bold",
          //       ),
          //     ),
          //   ),
          // ],

          // Audio Player Section
          // if (subtitle.audioName.isNotEmpty)
          //   BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
          //     bloc: audioPositionTrackerBloc,
          //     builder: (context, positionState) {
          //       return BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
          //         bloc: audioDurationTrackerBloc,
          //         builder: (context, durationState) {
          //           return BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
          //             bloc: audioPlayerStateTrackerBloc,
          //             builder: (context, playerState) {
          //               final positionDuration = positionState.maybeWhen(
          //                 onCurrentPosition: (position) => position,
          //                 orElse: () => Duration.zero,
          //               );
          //               final totalDuration = durationState.maybeWhen(
          //                 onTotalDuration: (duration) => duration.inSeconds,
          //                 orElse: () => 0,
          //               );
          //               final currentPlayerState = playerState.maybeWhen(
          //                 onUpdatePlayerState: (playerState) => playerState,
          //                 orElse: () => null,
          //               );
          //               final isPlaying = currentPlayerState?.playing == true;
          //               final isCompleted =
          //                   currentPlayerState?.processingState ==
          //                       ProcessingState.completed;
          //               final loading = (currentPlayerState?.processingState ==
          //                       ProcessingState.loading ||
          //                   currentPlayerState?.processingState ==
          //                       ProcessingState.buffering);
          //               return Container(
          //                 padding: const EdgeInsets.all(16),
          //                 decoration: BoxDecoration(
          //                   borderRadius: BorderRadius.circular(16),
          //                   color: Colors.white.withValues(alpha: 0.04),
          //                   border: Border.all(
          //                     color: Colors.white.withValues(alpha: 0.2),
          //                     width: 1.5,
          //                   ),
          //                 ),
          //                 child: Row(
          //                   crossAxisAlignment: CrossAxisAlignment.center,
          //                   children: [
          //                     // Play Button
          //                     GestureDetector(
          //                       onTap: () {
          //                         if (loading) {
          //                           return;
          //                         }
          //                         if (isCompleted) {
          //                           audioPlayer.seek(Duration.zero);
          //                           audioPlayer.play();
          //                           if (youtubeController.value.isPlaying) {
          //                             youtubeController.pause();
          //                           }
          //                         } else if (isPlaying) {
          //                           audioPlayer.pause();
          //                         } else {
          //                           audioPlayer.play();
          //                           if (youtubeController.value.isPlaying) {
          //                             youtubeController.pause();
          //                           }
          //                         }
          //                       },
          //                       child: Container(
          //                         padding: const EdgeInsets.all(8),
          //                         decoration: BoxDecoration(
          //                           shape: BoxShape.circle,
          //                           color: Colors.white.withValues(alpha: 0.05),
          //                           border: Border.all(
          //                             color:
          //                                 Colors.white.withValues(alpha: 0.4),
          //                             width: 1.5,
          //                           ),
          //                         ),
          //                         child: loading
          //                             ? const SizedBox(
          //                                 width: 16,
          //                                 height: 16,
          //                                 child: CircularProgressIndicator(
          //                                   color: Colors.white,
          //                                 ),
          //                               )
          //                             : Icon(
          //                                 isCompleted
          //                                     ? Icons.replay
          //                                     : isPlaying
          //                                         ? Icons.pause
          //                                         : Icons.play_arrow,
          //                                 color: Colors.white,
          //                                 size: 22,
          //                               ),
          //                       ),
          //                     ),
          //                     const SizedBox(width: 16),

          //                     // Slider and Time
          //                     Expanded(
          //                       child: Column(
          //                         crossAxisAlignment: CrossAxisAlignment.start,
          //                         children: [
          //                           SliderTheme(
          //                             data: SliderTheme.of(context).copyWith(
          //                               trackHeight: 4,
          //                               thumbShape: const RoundSliderThumbShape(
          //                                   enabledThumbRadius: 5),
          //                               overlayShape:
          //                                   SliderComponentShape.noOverlay,
          //                             ),
          //                             child: Slider(
          //                               value: positionDuration.inSeconds
          //                                   .clamp(0, totalDuration)
          //                                   .toDouble(),
          //                               min: 0,
          //                               max: totalDuration > 0
          //                                   ? totalDuration.toDouble()
          //                                   : 1,
          //                               thumbColor: Colors.white,
          //                               activeColor: Colors.orange,
          //                               inactiveColor:
          //                                   Colors.white.withValues(alpha: 0.2),
          //                               onChanged: (_) {},
          //                               onChangeEnd: (value) {
          //                                 if (loading) {
          //                                   return;
          //                                 }
          //                                 audioPlayer.seek(
          //                                     Duration(seconds: value.toInt()));
          //                               },
          //                             ),
          //                           ),
          //                           Row(
          //                             mainAxisAlignment:
          //                                 MainAxisAlignment.spaceBetween,
          //                             children: [
          //                               Text(
          //                                 loading
          //                                     ? "0:00"
          //                                     : _formatDuration(
          //                                         positionDuration.inSeconds),
          //                                 style: PmpTextStyles.sub.copyWith(
          //                                   color: Colors.white
          //                                       .withValues(alpha: 0.9),
          //                                 ),
          //                               ),
          //                               Text(
          //                                 loading
          //                                     ? "0:00"
          //                                     : _formatDuration(totalDuration),
          //                                 style: PmpTextStyles.sub.copyWith(
          //                                   color: Colors.white
          //                                       .withValues(alpha: 0.9),
          //                                 ),
          //                               ),
          //                             ],
          //                           ),
          //                         ],
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //               );
          //             },
          //           );
          //         },
          //       );
          //     },
          //   ),

          const SizedBox(
            height: 8,
          ),
          if (subtitle.explanationUrl.isNotEmpty)
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  // Only pause YT when it's actively playing. Calling
                  // pause() during buffering interrupts the buffer fetch
                  // and the iframe gets stuck in a loading loop on return
                  // from the pushed route.
                  if (youtubeController.value.isPlaying) {
                    youtubeController.pause();
                  }
                  if (audioPlayer.playing) {
                    audioPlayer.pause();
                  }
                  final sentenceExplanation = SentenceExplanation(
                    id: 1,
                    start: subtitle.start.inSeconds.toDouble(),
                    end: subtitle.end.inSeconds.toDouble(),
                    english: subtitle.english,
                    burmese: subtitle.burmese ?? "",
                    explanationUrl: subtitle.explanationUrl,
                  );
                  Navigator.pushNamed(
                    context,
                    PmpRoutes.sentenceExplanationPage,
                    arguments: {
                      "sentence_explanation": sentenceExplanation,
                    },
                  );
                },
                child: Ink(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.green,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.visibility_outlined,
                        size: 18,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        AppLocalizations.of(context).txtViewExplanation,
                        style: PmpTextStyles.body2Semi.copyWith(
                          color: Colors.white,
                          fontFamily: "ArchivoBlack Regular",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
