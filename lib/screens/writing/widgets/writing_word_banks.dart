import 'package:flutter/material.dart';

import '../../../config/pmp_colors.dart';
import '../../../config/pmp_text_styles.dart';
import '../../../model/writing/writing_lexicon.dart';
import '../../../model/writing/writing_unit.dart';
import '../writing_highlight.dart';

/// Shared reference word banks for the writing teach screen
/// ([WritingTeachStepsPage]) — the verb / time-word / noun / adjective banks the
/// learner expands while studying a unit's toolkit.

/// A bilingual example row (bullet + English with highlight + Burmese gloss).
class ExampleRow extends StatelessWidget {
  const ExampleRow({super.key, required this.en, required this.mm});
  final String en;
  final String mm;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final mmColor = PmpColors.myanmarGloss(Theme.of(context).brightness);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
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

/// The subject → form table (e.g. `I / you` → base, `he / she / it` → +s).
class FormTable extends StatelessWidget {
  const FormTable({super.key, required this.rows});
  final List<FormRow> rows;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final verbColor = writingVerbColor(Theme.of(context).brightness);
    return Column(
      children: [
        for (var i = 0; i < rows.length; i++) ...[
          if (i > 0)
            Divider(
                height: 16, color: cs.outlineVariant.withValues(alpha: 0.6)),
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
                    style: PmpTextStyles.body2Semi.copyWith(color: verbColor)),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

/// The verb toolkit — each row collapses to `base → second-form` + gloss, and
/// expands to a bilingual example. Reinforces the form by showing both.
class VerbBank extends StatelessWidget {
  const VerbBank(
      {super.key,
      required this.verbs,
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
            VerbTile(
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

class VerbTile extends StatelessWidget {
  const VerbTile(
      {super.key,
      required this.verb,
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
        for (final ex in examples) ExampleRow(en: ex.en, mm: ex.mm),
      ],
    );
  }
}

/// The frequency / time-word toolkit — header shows the word + its position
/// rule (the part Burmese learners get wrong); expands to a bilingual example.
class TimeWordBank extends StatelessWidget {
  const TimeWordBank(
      {super.key,
      required this.words,
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
            TimeWordTile(
                word: words[i],
                showExamples: showExamples,
                exampleOverride: overrides[words[i].id]),
          ],
        ],
      ),
    );
  }
}

class TimeWordTile extends StatelessWidget {
  const TimeWordTile(
      {super.key,
      required this.word,
      required this.showExamples,
      required this.exampleOverride});
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
        for (final ex in examples) ExampleRow(en: ex.en, mm: ex.mm),
      ],
    );
  }
}

/// A plain (en + Burmese gloss) word for the adjective / noun banks. Unlike a
/// verb it has no second form, so the tile just shows the word and expands to a
/// bilingual example.
class WordEntry {
  const WordEntry({required this.en, required this.mm, required this.examples});
  final String en;
  final String mm;
  final List<ExamplePair> examples;
}

/// A simple word bank (adjectives / nouns) — expandable bilingual rows, mirroring
/// the verb / time-word banks but without a form column.
class SimpleWordBank extends StatelessWidget {
  const SimpleWordBank(
      {super.key, required this.entries, required this.showExamples});
  final List<WordEntry> entries;
  final bool showExamples;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < entries.length; i++) ...[
            if (i > 0)
              Divider(
                  height: 1, color: cs.outlineVariant.withValues(alpha: 0.5)),
            SimpleWordTile(entry: entries[i], showExamples: showExamples),
          ],
        ],
      ),
    );
  }
}

class SimpleWordTile extends StatelessWidget {
  const SimpleWordTile(
      {super.key, required this.entry, required this.showExamples});
  final WordEntry entry;
  final bool showExamples;

  @override
  Widget build(BuildContext context) {
    final mmColor = PmpColors.myanmarGloss(Theme.of(context).brightness);
    final verbColor = writingVerbColor(Theme.of(context).brightness);
    final title = Text(entry.en,
        style: PmpTextStyles.body1Semi.copyWith(color: verbColor));
    final subtitle = entry.mm.isEmpty
        ? null
        : Text(entry.mm,
            style: PmpTextStyles.body2Regular.copyWith(color: mmColor));
    final examples = showExamples ? entry.examples : const <ExamplePair>[];

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
        for (final ex in examples) ExampleRow(en: ex.en, mm: ex.mm),
      ],
    );
  }
}
