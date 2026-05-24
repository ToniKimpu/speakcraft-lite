import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speakcraft/bloc/pattern_exercise/pattern_exercise_bloc.dart';
import 'package:speakcraft/model/pattern_exercise/pattern_exercise.dart';
import 'package:speakcraft/screens/days/widgets/exercise_result_label.dart';

import '../../config/pmp_colors.dart';
import '../../config/pmp_text_styles.dart';
import '../listening_and_shadowing/listening_practice_widgets/chart_label_widget.dart';
import '../listening_and_shadowing/listening_practice_widgets/listening_practice_result_chart.dart';
import '../listening_and_shadowing/listening_practice_widgets/score_level_widget.dart';

class PatternExerciseResultScreen extends StatefulWidget {
  const PatternExerciseResultScreen({
    super.key,
    this.patternExercises,
    this.exerciseId,
    this.pass,
  });

  final List<PatternExercise>? patternExercises;
  final int? exerciseId;
  final bool? pass;

  @override
  State<PatternExerciseResultScreen> createState() =>
      _PatternExerciseResultScreenState();
}

class _PatternExerciseResultScreenState
    extends State<PatternExerciseResultScreen> {
  int correctCount = 0;
  int inCorrectCount = 0;
  int notAnswerCount = 0;

  @override
  void initState() {
    super.initState();
    if (widget.exerciseId == null) {
      for (final exercise in widget.patternExercises!) {
        if (exercise.userAnswer?.isEmpty ?? true) {
          notAnswerCount++;
        } else if (exercise.userAnswer == exercise.englishText) {
          correctCount++;
        } else {
          inCorrectCount++;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (widget.exerciseId != null) {
      return BlocProvider(
        create: (context) => PatternExerciseBloc()
          ..add(PatternExerciseEvent.loadPatternExercisesWithAnswers(
              widget.exerciseId!)),
        child: BlocConsumer<PatternExerciseBloc, PatternExerciseState>(
          listener: (context, state) {
            state.maybeWhen(
              loaded: (patternExercises) {
                if (patternExercises.isEmpty) {
                  return;
                }
                for (final exercise in patternExercises) {
                  if (exercise.userAnswer?.isEmpty ?? true) {
                    notAnswerCount++;
                  } else if (exercise.userAnswer == exercise.englishText) {
                    correctCount++;
                  } else {
                    inCorrectCount++;
                  }
                }
              },
              orElse: () => Container(),
            );
          },
          builder: (context, state) {
            return state.maybeWhen(
              loading: () => const Center(
                child: SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(),
                ),
              ),
              loaded: (patternExercises) {
                if (patternExercises.isEmpty) {
                  return const Center(
                    child: Text('No result'),
                  );
                }
                return _buildResultList(patternExercises);
              },
              orElse: () => Container(),
            );
          },
        ),
      );
    }
    return _buildResultList(widget.patternExercises!);
  }

  _buildResultList(List<PatternExercise> patternExercises) {
    final colorScheme = Theme.of(context).colorScheme;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    ExerciseResultLabel(pass: widget.pass),
                    const SizedBox(height: 24),
                    ListeningPracticeResultChart(
                      correctCount: correctCount,
                      inCorrectCount: inCorrectCount,
                      notAnswerCount: notAnswerCount,
                    ),
                    const SizedBox(height: 18),
                    const ChartLabelWidget(),
                    const SizedBox(height: 32),
                    ScoreLevelWidget(
                      correctCount: correctCount,
                      inCorrectCount: inCorrectCount,
                      notAnswerCount: notAnswerCount,
                    ),
                    const SizedBox(height: 32),
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: colorScheme.outlineVariant,
                    ),
                  ],
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _StickyHeaderDelegate(
                minHeight: 50,
                maxHeight: 50,
                correctCount: correctCount,
                totalCount: patternExercises.length,
                pass: widget.pass,
                child: Text(
                  'Your Answers',
                  style: PmpTextStyles.body1Regular.copyWith(
                    color: colorScheme.onSurface,
                    fontFamily: "ArchivoBlack Regular",
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final patternExercise = patternExercises[index];
                    final borderColor = getAnswerColor(
                      patternExercise.userAnswer,
                      patternExercise.englishText,
                    );
                    final trialingIconData = getTrialingIconData(
                      patternExercise.userAnswer,
                      patternExercise.englishText,
                    );
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: borderColor,
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: colorScheme.shadow.withValues(alpha: 0.12),
                              blurRadius: 12,
                              spreadRadius: 0,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 12),
                            Text(
                              'Question ${index + 1}',
                              style: PmpTextStyles.label2Regular.copyWith(
                                  color: colorScheme.onSurfaceVariant),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              patternExercise.englishText,
                              style: PmpTextStyles.body1Regular.copyWith(
                                color: colorScheme.onSurface,
                                fontFamily: 'ArchivoBlack Regular',
                              ),
                            ),
                            Text(
                              patternExercise.burmeseText,
                              style: PmpTextStyles.body1Regular.copyWith(
                                color: colorScheme.onSurface,
                                fontFamily: 'MM Lyrics Bold',
                              ),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              height: 1,
                              width: double.infinity,
                              color: colorScheme.outlineVariant,
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    patternExercise.userAnswer == null ||
                                            patternExercise.userAnswer!.isEmpty
                                        ? "Not Answered"
                                        : patternExercise.userAnswer!,
                                    style: PmpTextStyles.body1Regular.copyWith(
                                      // color: PmpColors.white,
                                      color: Colors.orangeAccent,
                                      fontFamily: 'ArchivoBlack Regular',
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: borderColor),
                                  child: Center(
                                    child: Icon(
                                      trialingIconData,
                                      color: Colors.white,
                                      size: 13,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    );
                  },
                  childCount: patternExercises.length,
                ),
              ),
            ),
          ],
        ),
        Positioned(
          top: 8,
          right: 12,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () => Navigator.pop(context),
              child: Ink(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: colorScheme.inverseSurface,
                  border: Border.all(
                    color: colorScheme.outline,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.close,
                    color: colorScheme.onInverseSurface,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Color getAnswerColor(String? userAnswer, String correctAnswer) {
    if (userAnswer == null || userAnswer.isEmpty) {
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

  IconData getTrialingIconData(String? userAnswer, String correctAnswer) {
    if (userAnswer == null || userAnswer.isEmpty) {
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
}

class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final int correctCount;
  final int totalCount;
  final bool? pass;
  final Widget child;

  _StickyHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.correctCount,
    required this.totalCount,
    required this.pass,
    required this.child,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final bool isPinned = shrinkOffset > 0;
    return Container(
      color: isPinned
          ? (pass == null
              ? Colors.blue
              : pass == true
                  ? Colors.green
                  : Colors.deepOrangeAccent)
          : Colors.transparent,
      alignment: Alignment.center,
      child: !isPinned
          ? Text(
              'Your Answers',
              style: PmpTextStyles.body1Regular.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontFamily: "ArchivoBlack Regular",
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Your Answers',
                  style: PmpTextStyles.body1Regular.copyWith(
                    color: PmpColors.white,
                    fontFamily: "ArchivoBlack Regular",
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  '[$correctCount/$totalCount]',
                  style: PmpTextStyles.body1Regular.copyWith(
                    color: Colors.amberAccent,
                    fontFamily: "ArchivoBlack Regular",
                  ),
                )
              ],
            ),
    );
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant _StickyHeaderDelegate oldDelegate) {
    return oldDelegate.child != child ||
        oldDelegate.minHeight != minHeight ||
        oldDelegate.maxHeight != maxHeight;
  }
}
