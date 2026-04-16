import 'package:flutter/material.dart';
import '../../../config/pmp_colors.dart';
import '../../../config/pmp_text_styles.dart';

/// Renders a grammar-pattern explanation from structured JSON sections.
///
/// Each section has a `type` key that selects a widget:
/// `intro`, `heading`, `explanation`, `agreement`, `note`,
/// `table`, `examples`, `practice`, `tip`.
class GrammarExplanationJsonView extends StatelessWidget {
  const GrammarExplanationJsonView({
    super.key,
    required this.pattern,
    required this.sections,
  });

  final String pattern;
  final List<dynamic> sections;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      children: [
        _PatternCard(pattern: pattern),
        const SizedBox(height: 20),
        for (final section in sections) ...[
          _buildSection(context, colorScheme, section as Map<String, dynamic>),
          const SizedBox(height: 20),
        ],
      ],
    );
  }

  Widget _buildSection(
    BuildContext context,
    ColorScheme cs,
    Map<String, dynamic> s,
  ) {
    switch (s['type'] as String?) {
      case 'intro':
        return _IntroSection(text: s['text'] as String? ?? '');
      case 'heading':
        return _HeadingSection(text: s['text'] as String? ?? '');
      case 'explanation':
        return _ExplanationSection(
          title: s['title'] as String?,
          items: (s['items'] as List<dynamic>?) ?? [],
        );
      case 'agreement':
        return _AgreementSection(
          note: s['note'] as String?,
          groups: (s['groups'] as List<dynamic>?) ?? [],
          footnote: s['footnote'] as String?,
        );
      case 'note':
        return _NoteSection(
          title: s['title'] as String?,
          text: s['text'] as String? ?? '',
        );
      case 'table':
        return _TableSection(
          title: s['title'] as String?,
          headers: (s['headers'] as List<dynamic>?)
                  ?.map((e) => e.toString())
                  .toList() ??
              [],
          rows: (s['rows'] as List<dynamic>?)
                  ?.map((r) =>
                      (r as List<dynamic>).map((c) => c.toString()).toList())
                  .toList() ??
              [],
          footnote: s['footnote'] as String?,
        );
      case 'examples':
        return _ExamplesSection(
          title: s['title'] as String?,
          items: (s['items'] as List<dynamic>?) ?? [],
        );
      case 'practice':
        return _PracticeSection(
          title: s['title'] as String?,
          instruction: s['instruction'] as String?,
          words: (s['words'] as List<dynamic>?) ?? [],
          example: s['example'] as String?,
        );
      case 'tip':
        return _TipSection(text: s['text'] as String? ?? '');
      default:
        return const SizedBox.shrink();
    }
  }
}

// ─── Accent color constants ─────────────────────────────────────
// Semantic colors for educational content — keeps app chrome B&W
// but makes learning material vibrant and engaging.

const _gold = PmpColors.warning400;
const _goldDark = PmpColors.warning600;
const _green = PmpColors.success400;
const _red = PmpColors.destructive400;
const _blue = PmpColors.info400;

const _accentColors = [_green, _red, _blue, _gold];

// ─── Pattern card ───────────────────────────────────────────────

class _PatternCard extends StatelessWidget {
  const _PatternCard({required this.pattern});
  final String pattern;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
      decoration: BoxDecoration(
        color: _gold.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _gold.withValues(alpha: 0.4)),
        boxShadow: [
          BoxShadow(
            color: cs.shadow.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        pattern,
        textAlign: TextAlign.center,
        style: PmpTextStyles.body1Regular.copyWith(
          color: _goldDark,
          fontWeight: FontWeight.bold,
          fontSize: 18,
          letterSpacing: 0.5,
          fontFamily: 'ArchivoBlack Regular',
        ),
      ),
    );
  }
}

// ─── Intro ──────────────────────────────────────────────────────

class _IntroSection extends StatelessWidget {
  const _IntroSection({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: PmpTextStyles.body2Regular.copyWith(
        color: Theme.of(context).colorScheme.onSurface,
        fontSize: 15,
        height: 1.7,
      ),
    );
  }
}

// ─── Heading ────────────────────────────────────────────────────

