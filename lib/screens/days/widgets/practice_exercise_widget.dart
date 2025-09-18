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
    _controller.dispose();
    _showVocabularyNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 3,
            color: const Color(0xFF1C2C3C),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle("Burmese"),
                  Text(
                    widget.patternExercise.burmeseText,
                    style: PmpTextStyles.body2Regular
                        .copyWith(color: PmpColors.white),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: Colors.black.withValues(alpha: 0.1),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  _buildSectionTitle('Your Answer:'),
                  const SizedBox(height: 8),
                  PracticeTextField(
                    focusNode: widget.focusNode,
                    controller: _controller,
                    onChange: widget.onUserInput,
                    englishOnly: true,
                    minLines: 2,
                    maxHeight: 120,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          if (widget.patternExercise.vocabularies.isNotEmpty)
            ValueListenableBuilder<bool>(
              valueListenable: _showVocabularyNotifier,
              builder: (context, showVocabulary, _) {
                return Card(
                  color: Colors.black.withValues(alpha: 0.4),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side:
                        BorderSide(color: Colors.white.withValues(alpha: 0.2)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Show Vocabulary',
                          style: PmpTextStyles.body2Semi.copyWith(
                            color: Colors.white,
                            fontFamily: "ArchivoBlack Regular",
                          ),
                        ),
                        const SizedBox(width: 4),
                        Transform.scale(
                          scale:
                              0.75, // Adjust between 0.6 to 1.0 to fine-tune size
                          child: Switch(
                            value: showVocabulary,
                            onChanged: (value) {
                              setState(() {
                                _showVocabularyNotifier.value = value;
                              });
                            },
                            activeColor: Colors.white,
                            inactiveThumbColor:
                                Colors.white.withValues(alpha: 0.8),
                            activeTrackColor: Colors.green,
                            inactiveTrackColor:
                                Colors.white.withValues(alpha: 0.4),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

          // Vocabulary List
          if (widget.patternExercise.vocabularies.isNotEmpty)
            ValueListenableBuilder<bool>(
              valueListenable: _showVocabularyNotifier,
              builder: (context, showVocabulary, child) {
                return _buildVocabularyList(showVocabulary);
              },
            ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: PmpTextStyles.body1Regular.copyWith(
        color: PmpColors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildVocabularyList(bool showVocabulary) {
    return AnimatedSlide(
      offset: showVocabulary ? Offset.zero : const Offset(1.5, 0),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.2),
              spreadRadius: 1,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          children: widget.patternExercise.vocabularies
              .map(
                (e) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        margin: const EdgeInsets.only(right: 8),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              e.englishText,
                              style: PmpTextStyles.body2Semi.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              e.burmeseText,
                              style: PmpTextStyles.body2Regular.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
