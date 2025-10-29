import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmp_english/bloc/user_recorded_sentence_audio/user_recorded_sentence_audio_bloc.dart';
import 'package:pmp_english/config/pmp_text_styles.dart';
import 'package:pmp_english/model/user_recorded_sentence_audio/user_recorded_sentence_audio.dart';

class DeleteRecordedAudioDialog extends StatelessWidget {
  DeleteRecordedAudioDialog({
    super.key,
    required this.data,
    required this.onDeleted,
  });

  final UserRecordedSentenceAudio data;
  final Function(bool success) onDeleted;
  final _deleteUserRecordedVoiceBloc = UserRecordedSentenceAudioBloc();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: BlocConsumer<UserRecordedSentenceAudioBloc,
          UserRecordedSentenceAudioState>(
        bloc: _deleteUserRecordedVoiceBloc,
        listener: (context, state) {
          state.maybeWhen(
            success: (_) {
              onDeleted(true);
              Navigator.pop(context);
            },
            error: (_) {
              onDeleted(false);
              Navigator.pop(context);
            },
            orElse: () => null,
          );
        },
        builder: (context, state) {
          final isLoading = state.maybeWhen(
            loading: (_) => true,
            success: (data) => true,
            orElse: () => false,
          );

          return Container(
            clipBehavior: Clip.antiAlias,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                // colors: [Color(0xFF1E293B), Color(0xFF334155)],
                colors: [Color(0xFF203A43), Color(0xFF2C5364)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.white, width: 1.2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 🔥 Warning Icon
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.redAccent.withOpacity(0.15),
                    border: Border.all(color: Colors.redAccent, width: 1.2),
                  ),
                  child: const Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.redAccent,
                    size: 40,
                  ),
                ),

                const SizedBox(height: 16),

                // 📝 Title
                Text(
                  "Delete Recording?",
                  textAlign: TextAlign.center,
                  style: PmpTextStyles.body1Regular.copyWith(
                    color: Colors.white,
                    fontFamily: 'ArchivoBlack Regular',
                    fontSize: 20,
                    letterSpacing: 0.5,
                  ),
                ),

                const SizedBox(height: 8),

                // 💬 Subtitle
                Text(
                  "This will permanently remove your recorded audio:",
                  textAlign: TextAlign.center,
                  style: PmpTextStyles.body2Regular.copyWith(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 12),

                // 🎧 Audio name display
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                    ),
                  ),
                  child: Text(
                    data.audioName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                Row(
                  children: [
                    // Cancel Button
                    Expanded(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () => Navigator.pop(context),
                          child: Ink(
                            height: 44,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.5),
                              ),
                              color: Colors.white.withOpacity(0.1),
                            ),
                            child: Center(
                              child: Text(
                                "Keep It",
                                style: PmpTextStyles.body1Regular.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Delete Button
                    Expanded(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: isLoading
                              ? null
                              : () {
                                  _deleteUserRecordedVoiceBloc.add(
                                    UserRecordedSentenceAudioEvent.delete(
                                      data,
                                    ),
                                  );
                                },
                          child: Ink(
                            height: 44,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: isLoading
                                  ? Colors.redAccent.withOpacity(0.5)
                                  : Colors.redAccent,
                              boxShadow: [
                                if (!isLoading)
                                  BoxShadow(
                                    color: Colors.redAccent.withOpacity(0.4),
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  ),
                              ],
                            ),
                            child: Center(
                              child: isLoading
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    )
                                  : Text(
                                      "Delete",
                                      style:
                                          PmpTextStyles.body1Regular.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          ),
                        ),
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
