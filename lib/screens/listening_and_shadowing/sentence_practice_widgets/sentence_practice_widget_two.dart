import 'package:flutter/material.dart';

import '../../../model/listening_question/listening_question.dart';

class SentencePracticeWidgetTwo extends StatefulWidget {
  const SentencePracticeWidgetTwo({
    super.key,
    required this.listeningQuestion,
    this.answerOption,
    required this.onAnswerSelected,
  });
  final ListeningQuestion listeningQuestion;
  final AnswerOption? answerOption;
  final Function(AnswerOption answerOption) onAnswerSelected;

  @override
  State<SentencePracticeWidgetTwo> createState() =>
      _SentencePracticeWidgetTwoState();
}

class _SentencePracticeWidgetTwoState extends State<SentencePracticeWidgetTwo> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Text(
            widget.listeningQuestion.question,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              height: 1.4,
              fontFamily: "ArchivoBlack Regular",
            ),
          ),
          const SizedBox(height: 12),
          // Map answers with spacing except after the last one
          for (var i = 0; i < widget.listeningQuestion.answers.length; i++) ...[
            _buildOption(widget.listeningQuestion.answers[i]),
            if (i != widget.listeningQuestion.answers.length - 1)
              const SizedBox(height: 12),
          ],

          const SizedBox(height: 40), // spacing after all options
        ],
      ),
    );
  }

  Widget _buildOption(AnswerOption answerOption) {
    bool selected = false;
    if (answerOption.answer == widget.answerOption?.answer) {
      selected = true;
    }
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
                widget.onAnswerSelected(answerOption);
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
