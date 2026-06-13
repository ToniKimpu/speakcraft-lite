import 'package:flutter/material.dart';
import 'package:speakcraft/config/pmp_colors.dart';
import 'package:speakcraft/config/pmp_text_styles.dart';
import 'package:speakcraft/l10n/generated/l10n.dart';
import 'package:speakcraft/model/daily_speaking/daily_speaking_topic.dart';

/// Shared "prep kit" UI for the daily-speaking on-ramps. Used by both the
/// suggested-topic prep page and the own-topic AI scaffold so the two stay in
/// sync (this replaces the copies that used to live in each page).
///
/// - [PrepPromptCard] — the prompt banner (EN + MM + target time).
/// - [PrepGuideSections] — the collapsible guide: structure / words / phrases /
///   grammar / common mistakes / things-to-mention / example. Each section
///   renders only when its field is non-empty, so a partially-filled own-topic
///   scaffold (only the sections the learner chose) shows just those.

class PrepPromptCard extends StatelessWidget {
  const PrepPromptCard({super.key, required this.topic, required this.mins});
  final DailySpeakingTopic topic;
  final int mins;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.primary.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colorScheme.primary.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.format_quote, size: 18, color: colorScheme.primary),
              const SizedBox(width: 6),
              Text(
                AppLocalizations.of(context).txtDsYourPrompt,
                style: PmpTextStyles.labelSemi
                    .copyWith(color: colorScheme.primary),
              ),
              const Spacer(),
              Icon(Icons.timer_outlined,
                  size: 14, color: colorScheme.onSurfaceVariant),
              const SizedBox(width: 4),
              Text(
                AppLocalizations.of(context).txtDsApproxMin(mins),
                style: PmpTextStyles.sub
                    .copyWith(color: colorScheme.onSurfaceVariant),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            topic.promptEn,
            style: PmpTextStyles.body1Regular.copyWith(
              color: colorScheme.onSurface,
              height: 1.5,
            ),
          ),
          if (topic.promptMm.isNotEmpty) ...[
            const SizedBox(height: 10),
            Text(
              topic.promptMm,
              style: PmpTextStyles.body2Regular.copyWith(
                color: PmpColors.myanmarGloss(Theme.of(context).brightness),
                fontFamily: 'Noto Sans Myanmar',
                height: 1.7,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// The collapsible guide sections for a [topic]. Renders each section only when
/// its data is present; the structure section opens by default and the example
/// answer stays gated (collapsed) so it doesn't spoil the challenge.
class PrepGuideSections extends StatelessWidget {
  const PrepGuideSections({super.key, required this.topic});
  final DailySpeakingTopic topic;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (topic.outline.isNotEmpty)
          _CollapsibleSection(
            icon: Icons.list_alt_rounded,
            iconColor: colorScheme.primary,
            title: l10n.txtDsHowToStructure,
            initiallyExpanded: true,
            child: _OutlineList(steps: topic.outline),
          ),
        if (topic.vocabulary.isNotEmpty)
          _CollapsibleSection(
            icon: Icons.menu_book_outlined,
            iconColor: colorScheme.primary,
            title: l10n.txtDsWordsYouMightUse,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _TapHint(text: l10n.txtDsTapWordHint),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: topic.vocabulary
                      .map((v) => _VocabChip(item: v))
                      .toList(growable: false),
                ),
              ],
            ),
          ),
        if (topic.targetPhrases.isNotEmpty)
          _CollapsibleSection(
            icon: Icons.flag_outlined,
            iconColor: PmpColors.info500,
            title: l10n.txtDsTryUseThesePhrases,
            child: Column(
              children: [
                for (final p in topic.targetPhrases)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: _TargetPhraseCard(phrase: p),
                  ),
              ],
            ),
          ),
        if (topic.grammarPatterns.isNotEmpty)
          _CollapsibleSection(
            icon: Icons.account_tree_outlined,
            iconColor: PmpColors.info500,
            title: l10n.txtDsGrammarPatterns,
            child: Column(
              children: [
                for (final g in topic.grammarPatterns)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: _GrammarPatternCard(pattern: g),
                  ),
              ],
            ),
          ),
        if (topic.commonMistakes.isNotEmpty)
          _CollapsibleSection(
            icon: Icons.error_outline,
            iconColor: PmpColors.warning500,
            title: l10n.txtDsWatchOutFor,
            child: Column(
              children: [
                for (final m in topic.commonMistakes)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: _MistakeCard(mistake: m),
                  ),
              ],
            ),
          ),
        if (topic.warmupQuestions.isNotEmpty)
          _CollapsibleSection(
            icon: Icons.help_outline,
            iconColor: PmpColors.warning500,
            title: l10n.txtDsThingsYouCanMention,
            child: _WarmupList(questions: topic.warmupQuestions),
          ),
        if (topic.exampleAnswerEn.isNotEmpty)
          _CollapsibleSection(
            icon: Icons.visibility_outlined,
            iconColor: colorScheme.primary,
            title: l10n.txtDsPeekExample,
            child: _ExampleAnswer(
              en: topic.exampleAnswerEn,
              mm: topic.exampleAnswerMm,
            ),
          ),
      ],
    );
  }
}

