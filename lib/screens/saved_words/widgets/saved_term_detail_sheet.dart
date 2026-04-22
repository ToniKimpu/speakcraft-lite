import 'package:flutter/material.dart';
import 'package:pmp_english/config/pmp_colors.dart';
import 'package:pmp_english/config/pmp_text_styles.dart';
import 'package:pmp_english/model/saved_term/saved_term.dart';
import 'package:pmp_english/model/vocabulary/vocabulary.dart';

class SavedTermDetailSheet extends StatelessWidget {
  const SavedTermDetailSheet({
    super.key,
    required this.saved,
    required this.onRemove,
  });

  final SavedTerm saved;
  final Future<void> Function() onRemove;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final examples = saved.examples;

    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) => Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius:
              const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            _DragHandle(color: colorScheme.outlineVariant),
            Expanded(
              child: ListView(
                controller: scrollController,
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                children: [
                  _Header(term: saved.term, kind: saved.kind),
                  if ((saved.translationMy ?? '').isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Text(
                      saved.translationMy!,
                      style: PmpTextStyles.body1Regular.copyWith(
                        color: PmpColors.warning600,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                  if ((saved.definitionMy ?? '').isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      saved.definitionMy!,
                      style: PmpTextStyles.body2Regular.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        height: 1.6,
                      ),
                    ),
                  ],
                  if (examples.isNotEmpty) ...[
                    const SizedBox(height: 20),
                    _ExamplesViewer(examples: examples),
                  ],
                  if ((saved.sourceTitle ?? '').isNotEmpty) ...[
                    const SizedBox(height: 20),
                    _SourceLine(title: saved.sourceTitle!),
                  ],
                ],
              ),
            ),
            _RemoveButton(onRemove: onRemove),
          ],
        ),
      ),
    );
  }
}

class _DragHandle extends StatelessWidget {
  const _DragHandle({required this.color});
  final Color color;
  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.only(top: 10),
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(2),
        ),
      );
}

class _Header extends StatelessWidget {
  const _Header({required this.term, required this.kind});
  final String term;
  final String kind;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            term,
            style: PmpTextStyles.h1.copyWith(
              color: cs.onSurface,
              fontFamily: 'ArchivoBlack Regular',
              fontSize: 24,
            ),
          ),
        ),
        if (kind.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(left: 8, top: 4),
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: PmpColors.success400.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              kind,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: PmpColors.success400,
              ),
            ),
          ),
      ],
    );
  }
}

class _ExamplesViewer extends StatelessWidget {
  const _ExamplesViewer({required this.examples});
  final List<VocabularyExample> examples;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.format_quote_rounded,
              size: 18,
              color: cs.onSurfaceVariant,
            ),
            const SizedBox(width: 6),
            Text(
              'Examples',
              style: PmpTextStyles.body1Regular.copyWith(
                color: cs.onSurface,
                fontFamily: 'ArchivoBlack Regular',
                fontSize: 15,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
              decoration: BoxDecoration(
                color: cs.onSurface.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '${examples.length}',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: cs.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        for (int i = 0; i < examples.length; i++) ...[
          _ExampleCard(example: examples[i], index: i),
          if (i < examples.length - 1) const SizedBox(height: 10),
        ],
      ],
    );
  }
}

class _ExampleCard extends StatelessWidget {
  const _ExampleCard({required this.example, required this.index});
  final VocabularyExample example;
  final int index;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: PmpColors.info400.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '${index + 1}',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: PmpColors.info400,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  example.english,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: cs.onSurface,
                    fontFamily: 'ArchivoBlack Regular',
                    height: 1.5,
                  ),
                ),
                if (example.burmese.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Container(
                    height: 1,
                    color: cs.outlineVariant.withValues(alpha: 0.6),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    example.burmese,
                    style: TextStyle(
                      fontSize: 13,
                      color: cs.onSurfaceVariant,
                      fontFamily: 'MM Lyrics Bold',
                      height: 1.6,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SourceLine extends StatelessWidget {
  const _SourceLine({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      children: [
        Icon(
          Icons.link_rounded,
          size: 14,
          color: cs.onSurfaceVariant,
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            'From: $title',
            style: PmpTextStyles.body2Regular.copyWith(
              color: cs.onSurfaceVariant,
              fontStyle: FontStyle.italic,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}

class _RemoveButton extends StatelessWidget {
  const _RemoveButton({required this.onRemove});
  final Future<void> Function() onRemove;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          onPressed: () async {
            await onRemove();
            if (context.mounted) Navigator.pop(context);
          },
          style: OutlinedButton.styleFrom(
            foregroundColor: cs.error,
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
          icon: const Icon(Icons.delete_outline),
          label: const Text('Remove'),
        ),
      ),
    );
  }
}
