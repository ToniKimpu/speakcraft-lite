import 'package:flutter/material.dart';

import '../../../../config/pmp_colors.dart';

class SejMainCard extends StatelessWidget {
  const SejMainCard({super.key, required this.main});
  final Map<String, dynamic> main;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final english = main['english'] as String? ?? '';
    final burmese = main['burmese'] as String? ?? '';
    final highlights = (main['highlights'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ??
        [];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: PmpColors.warning400.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
        border:
            Border.all(color: PmpColors.warning400.withValues(alpha: 0.35)),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHighlightedText(
            english,
            highlights,
            TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: colorScheme.onSurface,
              fontFamily: 'ArchivoBlack Regular',
              height: 1.4,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 1,
            color: PmpColors.warning400.withValues(alpha: 0.25),
          ),
          const SizedBox(height: 8),
          Text(
            burmese,
            style: TextStyle(
              fontSize: 14,
              color: colorScheme.onSurfaceVariant,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHighlightedText(
    String text,
    List<String> highlights,
    TextStyle baseStyle,
  ) {
    if (highlights.isEmpty) return Text(text, style: baseStyle);

    final highlightStyle = baseStyle.copyWith(
      color: PmpColors.warning600,
      decoration: TextDecoration.underline,
      decorationColor: PmpColors.warning400.withValues(alpha: 0.5),
      decorationStyle: TextDecorationStyle.dotted,
      decorationThickness: 2,
    );

    final pattern = highlights.map((h) => RegExp.escape(h)).join('|');
    final regex = RegExp('($pattern)', caseSensitive: false);

    final spans = <TextSpan>[];
    int lastEnd = 0;
    for (final match in regex.allMatches(text)) {
      if (match.start > lastEnd) {
        spans.add(TextSpan(text: text.substring(lastEnd, match.start)));
      }
      spans.add(TextSpan(text: match.group(0), style: highlightStyle));
      lastEnd = match.end;
    }
    if (lastEnd < text.length) {
      spans.add(TextSpan(text: text.substring(lastEnd)));
    }

    return Text.rich(TextSpan(style: baseStyle, children: spans));
  }
}
