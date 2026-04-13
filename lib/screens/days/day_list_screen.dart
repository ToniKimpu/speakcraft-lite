import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmp_english/bloc/exercise/exercise_bloc.dart';
import 'package:pmp_english/config/pmp_text_styles.dart';
import 'package:pmp_english/model/day/day.dart';

import '../../bloc/day/day_bloc.dart';
import '../../l10n/generated/l10n.dart';
import 'pages/completed_day_list.dart';
import 'pages/in_progress_day_list.dart';

class DayListScreen extends StatefulWidget {
  const DayListScreen({super.key});

  @override
  State<DayListScreen> createState() => _DayListScreenState();
}

class _DayListScreenState extends State<DayListScreen> {
  bool complete = true;

  @override
  void initState() {
    super.initState();
    context.read<DayBloc>().add(const DayEvent.loadDays());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Useful Spoken Patterns'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Toggle Buttons
            Row(
              children: [
                _buildToggleButton(
                  label: "Completed",
                  isSelected: complete,
                  onTap: () => setState(() => complete = true),
                ),
                const SizedBox(width: 12),
                _buildToggleButton(
                  label: "Progress",
                  isSelected: !complete,
                  onTap: () => setState(() => complete = false),
                ),
              ],
            ),

            /// Bloc Content
            Expanded(
              child: BlocBuilder<DayBloc, DayState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    loading: () => const Center(
                      child: SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    socketError: (message) => _buildError(message),
                    loaded: (currentDay, days) {
                      if (days.isEmpty) {
                        return Center(
                          child: Text(
                            AppLocalizations.of(context).txtWillUploadSoon,
                            style: PmpTextStyles.body2Semi.copyWith(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        );
                      }
                      final notCompletedDays =
                          days.where((day) => !day.isComplete).toList();
                      final completedDays =
                          days.where((day) => day.isComplete).toList();

                      /// preload exercises for current day
                      if (notCompletedDays.isNotEmpty) {
                        context.read<ExerciseBloc>().add(
                              ExerciseEvent.loadExercises(
                                  notCompletedDays.first.id),
                            );
                      }
                      final remainingDays = (notCompletedDays.isNotEmpty &&
                              notCompletedDays.length > 1)
                          ? notCompletedDays.skip(1).toList()
                          : <Day>[];
                      return IndexedStack(
                        index: complete ? 0 : 1,
                        children: [
                          /// Completed list
                          CompletedDayList(days: completedDays),
                          /// In progress list
                          InProgressDayList(
                            currentDay: notCompletedDays.isNotEmpty
                                ? notCompletedDays.first
                                : null,
                            remainingDays: remainingDays,
                          ),
                        ],
                      );
                    },
                    orElse: () => Container(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleButton({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return Material(
      borderRadius: BorderRadius.circular(24),
      color: isSelected ? colorScheme.primary : Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Container(
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isSelected ? Colors.transparent : colorScheme.outline,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: PmpTextStyles.body2Regular.copyWith(
                color: isSelected
                    ? colorScheme.onPrimary
                    : colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildError(String message) {
    final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            message,
            style: PmpTextStyles.body2Semi.copyWith(color: colorScheme.error),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              context.read<DayBloc>().add(const DayEvent.loadDays());
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
