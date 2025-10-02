import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:pmp_english/model/ai_sentence_practice/ai_sentence_practice.dart';

class CorrectSentenceCard extends StatefulWidget {
  final AiSentencePractice aiSentencePractice;

  const CorrectSentenceCard({
    super.key,
    required this.aiSentencePractice,
  });

  @override
  State<CorrectSentenceCard> createState() => _CorrectSentenceCardState();
}

class _CorrectSentenceCardState extends State<CorrectSentenceCard> {
  late ConfettiController _confettiController;
  final List<String> _praiseMessages = [
    "Correct!", // Simple and clear
    "Well done!", // Polite and encouraging
    "Perfect!", // Strong, precise praise
    "Spot on!", // Confirms accuracy
    "Great job!", // Friendly, positive
    "Nicely done!", // Polished alternative to "You nailed it"
    "Excellent!", // Encouraging without being over-the-top
    "Impressive!" // Optional, for translations that are particularly good
  ];

  final List<String> _confirmationMessages = [
    "🎉 Your sentence is grammatically correct!",
    "✅ That’s spot on — no errors found!",
    "👏 Everything looks perfect!",
    "🎯 You got it just right!",
    "🌟 Grammar check passed with flying colors!",
    "🙌 Nailed it! No corrections needed.",
  ];

  late final String selectedPraise;
  late final String selectedConfirmation;

  @override
  void initState() {
    super.initState();
    selectedPraise = _praiseMessages[Random().nextInt(_praiseMessages.length)];
    selectedConfirmation =
        _confirmationMessages[Random().nextInt(_confirmationMessages.length)];
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 2));
    _confettiController.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Card(
          elevation: 4,
          color: const Color(0xFF1C3B2C),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.emoji_events,
                        color: Colors.amber, size: 28),
                    const SizedBox(width: 10),
                    Text(
                      selectedPraise,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  selectedConfirmation,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.greenAccent.withValues(alpha: 0.9),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "✅ \"${widget.aiSentencePractice.inputSentence}\"",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    height: 1.4,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Icon(
                      Icons.info,
                      size: 18,
                      color: Colors.white24,
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Tooltip(
                      message: "Tokens are units of text processed by the AI.",
                      child: Text(
                        "Used ${widget.aiSentencePractice.totalTokensUsed} tokens",
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        ),
        ConfettiWidget(
          confettiController: _confettiController,
          blastDirectionality: BlastDirectionality.explosive,
          shouldLoop: false,
          maxBlastForce: 10,
          minBlastForce: 5,
          emissionFrequency: 0.05,
          numberOfParticles: 20,
          gravity: 0.3,
        ),
      ],
    );
  }
}
