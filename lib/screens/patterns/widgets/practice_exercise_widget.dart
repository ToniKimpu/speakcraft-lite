import 'package:flutter/material.dart';
import 'package:pmp_english/model/pattern_exercise/pattern_exercise.dart';

import '../../../config/pmp_colors.dart';
import '../../../config/pmp_text_styles.dart';
import '../../../shared_widgets/practice_text_field.dart';

class PracticeExerciseWidget extends StatefulWidget {
  const PracticeExerciseWidget({
    super.key,
    required this.focusNode,
    required this.patternExercise,
    required this.onUserInput,
  });

  final FocusNode focusNode;
  final PatternExercise patternExercise;
  final Function(String value) onUserInput;

  @override
  State<PracticeExerciseWidget> createState() => _PracticeExerciseWidgetState();
}

class _PracticeExerciseWidgetState extends State<PracticeExerciseWidget> {
  late final TextEditingController _controller;
  late final ValueNotifier<bool> _showVocabularyNotifier;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _showVocabularyNotifier = ValueNotifier<bool>(false);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Burmese",
            style: PmpTextStyles.body1Regular.copyWith(
              color: PmpColors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            widget.patternExercise.burmeseText,
            style: PmpTextStyles.body2Regular.copyWith(
              color: PmpColors.black,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Text(
            'Your Answer:',
            style: PmpTextStyles.body1Regular.copyWith(
              color: PmpColors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          PracticeTextField(
            englishOnly: true,
            focusNode: widget.focusNode,
            controller: _controller,
            onChange: (value) => widget.onUserInput(value),
          ),
          const SizedBox(
            height: 12,
          ),
          if (widget.patternExercise.vocabularies.isNotEmpty)
            InkWell(
              onTap: () {
                _showVocabularyNotifier.value = !_showVocabularyNotifier.value;
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                child: Row(
                  children: [
                    SizedBox(
                      width: 14,
                      height: 14,
                      child: ValueListenableBuilder<bool>(
                          valueListenable: _showVocabularyNotifier,
                          builder: (context, showVocabulary, _) {
                            return Checkbox(
                              value: showVocabulary,
                              onChanged: (value) {
                                _showVocabularyNotifier.value = value ?? false;
                              },
                            );
                          }),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Vocabulary',
                      style: PmpTextStyles.body2Regular.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(
            height: 12,
          ),
          ValueListenableBuilder<bool>(
            valueListenable: _showVocabularyNotifier,
            builder: (context, hideVocabulary, child) {
              return Offstage(
                offstage: !hideVocabulary,
                child: child,
              );
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(6)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: widget.patternExercise.vocabularies
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: Colors.red,
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
                                    style: PmpTextStyles.body2Regular.copyWith(
                                      color: Colors.black,
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
          ),
        ],
      ),
    );
  }
}
