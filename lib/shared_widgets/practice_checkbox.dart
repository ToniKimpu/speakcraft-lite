import 'package:flutter/material.dart';
import 'package:pmp_english/config/pmp_colors.dart';

import '../config/pmp_text_styles.dart';

class PracticeCheckbox extends StatelessWidget {
  const PracticeCheckbox({
    super.key,
    required this.practiceNotifier,
    required this.label,
    this.isWrods = false,
    this.onBackward,
  });

  final ValueNotifier<bool> practiceNotifier;
  final String label;
  final bool isWrods;
  final VoidCallback? onBackward;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                practiceNotifier.value = !practiceNotifier.value;
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 12, // Space between items
                  children: [
                    SizedBox(
                      width: 14,
                      height: 14,
                      child: ValueListenableBuilder<bool>(
                        valueListenable: practiceNotifier,
                        builder: (context, showVocabulary, _) {
                          return Checkbox(
                            value: showVocabulary,
                            onChanged: (value) {
                              practiceNotifier.value = value ?? false;
                            },
                          );
                        },
                      ),
                    ),
                    Text(
                      label,
                      style: PmpTextStyles.body2Semi.copyWith(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (isWrods)
            const SizedBox(
              width: 12,
            ),
          if (isWrods)
            ValueListenableBuilder<bool>(
              valueListenable: practiceNotifier,
              builder: (context, showWordList, child) {
                return Offstage(
                  offstage: !showWordList,
                  child: child,
                );
              },
              child: Material(
                borderRadius: BorderRadius.circular(18),
                color: PmpColors.primary400,
                child: InkWell(
                  borderRadius: BorderRadius.circular(18),
                  onTap: () {
                    onBackward?.call();
                  },
                  child: const SizedBox(
                    width: 24,
                    height: 24,
                    child: Center(
                      child: Icon(
                        Icons.refresh,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
