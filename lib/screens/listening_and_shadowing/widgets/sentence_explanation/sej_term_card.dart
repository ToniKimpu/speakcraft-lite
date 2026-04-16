import 'package:flutter/material.dart';

import '../../../../config/pmp_colors.dart';
import 'sej_example_row.dart';

class SejTermCard extends StatelessWidget {
  const SejTermCard({super.key, required this.term});
  final Map<String, dynamic> term;

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
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.04),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(colorScheme, number, termText, kind),
          _buildBody(colorScheme, translationMy, definitionMy, items, examples),
        ],
      ),
    );
  }

  Widget _buildHeader(
    ColorScheme cs,
    int number,
    String termText,
    String kind,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: PmpColors.info400.withValues(alpha: 0.08),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
        border: Border(bottom: BorderSide(color: cs.outlineVariant)),
      ),
      child: Row(
        children: [
          Container(
            width: 26,
            height: 26,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: PmpColors.info400.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '$number',
              style: const TextStyle(
                color: PmpColors.info400,
                fontSize: 13,
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
                color: cs.onSurface,
              ),
            ),
          ),
          if (kind.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: PmpColors.success400.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                kind,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: PmpColors.success400,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBody(
    ColorScheme cs,
    String translationMy,
    String definitionMy,
    List<dynamic> items,
    List<dynamic> examples,
  ) {
    return Container(
      color: cs.surface,
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (translationMy.isNotEmpty || definitionMy.isNotEmpty)
            Text.rich(
              TextSpan(children: [
                if (translationMy.isNotEmpty)
                  TextSpan(
                    text: definitionMy.isNotEmpty
                        ? '$translationMy '
                        : translationMy,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: PmpColors.warning600,
                    ),
                  ),
                if (definitionMy.isNotEmpty)
                  TextSpan(
                    text: definitionMy,
                    style: TextStyle(
                      fontSize: 13,
                      color: cs.onSurfaceVariant,
                      height: 1.5,
                    ),
                  ),
              ]),
            ),
          if (items.isNotEmpty) ...[
            const SizedBox(height: 12),
            for (final item in items)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: SejExampleRow(
                  english:
                      (item as Map<String, dynamic>)['english'] as String? ??
                          '',
                  burmese: item['burmese'] as String? ?? '',
                ),
              ),
          ],
          if (examples.isNotEmpty) ...[
            const SizedBox(height: 10),
            Divider(color: cs.outlineVariant),
            const SizedBox(height: 8),
            for (int i = 0; i < examples.length; i++)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: SejExampleRow(
                  english: (examples[i] as Map<String, dynamic>)['english']
                          as String? ??
                      '',
                  burmese: (examples[i] as Map<String, dynamic>)['burmese']
                          as String? ??
                      '',
                  index: i,
                ),
              ),
          ],
        ],
      ),
    );
  }
}
