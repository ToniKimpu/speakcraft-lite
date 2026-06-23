import 'package:flutter/material.dart';

import '../../../config/pmp_colors.dart';
import '../../../config/pmp_text_styles.dart';
import '../../../model/writing/writing_lexicon.dart';
import '../../../model/writing/writing_review.dart';
import '../../../model/writing/writing_unit.dart';
import '../writing_highlight.dart';
import 'writing_practice_inputs.dart';

/// The exercise frame for [WritingPracticePage] — the prompt + stimulus + input
/// dispatch ([ExerciseView]), the post-check feedback, the bottom nav bar, and
/// the lesson-complete sheet. The input controls themselves live in
/// [writing_practice_inputs.dart].

class KindBadge extends StatelessWidget {
  const KindBadge({super.key, required this.exercise});
  final WritingExercise exercise;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isAi = exercise.grade == WritingGrade.ai;
    final (label, icon) = switch (exercise.kind) {
      'mcq' => ('Choose the correct answer', Icons.radio_button_checked),
      'gap_fill' => ('Fill the gap', Icons.short_text),
      'reorder' => ('Put it in order', Icons.swap_horiz_rounded),
      'correct_error' => ('Fix the mistake', Icons.build_outlined),
      'word_order' => ('Translate & arrange', Icons.translate_rounded),
      'join' => ('Join the sentences', Icons.merge_type),
      'free_write' => ('Write your own', Icons.draw_outlined),
      'scan_sentences' => ('Write sentences & scan', Icons.camera_alt_outlined),
      'scan_paragraph' => ('Write a paragraph & scan', Icons.camera_alt_outlined),
      _ => ('Practice', Icons.edit_outlined),
    };
    final color = isAi ? PmpColors.accentOrange : cs.primary;
    return Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 6),
        Text(label.toUpperCase(),
            style: PmpTextStyles.labelSemi
                .copyWith(color: color, letterSpacing: 0.6)),
        if (isAi) ...[
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text('AI',
                style: PmpTextStyles.sub
                    .copyWith(color: color, fontWeight: FontWeight.w700)),
          ),
        ],
      ],
    );
  }
}

/// One exercise's prompt + stimulus + the right input by kind, with the
/// post-check feedback. Stateless: the page owns the [ExState] and the
/// callbacks, so this just renders the current state.
class ExerciseView extends StatelessWidget {
  const ExerciseView({
    super.key,
    required this.exercise,
    required this.state,
    required this.toolkit,
    required this.verbForm,
    required this.onSelect,
    required this.onChanged,
    required this.onAddLine,
    required this.onRemoveLine,
  });

