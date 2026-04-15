import 'package:flutter/material.dart';

/// Renders a sentence-explanation JSON object (matching `__template.json`
/// schema) as a scrollable list of structured cards.
///
/// The [data] map must contain at minimum a `"main"` key and a `"terms"` list.
/// The optional `"note"` key, if present, is rendered at the bottom.
class SentenceExplanationJsonView extends StatelessWidget {
  final Map<String, dynamic> data;

  const SentenceExplanationJsonView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final main = data['main'] as Map<String, dynamic>?;
    final terms = (data['terms'] as List<dynamic>?) ?? [];
    final note = data['note'] as Map<String, dynamic>?;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (main != null) ...[
          _SejMainCard(main: main),
          const SizedBox(height: 16),
        ],

        ...terms.map((t) {
          final term = t as Map<String, dynamic>;
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _SejTermCard(term: term),
          );
        }),

        if (note != null) ...[
          const SizedBox(height: 4),
          _SejNoteCard(note: note),
          const SizedBox(height: 24),
        ],
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Main sentence card
// ─────────────────────────────────────────────────────────────────────────────
class _SejMainCard extends StatelessWidget {
  final Map<String, dynamic> main;

  const _SejMainCard({required this.main});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final english = main['english'] as String? ?? '';
    final burmese = main['burmese'] as String? ?? '';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            english,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(height: 8),
          Divider(
            color: colorScheme.onPrimaryContainer.withValues(alpha: 0.2),
          ),
          const SizedBox(height: 4),
          Text(
            burmese,
            style: TextStyle(
              fontSize: 14,
              color: colorScheme.onPrimaryContainer.withValues(alpha: 0.85),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Term card
// ─────────────────────────────────────────────────────────────────────────────
class _SejTermCard extends StatelessWidget {
  final Map<String, dynamic> term;

  const _SejTermCard({required this.term});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final number = term['number'] as int? ?? 0;
    final kind = term['kind'] as String? ?? '';
    final termText = term['term'] as String? ?? '';
    final translationMy = term['translation_my'] as String? ?? '';
    final definitionMy = term['definition_my'] as String? ?? '';
    final examples = (term['examples'] as List<dynamic>?) ?? [];
    final items = (term['items'] as List<dynamic>?) ?? [];

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '$number',
                    style: TextStyle(
                      color: colorScheme.onPrimary,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    termText,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    kind,
                    style: TextStyle(
                      fontSize: 11,
                      color: colorScheme.onSecondaryContainer,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Body
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (translationMy.isNotEmpty) ...[
                  Text(
                    translationMy,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 6),
                ],
                if (definitionMy.isNotEmpty)
                  Text(
                    definitionMy,
                    style: TextStyle(
                      fontSize: 13,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),

                // Items (vocabulary table rows)
                if (items.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  ...items.map((item) {
                    final i = item as Map<String, dynamic>;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: _SejExampleRow(
                        english: i['english'] as String? ?? '',
                        burmese: i['burmese'] as String? ?? '',
                        colorScheme: colorScheme,
                      ),
                    );
                  }),
                ],

                // Examples
                if (examples.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  Divider(color: colorScheme.outlineVariant),
                  const SizedBox(height: 6),
                  ...examples.map((ex) {
                    final e = ex as Map<String, dynamic>;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: _SejExampleRow(
                        english: e['english'] as String? ?? '',
                        burmese: e['burmese'] as String? ?? '',
                        colorScheme: colorScheme,
                      ),
                    );
                  }),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Example / item row (shared)
// ─────────────────────────────────────────────────────────────────────────────
class _SejExampleRow extends StatelessWidget {
  final String english;
  final String burmese;
  final ColorScheme colorScheme;

  const _SejExampleRow({
    required this.english,
    required this.burmese,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          english,
          style: TextStyle(
            fontSize: 13,
            fontStyle: FontStyle.italic,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          burmese,
          style: TextStyle(
            fontSize: 12,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Note card
// ─────────────────────────────────────────────────────────────────────────────
class _SejNoteCard extends StatelessWidget {
  final Map<String, dynamic> note;

  const _SejNoteCard({required this.note});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final titleMy = note['title_my'] as String? ?? '';
    final bodyMy = note['body_my'] as String? ?? '';

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colorScheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (titleMy.isNotEmpty)
            Text(
              titleMy,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: colorScheme.onTertiaryContainer,
              ),
            ),
          if (titleMy.isNotEmpty && bodyMy.isNotEmpty)
            const SizedBox(height: 6),
          if (bodyMy.isNotEmpty)
            Text(
              bodyMy,
              style: TextStyle(
                fontSize: 13,
                color: colorScheme.onTertiaryContainer,
              ),
            ),
        ],
      ),
    );
  }
}
