import 'package:flutter/material.dart';
import 'package:pmp_english/screens/patterns/enum/day_item_type.dart';
import 'package:pmp_english/screens/patterns/widgets/day_widget.dart';

import '../../../config/pmp_colors.dart';
import '../../../config/pmp_text_styles.dart';
import '../../../model/day/day.dart';

class CompletedDayList extends StatelessWidget {
  const CompletedDayList({super.key, required this.days});
  final List<Day> days;

  @override
  Widget build(BuildContext context) {
    if (days.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Center(
          child: Text(
            'You haven\'t completed any tutorial yet!',
            style: PmpTextStyles.body2Semi.copyWith(color: PmpColors.white),
          ),
        ),
      );
    }

    return ListView.separated(
      itemCount: days.length,
      padding: const EdgeInsets.only(top: 16),
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (_, index) => DayWidget(
        day: days[index],
        type: DayItemType.completed,
      ),
    );
  }
}
