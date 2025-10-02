import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:pmp_english/model/pattern_example/pattern_example.dart';

import '../../../../bloc/audio_player/audio_player_bloc.dart';
import '../../../../config/pmp_text_styles.dart';

class SpokenPatternExamples extends StatefulWidget {
  const SpokenPatternExamples({
    super.key,
    required this.patternExamples,
    required this.audioPlayer,
    required this.audioPlayerStateTrackerBloc,
    required this.currentPlayingId,
    required this.onCurrentPlayingIdChanged,
    required this.currentPlayerState,
  });

  final List<PatternExample> patternExamples;
  final AudioPlayer audioPlayer;
  final AudioPlayerBloc audioPlayerStateTrackerBloc;
  final String currentPlayingId;
  final Function(String currentPlayingId) onCurrentPlayingIdChanged;
  final PlayerState? currentPlayerState;

  @override
  State<SpokenPatternExamples> createState() => _SpokenPatternExamplesState();
}

class _SpokenPatternExamplesState extends State<SpokenPatternExamples> {
  Future<void> _setAudioSourceIfNeeded(String url, int id) async {
    try {
      await widget.audioPlayer.stop();
      widget.onCurrentPlayingIdChanged("pattern-example-$id");
      final source = widget.audioPlayer.audioSource;
      final currentTag = source?.sequence.first.tag as String?;
      if (currentTag != url) {
        await widget.audioPlayer.setAudioSource(
          AudioSource.uri(Uri.parse(url), tag: url),
        );
      }
      widget.audioPlayer.play();
    } catch (e) {
      widget.onCurrentPlayingIdChanged("pattern-example-$id");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.patternExamples.isEmpty) {
      return const SizedBox.shrink();
    }
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(
        left: 12,
        right: 12,
        top: 12,
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
          const Row(
            children: [
              Icon(
                Icons.description_outlined,
                color: Colors.white,
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                "Examples",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  fontFamily: "ArchivoBlack Regular",
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          ...widget.patternExamples.map((patternExample) {
            final isCurrentAudio = widget.currentPlayingId ==
                "pattern-example-${patternExample.id}";
            final loading = (widget.currentPlayerState?.processingState ==
                    ProcessingState.loading ||
                widget.currentPlayerState?.processingState ==
                    ProcessingState.buffering);
            final isPlaying = widget.currentPlayerState?.playing ?? false;
            final completed = widget.currentPlayerState?.processingState ==
                ProcessingState.completed;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Row(
                children: [
                  InkWell(
                    onTap: () async {
                      if (isCurrentAudio) {
                        if (completed) {
                          widget.audioPlayer.seek(Duration.zero);
                          widget.audioPlayer.play();
                        } else if (isPlaying) {
                          await widget.audioPlayer.pause();
                        } else {
                          await widget.audioPlayer.play();
                        }
                      } else {
                        _setAudioSourceIfNeeded(
                          patternExample.audioUrl ?? '',
                          patternExample.id,
                        );
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Colors.blue,
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
                        child: Center(
                          child: (loading && isCurrentAudio)
                              ? const SizedBox(
                                  width: 14,
                                  height: 14,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  ),
                                )
                              : Icon(
                                  (completed && isCurrentAudio)
                                      ? Icons.replay
                                      : (isPlaying && isCurrentAudio)
                                          ? Icons.pause
                                          : Icons.play_arrow,
                                  color: Colors.white,
                                  size: 18,
                                ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          patternExample.englishText,
                          style: PmpTextStyles.body2Semi
                              .copyWith(color: Colors.white),
                        ),
                        if (patternExample.burmeseText?.isNotEmpty ?? false)
                          Text(
                            patternExample.burmeseText!,
                            style: PmpTextStyles.body2Semi
                                .copyWith(color: Colors.white),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
