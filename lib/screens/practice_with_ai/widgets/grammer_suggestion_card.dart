import 'package:flutter/material.dart';
import 'package:pmp_english/model/ai_sentence_practice/ai_sentence_practice.dart';

class GrammerSuggestionCard extends StatelessWidget {
  const GrammerSuggestionCard({
    super.key,
    required this.aiSentencePractice,
  });
  final AiSentencePractice aiSentencePractice;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      // color: const Color(0xFF0D1B2A),
      color: const Color(0xFF1C2C3C),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Row(
              children: [
                Icon(Icons.edit_note, color: Colors.amberAccent),
                SizedBox(width: 8),
                Text(
                  "Grammar Suggestion",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.amberAccent,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            /// ❌ User Input
            _sectionWithIcon(
              icon: Icons.close,
              label: "Your Input",
              backgroundColor: Colors.red.withValues(alpha: 0.15),
              textColor: Colors.redAccent,
              text: aiSentencePractice.inputSentence,
            ),

            const SizedBox(height: 16),

            /// ✅ Corrected Sentence
            _sectionWithIcon(
              icon: Icons.check_circle_outline,
              label: "Corrected",
              backgroundColor: Colors.green.withValues(alpha: 0.15),
              textColor: Colors.greenAccent,
              text: aiSentencePractice.correctedSentence!,
            ),

            const SizedBox(height: 16),

            /// 💬 Explanation
            _sectionWithIcon(
              icon: Icons.chat_bubble_outline,
              label: "Explanation",
              backgroundColor: Colors.white
                  .withValues(alpha: 0.08), // subtle translucent layer
              textColor: Colors.tealAccent[100]!, // friendly + high contrast
              text: aiSentencePractice.explanation!,
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
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
                    "Used ${aiSentencePractice.totalTokensUsed} tokens",
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
    );
  }

  Widget _sectionWithIcon({
    required IconData icon,
    required String label,
    required String text,
    required Color backgroundColor,
    required Color textColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: textColor),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: textColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            text,
            style: TextStyle(
              color: textColor.withValues(alpha: 0.85),
              fontSize: 15,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
