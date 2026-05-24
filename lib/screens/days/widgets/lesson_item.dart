import 'package:flutter/material.dart';
import 'package:speakcraft/config/pmp_text_styles.dart';
import 'package:speakcraft/model/lesson/lesson.dart';
import 'package:speakcraft/screens/days/enum/day_item_type.dart';

import '../../../../config/pmp_routes.dart';

class LessonItem extends StatelessWidget {
  const LessonItem({
    super.key,
    required this.lesson,
    required this.type,
  });

  final Lesson lesson;
  final DayItemType type;

  // bool get isClickable =>
  //     type == DayItemType.completed || type == DayItemType.current;

  bool get isClickable => true;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final content = Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 12,
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: colorScheme.onSurface,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  lesson.lessonName,
                  style: PmpTextStyles.body2Regular
                      .copyWith(color: colorScheme.onSurface),
                ),
                if (lesson.subtitle?.isNotEmpty ?? false)
                  Text(
                    lesson.subtitle!,
                    style: PmpTextStyles.body2Regular
                        .copyWith(color: colorScheme.onSurfaceVariant),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          if (isClickable)
            Icon(
              Icons.chevron_right,
              size: 20,
              color: colorScheme.onSurfaceVariant,
            ),
        ],
      ),
    );

    if (isClickable) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // Navigator.pushNamed(
            //   context,
            //   PmpRoutes.spokenPatternDetail,
            // );

            Navigator.pushNamed(
              context,
              PmpRoutes.spokenPatternPage,
              arguments: {'lesson': lesson},
            );
          },
          child: content,
        ),
      );
    } else {
      return Material(
        color: Colors.transparent,
        child: content,
      );
    }
  }
}
