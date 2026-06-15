import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../../config/pmp_colors.dart';
import '../../config/pmp_text_styles.dart';
import '../../config/pmp_routes.dart';
import '../../model/writing/writing_unit.dart';
import '../../model/writing/writing_lexicon.dart';
import 'writing_highlight.dart';

/// Writing module — **Phase-0 prototype**. The "Teach" step of one grammar unit
/// (Present simple), loaded from a bundled JSON asset. Renders the fixed 6-part
/// template — situation → use (+timeline) → form → Burmese trap → examples — and
/// hands off to the exercise ladder.
///
/// Inline English chrome for now (like the daily-speaking prototype);
/// intl-ize before ship. Authored Burmese is data and already bilingual.
class WritingTeachPage extends StatefulWidget {
  const WritingTeachPage({super.key, this.assetPath = _kDefaultUnitAsset});

  static const _kDefaultUnitAsset = 'assets/writing/units/l1_present_simple.json';

  final String assetPath;

  @override
  State<WritingTeachPage> createState() => _WritingTeachPageState();
}

/// The unit plus its toolkit resolved against the shared lexicon.
class _TeachData {
  const _TeachData({required this.unit, required this.toolkit});
  final WritingUnit unit;
  final ResolvedToolkit toolkit;
}

/// Frequency adverbs (how often → before the verb), highest frequency first.
List<LexiconTimeWord> _frequencyAdverbs(ResolvedToolkit t) {
  final list =
      t.timeWords.where((w) => w.isFrequencyAdverb).toList(growable: false);
  list.sort((a, b) => (b.frequency ?? 0).compareTo(a.frequency ?? 0));
  return list;
}

/// Time phrases (when → end of sentence), in authored order.
List<LexiconTimeWord> _timePhrases(ResolvedToolkit t) =>
    t.timeWords.where((w) => !w.isFrequencyAdverb).toList(growable: false);

/// The shared lexicon stores **positive present-simple** examples, so they only
/// fit an affirmative present-simple unit (`verb_form: third`). For negatives /
/// questions (`base`) or continuous (`ing`) those examples are off-message, so
/// the banks show form-only (the unit's own Examples section carries the
/// tense-correct sentences).
bool _showBankExamples(WritingUnit unit) => unit.toolkit.verbForm == 'third';

class _WritingTeachPageState extends State<WritingTeachPage> {
  late final Future<_TeachData> _data = _load();

  Future<_TeachData> _load() async {
    final raw = await rootBundle.loadString(widget.assetPath);
    final unit = WritingUnit.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    final lexicon = await loadWritingLexicon();
    final toolkit = ResolvedToolkit(
      verbs: lexicon.resolveVerbs(unit.toolkit.verbIds),
      timeWords: lexicon.resolveTimeWords(unit.toolkit.timeWordIds),
    );
    return _TeachData(unit: unit, toolkit: toolkit);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Writing')),
      body: FutureBuilder<_TeachData>(
        future: _data,
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError || !snap.hasData) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text('Could not load this lesson.\n${snap.error ?? ''}',
                    textAlign: TextAlign.center),
              ),
            );
          }
          return _TeachBody(unit: snap.data!.unit, toolkit: snap.data!.toolkit);
        },
      ),
    );
  }
}

