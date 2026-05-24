import 'package:flutter/material.dart';
import 'package:speakcraft/model/ai_sentence_practice/ai_sentence_practice.dart';
import 'package:speakcraft/screens/practice_with_ai/widgets/correct_sentence_card.dart';
import 'package:speakcraft/screens/practice_with_ai/widgets/grammer_suggestion_card.dart';

class AiReponseCard extends StatelessWidget {
  const AiReponseCard({
    super.key,
    required this.aiSentencePractice,
  });
  final AiSentencePractice aiSentencePractice;

  @override
  Widget build(BuildContext context) {
    if (aiSentencePractice.correctedSentence == null) {
      return CorrectSentenceCard(
        aiSentencePractice: aiSentencePractice,
      );
    }
    return GrammerSuggestionCard(
      aiSentencePractice: aiSentencePractice,
    );
  }
}
