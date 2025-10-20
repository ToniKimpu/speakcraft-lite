import 'package:flutter/material.dart';
import 'package:pmp_english/config/pmp_routes.dart';
import 'package:pmp_english/model/day/day.dart';
import 'package:pmp_english/model/exercise/exercise.dart';

import '../../../config/pmp_text_styles.dart';

class ExerciseItem extends StatelessWidget {
  const ExerciseItem({
    super.key,
    required this.exercise,
    this.day,
    this.isOpenIndex = false,
    this.isLastIndex = false,
    this.showStatus =
        true, // ✅ allow hiding status icon (for pure list display)
  });

  final Exercise exercise;
  final Day? day;
  final bool isOpenIndex;
  final bool isLastIndex;
  final bool showStatus;

  void _onTap(BuildContext context) {
    if (exercise.isComplete) {
      Navigator.pushNamed(
        context,
        PmpRoutes.patternPracticeResultScreen,
        arguments: {
          'exercise_id': exercise.id,
        },
      );
      return;
    }
    if (isOpenIndex && day != null) {
      Navigator.pushNamed(
        context,
        PmpRoutes.spokenPatternExercisePage,
        arguments: {
          'exercise': exercise,
          'day': day!,
          'is_last_index': isLastIndex,
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _onTap(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  exercise.exerciseName,
                  style:
                      PmpTextStyles.body2Regular.copyWith(color: Colors.white),
                ),
              ),
              const SizedBox(width: 8),
              if (showStatus) // ✅ only show if needed
                Icon(
                  exercise.isComplete
                      ? Icons.check_circle
                      : isOpenIndex
                          ? Icons.chevron_right
                          : Icons.lock,
                  size: (exercise.isComplete || !isOpenIndex) ? 20 : null,
                  color: exercise.isComplete
                      ? Colors.green
                      : isOpenIndex
                          ? Colors.white
                          : Colors.red,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
