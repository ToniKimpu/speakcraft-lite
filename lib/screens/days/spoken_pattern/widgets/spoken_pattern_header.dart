import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:speakcraft/model/spoken_pattern/spoken_pattern.dart';
import 'package:speakcraft/screens/days/spoken_pattern/widgets/spoken_pattern_audio_button.dart';

import '../../../../bloc/audio_player/audio_player_bloc.dart';
import '../../../../config/pmp_text_styles.dart';

class SpokenPatternHeader extends StatelessWidget {
  const SpokenPatternHeader({
    super.key,
    required this.spokenPattern,
    required this.audioPlayer,
    required this.audioPositionTrackerBloc,
    required this.audioPlayerStateTrackerBloc,
    required this.currentPlayingId,
    required this.onCurrentPlayingIdChanged,
  });
  final SpokenPattern spokenPattern;
  final AudioPlayer audioPlayer;
  final AudioPlayerBloc audioPositionTrackerBloc, audioPlayerStateTrackerBloc;
  final String currentPlayingId;
  final Function(String id) onCurrentPlayingIdChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        // color: Colors.blue,
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        // border: Border.all(color: Colors.white, width: 2),
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      spokenPattern.pattern,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontFamily: 'ArchivoBlack Regular',
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (spokenPattern.title?.isNotEmpty ?? false)
                      Text(
                        spokenPattern.title!,
                        style: PmpTextStyles.body2Semi.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              if (spokenPattern.audioPath != null &&
                  spokenPattern.audioPath!.isNotEmpty)
                BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
                  bloc: audioPlayerStateTrackerBloc,
                  builder: (context, audioPlayerState) {
                    final currentPlayerState = audioPlayerState.maybeWhen(
                      onUpdatePlayerState: (playerState) => playerState,
                      orElse: () => null,
                    );
                    return SpokenPatternAudioButton(
                      audioPlayer: audioPlayer,
                      spokenPattern: spokenPattern,
                      currentPlayerState: currentPlayerState,
                      currentPlayingId: currentPlayingId,
                      onCurrentPlayingIdChanged: (value) {
                        onCurrentPlayingIdChanged(value);
                      },
                    );
                  },
                ),
              // const SizedBox(width: 8),
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          DecoratedBox(
            decoration: const BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: Colors.white,
                  width: 4,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Text(
                "á€’á€® pattern á€œá€±á€¸á€€á€á€±á€¬á€· á€€á€­á€¯á€šá€ºá€á€­á€¯á€„á€º \"á€á€…á€ºá€á€¯á€á€¯á€œá€¯á€•á€ºá€á€»á€„á€ºá€á€šá€º\" á€œá€­á€¯á€· á€•á€¼á€±á€¬á€á€²á€·á€¡á€á€« á€žá€¯á€¶á€¸á€á€¬á€•á€«á‹ á€¡á€›á€™á€ºá€¸á€›á€­á€¯á€¸á€›á€¾á€„á€ºá€¸á€•á€¼á€®á€¸ á€”á€±á€·á€…á€‰á€ºá€žá€¯á€¶á€¸á€…á€€á€¬á€¸á€™á€¾á€¬ á€¡á€™á€¼á€²á€á€™á€ºá€¸á€œá€­á€¯á€œá€­á€¯ á€žá€¯á€¶á€¸á€›á€•á€«á€á€šá€ºá‹",
                style: PmpTextStyles.body2Regular.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
