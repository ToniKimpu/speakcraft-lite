import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speakcraft/bloc/user_recorded_sentence_audio/user_recorded_sentence_audio_bloc.dart';
import 'package:speakcraft/config/pmp_colors.dart';
import 'package:speakcraft/config/pmp_text_styles.dart';
import 'package:speakcraft/l10n/generated/l10n.dart';
import 'package:record/record.dart';

/// Confirm-and-save sheet for a fresh take. Takes are auto-labelled "Take N" at
/// display time (from order + created_at), so there is no name to enter — Save
/// just uploads the take and lets the cap (free 1 / premium 5) apply.
class SaveRecordingDialog extends StatefulWidget {
  const SaveRecordingDialog({
    super.key,
    required this.listeningId,
    required this.sentenceId,
    required this.audioRecorder,
    required this.onSaved,
    required this.onDiscard,
  });
  final int listeningId;
  final String sentenceId;
  final AudioRecorder audioRecorder;
  final Function(bool success) onSaved;
  final VoidCallback onDiscard;

  @override
  State<SaveRecordingDialog> createState() => _SaveRecordingDialogState();
}

class _SaveRecordingDialogState extends State<SaveRecordingDialog> {
  final _saveUserRecordedVoiceBloc = UserRecordedSentenceAudioBloc();

  @override
  void dispose() {
    _saveUserRecordedVoiceBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      backgroundColor: Colors.transparent,
      child: BlocConsumer<UserRecordedSentenceAudioBloc,
          UserRecordedSentenceAudioState>(
        bloc: _saveUserRecordedVoiceBloc,
        listener: (context, state) {
          state.maybeWhen(
            success: () {
              widget.onSaved(true);
              Navigator.pop(context);
            },
            error: (message) {
              widget.onSaved(false);
              Navigator.pop(context);
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          final loading = state.maybeWhen(
            loading: (message) => true,
            orElse: () => false,
          );
          return Container(
            clipBehavior: Clip.antiAlias,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: colorScheme.outlineVariant),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context).txtSaveRecordingTitle,
                  textAlign: TextAlign.center,
                  style: PmpTextStyles.body1Regular.copyWith(
                    color: colorScheme.onSurface,
                    fontFamily: 'ArchivoBlack Regular',
                    fontSize: 20,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 24),
                Divider(
                  color: colorScheme.outlineVariant,
                  thickness: 1,
                  height: 1,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        style: TextButton.styleFrom(
                          foregroundColor: colorScheme.onSurfaceVariant,
                        ),
                        child: Text(AppLocalizations.of(context).txtCancel),
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 24,
                      color: colorScheme.outlineVariant,
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          widget.onDiscard.call();
                          Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: PmpColors.warning400,
                        ),
                        child: Text(AppLocalizations.of(context).txtDiscard),
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 24,
                      color: colorScheme.outlineVariant,
                    ),
                    Expanded(
                      child: loading
                          ? const Center(
                              child: SizedBox(
                                width: 18,
                                height: 18,
                                child:
                                    CircularProgressIndicator(strokeWidth: 2),
                              ),
                            )
                          : TextButton(
                              onPressed: () async {
                                final audioPath =
                                    await widget.audioRecorder.stop();
                                if (audioPath == null || audioPath.isEmpty) {
                                  widget.onSaved(false);
                                  if (context.mounted) Navigator.pop(context);
                                  return;
                                }
                                _saveUserRecordedVoiceBloc.add(
                                  UserRecordedSentenceAudioEvent.insert(
                                    listeningId: widget.listeningId,
                                    sentenceId: widget.sentenceId,
                                    file: File(audioPath),
                                  ),
                                );
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: PmpColors.success400,
                              ),
                              child: Text(AppLocalizations.of(context).txtSave),
                            ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