class _CollapsibleSection extends StatefulWidget {
  const _CollapsibleSection({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.child,
    this.initiallyExpanded = false,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final Widget child;
  final bool initiallyExpanded;

  @override
  State<_CollapsibleSection> createState() => _CollapsibleSectionState();
}

class _CollapsibleSectionState extends State<_CollapsibleSection> {
  late bool _expanded = widget.initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Material(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: colorScheme.outlineVariant),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () => setState(() => _expanded = !_expanded),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    Icon(widget.icon, size: 18, color: widget.iconColor),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        widget.title,
                        style: PmpTextStyles.body2Semi
                            .copyWith(color: colorScheme.onSurface),
                      ),
                    ),
                    AnimatedRotation(
                      turns: _expanded ? 0.5 : 0,
                      duration: const Duration(milliseconds: 180),
                      child: Icon(Icons.keyboard_arrow_down,
                          color: colorScheme.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOut,
              alignment: Alignment.topCenter,
              child: _expanded
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
                      child: SizedBox(
                          width: double.infinity, child: widget.child),
                    )
                  : const SizedBox(width: double.infinity),
            ),
          ],
        ),
      ),
    );
  }
}

class _OutlineList extends StatelessWidget {
  const _OutlineList({required this.steps});
  final List<TopicOutlineStep> steps;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final mm = PmpColors.myanmarGloss(Theme.of(context).brightness);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < steps.length; i++)
          Padding(
            padding: EdgeInsets.only(bottom: i == steps.length - 1 ? 0 : 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _StepNumber(n: i + 1),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        steps[i].pointEn,
                        style: PmpTextStyles.body2Semi
                            .copyWith(color: colorScheme.onSurface),
                      ),
                      if (steps[i].pointMm.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(
                          steps[i].pointMm,
                          style: PmpTextStyles.label2Regular.copyWith(
                            color: mm,
                            fontFamily: 'Noto Sans Myanmar',
                            height: 1.5,
                          ),
                        ),
                      ],
                      if (steps[i].starterEn.isNotEmpty) ...[
                        const SizedBox(height: 6),
                        _StarterChip(text: steps[i].starterEn),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _StepNumber extends StatelessWidget {
  const _StepNumber({required this.n});
  final int n;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: 22,
      height: 22,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: colorScheme.primary.withValues(alpha: 0.14),
        shape: BoxShape.circle,
      ),
      child: Text(
        '$n',
        style: PmpTextStyles.subBold.copyWith(color: colorScheme.primary),
      ),
    );
  }
}

