import 'package:flutter/material.dart';
import 'package:pmp_english/screens/patterns/widgets/exercise_item.dart';
import 'package:pmp_english/screens/patterns/widgets/lesson_item.dart';

import '../../../config/pmp_colors.dart';
import '../../../config/pmp_text_styles.dart';
import '../../../model/day/day.dart';

class DayWidget extends StatelessWidget {
  const DayWidget({
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
        color: PmpColors.white,
        border: Border.all(
          color: PmpColors.neutral10.withOpacity(0.1),
        ),
        borderRadius: BorderRadius.circular(12),
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
                    color: PmpColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Icon(
                  Icons.lock,
                  color: Colors.red,
                  size: 20,
                ),
              ],
            ),
          ),
          if (day.lessons.isEmpty && day.exercises.isEmpty)
            SizedBox(
              height: 120,
              width: double.infinity,
              child: Center(
                child: Text(
                  'မကြာခင်တင်ပေးပါမည်။',
                  style: PmpTextStyles.body1Regular.copyWith(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          if (day.lessons.isNotEmpty)
            Container(
              height: 1,
              width: double.infinity,
              color: Colors.black.withOpacity(0.1),
              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            ),
          ...day.lessons.map((lesson) => LessonItem(lesson: lesson)),
          if (day.exercises.isNotEmpty)
            Container(
              height: 1,
              width: double.infinity,
              color: Colors.black.withOpacity(0.1),
              margin: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 12,
              ),
            ),
          ...day.exercises.map((exercise) => ExerciseItem(
                exercise: exercise,
              )),
        ],
      ),
    );
  }
}
