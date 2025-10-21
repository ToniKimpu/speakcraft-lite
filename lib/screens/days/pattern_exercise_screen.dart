import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmp_english/bloc/day/day_bloc.dart';
import 'package:pmp_english/bloc/exercise/exercise_bloc.dart';
import 'package:pmp_english/bloc/exercise_user_answer/exercise_user_answer_bloc.dart';
import 'package:pmp_english/bloc/pattern_exercise/pattern_exercise_bloc.dart';
import 'package:pmp_english/config/common_extensions.dart';
import 'package:pmp_english/config/pmp_colors.dart';
import 'package:pmp_english/config/pmp_routes.dart';
import 'package:pmp_english/config/pmp_text_styles.dart';
import 'package:pmp_english/model/day/day.dart';
import 'package:pmp_english/model/exercise/exercise.dart';
import 'package:pmp_english/model/exercise_user_answer/exercise_user_answer.dart';
import 'package:pmp_english/model/pattern_exercise/pattern_exercise.dart';
import 'package:pmp_english/screens/days/widgets/practice_exercise_widget.dart';

import '../../l10n/generated/l10n.dart';

class PatternExerciseScreen extends StatefulWidget {
  const PatternExerciseScreen({
    super.key,
    required this.exercise,
    required this.day,
    required this.isLastIndex,
  });

  final Exercise exercise;
  final Day day;
  final bool isLastIndex;

  @override
  State<PatternExerciseScreen> createState() => _PatternExerciseScreenState();
}

class _PatternExerciseScreenState extends State<PatternExerciseScreen> {
  late final PatternExerciseBloc _patternExerciseBloc;
  late final ExerciseUserAnswerBloc _exerciseUserAnswerBloc;
  late final ValueNotifier<String?> _userAnswer;
  late List<FocusNode> _practiceNodes;