class _TeachBody extends StatelessWidget {
  const _TeachBody({required this.unit, required this.toolkit});
  final WritingUnit unit;
  final ResolvedToolkit toolkit;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final mm = PmpColors.myanmarGloss(Theme.of(context).brightness);
    final teach = unit.teach;

    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header: level chip + title.
                  Row(
                    children: [
                      _Chip(label: 'Level ${unit.level}'),
                      const SizedBox(width: 8),
                      _Chip(label: unit.section, tonal: true),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    unit.title,
                    style: PmpTextStyles.h1.copyWith(
                      color: cs.onSurface,
                      fontFamily: 'ArchivoBlack Regular',
                    ),
                  ),
                  if (unit.subtitleMm.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(unit.subtitleMm,
                          style:
                              PmpTextStyles.body2Regular.copyWith(color: mm)),
                    ),
                  const SizedBox(height: 16),

                  // Colour key — teaches the highlight language up front.
                  const HighlightLegend(),
                  const SizedBox(height: 20),

                  // ① Situation
                  _Section(
                    icon: Icons.menu_book_outlined,
                    label: 'ဒါလေးကို အရင်ဖတ်ကြည့်ပါ',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HighlightedText(teach.situationEn,
                            style: PmpTextStyles.body1Regular
                                .copyWith(color: cs.onSurface, height: 1.6)),
                        if (teach.situationMm.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Text(teach.situationMm,
                              style: PmpTextStyles.body2Regular
                                  .copyWith(color: mm, height: 1.6)),
                        ],
                      ],
                    ),
                  ),

                  // ② Use + timeline
                  _Section(
                    icon: Icons.lightbulb_outline,
                    label: 'ဘယ်လိုအချိန်မှာ အသုံးပြုမှာလဲ',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(teach.useEn,
                            style: PmpTextStyles.body1Regular
                                .copyWith(color: cs.onSurface)),
                        if (teach.useMm.isNotEmpty) ...[
                          const SizedBox(height: 6),
                          Text(teach.useMm,
                              style: PmpTextStyles.body2Regular
                                  .copyWith(color: mm, height: 1.6)),
                        ],
                        if (teach.timeline.isNotEmpty) ...[
                          const SizedBox(height: 12),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10),
                            decoration: BoxDecoration(
                              color: cs.primary.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              teach.timeline,
                              textAlign: TextAlign.center,
                              style: PmpTextStyles.body2Semi.copyWith(
                                  color: cs.primary,
                                  fontFeatures: const [],
                                  letterSpacing: 0.5),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  // ③ Form table
                  _Section(
                    icon: Icons.grid_view_rounded,
                    label: 'Subject နှင့် Verb ဘယ်လိုတွဲမလဲ',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _FormTable(rows: teach.form),
                        if (teach.formNoteMm.isNotEmpty) ...[
                          const SizedBox(height: 12),
                          _InlineNote(mm: teach.formNoteMm),
                        ],
                      ],
                    ),
                  ),

                  // ④ Burmese trap
                  if (teach.trapEn.isNotEmpty || teach.trapMm.isNotEmpty)
                    _TrapCard(en: teach.trapEn, mm: teach.trapMm),

                  // ⑤ Examples
                  _Section(
                    icon: Icons.format_quote_rounded,
                    label: 'Examples',
                    child: Column(
                      children: [
                        for (final ex in teach.examples)
                          _ExampleRow(en: ex.en, mm: ex.mm),
                      ],
                    ),
                  ),

                  // ⑥ Toolkit — verbs + time words to build with.
                  if (toolkit.verbs.isNotEmpty)
                    _Section(
                      icon: Icons.handyman_outlined,
                      label: 'ဒီ verbs တွေနှင့် လေ့ကျင့်ကြည့်ပါ',
                      child: _VerbBank(
                          verbs: toolkit.verbs,
                          formKey: unit.toolkit.verbForm,
                          showExamples: _showBankExamples(unit),
                          overrides: unit.toolkit.verbExamples),
                    ),

                  // Bespoke teach blocks (e.g. the frequency scale) sit in the
                  // toolkit region, on top of the fixed spine.
                  for (final block in unit.teach.blocks)
                    _TeachBlockView(block: block, toolkit: toolkit),

                  // Time phrases (the "when" group) + the Burmese how-to note.
                  if (_timePhrases(toolkit).isNotEmpty)
                    _Section(
                      icon: Icons.event_outlined,
                      label: 'Time phrases  ·  when',
                      child: _TimeWordBank(
                          words: _timePhrases(toolkit),
                          showExamples: _showBankExamples(unit),
                          overrides: unit.toolkit.timeWordExamples),
                    ),
                  if (unit.toolkit.timeWordsNoteMm.isNotEmpty)
                    _NoteCard(mm: unit.toolkit.timeWordsNoteMm),

                  // ⑦ Model paragraph — see the toolkit used before you write.
                  if (teach.hasModelParagraph)
                    _Section(
                      icon: Icons.auto_stories_outlined,
                      label: 'See it all together',
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HighlightedText(teach.modelParagraphEn,
                              style: PmpTextStyles.body1Regular
                                  .copyWith(color: cs.onSurface, height: 1.7)),
                          if (teach.modelParagraphMm.isNotEmpty) ...[
                            const SizedBox(height: 10),
                            Text(teach.modelParagraphMm,
                                style: PmpTextStyles.body2Regular
                                    .copyWith(color: mm, height: 1.7)),
                          ],
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),

          // Sticky CTA → exercise ladder.
          _StartBar(
            count: unit.exercises.length,
            onStart: () => Navigator.pushNamed(
              context,
              PmpRoutes.writingPractice,
              arguments: {'unit': unit, 'toolkit': toolkit},
            ),
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label, this.tonal = false});
  final String label;
  final bool tonal;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final bg = tonal
        ? cs.surfaceContainerHighest
        : cs.primary.withValues(alpha: 0.12);
    final fg = tonal ? cs.onSurfaceVariant : cs.primary;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
        border: tonal ? Border.all(color: cs.outlineVariant) : null,
      ),
      child: Text(label, style: PmpTextStyles.labelSemi.copyWith(color: fg)),
    );
  }
}

