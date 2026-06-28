import 'package:flutter/material.dart';

import '../../../config/pmp_text_styles.dart';

/// Shows an explanation with Burmese as the primary language and English
/// available as support — the "both, hierarchical" pattern.
///
/// - both present, short  → MM primary + smaller muted EN beneath
/// - both present, [long] → MM inline + a "Show English" expander
/// - only one present     → shows it (graceful fallback; e.g. before the
///   Gemini Burmese pass fills `_mm`, this shows the English)
class BilingualText extends StatefulWidget {
  const BilingualText({
    super.key,
    required this.mm,
    required this.en,
    this.long = false,
    this.style,
    this.color,
  });

  final String mm;
  final String en;

  /// Long prose hides EN behind an expander instead of stacking it inline.
  final bool long;

  /// Primary text style (EN fallback uses the same).
  final TextStyle? style;
  final Color? color;

  @override
  State<BilingualText> createState() => _BilingualTextState();
}

class _BilingualTextState extends State<BilingualText> {
  bool _showEn = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final mm = widget.mm.trim();
    final en = widget.en.trim();
    if (mm.isEmpty && en.isEmpty) return const SizedBox.shrink();

    final primaryStyle = (widget.style ?? PmpTextStyles.body2Regular)
        .copyWith(color: widget.color ?? cs.onSurface, height: 1.45);
    final mutedStyle = PmpTextStyles.label2Regular
        .copyWith(color: cs.onSurfaceVariant, height: 1.4);

    // No Burmese yet → English is the primary (fallback).
    if (mm.isEmpty) return Text(en, style: primaryStyle);

    final primary = Text(mm, style: primaryStyle);
    if (en.isEmpty) return primary;

    // Both present.
    if (!widget.long) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          primary,
          const SizedBox(height: 3),
          Text(en, style: mutedStyle),
        ],
      );
    }

    // Long prose → expander.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        primary,
        const SizedBox(height: 4),
        InkWell(
          onTap: () => setState(() => _showEn = !_showEn),
          borderRadius: BorderRadius.circular(6),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(_showEn ? Icons.expand_less : Icons.expand_more,
                    size: 16, color: cs.primary),
                const SizedBox(width: 2),
                Text(_showEn ? 'Hide English' : 'Show English',
                    style: PmpTextStyles.label2Regular
                        .copyWith(color: cs.primary)),
              ],
            ),
          ),
        ),
        if (_showEn)
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text(en, style: mutedStyle),
          ),
      ],
    );
  }
}
