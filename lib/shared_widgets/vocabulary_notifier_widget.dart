import 'package:flutter/material.dart';
import 'package:speakcraft/config/pmp_colors.dart';
import 'package:speakcraft/model/pattern_vocabulary/pattern_vocabulary.dart';

import '../config/pmp_text_styles.dart';

class VocabularyNotifierWidget extends StatelessWidget {
  const VocabularyNotifierWidget({
    super.key,
    required ValueNotifier<bool> showVocabularyNotifier,
    required this.vocabularies,
  }) : _showVocabularyNotifier = showVocabularyNotifier;

  final ValueNotifier<bool> _showVocabularyNotifier;
  final List<PatternVocabulary> vocabularies;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _showVocabularyNotifier,
      builder: (context, hideVocabulary, child) {
        return Offstage(
          offstage: !hideVocabulary,
          child: child,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(6),
          ),
          border: Border.all(color: Colors.black.withOpacity(0.3)),
        ),
        child: Column(
          children: vocabularies
              .map(
                (e) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: PmpColors.primary400,
                          borderRadius: BorderRadius.circular(9999),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              e.englishText,
                              style: PmpTextStyles.body2Semi.copyWith(
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              e.burmeseText,
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
              )
              .toList(), // Convert the mapped items to a list
        ),
      ),
    );
  }
}
