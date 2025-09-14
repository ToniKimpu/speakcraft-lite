import 'package:flutter/material.dart';

import '../../../config/pmp_colors.dart';
import '../../../config/pmp_text_styles.dart';
import '../../../model/day/day.dart';
import '../enum/day_item_type.dart';
import '../widgets/day_widget.dart';

class InProgressDayList extends StatelessWidget {
  const InProgressDayList({
    super.key,
    required this.currentDay,
    required this.remainingDays,
  });

  final Day? currentDay;
  final List<Day> remainingDays;

  @override
  Widget build(BuildContext context) {
    if (currentDay == null) {
      return Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Center(
          child: Column(
            children: [
              Text(
                'Good job!',
                style: PmpTextStyles.body1Regular.copyWith(
                  color: PmpColors.black,
                ),
              ),
              const SizedBox(height: 4),
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

    return ListView.separated(
      itemCount: remainingDays.length + 1,
      padding: const EdgeInsets.only(top: 16),
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (_, index) {
        if (index == 0) {
          return DayWidget(
            day: currentDay!,
            type: DayItemType.current,
          );
        }
        return DayWidget(
          day: remainingDays[index - 1],
          type: DayItemType.inProgress,
        );
      },
    );
  }
}