  final List<PatternExercise> _patternExercises = [];
  final List<ExerciseUserAnswer> _userAnswers = [];
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _patternExerciseBloc = PatternExerciseBloc()
      ..add(PatternExerciseEvent.loadPatternExercises(widget.exercise.id));
    _exerciseUserAnswerBloc = ExerciseUserAnswerBloc();
    _userAnswer = ValueNotifier<String?>(null);
    _practiceNodes = [];
  }

  @override
  void dispose() {
    for (var node in _practiceNodes) {
      node.dispose();
    }
    _userAnswer.dispose();
    super.dispose();
  }

  void _handlePageChange(int newPage) {
    setState(() {
      _currentPage = newPage;
    });
  }

  void _addUserAnswer(PatternExercise exercise, String? answer) {
    if (answer == null) return;
    _addOrUpdateExercise(exercise, answer);
    if (_currentPage < _practiceNodes.length - 1) {
      _handlePageChange(_currentPage + 1);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _userAnswer.value = null;
      });
    } else {
      FocusManager.instance.primaryFocus?.unfocus();
      for (final patternExercise in _patternExercises) {
        _userAnswers.add(
          ExerciseUserAnswer(
            patternExerciseId: patternExercise.id,
            userAnswer: patternExercise.userAnswer!,
          ),
        );
      }
      _exerciseUserAnswerBloc.add(
        ExerciseUserAnswerEvent.addUserAnswerList(
            _userAnswers, widget.exercise, widget.isLastIndex),
      );
    }
  }

  void _addOrUpdateExercise(PatternExercise exercise, String answer) {
    final index = _patternExercises.indexWhere((e) => e.id == exercise.id);

    if (index != -1) {
      _patternExercises[index] =
          _patternExercises[index].copyWith(userAnswer: answer);
    } else {
      _patternExercises.add(exercise.copyWith(userAnswer: answer));
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        if (_currentPage > 0) {
          setState(() {
            _currentPage--;
          });
          return;
        }
        Navigator.pop(context);
      },
      child: Scaffold(
        backgroundColor: PmpColors.primary100,
        appBar: AppBar(
          title: Text(widget.exercise.exerciseName),
          backgroundColor: const Color(0xFF0F2027),
          elevation: 0,
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => _patternExerciseBloc,
              ),
              BlocProvider(
                create: (context) => _exerciseUserAnswerBloc,
              ),
            ],
            child:
                BlocListener<ExerciseUserAnswerBloc, ExerciseUserAnswerState>(
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
                        'pattern_exercises': _patternExercises,
                        "pass": true,
                      },
                    );
                  },
                );
              },
              child: BlocBuilder<PatternExerciseBloc, PatternExerciseState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    loading: () => const Center(
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    loaded: (patternExercises) =>
                        _buildExerciseContent(patternExercises),
                    orElse: () => const SizedBox(),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExerciseContent(List<PatternExercise> exercises) {
    if (exercises.isEmpty) {
      return Center(
          child: Text(
        AppLocalizations.of(context).txtWillUploadSoon,
        style: PmpTextStyles.body1Regular.copyWith(color: PmpColors.white),
      ));
    }

    // Initialize FocusNodes only once
    if (_practiceNodes.isEmpty) {
      _practiceNodes = List.generate(exercises.length, (_) => FocusNode());
    }

    return Column(
      children: [
        Expanded(
          child: _buildExercisePageView(exercises),
        ),
        _buildFooter(exercises),
      ],
    );
  }

  Widget _buildExercisePageView(List<PatternExercise> exercises) {
    return IndexedStack(
      index: _currentPage,
      children: List.generate(exercises.length, (index) {
        if (index == _currentPage) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _practiceNodes[index].requestFocus();
          });
        }
        return PracticeExerciseWidget(
          focusNode: _practiceNodes[index],
          patternExercise: exercises[index],
          onUserInput: (value) {
            if (value.isNotEmpty) {
              _userAnswer.value = value;
            } else {
              _userAnswer.value = null;
            }
          },
        );
      }),
    );
  }

  Widget _buildFooter(List<PatternExercise> exercises) {
    return Card(
      elevation: 4, // Adds shadow effect
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      // color: const Color(0xFF0F2027),
      color: const Color(0xFF1C2C3C),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildPreviousButton(),
            _buildProgressIndicator(exercises.length),
            _buildNextButton(exercises),
          ],
        ),
      ),
    );
  }

  Widget _buildPreviousButton() {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: _currentPage > 0
          ? () {
              _userAnswer.value =
                  _patternExercises[_currentPage - 1].userAnswer;
              _handlePageChange(_currentPage - 1);
            }
          : null,
      child: Ink(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          gradient: _currentPage == 0
              ? const LinearGradient(
                  colors: [Colors.grey, Colors.grey], // Disabled state
                )
              : const LinearGradient(
                  colors: [
                    Color(0xFFFFD700), // Gold
                    Color(0xFFFFA500), // Deep Gold
                    Color(0xFFB8860B), // Dark Golden
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(
          Icons.chevron_left,
          color: _currentPage == 0
              ? Colors.black38
              : Colors.white, // White for contrast
          size: 28,
        ),
      ),
    );
  }

  Widget _buildProgressIndicator(int totalExercises) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFFFFD700), // Gold
            Color(0xFFFFA500), // Deep Gold/Orange
            Color(0xFFB8860B), // Dark Golden
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        '${_currentPage + 1} / $totalExercises',
        style: PmpTextStyles.body2Semi.copyWith(
          color: Colors.white, // White text for contrast
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 4,
              offset: const Offset(1, 1),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNextButton(List<PatternExercise> exercises) {
    return ValueListenableBuilder<String?>(
      valueListenable: _userAnswer,
      builder: (context, userAnswer, child) {
        return InkWell(
          borderRadius: BorderRadius.circular(100),
          onTap: userAnswer == null
              ? null
              : () => _addUserAnswer(exercises[_currentPage], userAnswer),
          child: Ink(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              gradient: userAnswer == null
                  ? const LinearGradient(
                      colors: [Colors.grey, Colors.grey], // Disabled state
                    )
                  : const LinearGradient(
                      colors: [
                        Color(0xFFFFD700), // Gold
                        Color(0xFFFFA500), // Deep Gold
                        Color(0xFFB8860B), // Dark Golden
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 3,
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              Icons.chevron_right,
              color: userAnswer == null
                  ? Colors.black38
                  : Colors.white, // White for contrast
              size: 28,
            ),
          ),
        );
      },
    );
  }
}
