import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmp_english/config/common_extensions.dart';
import 'package:pmp_english/model/pattern_exercise/pattern_exercise.dart';
import 'package:pmp_english/screens/days/widgets/spoken_pattern_exercise_widget.dart';

import '../../bloc/day/day_bloc.dart';
import '../../bloc/exercise/exercise_bloc.dart';
import '../../bloc/exercise_user_answer/exercise_user_answer_bloc.dart';
import '../../bloc/pattern_exercise/pattern_exercise_bloc.dart';
import '../../config/pmp_routes.dart';
import '../../model/day/day.dart';
import '../../model/exercise/exercise.dart';
import '../../model/exercise_user_answer/exercise_user_answer.dart';
import 'widgets/countdown_circle.dart';

class SpokenPatternExerciseScreen extends StatefulWidget {
  const SpokenPatternExerciseScreen({
    super.key,
    required this.exercise,
    required this.day,
    required this.isLastIndex,
  });
  final Exercise exercise;
  final Day day;
  final bool isLastIndex;

  @override
  State<SpokenPatternExerciseScreen> createState() =>
      _SpokenPatternExerciseScreenState();
}

class _SpokenPatternExerciseScreenState
    extends State<SpokenPatternExerciseScreen> {
  late final PatternExerciseBloc _patternExerciseBloc;
  late final ExerciseUserAnswerBloc _exerciseUserAnswerBloc;

  late final PageController _pageController;
  int _currentPage = 0;

  final _userFullAnswerNotifier = ValueNotifier<String>("");
  double availableWidth = 0;

  int _totalExercise = -1;
  PatternExercise? _currentPatternExercise;
  final _exerciseWithAnswers = <PatternExercise>[];
  final _userAnswers = <ExerciseUserAnswer>[];

  final _countdownController = CountdownController();

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
    _patternExerciseBloc = PatternExerciseBloc()
      ..add(PatternExerciseEvent.loadPatternExercises(widget.exercise.id));
    _exerciseUserAnswerBloc = ExerciseUserAnswerBloc();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _countdownController.start();
      },
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _userFullAnswerNotifier.dispose();
    super.dispose();
  }

  void _goToNextPage(int page) {
    if (page >= _totalExercise) return;
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    setState(() => _currentPage = page);
    _countdownController.reset();
    _countdownController.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () => Navigator.pop(context),
              child: Ink(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.orangeAccent.withValues(alpha: 0.1),
                ),
                child: Center(
                  child: Icon(
                    Icons.close,
                    color: Colors.orangeAccent.withValues(alpha: 0.8),
                    size: 24,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),

            // 🔹 Progress Bar
            Expanded(
              child: LinearProgressIndicator(
                borderRadius: BorderRadius.circular(4),
                value: _totalExercise == -1
                    ? 0
                    : (_currentPage + 1) /
                        (_totalExercise == 0 ? 1 : _totalExercise),
                minHeight: 8,
                backgroundColor: Colors.orangeAccent.withValues(alpha: 0.2),
                color: Colors.orangeAccent,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              '${_currentPage + 1}/$_totalExercise',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontFamily: 'ArchivoBlack Regular',
                shadows: [
                  Shadow(
                    offset: Offset(1, 1),
                    blurRadius: 2,
                    color: Colors.deepOrangeAccent,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: BlocListener<ExerciseUserAnswerBloc, ExerciseUserAnswerState>(
        bloc: _exerciseUserAnswerBloc,
        listener: (context, state) {
          state.whenOrNull(
            loading: () {
              context.showLoadingDialog(message: "saving...");
            },
            onSuccess: () {
              context.hideLoadingDialog();
              if (widget.isLastIndex) {
                context.read<DayBloc>().add(const DayEvent.loadDays());
              } else {
                context.read<ExerciseBloc>().add(
                      ExerciseEvent.loadExercises(widget.day.id),
                    );
              }
              Navigator.pushReplacementNamed(
                context,
                PmpRoutes.patternExerciseResultScreen,
                arguments: {
                  'pattern_exercises': _exerciseWithAnswers,
                },
              );
            },
          );
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            availableWidth = constraints.maxWidth - 32;
            return Column(
              children: [
                // 🔸 Scrollable top section
                Expanded(
                  child:
                      BlocConsumer<PatternExerciseBloc, PatternExerciseState>(
                    bloc: _patternExerciseBloc,
                    listener: (context, state) {
                      state.maybeWhen(
                        loaded: (patternExercises) {
                          setState(() {
                            _totalExercise = patternExercises.length;
                            _currentPatternExercise =
                                patternExercises[_currentPage];
                          });
                        },
                        orElse: () => -1,
                      );
                    },
                    builder: (context, state) {
                      return state.maybeWhen(
                        loading: () {
                          return const Center(
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                        loaded: (patternExercises) {
                          return PageView.builder(
                            controller: _pageController,
                            itemCount: patternExercises.length,
                            padEnds: false,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              _currentPatternExercise = patternExercises[index];
                              return SpokenPatternExerciseWidget(
                                patternExercise: _currentPatternExercise!,
                                availableWidth: availableWidth,
                                onAnswerChanged: (userAnswers) {
                                  _userFullAnswerNotifier.value = userAnswers;
                                },
                              );
                            },
                          );
                        },
                        orElse: () => const SizedBox.shrink(),
                      );
                    },
                  ),
                ),
                // 🔸 Fixed bottom confirm row
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 16, left: 16, right: 16),
                  child: Row(
                    children: [
                      CountdownCircle(
                        start: 20,
                        controller: _countdownController,
                        onComplete: () {
                          if (_currentPage >= _totalExercise) {
                            _countdownController.reset();
                            _countdownController.stop();
                            return;
                          }
                          _exerciseWithAnswers.add(
                            _currentPatternExercise!.copyWith(
                              userAnswer: _userFullAnswerNotifier.value,
                            ),
                          );
                          _userFullAnswerNotifier.value = "";
                          _goToNextPage(_currentPage + 1);
                        },
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ValueListenableBuilder<String>(
                            valueListenable: _userFullAnswerNotifier,
                            builder: (context, userAnswer, child) {
                              return InkWell(
                                borderRadius: BorderRadius.circular(22),
                                onTap: () {
                                  _exerciseWithAnswers.add(
                                    _currentPatternExercise!.copyWith(
                                      userAnswer: userAnswer,
                                    ),
                                  );
                                  _userAnswers.add(
                                    ExerciseUserAnswer(
                                      patternExerciseId:
                                          _currentPatternExercise!.id,
                                      userAnswer: userAnswer,
                                    ),
                                  );
                                  if (_currentPage >= _totalExercise - 1) {
                                    _countdownController.reset();
                                    _countdownController.stop();
                                    final isPassed = _checkOverallResult();
                                    _userFullAnswerNotifier.value = "";
                                    if (isPassed) {
                                      Navigator.pushReplacementNamed(
                                        context,
                                        PmpRoutes.patternExerciseResultScreen,
                                        arguments: {
                                          'pattern_exercises':
                                              _exerciseWithAnswers,
                                        },
                                      );
                                      // _exerciseUserAnswerBloc.add(
                                      //   ExerciseUserAnswerEvent
                                      //       .addUserAnswerList(
                                      //     _userAnswers,
                                      //     widget.exercise,
                                      //     widget.isLastIndex,
                                      //   ),
                                      // );
                                    } else {
                                      Navigator.pushReplacementNamed(
                                        context,
                                        PmpRoutes.patternExerciseResultScreen,
                                        arguments: {
                                          'pattern_exercises':
                                              _exerciseWithAnswers,
                                        },
                                      );
                                    }

                                    return;
                                  }
                                  _userFullAnswerNotifier.value = "";
                                  _goToNextPage(_currentPage + 1);
                                },
                                child: Ink(
                                  height: 44,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(22),
                                    color: userAnswer.isNotEmpty
                                        ? Colors.deepOrangeAccent
                                        : Colors.deepOrangeAccent
                                            .withValues(alpha: 0.6),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Confirm",
                                      style: TextStyle(
                                        color: userAnswer.isNotEmpty
                                            ? Colors.white
                                            : Colors.white
                                                .withValues(alpha: 0.4),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'ArchivoBlack Regular',
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  bool _checkOverallResult() {
    int total = _exerciseWithAnswers.length;
    int correctCount = 0;
    for (final exercise in _exerciseWithAnswers) {
      final userAnswer = exercise.userAnswer!.trim().toLowerCase();
      final correctAnswer = exercise.englishText.trim().toLowerCase();
      if (userAnswer == correctAnswer) {
        correctCount++;
      }
    }
    final double percentage = (correctCount / total) * 100;
    if (percentage >= 70) {
      return true;
    } else {
      return false;
    }
  }
}
