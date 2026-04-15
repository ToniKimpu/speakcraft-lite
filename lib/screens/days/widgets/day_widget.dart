import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmp_english/bloc/exercise/exercise_bloc.dart';
import 'package:pmp_english/screens/days/enum/day_item_type.dart';
import 'package:pmp_english/screens/days/widgets/exercise_item.dart';
import 'package:pmp_english/screens/days/widgets/exercise_item_loading.dart';
import 'package:pmp_english/screens/days/widgets/lesson_item.dart';

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
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.12),
            blurRadius: 12,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          if (day.lessons.isEmpty && day.exercises.isEmpty)
            SizedBox(
              height: 120,
              width: double.infinity,
              child: Center(
                child: Text(
                  AppLocalizations.of(context).txtWillUploadSoon,
                  style: PmpTextStyles.body1Regular.copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
              ),
            ),
          if (day.lessons.isNotEmpty) _divider(context),
          ...day.lessons.map(
            (lesson) => LessonItem(
              lesson: lesson,
              type: type,
            ),
          ),
          if (day.exercises.isNotEmpty) _divider(context),
          _buildExercises(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final dayTextStyle = PmpTextStyles.body1Regular.copyWith(
      color: colorScheme.onSurface,
      fontWeight: FontWeight.bold,
    );
    switch (type) {
      case DayItemType.completed:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Day ${day.orderNumber}', style: dayTextStyle),
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
          child: Text('Day ${day.orderNumber}', style: dayTextStyle),
        );
      case DayItemType.inProgress:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Day ${day.orderNumber}', style: dayTextStyle),
              Icon(
                Icons.lock,
                color: colorScheme.onSurfaceVariant,
                size: 20,
              ),
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

  Widget _divider(BuildContext context) => Container(
        height: 1,
        width: double.infinity,
        color: Theme.of(context).colorScheme.outlineVariant,
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      );
}