  final WritingExercise exercise;
  final ExState state;
  final ResolvedToolkit? toolkit;
  final String verbForm;
  final ValueChanged<String> onSelect;
  final VoidCallback onChanged;
  final VoidCallback onAddLine;
  final ValueChanged<int> onRemoveLine;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final mm = PmpColors.myanmarGloss(Theme.of(context).brightness);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        KindBadge(exercise: exercise),
        const SizedBox(height: 14),
        if (exercise.promptEn.isNotEmpty)
          HighlightedText(exercise.promptEn,
              style: PmpTextStyles.h2.copyWith(color: cs.onSurface)),
        // For a translate-&-arrange task the Burmese sentence is the thing to
        // render in English, so it's the hero (a card) rather than a small gloss.
        if (exercise.kind == 'word_order') ...[
          if (exercise.promptMm.isNotEmpty) ...[
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: cs.primary.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: cs.primary.withValues(alpha: 0.25)),
              ),
              child: Text(exercise.promptMm,
                  style: PmpTextStyles.body1Semi.copyWith(color: mm)),
            ),
          ],
        ] else if (exercise.promptMm.isNotEmpty) ...[
          // When there's no English line (e.g. the free-write task), the Burmese
          // is the instruction itself, so render it readably — not as a small gloss.
          SizedBox(height: exercise.promptEn.isEmpty ? 0 : 6),
          Text(exercise.promptMm,
              style: exercise.promptEn.isEmpty
                  ? PmpTextStyles.body1Semi.copyWith(color: mm, height: 1.5)
                  : PmpTextStyles.body2Regular.copyWith(color: mm, height: 1.6)),
        ],

        // The two source sentences for a "join" task.
        if (exercise.stimulus.isNotEmpty) ...[
          const SizedBox(height: 14),
          for (final s in exercise.stimulus)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: cs.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: cs.outlineVariant),
                ),
                child: Text(s,
                    style: PmpTextStyles.body1Regular
                        .copyWith(color: cs.onSurface)),
              ),
            ),
        ],

        const SizedBox(height: 18),

        // Toolkit reminder while doing open writing (or a scan task on units
        // that still use one). Skipped for word-order items, where the chips
        // already are the words.
        if ((isScanTask(exercise.kind) || exercise.kind == 'free_write') &&
            toolkit != null &&
            !toolkit!.isEmpty &&
            !state.checked) ...[
          ToolkitReminder(toolkit: toolkit!, formKey: verbForm),
          const SizedBox(height: 14),
        ],

        // The primary "write in your notebook & scan" affordance.
        if (isScanTask(exercise.kind) && !state.checked) ...[
          const ScanCallout(),
          const SizedBox(height: 14),
        ],

        // Input area by kind. For scan tasks the text field is the typed fallback.
        if (exercise.kind == 'mcq')
          McqOptions(
            options: exercise.options,
            selected: state.selected,
            checked: state.checked,
            answers: exercise.answers,
            onSelect: onSelect,
          )
        else if (exercise.kind == 'scan_sentences')
          SentenceLines(
            lines: state.lines,
            min: exercise.minLines,
            max: exercise.maxLines,
            enabled: !state.checked,
            onChanged: onChanged,
            onAdd: onAddLine,
            onRemove: onRemoveLine,
          )
        else if (exercise.kind == 'word_order')
          WordOrderBuilder(
            // ExerciseView is keyed by exercise index, so each exercise gets a
            // fresh builder with its own shuffled pool.
            words: exercise.options,
            controller: state.controller,
            enabled: !state.checked,
            onChanged: onChanged,
          )
        else
          TextAnswer(
            controller: state.controller,
            enabled: !state.checked,
            multiline: exercise.grade == WritingGrade.ai,
            hintText: isScanTask(exercise.kind)
                ? 'Or type it here instead…'
                : null,
            onChanged: onChanged,
          ),

        // Generic AI hint for non-scan AI items (e.g. legacy `join`). Not shown
        // for `free_write`, which is plain type-and-reveal.
        if (exercise.grade == WritingGrade.ai &&
            !isScanTask(exercise.kind) &&
            exercise.kind != 'free_write' &&
            !state.checked) ...[
          const SizedBox(height: 10),
          const ScanHint(),
        ],

        // Feedback after checking.
        if (state.checked) ...[
          const SizedBox(height: 18),
          Feedback(exercise: exercise, state: state),
        ],
      ],
    );
  }
}

/// Post-check feedback. Routes to the AI review for `free_write`, or the instant
/// correct/wrong card for the auto-graded items.
class Feedback extends StatelessWidget {
  const Feedback({super.key, required this.exercise, required this.state});
  final WritingExercise exercise;
  final ExState state;

  @override
  Widget build(BuildContext context) {
    if (exercise.grade == WritingGrade.ai) {
      return _AiFeedback(exercise: exercise, state: state);
    }
    return _AutoFeedback(exercise: exercise, state: state);
  }
}

/// Instant feedback for auto-graded items — correct, or a struck-through "you
/// wrote X → it's Y" correction with the rule.
class _AutoFeedback extends StatelessWidget {
  const _AutoFeedback({required this.exercise, required this.state});
  final WritingExercise exercise;
  final ExState state;

  @override
  Widget build(BuildContext context) {
    final mm = PmpColors.myanmarGloss(Theme.of(context).brightness);
    final correct = state.correct == true;
    final color = correct ? PmpColors.success500 : PmpColors.destructive500;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(correct ? Icons.check_circle : Icons.cancel,
                  size: 18, color: color),
              const SizedBox(width: 8),
              Text(correct ? 'Correct!' : 'Not quite',
                  style: PmpTextStyles.body1Semi.copyWith(color: color)),
            ],
          ),
          if (!correct && exercise.answers.isNotEmpty) ...[
            const SizedBox(height: 10),
            _Correction(
              you: (exercise.kind == 'mcq'
                          ? state.selected
                          : state.controller.text)
                      ?.trim() ??
                  '',
              answer: exercise.answers.first,
            ),
          ],
          if (exercise.explainMm.isNotEmpty) ...[
            const SizedBox(height: 10),
            Text(exercise.explainMm,
                style: PmpTextStyles.body2Regular
                    .copyWith(color: mm, height: 1.6)),
          ],
        ],
      ),
    );
  }
}

