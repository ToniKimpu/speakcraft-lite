import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmp_english/bloc/youtube_player/youtube_player_bloc.dart';
import 'package:pmp_english/config/pmp_colors.dart';
import 'package:pmp_english/shared_widgets/line_with_text.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../config/pmp_text_styles.dart';
import '../../../model/listening_practice_answer/listening_practice_answer.dart';
import '../../../model/listening_question/listening_question.dart';

class UserAnswerDetailSheet extends StatelessWidget {
  const UserAnswerDetailSheet({
    super.key,
    required this.index,
    required this.listeningQuestion,
    required this.listeningPracticeAnswer,
    required this.onPlayAudio,
    required this.controller,
    required this.youtubePlayerBloc,
  });

  final int index;
  final ListeningQuestion listeningQuestion;
  final ListeningPracticeAnswer listeningPracticeAnswer;
  final VoidCallback onPlayAudio;
  final YoutubePlayerController controller;
  final YoutubePlayerBloc youtubePlayerBloc;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BlocBuilder<YoutubePlayerBloc, YoutubePlayerState>(
      builder: (context, state) {
        final playerState = state.maybeWhen(
          onUpdatePlayerState: (playerState) => playerState,
          orElse: () => null,
        );
        bool loading =
            playerState == PlayerState.buffering || !controller.value.isReady;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: colorScheme.outlineVariant),
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Question $index',
                      style: PmpTextStyles.label2Regular
                          .copyWith(color: colorScheme.onSurface),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(100),
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Ink(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colorScheme.surface,
                        ),
                        child: Icon(
                          Icons.expand_more,
                          size: 16,
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                _buildPlayButton(context, loading),
                const SizedBox(height: 12),
                LineWithText(englishText: listeningQuestion.text),
                const SizedBox(height: 6),
                Text(
                  listeningQuestion.question,
                  style: PmpTextStyles.body1Regular.copyWith(
                    color: colorScheme.onSurface,
                    fontFamily: "ArchivoBlack Regular",
                  ),
                ),
                const SizedBox(height: 8),
                ...List.generate(
                  listeningQuestion.answers.length,
                  (i) {
                    final answerOption = listeningQuestion.answers[i];
                    final isUserAnswer = answerOption.answer ==
                        listeningPracticeAnswer.userAnswer;
                    IconData? icon;
                    Color? bgColor;

                    if (listeningPracticeAnswer.isCorrect && isUserAnswer) {
                      icon = Icons.check;
                      bgColor = PmpColors.success400;
                    } else if (!listeningPracticeAnswer.isCorrect &&
                        isUserAnswer) {
                      icon = Icons.close;
                      bgColor = PmpColors.destructive400;
                    } else if (answerOption.correct) {
                      icon = Icons.check;
                      bgColor = PmpColors.success400;
                    }

                    return Column(
                      children: [
                        _buildOption(context, answerOption, icon, bgColor),
                        if (i != listeningQuestion.answers.length - 1)
                          const SizedBox(height: 12),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPlayButton(BuildContext context, bool loading) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onPlayAudio,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: colorScheme.outline, width: 1),
          color: colorScheme.surface,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: colorScheme.primary,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: loading
                    ? SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          color: colorScheme.onPrimary,
                          strokeWidth: 2,
                        ),
                      )
                    : Icon(
                        controller.value.playerState == PlayerState.ended
                            ? Icons.replay
                            : controller.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                        color: colorScheme.onPrimary,
                        size: 20,
                      ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'Play Audio',
              style: PmpTextStyles.body2Semi
                  .copyWith(color: colorScheme.onSurface),
            ),
            const SizedBox(width: 6),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(
    BuildContext context,
    AnswerOption answerOption,
    IconData? leadingIcon,
    Color? bgColor,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: bgColor ?? colorScheme.surface,
            border: Border.all(color: colorScheme.outlineVariant),
          ),
          child: leadingIcon == null
              ? const SizedBox()
              : Center(
                  child: Icon(leadingIcon, color: Colors.white, size: 13),
                ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: bgColor ?? colorScheme.surface,
              border: Border.all(color: colorScheme.outlineVariant),
            ),
            padding: const EdgeInsets.all(16),
            child: Text(
              answerOption.answer,
              style: TextStyle(
                fontSize: 14,
                color: bgColor != null ? Colors.white : colorScheme.onSurface,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
