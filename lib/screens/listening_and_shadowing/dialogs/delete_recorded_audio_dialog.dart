import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmp_english/bloc/user_recorded_sentence_audio/user_recorded_sentence_audio_bloc.dart';
import 'package:pmp_english/config/pmp_colors.dart';
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
    final colorScheme = Theme.of(context).colorScheme;
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
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: colorScheme.outlineVariant),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: PmpColors.destructive400.withValues(alpha: 0.15),
                    border: Border.all(
                        color: PmpColors.destructive400, width: 1.2),
                  ),
                  child: const Icon(
                    Icons.warning_amber_rounded,
                    color: PmpColors.destructive400,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Delete Recording?',
                  textAlign: TextAlign.center,
                  style: PmpTextStyles.body1Regular.copyWith(
                    color: colorScheme.onSurface,
                    fontFamily: 'ArchivoBlack Regular',
                    fontSize: 20,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'This will permanently remove your recorded audio:',
                  textAlign: TextAlign.center,
                  style: PmpTextStyles.body2Regular.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: colorScheme.outlineVariant),
                  ),
                  child: Text(
                    data.audioName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 44,
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Keep It'),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: SizedBox(
                        height: 44,
                        child: FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor: PmpColors.destructive400,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: isLoading
                              ? null
                              : () {
                                  _deleteUserRecordedVoiceBloc.add(
                                    UserRecordedSentenceAudioEvent.delete(
                                      data,
                                    ),
                                  );
                                },
                          child: isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Text('Delete'),
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
