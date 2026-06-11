part of 'feedback_result_page.dart';

/// The transcript preview at the top of the result page — the first few lines
/// of what the learner said, with a "Review & highlights" entry point to the
/// full annotated transcript (inline error highlights + native compare). The
/// button only shows for v2 payloads that carry an annotated transcript.
class _InputPreviewCard extends StatelessWidget {
  const _InputPreviewCard({
    required this.title,
    required this.text,
    required this.canReview,
    required this.onReview,
  });

  final String title;
  final String text;
  final bool canReview;
  final VoidCallback onReview;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: PmpTextStyles.body2Semi.copyWith(color: colorScheme.onSurface),
          ),
          const SizedBox(height: 8),
          Text(
            text,
            maxLines: 6,
            overflow: TextOverflow.ellipsis,
            style: PmpTextStyles.body1Regular.copyWith(
              color: colorScheme.onSurfaceVariant,
              height: 1.6,
            ),
          ),
          if (canReview) ...[
            const SizedBox(height: 6),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: onReview,
                icon: const Icon(Icons.highlight_alt, size: 18),
                label: Text(l10n.txtDsReviewHighlights),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// The coaching sections, rendered in a fixed order as a plain column (the page
/// itself scrolls). Each block is conditional on its data being present.
///
/// When the payload carries an annotated transcript (`sentences[]`), the inline
/// categories — grammar fixes, vocab upgrades, Burmese interference and
/// sentence rewrites — are shown on the Review & highlights screen instead of
/// here, so this body keeps to the cross-cutting coaching (scores, strengths,
/// patterns, collocations, idioms, pronunciation, fillers, summary). Legacy
/// payloads (no `sentences[]`) still show the flat lists inline.
class _FeedbackSections extends StatelessWidget {
  const _FeedbackSections({required this.session});

  final DailySpeakingSession session;

  @override
  Widget build(BuildContext context) {
    final feedback = session.feedback;
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    // Inline error categories live on the Review screen when we have an
    // annotated transcript; only fall back to flat lists for legacy payloads.
    final showInlineLists = !feedback.hasSentences;
    final fillerWords = feedback.effectiveFillerWords;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (feedback.inferredTopic != null) ...[
          const SizedBox(height: 16),
          _TopicChip(label: feedback.inferredTopic!),
        ],
        if (feedback.subScores != null) ...[
          const SizedBox(height: 16),
          _Section(
            icon: Icons.bar_chart,
            iconColor: colorScheme.primary,
            title: l10n.txtDsSkillBreakdown,
            child: _SubScoresCard(scores: feedback.subScores!),
          ),
        ],
        if (feedback.strengths.isNotEmpty) ...[
          const SizedBox(height: 20),
          _Section(
            icon: Icons.star_outline,
            iconColor: PmpColors.success500,
            title: l10n.txtDsWhatYouDidWell,
            count: feedback.strengths.length,
            child: _BulletList(items: feedback.strengths),
          ),
        ],
        if (showInlineLists && feedback.effectiveFixes.isNotEmpty) ...[
          const SizedBox(height: 16),
          _Section(
            icon: Icons.tune,
            iconColor: PmpColors.warning500,
            title: l10n.txtDsThingsToFix,
            count: feedback.effectiveFixes.length,
            child: _CollapsibleColumn(
              children: feedback.effectiveFixes
                  .map((f) => _FixCard(fix: f))
                  .toList(growable: false),
            ),
          ),
        ],
        if (feedback.grammarPatterns.isNotEmpty) ...[
          const SizedBox(height: 16),
          _Section(
            icon: Icons.rule,
            iconColor: PmpColors.warning500,
            title: l10n.txtDsGrammarPatterns,
            count: feedback.grammarPatterns.length,
            child: _BulletList(items: feedback.grammarPatterns),
          ),
        ],
        if (showInlineLists && feedback.effectiveInterference.isNotEmpty) ...[
          const SizedBox(height: 16),
          _Section(
            icon: Icons.translate,
            iconColor: PmpColors.destructive400,
            title: l10n.txtDsBurmeseErrors,
            count: feedback.effectiveInterference.length,
            child: _CollapsibleColumn(
              children: feedback.effectiveInterference
                  .map((f) => _FixCard(fix: f))
                  .toList(growable: false),
            ),
          ),
        ],
        // "Better word choices" is a vocabulary enrichment the learner opts into
        // (like phrases below), not a transcript error category — so it stays on
        // this page regardless of schema version, even though under v2 the same
        // vocab segments are also highlighted inline on the Review screen.
        if (feedback.effectiveVocabUpgrades.isNotEmpty) ...[
          const SizedBox(height: 16),
          _Section(
            icon: Icons.upgrade,
            iconColor: PmpColors.info500,
            title: l10n.txtDsBetterWordChoices,
            count: feedback.effectiveVocabUpgrades.length,
            child: _CollapsibleColumn(
              children: feedback.effectiveVocabUpgrades
                  .map((v) => _VocabUpgradeRow(upgrade: v))
                  .toList(growable: false),
            ),
          ),
        ],
        if (feedback.phrases.isNotEmpty) ...[
          const SizedBox(height: 16),
          _Section(
            icon: Icons.lightbulb_outline,
            iconColor: PmpColors.accentOrange,
            title: l10n.txtDsPhrasesToTry,
            count: feedback.phrases.length,
            child: _PhrasesToTry(phrases: feedback.phrases),
          ),
        ],
        if (showInlineLists && feedback.effectiveSentenceRewrites.isNotEmpty) ...[
          const SizedBox(height: 16),
          _Section(
            icon: Icons.format_quote,
            iconColor: colorScheme.primary,
            title: l10n.txtDsSentenceRewritesTitle,
            count: feedback.effectiveSentenceRewrites.length,
            child: _CollapsibleColumn(
              children: feedback.effectiveSentenceRewrites
                  .map((s) => _SentenceRewriteCard(rewrite: s))
                  .toList(growable: false),
            ),
          ),
        ],
        if (feedback.targetPhraseResults.isNotEmpty) ...[
          const SizedBox(height: 16),
          _Section(
            icon: Icons.flag_outlined,
            iconColor: PmpColors.info500,
            title: l10n.txtDsTargetPhrases,
            count: feedback.targetPhraseResults.length,
            child: Column(
              children: feedback.targetPhraseResults
                  .map((p) => _TargetPhraseRow(result: p))
                  .toList(growable: false),
            ),
          ),
        ],
        if (feedback.pronunciationNotes.isNotEmpty) ...[
          const SizedBox(height: 16),
          _Section(
            icon: Icons.graphic_eq,
            iconColor: colorScheme.tertiary,
            title: l10n.txtDsPronunciationNotes,
            count: feedback.pronunciationNotes.length,
            child: _BulletList(items: feedback.pronunciationNotes),
          ),
        ],
        if (fillerWords.isNotEmpty) ...[
          const SizedBox(height: 16),
          _Section(
            icon: Icons.bubble_chart_outlined,
            iconColor: colorScheme.tertiary,
            title: l10n.txtDsFillerWords,
            count: fillerWords.length,
            child: _ChipWrap(
              labels: fillerWords
                  .map((f) => '${f.word} ×${f.count}')
                  .toList(growable: false),
            ),
          ),
        ],
        if (feedback.explanationMm.isNotEmpty) ...[
          const SizedBox(height: 16),
          _Section(
            icon: Icons.translate,
            iconColor: PmpColors.accentOrange,
            title: l10n.txtDsSummaryMm,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: PmpColors.accentOrange.withValues(alpha: 0.07),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: PmpColors.accentOrange.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 1, right: 10),
                    child: Icon(Icons.format_quote,
                        size: 20, color: PmpColors.accentOrange),
                  ),
                  Expanded(
                    child: Text(
                      feedback.explanationMm,
                      style: PmpTextStyles.body1Regular.copyWith(
                        color: colorScheme.onSurface,
                        fontFamily: 'Noto Sans Myanmar',
                        height: 1.7,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}

/// The footer actions. For a loopable session, "Polish & retry" is the primary
/// nudge and "Done" is a quiet companion beside it; for a one-shot result,
/// "Done" is a single full-width finish. Compact, single-row — no oversized
/// stacked buttons.
class _ResultActions extends StatelessWidget {
  const _ResultActions({
    required this.canRetry,
    required this.onRetry,
    required this.onDone,
  });

  final bool canRetry;
  final VoidCallback onRetry;
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (!canRetry) {
      return SizedBox(
        width: double.infinity,
        child: FilledButton(
          onPressed: onDone,
          child: Text(l10n.txtDone),
        ),
      );
    }
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: onDone,
            child: Text(l10n.txtDone),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 2,
          child: FilledButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh, size: 18),
            label: Text(l10n.txtDsPolishRetry),
          ),
        ),
      ],
    );
  }
}

