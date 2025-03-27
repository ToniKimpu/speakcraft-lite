import 'package:flutter/material.dart';
import 'package:pmp_english/screens/patterns/widgets/completed/completed_exercise_item.dart';
import 'package:pmp_english/screens/patterns/widgets/completed/completed_lesson_item.dart';

import '../../../../config/pmp_colors.dart';
import '../../../../config/pmp_text_styles.dart';
import '../../../../model/day/day.dart';

class CompletedDayWidget extends StatelessWidget {
  const CompletedDayWidget({
    super.key,
    required this.day,
  });

  final Day day;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08), // Dark card with transparency
        borderRadius: BorderRadius.circular(16),
        border:
            Border.all(color: Colors.white.withOpacity(0.2)), // Subtle border
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Day ${day.orderNumber}',
                  style: PmpTextStyles.body1Regular.copyWith(
                    color: PmpColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.check,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 1,
            width: double.infinity,
            color: Colors.white.withOpacity(0.1),
            margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          ),
          ...day.lessons.map((lesson) => CompletedLessonItem(lesson: lesson)),
          if (day.exercises.isNotEmpty)
            Container(
              height: 1,
              width: double.infinity,
              color: Colors.white.withOpacity(0.1),
              margin: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 12,
              ),
            ),
          ...day.exercises.map(
            (exercise) => CompletedExerciseItem(
              exercise: exercise,
            ),
          ),
        ],
      ),
    );
  }
}
