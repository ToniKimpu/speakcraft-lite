import 'package:flutter/material.dart';

import '../../../config/pmp_colors.dart';
import '../../../config/pmp_text_styles.dart';
import '../../../model/writing/writing_lexicon.dart';
import '../../../model/writing/writing_unit.dart';
import '../writing_highlight.dart';
import 'writing_teach_helpers.dart';
import 'writing_word_banks.dart';

/// Step bodies + chrome for the step-by-step [WritingTeachStepsPage]. The pager
/// state lives in the page; these are the per-screen presentational widgets it
/// drives. The reference word banks they embed are the shared ones from
/// [writing_word_banks.dart]; the `Step`-prefixed cards here are this pager's
/// own flavour of the chrome (the single-scroll teach page uses its own).

/// One walkthrough card — a subject rule + a worked example + the *why*.
class Walk {
  const Walk(
      {required this.subject,
      required this.ruleMm,
      required this.en,
      required this.whyMm});
  final String subject;
  final String ruleMm;
  final String en;
  final String whyMm;

  factory Walk.fromJson(Map<String, dynamic> j) => Walk(
        subject: j['subject'] as String? ?? '',
        ruleMm: j['rule_mm'] as String? ?? '',
        en: j['en'] as String? ?? '',
        whyMm: j['why_mm'] as String? ?? '',
      );
}

