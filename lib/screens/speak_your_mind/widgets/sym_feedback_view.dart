import 'package:flutter/material.dart';

import '../../../config/pmp_colors.dart';
import '../../../config/pmp_text_styles.dart';
import '../../../model/speak_your_mind/sym_feedback.dart';
import '../../../shared_widgets/glass.dart';

/// The body of an AI feedback report — coach summary, strengths, fixes, the
/// natural rewrite, "try adding next time", and the next step. Shared so the
/// live produce screen and the saved-history detail render feedback the same
/// way. Pure content (no action buttons, no version badge); the caller wraps it
/// in a ListView/Column and adds its own surrounding chrome.
class SymFeedbackContent extends StatelessWidget {
  const SymFeedbackContent({
    super.key,
    required this.feedback,
    this.showCoachCard = true,
  });

  final SymFeedback feedback;

  /// Show the full coach card (band pill + clarity score + summary). The history
  /// detail sets this false — it already shows score/band in its own header — so
  /// only the warm Burmese summary appears here.
  final bool showCoachCard;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final mm = PmpColors.myanmarGloss(Theme.of(context).brightness);
    final hasOverall = feedback.overallMm.trim().isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (showCoachCard)
          _CoachCard(feedback: feedback)
        else if (hasOverall)
          _OverallSummaryCard(text: feedback.overallMm),
        if (feedback.strengths.isNotEmpty) ...[
          const SizedBox(height: 14),
          const _SectionLabel('What you did well'),
          const SizedBox(height: 8),
          for (final s in feedback.strengths) _StrengthRow(text: s),
        ],
        if (feedback.corrections.isNotEmpty) ...[
          const SizedBox(height: 14),
          const _SectionLabel('A few fixes'),
          const SizedBox(height: 8),
          for (final c in feedback.corrections) ...[
            _CorrectionCard(correction: c),
            const SizedBox(height: 8),
          ],
        ],
        if (feedback.naturalVersionEn.trim().isNotEmpty) ...[
          const SizedBox(height: 14),
          const _SectionLabel('A natural way to say it'),
          const SizedBox(height: 8),
          _NaturalVersionCard(text: feedback.naturalVersionEn.trim()),
        ],
        if (feedback.useMore.isNotEmpty) ...[
          const SizedBox(height: 14),
          const _SectionLabel('Try adding next time'),
          const SizedBox(height: 8),
          for (final u in feedback.useMore) ...[
            _UseMoreCard(item: u),
            const SizedBox(height: 8),
          ],
        ],
        if (feedback.nextStepMm.trim().isNotEmpty) ...[
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: cs.surfaceContainerHighest.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: cs.outlineVariant),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.flag_outlined, size: 17, color: cs.primary),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(feedback.nextStepMm,
                      style: PmpTextStyles.label2Regular
                          .copyWith(color: mm, height: 1.5)),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class _OverallSummaryCard extends StatelessWidget {
  const _OverallSummaryCard({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Text(text,
          style: PmpTextStyles.body2Regular
              .copyWith(color: cs.onSurface, height: 1.55)),
    );
  }
}

class _CoachCard extends StatelessWidget {
  const _CoachCard({required this.feedback});
  final SymFeedback feedback;

  ({Color color, String label}) get _band => switch (feedback.band) {
        'great' => (color: PmpColors.success500, label: 'Great!'),
        'keep_going' => (color: PmpColors.brandOrange, label: 'Keep going'),
        _ => (color: PmpColors.brandCyan, label: 'Good'),
      };

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final band = _band;
    return GlassCard(
      blur: false,
      highlight: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: band.color.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(band.label,
                    style:
                        PmpTextStyles.labelSemi.copyWith(color: band.color)),
              ),
              const Spacer(),
              Text('Clarity ${feedback.score}/100',
                  style: PmpTextStyles.label2Regular
                      .copyWith(color: cs.onSurfaceVariant)),
            ],
          ),
          if (feedback.overallMm.trim().isNotEmpty) ...[
            const SizedBox(height: 10),
            Text(feedback.overallMm,
                style: PmpTextStyles.body2Regular
                    .copyWith(color: cs.onSurface, height: 1.55)),
          ],
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Text(text,
        style: PmpTextStyles.labelSemi.copyWith(color: cs.primary));
  }
}

class _StrengthRow extends StatelessWidget {
  const _StrengthRow({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_outline,
              size: 17, color: PmpColors.success500),
          const SizedBox(width: 10),
          Expanded(
            child: Text(text,
                style: PmpTextStyles.body2Regular
                    .copyWith(color: cs.onSurface, height: 1.45)),
          ),
        ],
      ),
    );
  }
}

class _CorrectionCard extends StatelessWidget {
  const _CorrectionCard({required this.correction});
  final SymCorrection correction;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final mm = PmpColors.myanmarGloss(Theme.of(context).brightness);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (correction.original.isNotEmpty)
            Text(correction.original,
                style: PmpTextStyles.body2Regular.copyWith(
                  color: cs.onSurfaceVariant,
                  decoration: TextDecoration.lineThrough,
                  height: 1.4,
                )),
          const SizedBox(height: 2),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.arrow_right_alt_rounded,
                  size: 18, color: PmpColors.success500),
              const SizedBox(width: 4),
              Expanded(
                child: Text(correction.fixed,
                    style: PmpTextStyles.body2Semi
                        .copyWith(color: cs.onSurface, height: 1.4)),
              ),
            ],
          ),
          if (correction.whyMm.trim().isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(correction.whyMm,
                style: PmpTextStyles.label2Regular
                    .copyWith(color: mm, height: 1.45)),
          ],
        ],
      ),
    );
  }
}

class _NaturalVersionCard extends StatelessWidget {
  const _NaturalVersionCard({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: PmpColors.brandCyan.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: PmpColors.brandCyan.withValues(alpha: 0.3)),
      ),
      child: Text(text,
          style: PmpTextStyles.body2Medium
              .copyWith(color: cs.onSurface, height: 1.55)),
    );
  }
}

class _UseMoreCard extends StatelessWidget {
  const _UseMoreCard({required this.item});
  final SymUseMore item;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final mm = PmpColors.myanmarGloss(Theme.of(context).brightness);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.add_circle_outline, size: 16, color: cs.primary),
              const SizedBox(width: 8),
              Expanded(
                child: Text(item.moveEn,
                    style: PmpTextStyles.body2Semi
                        .copyWith(color: cs.onSurface)),
              ),
            ],
          ),
          if (item.exampleEn.trim().isNotEmpty) ...[
            const SizedBox(height: 6),
            Text('e.g. ${item.exampleEn}',
                style: PmpTextStyles.body2Regular.copyWith(
                    color: cs.primary, fontStyle: FontStyle.italic)),
          ],
          if (item.whyMm.trim().isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(item.whyMm,
                style: PmpTextStyles.label2Regular
                    .copyWith(color: mm, height: 1.45)),
          ],
        ],
      ),
    );
  }
}
