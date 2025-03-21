import 'package:flutter/material.dart';
import 'package:pmp_english/screens/patterns/widgets/exercise_item.dart';
import 'package:pmp_english/screens/patterns/widgets/lesson_item.dart';

import '../../../config/pmp_colors.dart';
import '../../../config/pmp_text_styles.dart';
import '../../../l10n/generated/l10n.dart';
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
        // color: PmpColors.white,
        // border: Border.all(
        //   color: PmpColors.neutral10.withOpacity(0.1),
        // ),
        // borderRadius: BorderRadius.circular(12),
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
                const Icon(
                  Icons.lock,
                  color: Color(0xFFECEFF1),
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
                  AppLocalizations.of(context).txtWillUploadSoon,
                  style: PmpTextStyles.body1Regular.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          if (day.lessons.isNotEmpty)
            Container(
              height: 1,
              width: double.infinity,
              color: Colors.white.withOpacity(0.1),
              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            ),
          ...day.lessons.map((lesson) => LessonItem(lesson: lesson)),
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
          ...day.exercises.map((exercise) => ExerciseItem(
                exercise: exercise,
              )),
        ],
      ),
    );
  }
}
