import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmp_english/bloc/exercise/exercise_bloc.dart';
import 'package:pmp_english/config/pmp_colors.dart';
import 'package:pmp_english/config/pmp_text_styles.dart';
import 'package:pmp_english/model/day/day.dart';
import 'package:pmp_english/screens/patterns/widgets/completed/completed_day_widget.dart';
import 'package:pmp_english/screens/patterns/widgets/day_widget.dart';
import 'package:pmp_english/shared_widgets/main_scaffold.dart';

import '../../bloc/day/day_bloc.dart';
import '../../l10n/generated/l10n.dart';
import 'widgets/current/current_day_widget.dart';

class DayListScreen extends StatefulWidget {
  const DayListScreen({super.key});

  @override
  State<DayListScreen> createState() => _DayListScreenState();
}

class _DayListScreenState extends State<DayListScreen> {
  // final _dayBloc = DayBloc();
  final _completeNotifier = ValueNotifier<bool>(true);

  @override
  void initState() {
    super.initState();
    context.read<DayBloc>().add(const DayEvent.loadDays());
  }

  @override
  void dispose() {
    _completeNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      appBar: AppBar(
        title: const Text('Spoken Pattern Tutorial'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ValueListenableBuilder<bool>(
              valueListenable: _completeNotifier,
              builder: (context, complete, child) {
                return Row(
                  children: [
                    // Completed Button
                    Material(
                      borderRadius: BorderRadius.circular(24),
                      color: complete
                          ? const Color(
                              0xFF2C5364) // Darkest shade from gradient
                          : Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(24),
                        onTap: () {
                          if (!complete) {
                            _completeNotifier.value = true;
                          }
                        },
                        child: Container(
                          height: 44,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: complete
                                  ? Colors.transparent
                                  : const Color(0xFF2C5364), // Matching border
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Completed',
                              style: PmpTextStyles.body2Regular.copyWith(
                                color: complete ? Colors.white : Colors.white54,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Progress Button
                    Material(
                      borderRadius: BorderRadius.circular(24),
                      color: complete
                          ? Colors.transparent
                          : const Color(0xFF203A43), // Mid-tone from gradient
                      child: InkWell(
                        borderRadius: BorderRadius.circular(24),
                        onTap: () {
                          if (complete) {
                            _completeNotifier.value = false;
                          }
                        },
                        child: Container(
                          height: 44,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: complete
                                  ? const Color(0xFF203A43) // Matched border
                                  : Colors.transparent,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Progress',
                              style: PmpTextStyles.body2Regular.copyWith(
                                color: complete ? Colors.white54 : Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(
              height: 16,
            ),
            BlocBuilder<DayBloc, DayState>(
              builder: (context, state) {
                return state.maybeWhen(
                  loading: () => const Center(
                      child: SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(),
                  )),
                  socketError: (message) {
                    return Center(
                      child: Column(
                        children: [
                          Text(
                            message,
                            style: PmpTextStyles.body2Semi.copyWith(
                              color: Colors.red,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              context
                                  .read<DayBloc>()
                                  .add(const DayEvent.loadDays());
                            },
                            child: Text(
                              "Retry",
                              style: PmpTextStyles.body2Semi.copyWith(
                                color: PmpColors.neutral800,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  loaded: (currentDay, days) {
                    if (days.isEmpty) {
                      return Center(
                        child: Text(
                          AppLocalizations.of(context).txtWillUploadSoon,
                          style: PmpTextStyles.body2Semi.copyWith(
                            color: Colors.black,
                          ),
                        ),
                      );
                    }
                    final notCompletedDays =
                        days.where((day) => !day.isComplete).toList();
                    final completedDays =
                        days.where((day) => day.isComplete).toList();
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
                    return Stack(
                      children: [
                        ValueListenableBuilder<bool>(
                          valueListenable: _completeNotifier,
                          builder: (context, complete, child) {
                            if (!complete && notCompletedDays.isEmpty) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 100),
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Good job!',
                                        style: PmpTextStyles.body1Regular
                                            .copyWith(color: PmpColors.black),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        'You have completed all Tutorials!',
                                        style: PmpTextStyles.body2Semi.copyWith(
                                          color: PmpColors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                            return Offstage(
                              offstage: complete,
                              child: child,
                            );
                          },
                          child: ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: remainingDays.length + 1,
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 16,
                            ),
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return CurrentDayWidget(
                                  day: notCompletedDays.first,
                                );
                              }
                              final day = remainingDays[index - 1];
                              return DayWidget(day: day);
                            },
                          ),
                        ),
                        ValueListenableBuilder<bool>(
                          valueListenable: _completeNotifier,
                          builder: (context, complete, child) {
                            if (completedDays.isEmpty && complete) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 100),
                                child: Center(
                                  child: Text(
                                    'You haven\'t completed any tutorial yet!',
                                    style: PmpTextStyles.body2Semi.copyWith(
                                      color: PmpColors.white,
                                    ),
                                  ),
                                ),
                              );
                            }
                            return Offstage(
                              offstage: !complete,
                              child: child,
                            );
                          },
                          child: ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: completedDays.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 16,
                            ),
                            itemBuilder: (context, index) {
                              final day = completedDays[index];
                              return CompletedDayWidget(day: day);
                            },
                          ),
                        ),
                      ],
                    );
                  },
                  orElse: () => Container(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