class _StarterChip extends StatelessWidget {
  const _StarterChip({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: colorScheme.primary.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colorScheme.primary.withValues(alpha: 0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.format_quote, size: 14, color: colorScheme.primary),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              style: PmpTextStyles.label2Regular.copyWith(
                color: colorScheme.onSurface,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GrammarPatternCard extends StatelessWidget {
  const _GrammarPatternCard({required this.pattern});
  final TopicGrammarPattern pattern;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final mm = PmpColors.myanmarGloss(Theme.of(context).brightness);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: PmpColors.info500.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              pattern.patternEn,
              style: PmpTextStyles.body2Semi.copyWith(color: PmpColors.info500),
            ),
          ),
          if (pattern.exampleEn.isNotEmpty) ...[
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.subdirectory_arrow_right,
                    size: 14, color: colorScheme.onSurfaceVariant),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    pattern.exampleEn,
                    style: PmpTextStyles.body2Regular.copyWith(
                      color: colorScheme.onSurface,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ],
          if (pattern.noteMm.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(
              pattern.noteMm,
              style: PmpTextStyles.label2Regular.copyWith(
                color: mm,
                fontFamily: 'Noto Sans Myanmar',
                height: 1.5,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _MistakeCard extends StatelessWidget {
  const _MistakeCard({required this.mistake});
  final TopicCommonMistake mistake;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final mm = PmpColors.myanmarGloss(Theme.of(context).brightness);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.close_rounded,
                  size: 16, color: PmpColors.destructive400),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  mistake.avoidEn,
                  style: PmpTextStyles.body2Regular.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    decoration: TextDecoration.lineThrough,
                    decorationColor: PmpColors.destructive400,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.check_rounded,
                  size: 16, color: PmpColors.success500),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  mistake.useEn,
                  style: PmpTextStyles.body2Semi
                      .copyWith(color: colorScheme.onSurface),
                ),
              ),
            ],
          ),
          if (mistake.noteMm.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              mistake.noteMm,
              style: PmpTextStyles.label2Regular.copyWith(
                color: mm,
                fontFamily: 'Noto Sans Myanmar',
                height: 1.5,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _WarmupList extends StatelessWidget {
  const _WarmupList({required this.questions});
  final List<String> questions;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final q in questions)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 7, right: 8),
                  child: Container(
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(
                      color: colorScheme.onSurface,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    q,
                    style: PmpTextStyles.body2Regular
                        .copyWith(color: colorScheme.onSurface),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _ExampleAnswer extends StatelessWidget {
  const _ExampleAnswer({required this.en, required this.mm});
  final String en;
  final String mm;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final mmColor = PmpColors.myanmarGloss(Theme.of(context).brightness);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            en,
            style: PmpTextStyles.body2Regular.copyWith(
              color: colorScheme.onSurface,
              height: 1.6,
            ),
          ),
          if (mm.isNotEmpty) ...[
            const SizedBox(height: 10),
            Text(
              mm,
              style: PmpTextStyles.body2Regular.copyWith(
                color: mmColor,
                fontFamily: 'Noto Sans Myanmar',
                height: 1.7,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _VocabChip extends StatelessWidget {
  const _VocabChip({required this.item});
  final TopicVocabItem item;

  void _showDetail(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (_) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.term,
              style: PmpTextStyles.h2.copyWith(color: colorScheme.onSurface),
            ),
            const SizedBox(height: 8),
            Text(
              item.definitionMm,
              style: PmpTextStyles.body1Regular.copyWith(
                color: colorScheme.onSurface,
                fontFamily: 'Noto Sans Myanmar',
                height: 1.6,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.txtDsExample,
              style: PmpTextStyles.labelSemi
                  .copyWith(color: colorScheme.onSurfaceVariant),
            ),
            const SizedBox(height: 6),
            Text(
              item.exampleEn,
              style: PmpTextStyles.body2Regular.copyWith(
                color: colorScheme.onSurface,
                fontStyle: FontStyle.italic,
              ),
            ),
            if (item.related.isNotEmpty) ...[
              const SizedBox(height: 18),
              Text(
                l10n.txtDsVocabRelatedTitle,
                style: PmpTextStyles.labelSemi
                    .copyWith(color: colorScheme.onSurfaceVariant),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: item.related
                    .map((w) => _WordChip(label: w))
                    .toList(growable: false),
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      avatar: const Icon(Icons.book_outlined, size: 16),
      label: Text(item.term),
      onPressed: () => _showDetail(context),
    );
  }
}

class _WordChip extends StatelessWidget {
  const _WordChip({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Text(
        label,
        style:
            PmpTextStyles.body2Regular.copyWith(color: colorScheme.onSurface),
      ),
    );
  }
}

class _TargetPhraseCard extends StatelessWidget {
  const _TargetPhraseCard({required this.phrase});
  final TopicTargetPhrase phrase;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            phrase.phraseEn,
            style:
                PmpTextStyles.body2Semi.copyWith(color: colorScheme.onSurface),
          ),
          const SizedBox(height: 4),
          Text(
            phrase.translationMm,
            style: PmpTextStyles.body2Regular.copyWith(
              color: PmpColors.myanmarGloss(Theme.of(context).brightness),
              fontFamily: 'Noto Sans Myanmar',
            ),
          ),
        ],
      ),
    );
  }
}

class _TapHint extends StatelessWidget {
  const _TapHint({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Icon(Icons.touch_app_outlined,
            size: 14, color: colorScheme.onSurfaceVariant),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            text,
            style: PmpTextStyles.sub.copyWith(
              color: colorScheme.onSurfaceVariant,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    );
  }
}
