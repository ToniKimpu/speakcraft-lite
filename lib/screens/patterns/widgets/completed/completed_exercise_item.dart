import 'package:flutter/material.dart';
import 'package:pmp_english/model/exercise/exercise.dart';

import '../../../../config/pmp_routes.dart';
import '../../../../config/pmp_text_styles.dart';

class CompletedExerciseItem extends StatelessWidget {
  const CompletedExerciseItem({
    super.key,
    required this.exercise,
  });
  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            PmpRoutes.patternPracticeResultScreen,
            arguments: {
              'exercise_id': exercise.id,
            },
          );
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
                  color: Colors.white,
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
                      PmpTextStyles.body2Regular.copyWith(color: Colors.white),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              const Icon(
                Icons.chevron_right,
                size: 20,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