/// A labelled teach block: a small icon + label header over its content card.
class _Section extends StatelessWidget {
  const _Section(
      {required this.icon, required this.label, required this.child});
  final IconData icon;
  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: cs.primary),
              const SizedBox(width: 6),
              Text(label.toUpperCase(),
                  style: PmpTextStyles.labelSemi.copyWith(
                      color: cs.onSurfaceVariant, letterSpacing: 0.6)),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: cs.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: cs.outlineVariant),
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}

class _FormTable extends StatelessWidget {
  const _FormTable({required this.rows});
  final List<FormRow> rows;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      children: [
        for (var i = 0; i < rows.length; i++) ...[
          if (i > 0)
            Divider(height: 16, color: cs.outlineVariant.withValues(alpha: 0.6)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child: Text(rows[i].subject,
                    style: PmpTextStyles.body2Regular
                        .copyWith(color: cs.onSurfaceVariant)),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 4,
                child: Text(rows[i].form,
                    style: PmpTextStyles.body2Semi.copyWith(
                        color: writingVerbColor(
                            Theme.of(context).brightness))),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

class _TrapCard extends StatelessWidget {
  const _TrapCard({required this.en, required this.mm});
  final String en;
  final String mm;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: PmpColors.warning500.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: PmpColors.warning500.withValues(alpha: 0.4)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.warning_amber_rounded,
                    size: 16, color: PmpColors.warning600),
                const SizedBox(width: 6),
                Text('COMMON MISTAKE',
                    style: PmpTextStyles.labelSemi.copyWith(
                        color: PmpColors.warning600, letterSpacing: 0.6)),
              ],
            ),
            const SizedBox(height: 8),
            if (en.isNotEmpty)
              Text(en,
                  style: PmpTextStyles.body2Semi.copyWith(color: cs.onSurface)),
            if (mm.isNotEmpty) ...[
              const SizedBox(height: 6),
              Text(mm,
                  style: PmpTextStyles.body2Regular.copyWith(
                      color: cs.onSurfaceVariant, height: 1.6)),
            ],
          ],
        ),
      ),
    );
  }
}

class _ExampleRow extends StatelessWidget {
  const _ExampleRow({required this.en, required this.mm});
  final String en;
  final String mm;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final mmColor = PmpColors.myanmarGloss(Theme.of(context).brightness);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2, right: 8),
            child: Icon(Icons.circle, size: 6, color: cs.primary),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HighlightedText(en,
                    style: PmpTextStyles.body1Regular
                        .copyWith(color: cs.onSurface)),
                if (mm.isNotEmpty)
                  Text(mm,
                      style:
                          PmpTextStyles.body2Regular.copyWith(color: mmColor)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// The verb toolkit — each row collapses to `base → third (+s)` + gloss, and
/// expands to a bilingual example. Reinforces the -s by showing both forms.
class _VerbBank extends StatelessWidget {
  const _VerbBank(
      {required this.verbs,
      required this.formKey,
      required this.showExamples,
      required this.overrides});
  final List<LexiconVerb> verbs;
  final String formKey;
  final bool showExamples;
  final Map<String, ExamplePair> overrides;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < verbs.length; i++) ...[
            if (i > 0)
              Divider(
                  height: 1, color: cs.outlineVariant.withValues(alpha: 0.5)),
            _VerbTile(
                verb: verbs[i],
                formKey: formKey,
                showExamples: showExamples,
                exampleOverride: overrides[verbs[i].id]),
          ],
        ],
      ),
    );
  }
}

