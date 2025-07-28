import 'package:flutter/material.dart';

import '../../../config/pmp_text_styles.dart';

class AiPracticeTabSelector extends StatelessWidget {
  const AiPracticeTabSelector({
    super.key,
    required this.currentTabIndex,
    required this.onTabChanged,
  });
  final int currentTabIndex;
  final Function(int tabIndex) onTabChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Material(
          borderRadius: BorderRadius.circular(24),
          color: currentTabIndex == 0
              ? const Color(0xFF2C5364)
              : Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: () => onTabChanged.call(0),
            child: Container(
              height: 44,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: currentTabIndex == 0
                      ? Colors.transparent
                      : const Color(0xFF2C5364), // Matching border
                ),
              ),
              child: Center(
                child: Text(
                  'AI Reponses',
                  style: PmpTextStyles.body2Regular.copyWith(
                    color: currentTabIndex == 0 ? Colors.white : Colors.white54,
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
          color: currentTabIndex == 0
              ? Colors.transparent
              : const Color(0xFF203A43), // Mid-tone from gradient
          child: InkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: () => onTabChanged.call(1),
            child: Container(
              height: 44,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: currentTabIndex == 0
                      ? const Color(0xFF203A43) // Matched border
                      : Colors.transparent,
                ),
              ),
              child: Center(
                child: Text(
                  'Correct Sentences',
                  style: PmpTextStyles.body2Regular.copyWith(
                    color: currentTabIndex == 0 ? Colors.white54 : Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