/// Feedback for the open `free_write` item: a loading state while the reviewer
/// runs, then the structured review — or, if the call failed, the offline
/// fallback of revealing the model answer.
class _AiFeedback extends StatelessWidget {
  const _AiFeedback({required this.exercise, required this.state});
  final WritingExercise exercise;
  final ExState state;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    if (state.reviewing) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: PmpColors.accentOrange.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(14),
          border:
              Border.all(color: PmpColors.accentOrange.withValues(alpha: 0.4)),
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(PmpColors.accentOrange)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text('AI က သင့်အရေးအသားကို စစ်ဆေးနေပါတယ်…',
                  style: PmpTextStyles.body2Semi
                      .copyWith(color: cs.onSurface)),
            ),
          ],
        ),
      );
    }

    final review = state.review;
    if (review != null) return _ReviewCard(review: review);

    // No review (offline / failed) → reveal the model answer, as before.
    return _ModelReveal(exercise: exercise);
  }
}

/// The AI review rendered: a verdict header, per-issue corrections, the fixed
/// version of the learner's writing, and a warm Burmese note.
class _ReviewCard extends StatelessWidget {
  const _ReviewCard({required this.review});
  final WritingReview review;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final mm = PmpColors.myanmarGloss(Theme.of(context).brightness);
    final (color, icon, title) = switch (review.verdict) {
      'great' => (PmpColors.success500, Icons.emoji_events_rounded, 'Great!'),
      'needs_work' => (
          PmpColors.warning600,
          Icons.refresh_rounded,
          'Let’s fix a few things'
        ),
      _ => (PmpColors.accentOrange, Icons.auto_awesome, 'Good effort!'),
    };

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: color),
              const SizedBox(width: 8),
              Text(title,
                  style: PmpTextStyles.body1Semi.copyWith(color: color)),
              const SizedBox(width: 6),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text('AI',
                    style: PmpTextStyles.sub
                        .copyWith(color: color, fontWeight: FontWeight.w700)),
              ),
            ],
          ),
          if (review.praiseMm.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(review.praiseMm,
                style: PmpTextStyles.body2Regular
                    .copyWith(color: mm, height: 1.6)),
          ],
          // Each fix: ✗ wrong → ✓ fix, with a short Burmese why.
          for (final issue in review.issues) ...[
            const SizedBox(height: 12),
            _Correction(you: issue.wrong, answer: issue.fix),
            if (issue.whyMm.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 24),
                child: Text(issue.whyMm,
                    style: PmpTextStyles.sub.copyWith(color: mm)),
              ),
          ],
          // The learner's writing, corrected.
          if (review.correctedText.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text('YOUR WRITING, FIXED',
                style: PmpTextStyles.sub.copyWith(
                    color: cs.onSurfaceVariant,
                    letterSpacing: 0.6,
                    fontWeight: FontWeight.w700)),
            const SizedBox(height: 6),
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: cs.surface,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: cs.outlineVariant),
              ),
              child: HighlightedText(review.correctedText,
                  style: PmpTextStyles.body1Regular
                      .copyWith(color: cs.onSurface, height: 1.5)),
            ),
          ],
          if (review.tipMm.isNotEmpty) ...[
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.tips_and_updates_outlined,
                    size: 16, color: cs.primary),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(review.tipMm,
                      style: PmpTextStyles.body2Regular
                          .copyWith(color: mm, height: 1.6)),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

/// Offline fallback for an AI item — reveal the model answer + the Burmese note.
class _ModelReveal extends StatelessWidget {
  const _ModelReveal({required this.exercise});
  final WritingExercise exercise;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final mm = PmpColors.myanmarGloss(Theme.of(context).brightness);
    const color = PmpColors.accentOrange;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_awesome, size: 18, color: color),
              const SizedBox(width: 8),
              Text('Here’s a model answer',
                  style: PmpTextStyles.body1Semi.copyWith(color: color)),
            ],
          ),
          if (exercise.model.isNotEmpty) ...[
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: cs.surface,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: cs.outlineVariant),
              ),
              child: HighlightedText(exercise.model,
                  style: PmpTextStyles.body1Regular
                      .copyWith(color: cs.onSurface)),
            ),
          ],
          if (exercise.explainMm.isNotEmpty) ...[
            const SizedBox(height: 10),
            Text(exercise.explainMm,
                style: PmpTextStyles.body2Regular
                    .copyWith(color: mm, height: 1.6)),
          ],
        ],
      ),
    );
  }
}

