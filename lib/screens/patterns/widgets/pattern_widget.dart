import 'package:flutter/material.dart';
import 'package:pmp_english/config/pmp_text_styles.dart';
import 'package:pmp_english/screens/patterns/widgets/example_widget.dart';

import '../../../config/pmp_colors.dart';
import '../../../model/pattern/pattern.dart';

class PatternWidget extends StatelessWidget {
  const PatternWidget({
    super.key,
    required this.pattern,
  });
  final Pattern pattern;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Wrap(
                direction: Axis.vertical,
                children: [
                  Text(
                    pattern.pattern,
                    style: PmpTextStyles.body2Semi.copyWith(
                      color: Colors.black,
                    ),
                  ),
                  if (pattern.title != null)
                    Text(
                      pattern.title!,
                      style: PmpTextStyles.body2Semi.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                ],
              ),
              Material(
                borderRadius: BorderRadius.circular(12),
                color: PmpColors.primary400,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {},
                  child: const SizedBox(
                    width: 24,
                    height: 24,
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (pattern.description != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
            child: Text(
              pattern.description!,
              style: PmpTextStyles.body2Semi.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        const SizedBox(
          height: 12,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'Examples',
            style: PmpTextStyles.body2Semi.copyWith(
              color: Colors.black,
            ),
          ),
        ),
        if (pattern.patternExamples!.isNotEmpty)
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: pattern.patternExamples!.length,
            itemBuilder: (context, index) {
              return ExampleWidget(
                patternExample: pattern.patternExamples![index],
              );
            },
          ),
      ],
    );
  }
}