/// The finish recap: a quick, celebratory look at how the score moved across
/// every version of this topic attempt. Pure local data — no AI call. Only
/// shown when there are 2+ versions to compare.
class _ProgressionRecap extends StatelessWidget {
  const _ProgressionRecap({required this.versions, required this.onFinish});

  final List<({int revision, int score})> versions;
  final VoidCallback onFinish;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final overall = versions.last.score - versions.first.score;
    final String subtitle;
    if (overall > 0) {
      subtitle = l10n.txtDsProgressUp(overall);
    } else if (overall < 0) {
      subtitle = l10n.txtDsProgressDown(overall.abs());
    } else {
      subtitle = l10n.txtDsProgressSame;
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.txtDsProgressTitle,
            style: PmpTextStyles.h2.copyWith(color: colorScheme.onSurface),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: PmpTextStyles.body2Regular
                .copyWith(color: colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 18),
          for (var i = 0; i < versions.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  _VersionChip(revision: versions[i].revision),
                  const SizedBox(width: 12),
                  Text(
                    '${versions[i].score}',
                    style: PmpTextStyles.body1Semi.copyWith(
                      color: colorScheme.onSurface,
                      fontFamily: 'ArchivoBlack Regular',
                    ),
                  ),
                  const Spacer(),
                  if (i > 0)
                    _DeltaBadge(
                      delta: versions[i].score - versions[i - 1].score,
                    ),
                ],
              ),
            ),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: onFinish,
            child: Text(l10n.txtDone),
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.child,
    this.count,
  });
  final IconData icon;
  final Color iconColor;
  final String title;
  final Widget child;

  /// Optional item count shown as a small pill next to the title (e.g. the
  /// number of fixes). Hidden when null or zero.
  final int? count;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    // A thin accent rail down the whole section colour-codes it and adds depth,
    // breaking the single-surface monotony.
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: 3,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.55),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: iconColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(icon, size: 17, color: iconColor),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        title,
                        style: PmpTextStyles.body1Semi
                            .copyWith(color: colorScheme.onSurface),
                      ),
                    ),
                    if (count != null && count! > 0) ...[
                      const SizedBox(width: 8),
                      _CountBadge(count: count!, color: iconColor),
                    ],
                  ],
                ),
                const SizedBox(height: 12),
                child,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Renders a list of card rows but only shows the first [collapsedCount] until