class _VerbTile extends StatelessWidget {
  const _VerbTile(
      {required this.verb,
      required this.formKey,
      required this.showExamples,
      required this.exampleOverride});
  final LexiconVerb verb;
  final String formKey;
  final bool showExamples;
  final ExamplePair? exampleOverride;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final mmColor = PmpColors.myanmarGloss(Theme.of(context).brightness);
    final second = verb.secondForm(formKey);
    final verbColor = writingVerbColor(Theme.of(context).brightness);
    final examples = exampleOverride != null
        ? [exampleOverride!]
        : (showExamples ? verb.examples : const <ExamplePair>[]);

    // base → form (e.g. work → works / working); or just the base form when the
    // unit uses the verb in its base form (after don't/doesn't, do/does).
    final title = (second == verb.base)
        ? Text(verb.base,
            style: PmpTextStyles.body1Semi.copyWith(color: verbColor))
        : RichText(
            text: TextSpan(
              style: PmpTextStyles.body1Regular.copyWith(color: cs.onSurface),
              children: [
                TextSpan(text: verb.base),
                TextSpan(
                    text: '  →  ',
                    style: TextStyle(color: cs.onSurfaceVariant)),
                TextSpan(
                    text: second,
                    style: PmpTextStyles.body1Semi.copyWith(color: verbColor)),
              ],
            ),
          );
    final subtitle = verb.mm.isEmpty
        ? null
        : Text(verb.mm,
            style: PmpTextStyles.body2Regular.copyWith(color: mmColor));

    // No example for this unit → a plain (non-expandable) reference row.
    if (examples.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [title, if (subtitle != null) subtitle],
        ),
      );
    }
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      childrenPadding: const EdgeInsets.only(left: 4, bottom: 10),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      title: title,
      subtitle: subtitle,
      children: [
        for (final ex in examples) _ExampleRow(en: ex.en, mm: ex.mm),
      ],
    );
  }
}

/// The frequency / time-word toolkit — header shows the word + its position
/// rule (the part Burmese learners get wrong); expands to a bilingual example.
class _TimeWordBank extends StatelessWidget {
  const _TimeWordBank(
      {required this.words,
      required this.showExamples,
      required this.overrides});
  final List<LexiconTimeWord> words;
  final bool showExamples;
  final Map<String, ExamplePair> overrides;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < words.length; i++) ...[
            if (i > 0)
              Divider(
                  height: 1, color: cs.outlineVariant.withValues(alpha: 0.5)),
            _TimeWordTile(
                word: words[i],
                showExamples: showExamples,
                exampleOverride: overrides[words[i].id]),
          ],
        ],
      ),
    );
  }
}

class _TimeWordTile extends StatelessWidget {
  const _TimeWordTile(
      {required this.word, required this.showExamples, required this.exampleOverride});
  final LexiconTimeWord word;
  final bool showExamples;
  final ExamplePair? exampleOverride;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final mmColor = PmpColors.myanmarGloss(Theme.of(context).brightness);
    final title = Row(
      children: [
        Flexible(
          child: Text(word.en,
              style: PmpTextStyles.body1Semi.copyWith(color: cs.onSurface)),
        ),
        if (word.positionLabel.isNotEmpty) ...[
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: cs.primary.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(word.positionLabel,
                style: PmpTextStyles.sub.copyWith(color: cs.primary)),
          ),
        ],
      ],
    );
    final subtitle = word.mm.isEmpty
        ? null
        : Text(word.mm,
            style: PmpTextStyles.body2Regular.copyWith(color: mmColor));
    final examples = exampleOverride != null
        ? [exampleOverride!]
        : (showExamples ? word.examples : const <ExamplePair>[]);

    if (examples.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [title, if (subtitle != null) subtitle],
        ),
      );
    }
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      childrenPadding: const EdgeInsets.only(left: 4, bottom: 10),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      title: title,
      subtitle: subtitle,
      children: [
        for (final ex in examples) _ExampleRow(en: ex.en, mm: ex.mm),
      ],
    );
  }
}

