import 'package:flutter/material.dart';

import 'sej_highlight.dart';

class SejExampleRow extends StatelessWidget {
  const SejExampleRow({
    super.key,
    required this.english,
    required this.burmese,
    this.highlight = const [],
    this.index,
  });

  final String english;
  final String burmese;

  /// Phrases within [english] to mark (the term in use), so it's obvious.
  final List<String> highlight;
  final int? index;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (index != null)
          Padding(
            padding: const EdgeInsets.only(right: 8, top: 1),
            child: Container(
              width: 20,
              height: 20,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: colorScheme.onSurface.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '${index! + 1}',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildHighlightedText(
                english,
                highlight,
                TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: colorScheme.onSurface,
                  fontFamily: 'ArchivoBlack Regular',
                ),
              ),
              if (burmese.isNotEmpty) ...[
                const SizedBox(height: 2),
                Text(
                  burmese,
                  style: TextStyle(
                    fontSize: 12,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