// ─────────────────────────────────────────────────────────────────────────
// Step 1 — When + Read
// ─────────────────────────────────────────────────────────────────────────
class WhenStep extends StatelessWidget {
  const WhenStep({super.key, required this.teach});
  final WritingTeach teach;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final mm = PmpColors.myanmarGloss(Theme.of(context).brightness);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (teach.useMm.isNotEmpty)
          StepCard(
            icon: Icons.lightbulb_outline,
            child: Text(teach.useMm,
                style: PmpTextStyles.body2Regular
                    .copyWith(color: mm, height: 1.7)),
          ),
        const SizedBox(height: 14),
        const HighlightLegend(),
        const SizedBox(height: 12),
        StepCard(
          icon: Icons.menu_book_outlined,
          label: 'ဒါလေးကို အရင်ဖတ်ကြည့်ပါ',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HighlightedText(teach.situationEn,
                  style: PmpTextStyles.body1Regular
                      .copyWith(color: cs.onSurface, height: 1.7)),
              if (teach.situationMm.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(teach.situationMm,
                    style: PmpTextStyles.body2Regular
                        .copyWith(color: mm, height: 1.7)),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Step 2 — The pattern (form table + agreement buckets)
// ─────────────────────────────────────────────────────────────────────────
class PatternStep extends StatelessWidget {
  const PatternStep({super.key, required this.teach});
  final WritingTeach teach;

  Map<String, dynamic>? get _agreement {
    for (final b in teach.blocks) {
      if (b.type == 'agreement') return b.data;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final agreement = _agreement;
    final buckets = ((agreement?['buckets'] as List?) ?? const [])
        .map((e) => (e as Map).cast<String, dynamic>())
        .toList(growable: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (buckets.isNotEmpty)
          for (final b in buckets) ...[
            StepAgreementCard(data: b),
            const SizedBox(height: 8),
          ]
        else
          StepCard(child: FormTable(rows: teach.form)),
        if (teach.formNoteMm.isNotEmpty) ...[
          const SizedBox(height: 6),
          StepNoteCard(mm: teach.formNoteMm),
        ],
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Step 3 — Worked examples, explained (progressive reveal)
// ─────────────────────────────────────────────────────────────────────────
class WalkthroughStep extends StatelessWidget {
  const WalkthroughStep(
      {super.key,
      required this.items,
      required this.revealed,
      required this.onReveal});
  final List<Walk> items;
  final int revealed;
  final VoidCallback onReveal;

  @override
  Widget build(BuildContext context) {
    final shown = revealed.clamp(1, items.length);
    final hasMore = shown < items.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var i = 0; i < shown; i++) ...[
          WalkCard(item: items[i], index: i),
          const SizedBox(height: 10),
        ],
        if (hasMore)
          OutlinedButton.icon(
            onPressed: onReveal,
            icon: const Icon(Icons.add_rounded, size: 18),
            label: const Text('နောက်တစ်ခု'),
          ),
      ],
    );
  }
}

class WalkCard extends StatelessWidget {
  const WalkCard({super.key, required this.item, required this.index});
  final Walk item;
  final int index;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final mm = PmpColors.myanmarGloss(Theme.of(context).brightness);
    final verbColor = writingVerbColor(Theme.of(context).brightness);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // subject pill → rule
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: verbColor.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(item.subject,
                    style: PmpTextStyles.body2Semi.copyWith(color: verbColor)),
              ),
            ],
          ),
          if (item.ruleMm.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(item.ruleMm,
                style: PmpTextStyles.body2Semi.copyWith(color: mm)),
          ],
          const SizedBox(height: 10),
          HighlightedText('“${item.en}”',
              style: PmpTextStyles.body1Regular
                  .copyWith(color: cs.onSurface, height: 1.5)),
          if (item.whyMm.isNotEmpty) ...[
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: cs.primary.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.help_outline_rounded, size: 16, color: cs.primary),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(item.whyMm,
                        style: PmpTextStyles.body2Regular
                            .copyWith(color: mm, height: 1.7)),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Step 4 — Watch out (trap)
// ─────────────────────────────────────────────────────────────────────────
class TrapStep extends StatelessWidget {
  const TrapStep({super.key, required this.mm});
  final String mm;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: PmpColors.warning500.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: PmpColors.warning500.withValues(alpha: 0.4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.warning_amber_rounded,
              size: 20, color: PmpColors.warning600),
          const SizedBox(width: 10),
          Expanded(
            child: Text(mm,
                style: PmpTextStyles.body2Regular
                    .copyWith(color: cs.onSurfaceVariant, height: 1.7)),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Concept block: the frequency scale (how often → before the verb)
// ─────────────────────────────────────────────────────────────────────────

/// The frequency scale — each adverb on a bar from 100% (always) to 0% (never),
/// so learners *see* "how often" and that these words cluster before the verb.
class StepFrequencyScale extends StatelessWidget {
  const StepFrequencyScale({super.key, required this.adverbs});
  final List<LexiconTimeWord> adverbs;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final mm = PmpColors.myanmarGloss(Theme.of(context).brightness);
    const bar = PmpColors.accentOrange;
    return StepCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              'always, usually, often … စတဲ့ စကားလုံးတွေက verb ရဲ့ ရှေ့မှာ နေပါတယ်။',
              style:
                  PmpTextStyles.body2Regular.copyWith(color: mm, height: 1.6)),
          const SizedBox(height: 12),
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
                          widthFactor:
                              ((w.frequency ?? 0) / 100).clamp(0.0, 1.0),
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
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Get ready to write: word banks + model paragraph
// ─────────────────────────────────────────────────────────────────────────

/// The reference step before the exercises: every word bank the unit carries
/// (verbs / jobs / describing words / time phrases) + its notes, ending with the
/// model paragraph so the learner sees the target output before writing.
class ToolkitStep extends StatelessWidget {
  const ToolkitStep({super.key, required this.unit, required this.toolkit});
  final WritingUnit unit;
  final ResolvedToolkit toolkit;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final mm = PmpColors.myanmarGloss(Theme.of(context).brightness);
    final teach = unit.teach;
    final showExamples = showBankExamples(unit);
    final phrases = timePhrases(toolkit);

    final sections = <Widget>[];
    void add(Widget w) {
      if (sections.isNotEmpty) sections.add(const SizedBox(height: 14));
      sections.add(w);
    }

    if (toolkit.verbs.isNotEmpty) {
      add(StepCard(
        icon: Icons.handyman_outlined,
        label: 'Verbs you can use',
        child: VerbBank(
            verbs: toolkit.verbs,
            formKey: unit.toolkit.verbForm,
            showExamples: showExamples,
            overrides: unit.toolkit.verbExamples),
      ));
    }
    if (toolkit.nouns.isNotEmpty) {
      add(StepCard(
        icon: Icons.badge_outlined,
        label: 'Jobs & roles  ·  I am a …',
        child: SimpleWordBank(
          entries: [
            for (final n in toolkit.nouns)
              WordEntry(en: n.withArticle, mm: n.mm, examples: n.examples),
          ],
          showExamples: showExamples,
        ),
      ));
    }
    if (toolkit.adjectives.isNotEmpty) {
      add(StepCard(
        icon: Icons.palette_outlined,
        label: 'Describing words  ·  She is …',
        child: SimpleWordBank(
          entries: [
            for (final a in toolkit.adjectives)
              WordEntry(en: a.en, mm: a.mm, examples: a.examples),
          ],
          showExamples: showExamples,
        ),
      ));
    }
    if (unit.toolkit.noteMm.isNotEmpty) add(StepNoteCard(mm: unit.toolkit.noteMm));
    if (phrases.isNotEmpty) {
      add(StepCard(
        icon: Icons.event_outlined,
        label: 'Time phrases  ·  when',
        child: TimeWordBank(
            words: phrases,
            showExamples: showExamples,
            overrides: unit.toolkit.timeWordExamples),
      ));
    }
    if (unit.toolkit.timeWordsNoteMm.isNotEmpty) {
      add(StepNoteCard(mm: unit.toolkit.timeWordsNoteMm));
    }
    if (teach.hasModelParagraph) {
      add(StepCard(
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
      ));
    }

    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, children: sections);
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Shared chrome (pager flavour)
// ─────────────────────────────────────────────────────────────────────────

/// A labelled content card — optional icon + label header over its child.
class StepCard extends StatelessWidget {
  const StepCard({super.key, this.icon, this.label, required this.child});
  final IconData? icon;
  final String? label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null || icon != null) ...[
            Row(
              children: [
                if (icon != null) ...[
                  Icon(icon, size: 16, color: cs.primary),
                  const SizedBox(width: 6),
                ],
                if (label != null)
                  Text(label!.toUpperCase(),
                      style: PmpTextStyles.labelSemi.copyWith(
                          color: cs.onSurfaceVariant, letterSpacing: 0.6)),
              ],
            ),
            const SizedBox(height: 10),
          ],
          child,
        ],
      ),
    );
  }
}

