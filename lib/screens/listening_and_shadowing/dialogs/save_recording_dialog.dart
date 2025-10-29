import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmp_english/bloc/user_recorded_sentence_audio/user_recorded_sentence_audio_bloc.dart';
import 'package:pmp_english/config/pmp_text_styles.dart';
import 'package:pmp_english/model/user_recorded_sentence_audio/user_recorded_sentence_audio.dart';
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
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      backgroundColor: Colors.transparent, // removes white edges
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
              gradient: const LinearGradient(
                colors: [Color(0xFF203A43), Color(0xFF2C5364)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(width: 1.5, color: Colors.white),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Title
                Text(
                  "Save your recording?",
                  textAlign: TextAlign.center,
                  style: PmpTextStyles.body1Regular.copyWith(
                    color: Colors.white,
                    fontFamily: 'ArchivoBlack Regular',
                    fontSize: 20,
                    letterSpacing: 0.5,
                  ),
                ),

                const SizedBox(height: 16),
                // Text Field Label
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Recording name",
                    style: PmpTextStyles.body2Regular.copyWith(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // Text Field
                PracticeTextField(
                  controller: _nameController,
                  englishOnly: true,
                ),

                const SizedBox(height: 24),

                // Divider
                Divider(
                  color: Colors.white.withOpacity(0.3),
                  thickness: 1,
                  height: 1,
                ),

                const SizedBox(height: 16),
                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white70,
                          overlayColor: Colors.white12,
                        ),
                        child: const Text("Cancel"),
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 24,
                      color: Colors.white.withOpacity(0.2),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          // discard logic
                          widget.onDiscard.call();
                          Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.orangeAccent,
                          overlayColor: Colors.white12,
                        ),
                        child: const Text("Discard"),
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 24,
                      color: Colors.white.withOpacity(0.2),
                    ),
                    Expanded(
                      child: loading
                          ? const Center(
                              child: SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
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
                                  audioPath: audioPath ?? "",
                                  audioName: audioName,
                                );

                                debugPrint(
                                    "_onUserSavedData: ${data.toJson()} saved data!");
                                _saveUserRecordedVoiceBloc.add(
                                  UserRecordedSentenceAudioEvent.insert(data),
                                );
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.lightGreenAccent,
                                overlayColor: Colors.white12,
                              ),
                              child: const Text("Save"),
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
