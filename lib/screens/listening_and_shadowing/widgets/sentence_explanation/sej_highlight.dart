import 'package:flutter/material.dart';

import '../../../../config/pmp_colors.dart';

/// Renders [text] with any [highlights] phrases marked (dotted underline +
/// accent colour, case-insensitive), so a term stands out in its sentence.
/// Shared by the main sentence card and the term example rows.
Widget buildHighlightedText(
  String text,
  List<String> highlights,
  TextStyle baseStyle,
) {
  final clean = highlights.where((h) => h.trim().isNotEmpty).toList();
  if (clean.isEmpty) return Text(text, style: baseStyle);

  final highlightStyle = baseStyle.copyWith(
    color: PmpColors.warning600,
    fontWeight: FontWeight.w700,
    decoration: TextDecoration.underline,
    decorationColor: PmpColors.warning400.withValues(alpha: 0.5),
    decorationStyle: TextDecorationStyle.dotted,
    decorationThickness: 2,
  );

  final pattern = clean.map((h) => RegExp.escape(h.trim())).join('|');
  final regex = RegExp('($pattern)', caseSensitive: false);

  final spans = <TextSpan>[];
  var lastEnd = 0;
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
