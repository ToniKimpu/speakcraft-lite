import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

import '../../../bloc/user_recorded_sentence_audio/user_recorded_sentence_audio_bloc.dart';
import '../../../model/user_recorded_sentence_audio/user_recorded_sentence_audio.dart';
import '../dialogs/delete_recorded_audio_dialog.dart';
import 'package:speakcraft/l10n/generated/l10n.dart';

class UserRecordedList extends StatefulWidget {
  const UserRecordedList({
    super.key,
    required this.userRecordedSentenceAudioBloc,
    required this.onNewVoiceName,
    required this.sentenceId,
    required this.youtubeId,
    required this.audioPlayer,
    required this.currentIndex,
    required this.onTogglePlay,
  });
  final UserRecordedSentenceAudioBloc userRecordedSentenceAudioBloc;
  final Function(String name) onNewVoiceName;
  final String sentenceId;
  final String youtubeId;
  final AudioPlayer audioPlayer;
  final int? currentIndex;
  final Function(UserRecordedSentenceAudio data, int index) onTogglePlay;

  @override
  State<UserRecordedList> createState() => _UserRecordedListState();
}

class _UserRecordedListState extends State<UserRecordedList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserRecordedSentenceAudioBloc,
        UserRecordedSentenceAudioState>(
      bloc: widget.userRecordedSentenceAudioBloc,
      builder: (context, state) {
        final colorScheme = Theme.of(context).colorScheme;
        return state.maybeWhen(
          loading: (message) {
            return const Center(
              child: SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(),
              ),
            );
          },
          loaded: (data) {
            // final sentenceId = _subtitles[_currentPage].id;
            final filteredData = data
                .where((e) =>
                    e.sentenceId == widget.sentenceId &&
                    e.youtubeId == widget.youtubeId)
                .toList();
            final nextVoiceIndex = filteredData.length + 1;
            final newVoiceName =
                'voice_${nextVoiceIndex.toString().padLeft(3, '0')}';
            widget.onNewVoiceName(newVoiceName);
            if (filteredData.isEmpty) {
              return Center(
                child: Text(
                  AppLocalizations.of(context).txtNoRecordForSentence,
                  style: TextStyle(
                    fontSize: 16,
                    color: colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w400,
                    fontFamily: "ArchivoBlack Regular",
                  ),
                ),
              );
            }
            return ListView.separated(
              itemCount: filteredData.length,
              padding: const EdgeInsets.symmetric(vertical: 16),
              itemBuilder: (context, index) {
                final data = filteredData[index];
                final isPlaying =
                    widget.currentIndex == index && widget.audioPlayer.playing;
                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => widget.onTogglePlay(data, index),
                    child: SizedBox(
                      height: 60,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isPlaying
                                    ? colorScheme.error
                                    : colorScheme.inverseSurface,
                              ),
                              child: Icon(
                                isPlaying
                                    ? Icons.pause_rounded
                                    : Icons.play_arrow_rounded,
                                color: colorScheme.onInverseSurface,
                                size: 22,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                data.audioName,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: colorScheme.onSurface,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "ArchivoBlack Regular",
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return DeleteRecordedAudioDialog(
                                      data: data,
                                      onDeleted: (success) {
                                        if (success) {
                                          widget.userRecordedSentenceAudioBloc
                                              .add(
                                            const UserRecordedSentenceAudioEvent
                                                .load(
                                              withLoading: false,
                                            ),
                                          );
                                        }
                                      },
                                    );
                                  },
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(6),
                                child: Icon(
                                  Icons.delete_forever,
                                  size: 20,
                                  color: colorScheme.error,
                                ),
                              ),
                            ),
                            InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: () {},
                              child: const Padding(
                                padding: EdgeInsets.all(6),
                                child: Icon(
                                  Icons.edit_note,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (_, __) => Container(
                height: 1,
                color: colorScheme.outlineVariant,
              ),
            );
          },
          orElse: () => Container(),
        );
      },
    );
  }
}
