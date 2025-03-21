import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmp_english/bloc/exercise/exercise_bloc.dart';
import 'package:pmp_english/screens/patterns/widgets/current/current_exercise_item.dart';
import 'package:pmp_english/screens/patterns/widgets/current/current_lesson_item.dart';
import 'package:pmp_english/screens/patterns/widgets/exercise_item_loading.dart';

import '../../../../config/pmp_colors.dart';
import '../../../../config/pmp_text_styles.dart';
import '../../../../model/day/day.dart';

class CurrentDayWidget extends StatefulWidget {
  const CurrentDayWidget({
    super.key,
    required this.day,
  });

  final Day day;

  @override
  State<CurrentDayWidget> createState() => _CurrentDayWidgetState();
}

class _CurrentDayWidgetState extends State<CurrentDayWidget> {
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
            child: Text(
              'Day ${widget.day.orderNumber}',
              style: PmpTextStyles.body1Regular.copyWith(
                color: PmpColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            height: 1,
            width: double.infinity,
            color: Colors.white.withOpacity(0.1),
            margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          ),
          ...widget.day.lessons.map(
            (lesson) => CurrentLessonItem(lesson: lesson),
          ),
          if (widget.day.exercises.isNotEmpty)
            Container(
              height: 1,
              width: double.infinity,
              color: Colors.white.withOpacity(0.1),
              margin: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 12,
              ),
            ),
          BlocBuilder<ExerciseBloc, ExerciseState>(
            // bloc: exerciseBloc,
            builder: (context, state) {
              return state.maybeWhen(
                loading: () {
                  return Wrap(
                    children:
                        List.generate(widget.day.exercises.length, (index) {
                      return const ExerciseItemLoading();
                    }),
                  );
                },
                loaded: (exercises) {
                  bool foundFirstIncomplete = false;
                  return Wrap(
                    children: exercises.asMap().entries.map((entry) {
                      final index = entry.key;
                      final exercise = entry.value;

                      bool isLastIndex = index == exercises.length - 1;
                      bool isOpenIndex =
                          !exercise.isComplete && !foundFirstIncomplete;

                      if (isOpenIndex) {
                        foundFirstIncomplete = true;
                      }

                      return CurrentExerciseItem(
                        exercise: exercise,
                        isOpenIndex: isOpenIndex,
                        isLastIndex: isLastIndex, // Pass the isLastIndex value
                        day: widget.day,
                      );
                    }).toList(),
                  );
                },
                orElse: () => Container(),
              );
            },
          ),
          // ...day.exercises.map(
          //   (exercise) => ExerciseItem(
          //     exercise: exercise,
          //   ),
          // ),
        ],
      ),
    );
  }
}
