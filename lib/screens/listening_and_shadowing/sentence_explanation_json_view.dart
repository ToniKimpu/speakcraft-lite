import 'package:flutter/material.dart';

import 'widgets/sentence_explanation/sej_main_card.dart';
import 'widgets/sentence_explanation/sej_note_card.dart';
import 'widgets/sentence_explanation/sej_term_card.dart';

/// Renders a sentence-explanation JSON object (matching `__template.json`
/// schema) as a scrollable list of structured cards.
///
/// The [data] map must contain at minimum a `"main"` key and a `"terms"` list.
/// The optional `"note"` key, if present, is rendered at the bottom.
class SentenceExplanationJsonView extends StatelessWidget {
  const SentenceExplanationJsonView({super.key, required this.data});
  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    final main = data['main'] as Map<String, dynamic>?;
    final terms = (data['terms'] as List<dynamic>?) ?? [];
    final note = data['note'] as Map<String, dynamic>?;

    final sourceTitle = data['title'] as String?;
    final sourceSentence = main?['english'] as String?;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (main != null) ...[
          SejMainCard(main: main),
          const SizedBox(height: 20),
        ],
        for (final t in terms)
          Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: SejTermCard(
              term: t as Map<String, dynamic>,
              sourceTitle: sourceTitle,
              sourceSentence: sourceSentence,
            ),
          ),
        if (note != null) ...[
          const SizedBox(height: 4),
          SejNoteCard(note: note),
          const SizedBox(height: 24),
        ],
      ],
    );
  }
}
