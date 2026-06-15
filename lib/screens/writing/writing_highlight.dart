import 'package:flutter/material.dart';

import '../../config/pmp_colors.dart';

/// Writing module — the shared **inline highlighter**.
///
/// Authored English content marks its teaching points with two inline tokens:
/// - `{v}wakes up{/v}` → a **verb** (rendered in the primary/teal colour)
/// - `{t}every day{/t}` → a **frequency / time word** (rendered in accent orange)
///
/// This is the one place that knows the colour language, so every screen
/// (teach + practice + feedback) highlights identically. Burmese glosses are
/// authored without markup and pass through untouched.
///
/// Colour alone is never the only signal — highlighted spans are also
/// semibold, so the distinction survives in greyscale / for colour-blind users.
///
/// NB: we do **not** use `cs.primary` for the verb colour — in this app's dark
/// theme `primary` is white, which would vanish against the white body text.
/// We use an explicit teal that stays vivid on both the dark and light surfaces.

/// Verb highlight — a vivid teal on both themes (never white).
Color writingVerbColor(Brightness b) =>
    b == Brightness.dark ? PmpColors.primary400 : PmpColors.primary500;

/// Time / frequency-word highlight — accent orange on both themes.
Color writingTimeColor(Brightness b) => PmpColors.accentOrange;

/// Matches `{v}…{/v}` or `{t}…{/t}` (a mismatched close tag is tolerated — the
/// open tag decides the colour).
final RegExp _kHighlightToken = RegExp(r'\{(v|t)\}(.*?)\{/[vt]\}', dotAll: true);

/// Builds the inline spans for [text], colouring `{v}`/`{t}` runs. Falls back to
/// a single plain span when there is no markup, so it is safe to call on any
/// string.
List<InlineSpan> buildHighlightSpans(
  String text, {
  required Color verbColor,
  required Color timeColor,
}) {
  final spans = <InlineSpan>[];
  var last = 0;
  for (final m in _kHighlightToken.allMatches(text)) {
    if (m.start > last) {
      spans.add(TextSpan(text: text.substring(last, m.start)));
    }
    final isVerb = m.group(1) == 'v';
    spans.add(TextSpan(
      text: m.group(2),
      style: TextStyle(
        color: isVerb ? verbColor : timeColor,
        fontWeight: FontWeight.w700,
      ),
    ));
    last = m.end;
  }
  if (last < text.length) {
    spans.add(TextSpan(text: text.substring(last)));
  }
  return spans;
}

/// Renders authored text with `{v}`/`{t}` markup highlighted. Drop-in for a
/// plain [Text] in teach / practice / feedback.
class HighlightedText extends StatelessWidget {
  const HighlightedText(
    this.text, {
    super.key,
    required this.style,
    this.textAlign = TextAlign.start,
  });

  final String text;
  final TextStyle style;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    final b = Theme.of(context).brightness;
    return RichText(
      textAlign: textAlign,
      text: TextSpan(
        style: style,
        children: buildHighlightSpans(
          text,
          verbColor: writingVerbColor(b),
          timeColor: writingTimeColor(b),
        ),
      ),
    );
  }
}

/// The colour-key shown once at the top of a teach page so the highlight colours
/// read as instruction ("this word is a verb"), not decoration.
class HighlightLegend extends StatelessWidget {
  const HighlightLegend({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Row(
        children: [
          Icon(Icons.palette_outlined, size: 15, color: cs.onSurfaceVariant),
          const SizedBox(width: 8),
          _LegendDot(
              color: writingVerbColor(Theme.of(context).brightness),
              label: 'verb'),
          const SizedBox(width: 14),
          const _LegendDot(color: PmpColors.accentOrange, label: 'time word'),
          const Spacer(),
          Text('shown in colour below',
              style: TextStyle(color: cs.onSurfaceVariant, fontSize: 11)),
        ],
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  const _LegendDot({required this.color, required this.label});
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 10, height: 10,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text(label,
            style: TextStyle(
                color: color, fontWeight: FontWeight.w700, fontSize: 12.5)),
      ],
    );
  }
}
