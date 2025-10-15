import 'package:flutter/material.dart';
import 'package:pmp_english/shared_widgets/line_with_text.dart';

import '../../../config/pmp_colors.dart';
import '../../../config/pmp_text_styles.dart';
import '../../../model/listening_question/listening_question.dart';

class CorrectAnswerSheet extends StatelessWidget {
  const CorrectAnswerSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        // color: Colors.red,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Text(
              'Question 1',
              style:
                  PmpTextStyles.label2Regular.copyWith(color: PmpColors.white),
            ),
            const SizedBox(
              height: 8,
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () async {},
                child: Ink(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                    color: Colors.blue.withValues(alpha: 0.8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.2),
                                spreadRadius: 3,
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.play_arrow,
                              color: Colors.blue,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Play Audio",
                        style: PmpTextStyles.body2Semi
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            const LineWithText(),
            const SizedBox(height: 6),
            Text(
              "Does the speaker know how to build grit?",
              style: PmpTextStyles.body1Regular.copyWith(
                color: PmpColors.white,
                fontFamily: "ArchivoBlack Regular",
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            _buildOption(
              const AnswerOption(
                  answer: "No, she does not know.", correct: true),
              true,
            ),
            const SizedBox(height: 12),
            _buildOption(
              const AnswerOption(
                  answer: "No, talent alone does not create grit.",
                  correct: false),
              false,
            ),
            const SizedBox(height: 12),
            _buildOption(
              const AnswerOption(
                  answer: "Talent guarantees success.", correct: false),
              false,
            ),
            const SizedBox(height: 12),
            _buildOption(
              const AnswerOption(
                  answer: "They may fail to follow through on commitments.",
                  correct: false),
              false,
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(AnswerOption answerOption, bool selected) {
    // bool selected = false;
    // if (answerOption.answer == widget.answerOption?.answer) {
    //   selected = true;
    // }
    return Row(
      children: [
        InkWell(
          onTap: () {},
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:
                  selected ? Colors.blue : Colors.white.withValues(alpha: 0.15),
            ),
            child: !selected
                ? const SizedBox()
                : const Center(
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 13,
                    ),
                  ),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                // widget.onAnswerSelected(answerOption);
              },
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: selected ? Colors.blue : const Color(0xFF203A43),
                  border:
                      Border.all(color: Colors.white.withValues(alpha: 0.15)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          answerOption.answer,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
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
