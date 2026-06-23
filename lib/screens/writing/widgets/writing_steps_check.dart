import 'package:flutter/material.dart';

import '../../../config/pmp_colors.dart';
import '../../../config/pmp_text_styles.dart';
import '../writing_highlight.dart';
import 'writing_steps_widgets.dart';

/// The end-of-pager understanding check for [WritingTeachStepsPage] — one MCQ
/// per rule, instant feedback, and a score tally that gates the exercise ladder.

/// The inline understanding-check (one MCQ).
class Check {
  const Check(
      {required this.promptEn,
      required this.promptMm,
      required this.options,
      required this.answer,
      required this.explainMm});
  final String promptEn;
  final String promptMm;
  final List<String> options;
  final String answer;
  final String explainMm;

  factory Check.fromJson(Map<String, dynamic> j) => Check(
        promptEn: j['prompt_en'] as String? ?? '',
        promptMm: j['prompt_mm'] as String? ?? '',
        options: ((j['options'] as List?) ?? const [])
            .map((e) => e.toString())
            .toList(growable: false),
        answer: j['answer'] as String? ?? '',
        explainMm: j['explain_mm'] as String? ?? '',
      );
}

// ─────────────────────────────────────────────────────────────────────────
// Quick check (one MCQ per rule, instant feedback)
// ─────────────────────────────────────────────────────────────────────────
class CheckStep extends StatelessWidget {
  const CheckStep(
      {super.key,
      required this.checks,
      required this.picks,
      required this.onPick,
      required this.passed,
      required this.onReview});
  final List<Check> checks;
  final Map<int, String> picks;
  final void Function(int index, String option) onPick;
  final bool passed;

  /// Jump back to the step-by-step page (null if the unit has none).
  final VoidCallback? onReview;

  @override
  Widget build(BuildContext context) {
    final answeredCount = picks.length;
    final correctCount = [
      for (var i = 0; i < checks.length; i++)
        if (picks[i] == checks[i].answer) i
    ].length;
    final allDone = answeredCount == checks.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var i = 0; i < checks.length; i++) ...[
          CheckQuestion(
            check: checks[i],
            number: i + 1,
            total: checks.length,
            picked: picks[i],
            onPick: (v) => onPick(i, v),
          ),
          if (i != checks.length - 1) const SizedBox(height: 16),
        ],
        if (allDone) ...[
          const SizedBox(height: 16),
          ScoreTally(
            correct: correctCount,
            total: checks.length,
            passed: passed,
            onReview: onReview,
          ),
        ],
      ],
    );
  }
}

/// A single check MCQ — its prompt, options, and instant feedback.
class CheckQuestion extends StatelessWidget {
  const CheckQuestion(
      {super.key,
      required this.check,
      required this.number,
      required this.total,
      required this.picked,
      required this.onPick});
  final Check check;
  final int number;
  final int total;
  final String? picked;
  final ValueChanged<String> onPick;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final mm = PmpColors.myanmarGloss(Theme.of(context).brightness);
    final answered = picked != null;
    final correct = picked == check.answer;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Question $number of $total',
            style: PmpTextStyles.sub.copyWith(color: cs.onSurfaceVariant)),
        const SizedBox(height: 6),
        StepCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HighlightedText(check.promptEn,
                  style: PmpTextStyles.body1Semi.copyWith(color: cs.onSurface)),
              if (check.promptMm.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(check.promptMm,
                    style: PmpTextStyles.body2Regular.copyWith(color: mm)),
              ],
            ],
          ),
        ),
        const SizedBox(height: 12),
        for (final opt in check.options) ...[
          OptionTile(
            label: opt,
            state: !answered
                ? OptState.idle
                : opt == check.answer
                    ? OptState.correct
                    : (opt == picked ? OptState.wrong : OptState.idle),
            onTap: answered ? null : () => onPick(opt),
          ),
          const SizedBox(height: 8),
        ],
        if (answered)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: (correct ? PmpColors.primary500 : PmpColors.warning500)
                  .withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                    correct
                        ? Icons.check_circle_rounded
                        : Icons.info_outline_rounded,
                    size: 18,
                    color:
                        correct ? PmpColors.primary500 : PmpColors.warning600),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                      correct
                          ? 'Correct!  ${check.explainMm}'
                          : check.explainMm,
                      style: PmpTextStyles.body2Regular
                          .copyWith(color: mm, height: 1.6)),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

/// The end-of-check tally. On a pass it celebrates; on a fail it is honest and
/// offers a path back to the lesson instead of waving the learner through.
class ScoreTally extends StatelessWidget {
  const ScoreTally(
      {super.key,
      required this.correct,
      required this.total,
      required this.passed,
      required this.onReview});
  final int correct;
  final int total;
  final bool passed;
  final VoidCallback? onReview;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final mm = PmpColors.myanmarGloss(Theme.of(context).brightness);
    final accent = passed ? PmpColors.primary500 : PmpColors.warning600;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: accent.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                  passed
                      ? Icons.emoji_events_rounded
                      : Icons.replay_circle_filled_rounded,
                  size: 22,
                  color: accent),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('$correct / $total correct',
                        style: PmpTextStyles.body1Semi
                            .copyWith(color: cs.onSurface)),
                    const SizedBox(height: 2),
                    Text(
                        passed
                            ? 'အကုန်မှန်ပါတယ်! Exercises ဆက်လုပ်လို့ ရပါပြီ။'
                            : 'အရင် သင်ခန်းစာလေး ပြန်ကြည့်ပြီး ထပ်ဖြေကြည့်ရအောင်။',
                        style: PmpTextStyles.body2Regular
                            .copyWith(color: mm, height: 1.6)),
                  ],
                ),
              ),
            ],
          ),
          if (!passed && onReview != null) ...[
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: onReview,
                icon: const Icon(Icons.menu_book_outlined, size: 18),
                label: const Text('Review the rules'),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

enum OptState { idle, correct, wrong }

class OptionTile extends StatelessWidget {
  const OptionTile(
      {super.key,
      required this.label,
      required this.state,
      required this.onTap});
  final String label;
  final OptState state;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    Color border = cs.outlineVariant;
    Color bg = cs.surfaceContainerHighest;
    Color fg = cs.onSurface;
    IconData? trailing;
    switch (state) {
      case OptState.correct:
        border = PmpColors.primary500;
        bg = PmpColors.primary500.withValues(alpha: 0.12);
        trailing = Icons.check_rounded;
        break;
      case OptState.wrong:
        border = PmpColors.warning500;
        bg = PmpColors.warning500.withValues(alpha: 0.12);
        trailing = Icons.close_rounded;
        break;
      case OptState.idle:
        break;
    }
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: border),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(label,
                    style: PmpTextStyles.body1Semi.copyWith(color: fg)),
              ),
              if (trailing != null) Icon(trailing, size: 20, color: border),
            ],
          ),
        ),
      ),
    );
  }
}