class _HeadingSection extends StatelessWidget {
  const _HeadingSection({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return _SectionTitle(text: text);
  }
}

// ─── Explanation (term + definition pairs) ──────────────────────

class _ExplanationSection extends StatelessWidget {
  const _ExplanationSection({this.title, required this.items});
  final String? title;
  final List<dynamic> items;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          _SectionTitle(text: title!),
          const SizedBox(height: 10),
        ],
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: cs.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int i = 0; i < items.length; i++) ...[
                if (i > 0) const SizedBox(height: 10),
                _buildTermRow(cs, items[i] as Map<String, dynamic>),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTermRow(ColorScheme cs, Map<String, dynamic> item) {
    return Text.rich(
      TextSpan(children: [
        TextSpan(
          text: '${item['term']}: ',
          style: const TextStyle(
            color: _green,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        TextSpan(
          text: item['definition'] as String? ?? '',
          style: TextStyle(color: cs.onSurface, fontSize: 14, height: 1.5),
        ),
      ]),
    );
  }
}

// ─── Agreement (subject-verb groups) ────────────────────────────

class _AgreementSection extends StatelessWidget {
  const _AgreementSection({
    this.note,
    required this.groups,
    this.footnote,
  });
  final String? note;
  final List<dynamic> groups;
  final String? footnote;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (note != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              note!,
              style: TextStyle(color: cs.onSurfaceVariant, fontSize: 14),
            ),
          ),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            for (int i = 0; i < groups.length; i++)
              _buildGroupChip(
                cs,
                groups[i] as Map<String, dynamic>,
                _accentColors[i % _accentColors.length],
              ),
          ],
        ),
        if (footnote != null)
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              footnote!,
              style: const TextStyle(
                color: _gold,
                fontSize: 13,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildGroupChip(
    ColorScheme cs,
    Map<String, dynamic> g,
    Color accent,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border(
          bottom: BorderSide(color: accent, width: 3),
        ),
      ),
      child: Column(
        children: [
          Text(
            g['subjects'] as String? ?? '',
            style: TextStyle(
              color: cs.onSurface,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            g['verb'] as String? ?? '',
            style: TextStyle(
              color: accent,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Note ───────────────────────────────────────────────────────

class _NoteSection extends StatelessWidget {
  const _NoteSection({this.title, required this.text});
  final String? title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          _SectionTitle(text: title!),
          const SizedBox(height: 10),
        ],
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _gold.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(12),
            border: const Border(
              left: BorderSide(color: _goldDark, width: 4),
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 14,
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Table ──────────────────────────────────────────────────────

class _TableSection extends StatelessWidget {
  const _TableSection({
    this.title,
    required this.headers,
    required this.rows,
    this.footnote,
  });
  final String? title;
  final List<String> headers;
  final List<List<String>> rows;
  final String? footnote;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          _SectionTitle(text: title!),
          const SizedBox(height: 10),
        ],
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: cs.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
          ),
          clipBehavior: Clip.antiAlias,
          child: Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              if (headers.isNotEmpty)
                TableRow(
                  decoration: BoxDecoration(
                    color: _gold.withValues(alpha: 0.1),
                    border: Border(
                      bottom: BorderSide(color: cs.outlineVariant),
                    ),
                  ),
                  children: [
                    for (final h in headers)
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          h,
                          style: const TextStyle(
                            color: _goldDark,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                  ],
                ),
              for (int i = 0; i < rows.length; i++)
                TableRow(
                  decoration: i < rows.length - 1
                      ? BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: cs.outlineVariant.withValues(alpha: 0.5),
                            ),
                          ),
                        )
                      : null,
                  children: [
                    for (final cell in rows[i])
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          cell,
                          style: TextStyle(
                            color: cs.onSurface,
                            fontSize: 13,
                          ),
                        ),
                      ),
                  ],
                ),
            ],
          ),
        ),
        if (footnote != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              footnote!,
              style: TextStyle(
                color: cs.onSurfaceVariant,
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
      ],
    );
  }
}

// ─── Examples ───────────────────────────────────────────────────

class _ExamplesSection extends StatelessWidget {
  const _ExamplesSection({this.title, required this.items});
  final String? title;
  final List<dynamic> items;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          _SectionTitle(text: title!),
          const SizedBox(height: 10),
        ],
        for (int i = 0; i < items.length; i++) ...[
          if (i > 0) const SizedBox(height: 8),
          _buildExampleCard(cs, i, items[i] as Map<String, dynamic>),
        ],
      ],
    );
  }

  Widget _buildExampleCard(
      ColorScheme cs, int index, Map<String, dynamic> item) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: cs.shadow.withValues(alpha: 0.04),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              color: _blue.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                '${index + 1}',
                style: const TextStyle(
                  color: _blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['english'] as String? ?? '',
                  style: TextStyle(
                    color: cs.onSurface,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    fontFamily: 'ArchivoBlack Regular',
                  ),
                ),
                if (item['burmese'] != null &&
                    (item['burmese'] as String).isNotEmpty)
                  Text(
                    '(${item['burmese']})',
                    style: TextStyle(
                      color: cs.onSurfaceVariant,
                      fontSize: 13,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Practice ───────────────────────────────────────────────────

class _PracticeSection extends StatelessWidget {
  const _PracticeSection({
    this.title,
    this.instruction,
    required this.words,
    this.example,
  });
  final String? title;
  final String? instruction;
  final List<dynamic> words;
  final String? example;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _green.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _green, width: 2),
      ),
      child: Column(
        children: [
          if (title != null)
            Text(
              title!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: _green,
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
          if (instruction != null) ...[
            const SizedBox(height: 8),
            Text(
              instruction!,
              textAlign: TextAlign.center,
              style: TextStyle(color: cs.onSurfaceVariant, fontSize: 13),
            ),
          ],
          const SizedBox(height: 12),
          for (final w in words)
            _buildWordChip(cs, w as Map<String, dynamic>),
          if (example != null) ...[
            const SizedBox(height: 12),
            Text(
              example!,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: cs.onSurfaceVariant,
                fontSize: 13,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildWordChip(ColorScheme cs, Map<String, dynamic> w) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Text.rich(
        TextSpan(children: [
          TextSpan(
            text: '${w['word']} ',
            style: const TextStyle(
              color: _goldDark,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          TextSpan(
            text: '(${w['translation']})',
            style: TextStyle(color: cs.onSurfaceVariant, fontSize: 13),
          ),
        ]),
      ),
    );
  }
}

// ─── Tip ────────────────────────────────────────────────────────

class _TipSection extends StatelessWidget {
  const _TipSection({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _blue.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _blue.withValues(alpha: 0.4)),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontSize: 14,
        ),
      ),
    );
  }
}

// ─── Shared section title ───────────────────────────────────────

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      decoration: const BoxDecoration(
        border: Border(left: BorderSide(color: _blue, width: 4)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontWeight: FontWeight.bold,
          fontSize: 17,
        ),
      ),
    );
  }
}