/// the learner taps "Show all N" — so a section with 10+ items (e.g. lots of
/// vocab upgrades or fixes) doesn't take over the whole screen. Collapses back
/// with "Show less". When the list is already short enough, it's just the rows.
class _CollapsibleColumn extends StatefulWidget {
  const _CollapsibleColumn({required this.children});

  final List<Widget> children;

  /// How many rows show before "Show all N" appears.
  static const int collapsedCount = 3;

  @override
  State<_CollapsibleColumn> createState() => _CollapsibleColumnState();
}

class _CollapsibleColumnState extends State<_CollapsibleColumn> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final total = widget.children.length;
    final overflows = total > _CollapsibleColumn.collapsedCount;
    final visible = (!overflows || _expanded)
        ? widget.children
        : widget.children
            .take(_CollapsibleColumn.collapsedCount)
            .toList(growable: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ...visible,
        if (overflows)
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: () => setState(() => _expanded = !_expanded),
              icon: Icon(
                _expanded ? Icons.expand_less : Icons.expand_more,
                size: 18,
              ),
              label: Text(
                _expanded ? l10n.txtDsShowLess : l10n.txtDsShowAll(total),
              ),
            ),
          ),
      ],
    );
  }
}

/// Small count pill shown beside a section title (e.g. "Things to fix · 3").
class _CountBadge extends StatelessWidget {
  const _CountBadge({required this.count, required this.color});
  final int count;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        '$count',
        style: PmpTextStyles.labelSemi.copyWith(color: color),
      ),
    );
  }
}

