import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speakcraft/bloc/user_recorded_sentence_audio/user_recorded_sentence_audio_bloc.dart';
import 'package:speakcraft/config/pmp_colors.dart';
import 'package:speakcraft/config/pmp_text_styles.dart';
import 'package:speakcraft/core/logger/app_logger.dart';
import 'package:speakcraft/l10n/generated/l10n.dart';
import 'package:speakcraft/model/user_recorded_sentence_audio/user_recorded_sentence_audio.dart';
import 'package:record/record.dart';

import '../../../shared_widgets/practice_text_field.dart';

class SaveRecordingDialog extends StatefulWidget {
  const SaveRecordingDialog({
    super.key,
    required this.sentenceId,
    required this.youtubeId,
    required this.audioName,
    required this.audioRecorder,
    required this.onSaved,
    required this.onDiscard,
  });
  final String sentenceId;
  final String youtubeId;
  final String audioName;
  final AudioRecorder audioRecorder;
  final Function(bool success) onSaved;
  final VoidCallback onDiscard;

  @override
  State<SaveRecordingDialog> createState() => _SaveRecordingDialogState();
}

class _SaveRecordingDialogState extends State<SaveRecordingDialog> {
  late final TextEditingController _nameController;
  final _saveUserRecordedVoiceBloc = UserRecordedSentenceAudioBloc();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.audioName);
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
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
            success: (data) {
              widget.onSaved(true);
              Navigator.pop(context);
            },
            error: (message) {
              widget.onSaved(false);
              Navigator.pop(context);
            },
            orElse: () => -1,
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
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppLocalizations.of(context).txtRecordingName,
                    style: PmpTextStyles.body2Regular.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                PracticeTextField(
                  controller: _nameController,
                  englishOnly: true,
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
                                final audioName =
                                    _nameController.text.trim().isEmpty
                                        ? widget.audioName
                                        : _nameController.text.trim();
                                final audioPath =
                                    await widget.audioRecorder.stop();
                                final data = UserRecordedSentenceAudio(
                                  sentenceId: widget.sentenceId,
                                  youtubeId: widget.youtubeId,
                                  audioPath: audioPath ?? '',
                                  audioName: audioName,
                                );

                                AppLogger.instance.debug(
                                    "_onUserSavedData: ${data.toJson()} saved data!");
                                _saveUserRecordedVoiceBloc.add(
                                  UserRecordedSentenceAudioEvent.insert(data),
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
