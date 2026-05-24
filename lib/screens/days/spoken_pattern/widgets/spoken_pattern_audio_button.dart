import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:speakcraft/core/logger/app_logger.dart';
import 'package:speakcraft/model/spoken_pattern/spoken_pattern.dart';

class SpokenPatternAudioButton extends StatelessWidget {
  const SpokenPatternAudioButton({
    super.key,
    required this.audioPlayer,
    required this.spokenPattern,
    required this.currentPlayerState,
    required this.currentPlayingId,
    required this.onCurrentPlayingIdChanged,
  });
  final AudioPlayer audioPlayer;
  final SpokenPattern spokenPattern;
  final PlayerState? currentPlayerState;
  final String currentPlayingId;
  final Function(String currentPlayingId) onCurrentPlayingIdChanged;

  Future<void> _setAudioSourceIfNeeded(String url, int id) async {
    try {
      await audioPlayer.stop();
      onCurrentPlayingIdChanged("spoken-pattern-$id");
      final source = audioPlayer.audioSource;
      final currentTag = source?.sequence.first.tag as String?;
      if (currentTag != url) {
        await audioPlayer.setAudioSource(
          AudioSource.uri(Uri.parse(url), tag: url),
        );
      }
      audioPlayer.play();
      AppLogger.instance.debug('_setAudioSourceIfNeeded: $url spoken_pattern-$id');
    } catch (e) {
      onCurrentPlayingIdChanged("spoken-pattern-$id");
      AppLogger.instance.error(
          '_setAudioSourceIfNeeded: ${e.toString()} from spoken_pattern', error: e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isCurrentAudio =
        currentPlayingId == "spoken-pattern-${spokenPattern.id ?? -1}";
    final loading =
        (currentPlayerState?.processingState == ProcessingState.loading ||
            currentPlayerState?.processingState == ProcessingState.buffering);
    final isPlaying = currentPlayerState?.playing ?? false;
    final completed =
        currentPlayerState?.processingState == ProcessingState.completed;
    return InkWell(
      onTap: () async {
        if (isCurrentAudio) {
          if (completed) {
            audioPlayer.seek(Duration.zero);
            audioPlayer.play();
          } else if (isPlaying) {
            await audioPlayer.pause();
          } else {
            audioPlayer.play();
          }
        } else {
          _setAudioSourceIfNeeded(
            spokenPattern.audioPath ?? '',
            spokenPattern.id ?? -1,
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                spreadRadius: 2,
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: (loading && isCurrentAudio)
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                  )
                : Icon(
                    (completed && isCurrentAudio)
                        ? Icons.replay
                        : (isPlaying && isCurrentAudio)
                            ? Icons.pause
                            : Icons.play_arrow,
                    color: Colors.blue,
                    size: 22,
                  ),
          ),
        ),
      ),
    );
  }
}