class _BulletList extends StatelessWidget {
  const _BulletList({required this.items});
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .map(
            (text) => Padding(
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
                      text,
                      style: PmpTextStyles.body2Regular.copyWith(
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(growable: false),
    );
  }
}

class _FixCard extends StatelessWidget {
  const _FixCard({required this.fix});
  final FeedbackFix fix;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            fix.original,
            style: PmpTextStyles.body2Regular.copyWith(
              color: PmpColors.destructive400,
              decoration: TextDecoration.lineThrough,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            fix.corrected,
            style: PmpTextStyles.body1Semi.copyWith(
              color: PmpColors.success500,
            ),
          ),
          if (fix.reasonMm.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              fix.reasonMm,
              style: PmpTextStyles.body2Regular.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontFamily: 'Noto Sans Myanmar',
                height: 1.6,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _TargetPhraseRow extends StatelessWidget {
  const _TargetPhraseRow({required this.result});
  final TargetPhraseResult result;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final Color fg = result.used
        ? (result.usedCorrectly ? PmpColors.success500 : PmpColors.warning500)
        : colorScheme.onSurfaceVariant;
    final IconData icon = result.used
        ? (result.usedCorrectly ? Icons.check_circle : Icons.error_outline)
        : Icons.radio_button_unchecked;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: fg),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              result.phraseEn,
              style: PmpTextStyles.body2Regular.copyWith(
                color: result.used ? colorScheme.onSurface : fg,
                fontStyle: result.used ? FontStyle.normal : FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SubScoresCard extends StatelessWidget {
  const _SubScoresCard({required this.scores});
  final SubScores scores;

  Color _barColor(int v) {
    if (v >= 80) return PmpColors.success500;
    if (v >= 60) return PmpColors.warning500;
    return PmpColors.destructive500;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final rows = <(String, int)>[
      (l10n.txtDsGrammar, scores.grammar),
      (l10n.txtDsVocabulary, scores.vocabulary),
      (l10n.txtDsFluency, scores.fluency),
      (l10n.txtDsPronunciation, scores.pronunciation),
    ];
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        for (final (label, value) in rows)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                SizedBox(
                  width: 96,
                  child: Text(
                    label,
                    style: PmpTextStyles.label2Regular
                        .copyWith(color: colorScheme.onSurfaceVariant),
                  ),
                ),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: LinearProgressIndicator(
                      value: value.clamp(0, 100) / 100.0,
                      minHeight: 8,
                      backgroundColor: _barColor(value).withValues(alpha: 0.15),
                      valueColor:
                          AlwaysStoppedAnimation<Color>(_barColor(value)),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 28,
                  child: Text(
                    '$value',
                    textAlign: TextAlign.right,
                    style: PmpTextStyles.body2Semi
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

class _VocabUpgradeRow extends StatelessWidget {
  const _VocabUpgradeRow({required this.upgrade});
  final VocabUpgrade upgrade;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Flexible(
                child: Text(
                  upgrade.original,
                  style: PmpTextStyles.body2Regular.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Icon(Icons.arrow_forward, size: 14),
              ),
              Flexible(
                child: Text(
                  upgrade.suggestion,
                  style: PmpTextStyles.body1Semi
                      .copyWith(color: PmpColors.success500),
                ),
              ),
            ],
          ),
          if (upgrade.reasonMm.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              upgrade.reasonMm,
              style: PmpTextStyles.body2Regular.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontFamily: 'Noto Sans Myanmar',
                height: 1.6,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// "Phrases to try next time" — collocations + idioms unified under one
/// intent-clear header. These are *suggestions seeded by the topic* (not pulled
/// from the learner's words and not errors), so the caption spells that out and
/// the styling marks them as things to pick up, distinct from the corrective
/// highlights. Each chip is tappable: a learner who doesn't know the phrase taps
/// it to see what it means and how to use it (definition + example sentences).
class _PhrasesToTry extends StatelessWidget {
  const _PhrasesToTry({required this.phrases});

  final List<PhraseSuggestion> phrases;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.txtDsPhrasesToTryHint,
          style: PmpTextStyles.sub.copyWith(color: colorScheme.onSurfaceVariant),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Icon(Icons.touch_app_outlined,
                size: 13, color: colorScheme.onSurfaceVariant),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                l10n.txtDsTapPhraseHint,
                style: PmpTextStyles.sub.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: phrases
              .map((p) => _PhraseChip(phrase: p))
              .toList(growable: false),
        ),
      ],
    );
  }
}

/// One tappable suggestion phrase. Accented to read as enrichment (not an
/// error); tapping opens a sheet with the meaning and example sentences so the
/// learner can actually pick it up.
class _PhraseChip extends StatelessWidget {
  const _PhraseChip({required this.phrase});
  final PhraseSuggestion phrase;

  bool get _isIdiom => phrase.kind == PhraseKind.idiom;

  void _showDetail(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (_) => SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(_isIdiom ? Icons.auto_awesome : Icons.add,
                      size: 18, color: PmpColors.accentOrange),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      phrase.phrase,
                      style: PmpTextStyles.h2.copyWith(
                        color: colorScheme.onSurface,
                        fontFamily: 'ArchivoBlack Regular',
                      ),
                    ),
                  ),
                ],
              ),
              if (phrase.meaningEn.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  phrase.meaningEn,
                  style: PmpTextStyles.body1Regular
                      .copyWith(color: colorScheme.onSurface, height: 1.4),
                ),
              ],
              if (phrase.meaningMm.isNotEmpty) ...[
                const SizedBox(height: 6),
                Text(
                  phrase.meaningMm,
                  style: PmpTextStyles.body2Regular.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontFamily: 'Noto Sans Myanmar',
                    height: 1.6,
                  ),
                ),
              ],
              if (phrase.examples.isNotEmpty) ...[
                const SizedBox(height: 16),
                Text(
                  l10n.txtDsExamples,
                  style: PmpTextStyles.labelSemi
                      .copyWith(color: colorScheme.onSurfaceVariant),
                ),
                const SizedBox(height: 8),
                for (final ex in phrase.examples)
                  _PhraseExampleRow(example: ex),
              ],
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Material(
      color: PmpColors.accentOrange.withValues(alpha: 0.10),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => _showDetail(context),
        child: Container(
          padding: const EdgeInsets.fromLTRB(8, 6, 10, 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: PmpColors.accentOrange.withValues(alpha: 0.4),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(_isIdiom ? Icons.auto_awesome : Icons.add,
                  size: 14, color: PmpColors.accentOrange),
              const SizedBox(width: 4),
              Text(
                phrase.phrase,
                style: PmpTextStyles.sub.copyWith(color: colorScheme.onSurface),
              ),
              const SizedBox(width: 4),
              Icon(Icons.info_outline,
                  size: 13,
                  color: PmpColors.accentOrange.withValues(alpha: 0.7)),
            ],
          ),
        ),
      ),
    );
  }
}

