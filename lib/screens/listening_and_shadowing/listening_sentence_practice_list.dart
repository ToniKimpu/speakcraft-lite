import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmp_english/core/logger/app_logger.dart';
import 'package:pmp_english/bloc/subtitle_detail/subtitle_detail_bloc.dart';
import 'package:pmp_english/config/pmp_routes.dart';
import 'package:pmp_english/model/listening/listening.dart';
import 'package:pmp_english/model/listening_question/listening_question.dart';

import '../../config/grade_utils.dart';
import '../../config/pmp_colors.dart';
import '../../config/pmp_text_styles.dart';

class ListeningSentencePracticeList extends StatefulWidget {
  const ListeningSentencePracticeList({
    super.key,
    required this.listening,
  });
  final Listening listening;

  @override
  State<ListeningSentencePracticeList> createState() =>
      _ListeningSentencePracticeListState();
}

class _ListeningSentencePracticeListState
    extends State<ListeningSentencePracticeList> {

  List<List<ListeningQuestion>> groupListeningQuestions(
      List<ListeningQuestion> listeningQuestions) {
    const int groupSize = 10;
    final List<List<ListeningQuestion>> groups = [];

    for (int i = 0; i < listeningQuestions.length; i += groupSize) {
      int end = (i + groupSize < listeningQuestions.length)
          ? i + groupSize
          : listeningQuestions.length;
      groups.add(listeningQuestions.sublist(i, end));
    }

    // if last group < 5 → merge into previous
    if (groups.length > 1 && groups.last.length < 5) {
      final lastGroup = groups.removeLast();
      groups.last.addAll(lastGroup);
    }
    return groups;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SubtitleBloc()
        ..add(SubtitleEvent.parseListeningQuestion(widget.listening)),
      child: Scaffold(
          appBar: AppBar(),
          body: BlocBuilder<SubtitleBloc, SubtitleState>(
            builder: (context, state) {
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
                onParseListeningQuestionCompleted:
                    (listeningQuestions, userAnswers) {
                  AppLogger.instance.debug(
                      "_listeningSentencePracticeListLogs: ${userAnswers.length} total userAnswers!");
                  final groupedListeningQuestions =
                      groupListeningQuestions(listeningQuestions);

                  // Find index of the first group that has no answers — this will be the current group
                  final currentGroupIndex =
                      groupedListeningQuestions.indexWhere((group) {
                    final groupId =
                        "${widget.listening.youtubeId}_group_${groupedListeningQuestions.indexOf(group) + 1}";
                    return userAnswers
                        .where((e) => e.groupId == groupId)
                        .isEmpty;
                  });
                  return ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: groupedListeningQuestions.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final groupId =
                          "${widget.listening.youtubeId}_group_${index + 1}";
                      final groupUserAnswers = userAnswers
                          .where((e) => e.groupId == groupId)
                          .toList();

                      final isCompleted = groupUserAnswers.isNotEmpty;
                      final isCurrent = index == currentGroupIndex;
                      final locked =
                          index > currentGroupIndex && currentGroupIndex != -1;

                      IconData icon;
                      if (isCompleted) {
                        icon = Icons.check;
                      } else if (isCurrent) {
                        icon = Icons.play_arrow_rounded;
                      } else {
                        icon = Icons.lock;
                      }
                      String scoreLevel = '';
                      Color leadingColor;
                      if (isCompleted) {
                        int total = groupUserAnswers.length;
                        final correctCount = groupUserAnswers
                            .where((answer) => answer.isCorrect)
                            .toList()
                            .length;
                        final percentage =
                            total == 0 ? 0.0 : (correctCount / total) * 100;
                        leadingColor = getGradeColor(calculateGrade(percentage));
                        scoreLevel = calculateGrade(percentage);
                      } else {
                        leadingColor = Colors.white.withValues(alpha: 0.08);
                      }
                      final borderColor = isCurrent
                          ? Colors.white
                          : Colors.white.withValues(alpha: 0.2);

                      return InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: locked
                            ? null
                            : () async {
                                final listeningQuestions =
                                    groupedListeningQuestions[index];
                                if (isCompleted) {
                                  Navigator.pushNamed(
                                    context,
                                    PmpRoutes.listeningPracticeResultPage,
                                    arguments: {
                                      "listening": widget.listening,
                                      "listening_answers": groupUserAnswers,
                                      "listening_questions": listeningQuestions,
                                    },
                                  );
                                  return;
                                }
                                await Navigator.pushNamed(
                                  context,
                                  PmpRoutes.listeningSentencePracticePage,
                                  arguments: {
                                    'listening': widget.listening,
                                    'listening_questions': listeningQuestions,
                                    'complete': isCompleted,
                                    'group_id': groupId,
                                  },
                                );
                                if (context.mounted) _reload(context);
                              },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: borderColor,
                              width: isCurrent ? 2 : 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  // color: isCompleted
                                  //     ? PmpColors.destructive500
                                  //     : Colors.white.withValues(alpha: 0.08),
                                  color: leadingColor,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: borderColor),
                                ),
                                child: Center(
                                  child: isCompleted
                                      ? Text(
                                          scoreLevel,
                                          style: PmpTextStyles.body1Semi
                                              .copyWith(color: PmpColors.white),
                                        )
                                      : Icon(icon, size: 18),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  "Practice ${index + 1}",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                    fontFamily: 'ArchivoBlack Regular',
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              if (isCompleted)
                                const Icon(
                                  Icons.chevron_right,
                                  color: Colors.white,
                                  size: 18,
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                orElse: () => Container(),
              );
            },
          ),
      ),
    );
  }

  void _reload(BuildContext context) {
    context.read<SubtitleBloc>()
        .add(SubtitleEvent.parseListeningQuestion(widget.listening));
  }

}
