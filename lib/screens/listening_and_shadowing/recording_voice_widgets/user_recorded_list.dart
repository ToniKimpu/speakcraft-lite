import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

import '../../../bloc/user_recorded_sentence_audio/user_recorded_sentence_audio_bloc.dart';
import '../../../model/listening/listening_recording.dart';
import '../dialogs/delete_recorded_audio_dialog.dart';
import 'package:speakcraft/l10n/generated/l10n.dart';

class UserRecordedList extends StatefulWidget {
  const UserRecordedList({
    super.key,
    required this.userRecordedSentenceAudioBloc,
    required this.listeningId,
    required this.sentenceId,
    required this.audioPlayer,
    required this.currentIndex,
    required this.onTogglePlay,
    this.emptyMessage,
  });
  final UserRecordedSentenceAudioBloc userRecordedSentenceAudioBloc;
  final int listeningId;
  final String sentenceId;
  final AudioPlayer audioPlayer;
  final int? currentIndex;
  final Function(ListeningRecording data, int index) onTogglePlay;

  /// Shown when there are no recordings for [sentenceId]. Defaults to the
  /// localized per-sentence string.
  final String? emptyMessage;

  /// "Take N · 3:42 PM" — derived from list order + created_at (not stored).
  String _label(BuildContext context, ListeningRecording rec, int index) {
    final n = 'Take ${index + 1}';
    final at = rec.createdAt;
    if (at == null) return n;
    return '$n · ${TimeOfDay.fromDateTime(at.toLocal()).format(context)}';
  }

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
            final filteredData = data
                .where((e) => e.sentenceId == widget.sentenceId)
                .toList();
            if (filteredData.isEmpty) {
              return Center(
                child: Text(
                  widget.emptyMessage ??
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
                final label = widget._label(context, data, index);
                final isPlaying =
                    widget.currentIndex == index && widget.audioPlayer.playing;
                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => widget.onTogglePlay(data, index),
                    child: SizedBox(
                      height: 60,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
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
                                label,
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
                            const SizedBox(width: 4),
                            InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return DeleteRecordedAudioDialog(
                                      data: data,
                                      label: label,
                                      onDeleted: (success) {
                                        if (success) {
                                          widget.userRecordedSentenceAudioBloc
                                              .add(
                                            UserRecordedSentenceAudioEvent.load(
                                              listeningId: widget.listeningId,
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