/// The wrong-answer correction — the learner's answer struck through over the
/// correct one, so the fix reads at a glance.
class _Correction extends StatelessWidget {
  const _Correction({required this.you, required this.answer});
  final String you;
  final String answer;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (you.isNotEmpty)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.close_rounded,
                  size: 18, color: PmpColors.destructive500),
              const SizedBox(width: 6),
              Expanded(
                child: Text(you,
                    style: PmpTextStyles.body2Regular.copyWith(
                      color: cs.onSurfaceVariant,
                      decoration: TextDecoration.lineThrough,
                      decorationColor: PmpColors.destructive500,
                    )),
              ),
            ],
          ),
        if (you.isNotEmpty) const SizedBox(height: 4),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.check_rounded,
                size: 18, color: PmpColors.success500),
            const SizedBox(width: 6),
            Expanded(
              child: Text(answer,
                  style: PmpTextStyles.body2Semi.copyWith(color: cs.onSurface)),
            ),
          ],
        ),
      ],
    );
  }
}

/// A one-line rule recap shown above the first exercise — a quick confidence
/// nudge ("here's the pattern") right before the learner starts practising.
class RecapCard extends StatelessWidget {
  const RecapCard({super.key, required this.en, required this.mm});
  final String en;
  final String mm;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final mmColor = PmpColors.myanmarGloss(Theme.of(context).brightness);
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cs.primary.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: cs.primary.withValues(alpha: 0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.lightbulb_outline_rounded, size: 18, color: cs.primary),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (en.isNotEmpty)
                  HighlightedText(en,
                      style: PmpTextStyles.body2Semi
                          .copyWith(color: cs.onSurface, height: 1.5)),
                if (mm.isNotEmpty) ...[
                  if (en.isNotEmpty) const SizedBox(height: 4),
                  Text(mm,
                      style: PmpTextStyles.body2Regular
                          .copyWith(color: mmColor, height: 1.6)),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
    required this.checked,
    required this.canCheck,
    required this.isLast,
    required this.canBack,
    required this.onBack,
    required this.onCheck,
    required this.onNext,
  });

  final bool checked;
  final bool canCheck;
  final bool isLast;
  final bool canBack;
  final VoidCallback onBack;
  final VoidCallback onCheck;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final primary = SizedBox(
      height: 52,
      child: checked
          ? FilledButton.icon(
              onPressed: onNext,
              icon: Icon(isLast ? Icons.flag_rounded : Icons.arrow_forward),
              label: Text(isLast ? 'Finish' : 'Next'),
              style: _style(cs),
            )
          : FilledButton(
              onPressed: canCheck ? onCheck : null,
              style: _style(cs),
              child: const Text('Check'),
            ),
    );
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
      decoration: BoxDecoration(
        color: cs.surface,
        border: Border(top: BorderSide(color: cs.outlineVariant)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            if (canBack) ...[
              SizedBox(
                height: 52,
                child: OutlinedButton(
                  onPressed: onBack,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: cs.onSurfaceVariant,
                    side: BorderSide(color: cs.outlineVariant),
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                  child: const Icon(Icons.arrow_back_rounded),
                ),
              ),
              const SizedBox(width: 12),
            ],
            Expanded(child: primary),
          ],
        ),
      ),
    );
  }

  ButtonStyle _style(ColorScheme cs) => FilledButton.styleFrom(
        backgroundColor: cs.primary,
        foregroundColor: cs.onPrimary,
        disabledBackgroundColor: cs.onSurface.withValues(alpha: 0.12),
        textStyle: PmpTextStyles.body1Semi,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      );
}

class SummarySheet extends StatelessWidget {
  const SummarySheet({super.key, required this.correct, required this.total});
  final int correct;
  final int total;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: cs.primary.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.emoji_events_rounded, color: cs.primary, size: 32),
          ),
          const SizedBox(height: 16),
          Text('Lesson complete!',
              style: PmpTextStyles.h2.copyWith(color: cs.onSurface)),
          const SizedBox(height: 6),
          Text(
            total > 0
                ? 'You got $correct of $total auto-checked exercises right.'
                : 'Nice work — keep practicing.',
            textAlign: TextAlign.center,
            style: PmpTextStyles.body2Regular
                .copyWith(color: cs.onSurfaceVariant),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: FilledButton(
              onPressed: () {
                Navigator.of(context).pop(); // sheet
                Navigator.of(context).pop(); // practice page → back to teach
              },
              style: FilledButton.styleFrom(
                backgroundColor: cs.primary,
                foregroundColor: cs.onPrimary,
                textStyle: PmpTextStyles.body1Semi,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
              ),
              child: const Text('Done'),
            ),
          ),
        ],
      ),
    );
  }
}
