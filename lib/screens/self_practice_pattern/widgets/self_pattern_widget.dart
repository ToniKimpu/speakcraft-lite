import 'package:flutter/material.dart';

import '../../../config/pmp_colors.dart';
import '../../../config/pmp_text_styles.dart';
import '../../../model/pattern/pattern.dart';

class SelfPatternWidget extends StatelessWidget {
  const SelfPatternWidget(
      {super.key,
      required this.patternContainerKey,
      required this.pattern,
      required ValueNotifier<bool> showVocabularyNotifier,
      required ValueNotifier<bool> showExampleNotifier})
      : _showVocabularyNotifier = showVocabularyNotifier,
        _showExampleNotifier = showExampleNotifier;

  final GlobalKey<State<StatefulWidget>> patternContainerKey;
  final ValueNotifier<bool> _showVocabularyNotifier;
  final ValueNotifier<bool> _showExampleNotifier;
  final Pattern pattern;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: patternContainerKey,
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            pattern.pattern,
            style: PmpTextStyles.body1Semi.copyWith(
              color: Colors.black,
            ),
          ),
          Text(
            pattern.title ?? '',
            style: PmpTextStyles.body2Medium.copyWith(
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(pattern.description ?? '', style: PmpTextStyles.body2Medium),
          const SizedBox(height: 8),
          Row(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: PmpColors.primary400,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  if (_showExampleNotifier.value) {
                    _showExampleNotifier.value = false;
                    return;
                  }
                  _showVocabularyNotifier.value =
                      !_showVocabularyNotifier.value;
                },
                child: Text(
                  'Vocabularies',
                  style:
                      PmpTextStyles.body2Medium.copyWith(color: Colors.white),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: PmpColors.primary400,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  if (_showVocabularyNotifier.value) {
                    _showVocabularyNotifier.value = false;
                    return;
                  }
                  _showExampleNotifier.value = !_showExampleNotifier.value;
                },
                child: Text(
                  'Examples',
                  style:
                      PmpTextStyles.body2Medium.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