/// One subject "bucket" — subject group → form + tag, with the worked example.
class StepAgreementCard extends StatelessWidget {
  const StepAgreementCard({super.key, required this.data});
  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final verbColor = writingVerbColor(Theme.of(context).brightness);
    final subjects = data['subjects']?.toString() ?? '';
    final form = data['form']?.toString() ?? '';
    final tag = data['tag']?.toString() ?? '';
    final example = data['example']?.toString() ?? '';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(subjects,
              style: PmpTextStyles.body2Semi.copyWith(color: cs.onSurface)),
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(Icons.arrow_forward_rounded,
                  size: 16, color: cs.onSurfaceVariant),
              const SizedBox(width: 6),
              Flexible(
                child: Text(form,
                    style: PmpTextStyles.body1Semi.copyWith(color: verbColor)),
              ),
              if (tag.isNotEmpty) ...[
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: cs.onSurfaceVariant.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(tag,
                      style: PmpTextStyles.sub.copyWith(
                          color: cs.onSurfaceVariant,
                          fontWeight: FontWeight.w600)),
                ),
              ],
            ],
          ),
          if (example.isNotEmpty) ...[
            const SizedBox(height: 6),
            HighlightedText('“$example”',
                style: PmpTextStyles.body2Regular
                    .copyWith(color: cs.onSurfaceVariant)),
          ],
        ],
      ),
    );
  }
}

class StepNoteCard extends StatelessWidget {
  const StepNoteCard({super.key, required this.mm});
  final String mm;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final mmColor = PmpColors.myanmarGloss(Theme.of(context).brightness);
    final lines = mm
        .split('\n')
        .map((l) => l.trim())
        .where((l) => l.isNotEmpty)
        .toList(growable: false);
    final style =
        PmpTextStyles.body2Regular.copyWith(color: mmColor, height: 1.7);
    return Container(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var i = 0; i < lines.length; i++)
                  Padding(
                    padding: EdgeInsets.only(top: i == 0 ? 0 : 7),
                    child: lines.length > 1
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('•  ', style: style),
                              Expanded(
                                  child:
                                      HighlightedText(lines[i], style: style)),
                            ],
                          )
                        : HighlightedText(lines[i], style: style),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// The step progress dots — the active one stretches into a pill.
class StepDots extends StatelessWidget {
  const StepDots({super.key, required this.count, required this.active});
  final int count;
  final int active;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      children: [
        for (var i = 0; i < count; i++) ...[
          AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            height: 6,
            width: i == active ? 26 : 6,
            decoration: BoxDecoration(
              color: i <= active
                  ? cs.primary
                  : cs.outlineVariant.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          if (i != count - 1) const SizedBox(width: 6),
        ],
      ],
    );
  }
}

class NavBar extends StatelessWidget {
  const NavBar({
    super.key,
    required this.showBack,
    required this.onBack,
    required this.primaryLabel,
    required this.primaryIcon,
    required this.onPrimary,
  });
  final bool showBack;
  final VoidCallback onBack;
  final String primaryLabel;
  final IconData primaryIcon;

  /// Null disables the primary button (e.g. the check gate before all answered).
  final VoidCallback? onPrimary;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 14),
      decoration: BoxDecoration(
        color: cs.surface,
        border: Border(top: BorderSide(color: cs.outlineVariant)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            if (showBack) ...[
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: OutlinedButton(
                    onPressed: onBack,
                    child: const Text('Back'),
                  ),
                ),
              ),
              const SizedBox(width: 12),
            ],
            Expanded(
              flex: 2,
              child: SizedBox(
                height: 50,
                child: FilledButton.icon(
                  onPressed: onPrimary,
                  icon: Icon(primaryIcon),
                  label: Text(primaryLabel),
                  style: FilledButton.styleFrom(
                    backgroundColor: cs.primary,
                    foregroundColor: cs.onPrimary,
                    disabledBackgroundColor:
                        cs.onSurface.withValues(alpha: 0.12),
                    disabledForegroundColor:
                        cs.onSurface.withValues(alpha: 0.38),
                    textStyle: PmpTextStyles.body1Semi,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
