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
            child: _BulletList(items: feedback.strengths),
          ),
        ],
        if (showInlineLists && feedback.effectiveFixes.isNotEmpty) ...[
          const SizedBox(height: 16),
          _Section(
            icon: Icons.tune,
            iconColor: PmpColors.warning500,
            title: l10n.txtDsThingsToFix,
            child: Column(
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
            child: _BulletList(items: feedback.grammarPatterns),
          ),
        ],
        if (showInlineLists && feedback.effectiveInterference.isNotEmpty) ...[
          const SizedBox(height: 16),
          _Section(
            icon: Icons.translate,
            iconColor: PmpColors.destructive400,
            title: l10n.txtDsBurmeseErrors,
            child: Column(
              children: feedback.effectiveInterference
                  .map((f) => _FixCard(fix: f))
                  .toList(growable: false),
            ),
          ),
        ],
        if (showInlineLists && feedback.effectiveVocabUpgrades.isNotEmpty) ...[
          const SizedBox(height: 16),
          _Section(
            icon: Icons.upgrade,
            iconColor: PmpColors.info500,
            title: l10n.txtDsBetterWordChoices,
            child: Column(
              children: feedback.effectiveVocabUpgrades
                  .map((v) => _VocabUpgradeRow(upgrade: v))
                  .toList(growable: false),
            ),
          ),
        ],
        if (feedback.collocations.isNotEmpty ||
            feedback.idioms.isNotEmpty) ...[
          const SizedBox(height: 16),
          _Section(
            icon: Icons.lightbulb_outline,
            iconColor: PmpColors.accentOrange,
            title: l10n.txtDsPhrasesToTry,
            child: _PhrasesToTry(
              collocations: feedback.collocations,
              idioms: feedback.idioms,
            ),
          ),
        ],
        if (showInlineLists && feedback.effectiveSentenceRewrites.isNotEmpty) ...[
          const SizedBox(height: 16),
          _Section(
            icon: Icons.format_quote,
            iconColor: colorScheme.primary,
            title: l10n.txtDsSentenceRewritesTitle,
            child: Column(
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
            child: _BulletList(items: feedback.pronunciationNotes),
          ),
        ],
        if (fillerWords.isNotEmpty) ...[
          const SizedBox(height: 16),
          _Section(
            icon: Icons.bubble_chart_outlined,
            iconColor: colorScheme.tertiary,
            title: l10n.txtDsFillerWords,
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
                color: colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: colorScheme.outlineVariant),
              ),
              child: Text(
                feedback.explanationMm,
                style: PmpTextStyles.body1Regular.copyWith(
                  color: colorScheme.onSurface,
                  fontFamily: 'Noto Sans Myanmar',
                  height: 1.7,
                ),
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
  });
  final IconData icon;
  final Color iconColor;
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: iconColor),
            const SizedBox(width: 8),
            Text(
              title,
              style: PmpTextStyles.body2Semi
                  .copyWith(color: colorScheme.onSurface),
            ),
          ],
        ),
        const SizedBox(height: 10),
        child,
      ],
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

/// "Phrases to try next time" — collocations + idioms grouped under one
/// intent-clear header. These are *suggestions seeded by the topic* (not pulled
/// from the learner's words and not errors), so the caption spells that out and
/// the styling marks them as things to pick up, distinct from the corrective
/// highlights.
class _PhrasesToTry extends StatelessWidget {
  const _PhrasesToTry({required this.collocations, required this.idioms});

  final List<String> collocations;
  final List<IdiomSuggestion> idioms;

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
        if (collocations.isNotEmpty) ...[
          const SizedBox(height: 12),
          _SuggestionChips(labels: collocations),
        ],
        if (idioms.isNotEmpty) ...[
          const SizedBox(height: 12),
          for (final i in idioms) _IdiomRow(idiom: i),
        ],
      ],
    );
  }
}

/// Suggestion phrases as accented, "add to your toolkit" chips — visually
/// distinct from the error highlights so they read as enrichment, not mistakes.
class _SuggestionChips extends StatelessWidget {
  const _SuggestionChips({required this.labels});
  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: labels
          .map(
            (label) => Container(
              padding: const EdgeInsets.fromLTRB(8, 6, 12, 6),
              decoration: BoxDecoration(
                color: PmpColors.accentOrange.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: PmpColors.accentOrange.withValues(alpha: 0.4),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.add, size: 14, color: PmpColors.accentOrange),
                  const SizedBox(width: 4),
                  Text(
                    label,
                    style: PmpTextStyles.sub
                        .copyWith(color: colorScheme.onSurface),
                  ),
                ],
              ),
            ),
          )
          .toList(growable: false),
    );
  }
}

class _IdiomRow extends StatelessWidget {
  const _IdiomRow({required this.idiom});
  final IdiomSuggestion idiom;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 2),
            child:
                Icon(Icons.auto_awesome, size: 16, color: PmpColors.accentOrange),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  idiom.expression,
                  style: PmpTextStyles.body1Semi
                      .copyWith(color: colorScheme.onSurface),
                ),
                if (idiom.meaningMm.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    idiom.meaningMm,
                    style: PmpTextStyles.body2Regular.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      fontFamily: 'Noto Sans Myanmar',
                      height: 1.6,
                    ),
                  ),
                ],
              ],
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
