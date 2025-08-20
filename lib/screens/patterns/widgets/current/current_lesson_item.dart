import 'package:flutter/material.dart';
import 'package:pmp_english/config/pmp_text_styles.dart';
import 'package:pmp_english/model/lesson/lesson.dart';

import '../../../../config/pmp_routes.dart';

class CurrentLessonItem extends StatelessWidget {
  const CurrentLessonItem({
    super.key,
    required this.lesson,
  });
  final Lesson lesson;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            PmpRoutes.speakingPattern,
            arguments: {
              'lesson': lesson,
            },
          );
        },
        child: Padding(
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
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      lesson.lessonName,
                      style: PmpTextStyles.body2Regular
                          .copyWith(color: Colors.white),
                    ),
                    if (lesson.subtitle!.isNotEmpty)
                      Text(
                        lesson.subtitle!,
                        style: PmpTextStyles.body2Regular
                            .copyWith(color: Colors.white),
                      ),
                  ],
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              const Icon(
                Icons.chevron_right,
                size: 20,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