/// Renders one optional teach block against the block registry. Unknown types
/// render nothing, so content can be authored ahead of app support.
class _TeachBlockView extends StatelessWidget {
  const _TeachBlockView({required this.block, required this.toolkit});
  final TeachBlock block;
  final ResolvedToolkit toolkit;

  @override
  Widget build(BuildContext context) {
    switch (block.type) {
      case 'frequency_scale':
        final adverbs = _frequencyAdverbs(toolkit);
        if (adverbs.isEmpty) return const SizedBox.shrink();
        return _Section(
          icon: Icons.bar_chart_rounded,
          label: 'How often  ·  before the verb',
          child: _FrequencyScale(adverbs: adverbs),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}

/// The frequency scale — each adverb on a bar from 100% (always) to 0% (never),
/// so learners *see* "how often" and that these words cluster before the verb.
class _FrequencyScale extends StatelessWidget {
  const _FrequencyScale({required this.adverbs});
  final List<LexiconTimeWord> adverbs;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    const bar = PmpColors.accentOrange;
    return Column(
      children: [
        for (final w in adverbs)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              children: [
                SizedBox(
                  width: 84,
                  child: Text(w.en,
                      style: PmpTextStyles.body2Semi.copyWith(color: bar)),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Container(
                      height: 12,
                      color: bar.withValues(alpha: 0.12),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: ((w.frequency ?? 0) / 100).clamp(0.0, 1.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: bar.withValues(alpha: 0.55),
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 36,
                  child: Text('${w.frequency ?? 0}%',
                      textAlign: TextAlign.right,
                      style: PmpTextStyles.sub
                          .copyWith(color: cs.onSurfaceVariant)),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

/// A light Burmese note that sits *inside* an existing section card (e.g. under
/// the form table) — a thin divider + tip icon, no card chrome of its own.
class _InlineNote extends StatelessWidget {
  const _InlineNote({required this.mm});
  final String mm;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final mmColor = PmpColors.myanmarGloss(Theme.of(context).brightness);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(height: 1, color: cs.outlineVariant.withValues(alpha: 0.6)),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.tips_and_updates_outlined, size: 17, color: cs.primary),
            const SizedBox(width: 9),
            Expanded(
              child: Text(mm,
                  style: PmpTextStyles.body2Regular
                      .copyWith(color: mmColor, height: 1.7)),
            ),
          ],
        ),
      ],
    );
  }
}

/// A small Burmese "how to use" note (e.g. the adverb-position rule).
class _NoteCard extends StatelessWidget {
  const _NoteCard({required this.mm});
  final String mm;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final mmColor = PmpColors.myanmarGloss(Theme.of(context).brightness);
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: cs.primary.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: cs.primary.withValues(alpha: 0.25)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.tips_and_updates_outlined, size: 18, color: cs.primary),
            const SizedBox(width: 10),
            Expanded(
              child: Text(mm,
                  style: PmpTextStyles.body2Regular
                      .copyWith(color: mmColor, height: 1.7)),
            ),
          ],
        ),
      ),
    );
  }
}

class _StartBar extends StatelessWidget {
  const _StartBar({required this.count, required this.onStart});
  final int count;
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
      decoration: BoxDecoration(
        color: cs.surface,
        border: Border(top: BorderSide(color: cs.outlineVariant)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 52,
          child: FilledButton.icon(
            onPressed: onStart,
            icon: const Icon(Icons.edit_note_rounded),
            label: Text('Start exercises  ·  $count'),
            style: FilledButton.styleFrom(
              backgroundColor: cs.primary,
              foregroundColor: cs.onPrimary,
              textStyle: PmpTextStyles.body1Semi,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
            ),
          ),
        ),
      ),
    );
  }
}
