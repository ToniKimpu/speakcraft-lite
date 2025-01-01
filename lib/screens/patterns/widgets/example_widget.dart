import 'package:flutter/material.dart';
import 'package:pmp_english/config/pmp_colors.dart';
import 'package:pmp_english/model/pattern_example/pattern_example.dart';

import '../../../config/pmp_text_styles.dart';

class ExampleWidget extends StatelessWidget {
  const ExampleWidget({
    super.key,
    required this.patternExample,
  });

  final PatternExample patternExample;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
        decoration: const BoxDecoration(
            // color: Colors.red,
            ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.circle,
              size: 12,
              color: PmpColors.primary400,
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    patternExample.englishText,
                    style: PmpTextStyles.body2Semi.copyWith(
                      color: Colors.black,
                    ),
                  ),
                  if (patternExample.burmeseText != null)
                    Text(
                      patternExample.burmeseText!,
                      style: PmpTextStyles.body2Semi.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