/// One example sentence inside the phrase-detail sheet: English, with the
/// Burmese translation under it when present.
class _PhraseExampleRow extends StatelessWidget {
  const _PhraseExampleRow({required this.example});
  final PhraseExample example;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 3, right: 6),
                child: Icon(Icons.chat_bubble_outline,
                    size: 13, color: colorScheme.onSurfaceVariant),
              ),
              Expanded(
                child: Text(
                  example.en,
                  style: PmpTextStyles.body2Regular.copyWith(
                    color: colorScheme.onSurface,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
          if (example.mm.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 19, top: 2),
              child: Text(
                example.mm,
                style: PmpTextStyles.sub.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  fontFamily: 'Noto Sans Myanmar',
                  height: 1.5,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _SentenceRewriteCard extends StatelessWidget {
  const _SentenceRewriteCard({required this.rewrite});
  final SentenceRewrite rewrite;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            rewrite.original,
            style: PmpTextStyles.body2Regular.copyWith(
              color: colorScheme.onSurfaceVariant,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            rewrite.rewrite,
            style: PmpTextStyles.body1Semi
                .copyWith(color: PmpColors.success500, height: 1.5),
          ),
        ],
      ),
    );
  }
}

class _ChipWrap extends StatelessWidget {
  const _ChipWrap({required this.labels});
  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: labels
          .map(
            (label) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: colorScheme.outlineVariant),
              ),
              child: Text(
                label,
                style: PmpTextStyles.sub.copyWith(color: colorScheme.onSurface),
              ),
            ),
          )
          .toList(growable: false),
    );
  }
}
