import 'package:flutter/material.dart';
import 'package:pmp_english/config/pmp_routes.dart';
import 'package:pmp_english/model/day/day.dart';
import 'package:pmp_english/model/exercise/exercise.dart';

import '../../../../config/pmp_text_styles.dart';

class CurrentExerciseItem extends StatelessWidget {
  const CurrentExerciseItem({
    super.key,
    required this.exercise,
    required this.day,
    required this.isOpenIndex,
    required this.isLastIndex,
  });
  final Exercise exercise;
  final Day day;
  final bool isOpenIndex;
  final bool isLastIndex;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          if (exercise.isComplete || isOpenIndex) {
            Navigator.pushNamed(
              context,
              PmpRoutes.patternExerciseScreen,
              arguments: {
                'exercise': exercise,
                'day': day,
                'is_last_index': isLastIndex,
              },
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 12,
          ),
          child: Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Text(
                  exercise.exerciseName,
                  style:
                      PmpTextStyles.body2Regular.copyWith(color: Colors.black),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
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
                        ? Colors.black
                        : Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
