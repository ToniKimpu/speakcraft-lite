import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmp_english/model/listening_question/listening_question.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../bloc/youtube_player/youtube_player_bloc.dart';
import '../../../config/pmp_colors.dart';
import '../../../config/pmp_text_styles.dart';
import '../../../model/listening_practice_answer/listening_practice_answer.dart';
import '../sheets/user_answer_detail_sheet.dart';

class UserAnswerListWidget extends StatelessWidget {
  const UserAnswerListWidget({
    super.key,
    required this.listeningQuestions,
    required this.listeningPracticeAnswers,
    required this.onPlayAudio,
    required this.controller,
    required this.youtubePlayerBloc,
  });
  final List<ListeningQuestion> listeningQuestions;
  final List<ListeningPracticeAnswer> listeningPracticeAnswers;
  final Function(ListeningQuestion listeningQuestion) onPlayAudio;
  final YoutubePlayerController controller;
  final YoutubePlayerBloc youtubePlayerBloc;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final question = listeningQuestions[index];
            final userAnswer = listeningPracticeAnswers[index];
            final correctAnswer = question.answers.firstWhere((e) => e.correct);

            final borderColor = getAnswerColor(
              userAnswer.userAnswer,
              correctAnswer.answer,
            );
            final leadingIconData = getLeadingIconData(
              userAnswer.userAnswer,
              correctAnswer.answer,
            );
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildQuestionItem(
                question,
                userAnswer,
                index,
                borderColor,
                leadingIconData,
                context,
              ),
            );
          },
          childCount: listeningQuestions.length,
        ),
      ),
    );
  }

  Color getAnswerColor(String? userAnswer, String correctAnswer) {
    if (userAnswer == null) {
      // User did not answer
      return PmpColors.warning400;
    } else if (userAnswer == correctAnswer) {
      // Correct answer
      return PmpColors.success400;
    } else {
      // Incorrect answer
      return PmpColors.destructive400;
    }
  }

  IconData getLeadingIconData(String? userAnswer, String correctAnswer) {
    if (userAnswer == null) {
      // User did not answer
      return Icons.schedule;
    } else if (userAnswer == correctAnswer) {
      // Correct answer
      return Icons.check;
    } else {
      // Incorrect answer
      return Icons.close;
    }
  }

  Widget _buildQuestionItem(
    ListeningQuestion question,
    ListeningPracticeAnswer userAnswer,
    int index,
    Color borderColor,
    IconData leadingIconData,
    BuildContext context,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Question ${index + 1}',
                style: PmpTextStyles.label2Regular
                    .copyWith(color: PmpColors.white),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (_) => BlocProvider.value(
                      value: youtubePlayerBloc,
                      child: UserAnswerDetailSheet(
                        index: index + 1,
                        listeningQuestion: question,
                        listeningPracticeAnswer: userAnswer,
                        controller: controller,
                        youtubePlayerBloc: youtubePlayerBloc,
                        onPlayAudio: () {
                          onPlayAudio.call(question);
                        },
                      ),
                    ),
                  ).then((value) {
                    controller.pause();
                  });
                },
                child: Ink(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.15),
                  ),
                  child: const Icon(Icons.expand_more, size: 16),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            question.question,
            style: PmpTextStyles.body1Regular.copyWith(
              color: PmpColors.white,
              fontFamily: "ArchivoBlack Regular",
            ),
          ),
          const SizedBox(height: 8),
          _buildOption(
            userAnswer.userAnswer,
            borderColor,
            leadingIconData,
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildOption(
      String? userAnswer, Color color, IconData leadingIconData) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          child: Center(
            child: Icon(
              leadingIconData,
              color: Colors.white,
              size: 13,
            ),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: color,
              border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      userAnswer ?? "Not Answer",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                      textAlign: userAnswer == null
                          ? TextAlign.center
                          : TextAlign.start,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
