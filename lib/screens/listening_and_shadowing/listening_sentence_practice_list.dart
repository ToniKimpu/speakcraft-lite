import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmp_english/bloc/subtitle_detail/subtitle_detail_bloc.dart';
import 'package:pmp_english/config/pmp_routes.dart';
import 'package:pmp_english/model/listening/listening.dart';
import 'package:pmp_english/model/listening_question/listening_question.dart';
import 'package:pmp_english/services/share_preference_utils.dart';

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
  final _subtitleBloc = SubtitleBloc();

  int _completedGroupCount = 0;

  @override
  void initState() {
    super.initState();
    _subtitleBloc.add(SubtitleEvent.parseListeningQuestion(widget.listening));
    _getCompletedCount();
  }

  void _getCompletedCount() async {
    _completedGroupCount =
        await SharedPreferenceUtils.getInt(widget.listening.youtubeId) ?? 0;
    setState(() {});
  }

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
      create: (context) => _subtitleBloc,
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
              onParseListeningQuestionCompleted: (listeningQuestions) {
                final groupedListeningQuestions =
                    groupListeningQuestions(listeningQuestions);
                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: groupedListeningQuestions.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final isCompleted = index < _completedGroupCount;
                    final isCurrent = index == _completedGroupCount;
                    final locked = index > _completedGroupCount;
                    IconData icon;
                    if (isCompleted) {
                      icon = Icons.check;
                    } else if (isCurrent) {
                      icon = Icons.play_arrow_rounded;
                    } else {
                      icon = Icons.lock;
                    }
                    final borderColor = isCurrent
                        ? Colors.white
                        : Colors.white.withValues(alpha: 0.2);
                    return InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: locked
                          ? null
                          : () async {
                              Navigator.pushNamed(
                                context,
                                PmpRoutes.listeningPracticeResultPage,
                              );
                              // final listeningQuestions =
                              //     groupedListeningQuestions[index];
                              // await Navigator.pushNamed(
                              //   context,
                              //   PmpRoutes.listeningSentencePracticePage,
                              //   arguments: {
                              //     'listening': widget.listening,
                              //     'listening_questions': listeningQuestions,
                              //     'complete': isCompleted,
                              //     'group_id':
                              //         "${widget.listening.youtubeId}_group_${index + 1}",
                              //   },
                              // );
                              // _getCompletedCount();
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
                                color: Colors.white.withValues(alpha: 0.08),
                                shape: BoxShape.circle,
                                border: Border.all(color: borderColor),
                              ),
                              child: Center(
                                child: Icon(
                                  icon,
                                  size: 18,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              "Practice ${index + 1}",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                                fontFamily: 'ArchivoBlack Regular',
                              ),
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
}
