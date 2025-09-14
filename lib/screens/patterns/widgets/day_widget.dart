import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmp_english/bloc/exercise/exercise_bloc.dart';
import 'package:pmp_english/screens/patterns/enum/day_item_type.dart';
import 'package:pmp_english/screens/patterns/widgets/exercise_item.dart';
import 'package:pmp_english/screens/patterns/widgets/exercise_item_loading.dart';
import 'package:pmp_english/screens/patterns/widgets/lesson_item.dart';

import '../../../config/pmp_colors.dart';
import '../../../config/pmp_text_styles.dart';
import '../../../l10n/generated/l10n.dart';
import '../../../model/day/day.dart';

class DayWidget extends StatelessWidget {
  const DayWidget({
    super.key,
    required this.day,
    required this.type,
  });

  final Day day;
  final DayItemType type;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
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
          if (day.lessons.isNotEmpty) _divider(),
          ...day.lessons.map(
            (lesson) => LessonItem(
              lesson: lesson,
              type: type,
            ),
          ),
          if (day.exercises.isNotEmpty) _divider(),
          _buildExercises(context),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    switch (type) {
      case DayItemType.completed:
        return Padding(
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
                child: const Icon(Icons.check, size: 16, color: Colors.white),
              ),
            ],
          ),
        );
      case DayItemType.current:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'Day ${day.orderNumber}',
            style: PmpTextStyles.body1Regular.copyWith(
              color: PmpColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      case DayItemType.inProgress:
        return Padding(
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
              const Icon(Icons.lock, color: Color(0xFFECEFF1), size: 20),
            ],
          ),
        );
    }
  }

  Widget _buildExercises(BuildContext context) {
    switch (type) {
      case DayItemType.completed:
        return Column(
          children: day.exercises
              .map((exercise) => ExerciseItem(exercise: exercise))
              .toList(),
        );
      case DayItemType.inProgress:
        return Column(
          children: day.exercises
              .map((exercise) => ExerciseItem(
                    exercise: exercise,
                    showStatus: false,
                  ))
              .toList(),
        );
      case DayItemType.current:
        return BlocBuilder<ExerciseBloc, ExerciseState>(
          builder: (context, state) {
            return state.maybeWhen(
              loading: () => Wrap(
                children: List.generate(
                  day.exercises.length,
                  (_) => const ExerciseItemLoading(),
                ),
              ),
              loaded: (exercises) {
                bool foundFirstIncomplete = false;
                return Wrap(
                  children: exercises.asMap().entries.map((entry) {
                    final index = entry.key;
                    final exercise = entry.value;
                    final isLastIndex = index == exercises.length - 1;
                    final isOpenIndex =
                        !exercise.isComplete && !foundFirstIncomplete;
                    if (isOpenIndex) foundFirstIncomplete = true;

                    return ExerciseItem(
                      exercise: exercise,
                      isOpenIndex: isOpenIndex,
                      isLastIndex: isLastIndex,
                      day: day,
                    );
                  }).toList(),
                );
              },
              orElse: () => Container(),
            );
          },
        );
    }
  }

  Widget _divider() => Container(
        height: 1,
        width: double.infinity,
        color: Colors.white.withValues(alpha: 0.1),
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      );
}
