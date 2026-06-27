import 'package:flutter/material.dart';

import '../../config/pmp_colors.dart';
import '../../config/pmp_text_styles.dart';
import '../../model/vocabulary/vocab_models.dart';
import '../../shared_widgets/glass.dart';
import 'widgets/bilingual_text.dart';

/// Contrast practice for one group — mirrors the Grammar practice UX:
/// one question at a time, **select then Check** (not auto-grade), with
/// **Back / Check / Next** navigation. Per-question state is preserved, so
/// going Back shows the earlier answer + its explanation (read-only).
class VocabPracticePage extends StatefulWidget {
  const VocabPracticePage({super.key, required this.group});

  final VocabGroup group;

  @override
  State<VocabPracticePage> createState() => _VocabPracticePageState();
}

/// Per-question state, kept in a list so navigation never loses an answer.
class _QState {
  String? selected; // mcq choice (before/after check)
  final TextEditingController controller = TextEditingController(); // gap_fill
  bool checked = false;
  bool correct = false;
}

class _VocabPracticePageState extends State<VocabPracticePage> {
  late final List<VocabExercise> _questions = widget.group.exercises
      .where((e) =>
          (e.type == 'which_word' && e.options.isNotEmpty) ||
          e.type == 'gap_fill')
      .toList();

  late final List<_QState> _states =
      List.generate(_questions.length, (_) => _QState());

  int _index = 0;
  bool _done = false;

  VocabExercise get _q => _questions[_index];
  _QState get _state => _states[_index];
  bool get _isGap => _q.type == 'gap_fill';
  bool get _isLast => _index == _questions.length - 1;

  bool get _canCheck {
    if (_state.checked) return false;
    return _isGap
        ? _state.controller.text.trim().isNotEmpty
        : _state.selected != null;
  }

  void _select(String option) {
    if (_state.checked) return;
    setState(() => _state.selected = option);
  }

  void _check() {
    if (!_canCheck) return;
    final answer = _isGap ? _state.controller.text : (_state.selected ?? '');
    setState(() {
      _state.checked = true;
      _state.correct = _q.isCorrect(answer);
    });
  }

  void _next() {
    if (_isLast) {
      setState(() => _done = true);
    } else {
      setState(() => _index++);
    }
  }

  void _back() {
    if (_index > 0) setState(() => _index--);
  }

  void _restart() {
    setState(() {
      for (final s in _states) {
        s.selected = null;
        s.controller.clear();
        s.checked = false;
        s.correct = false;
      }
      _index = 0;
      _done = false;
    });
  }

  @override
  void dispose() {
    for (final s in _states) {
      s.controller.dispose();
    }
    super.dispose();
  }

  _OptState _optState(String option) {
    if (!_state.checked) {
      return option == _state.selected ? _OptState.selected : _OptState.idle;
    }
    if (_q.isCorrect(option)) return _OptState.correct;
    if (option == _state.selected) return _OptState.wrong;
    return _OptState.idle;
  }

  @override
  Widget build(BuildContext context) {
    if (_questions.isEmpty) {
      return const GlassScaffold(
        title: Text('Practice'),
        body: Center(child: Text('No exercises for this set yet.')),
      );
    }
    if (_done) {
      final correct = _states.where((s) => s.correct).length;
      return GlassScaffold(
        title: const Text('Practice'),
        body: _ResultView(
          correct: correct,
          total: _questions.length,
          onRetry: _restart,
          onDone: () => Navigator.pop(context),
        ),
      );
    }

    final cs = Theme.of(context).colorScheme;
    final q = _q;
    return GlassScaffold(
      title: Text('Question ${_index + 1} of ${_questions.length}'),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: (_index + 1) / _questions.length,
            minHeight: 4,
            backgroundColor: cs.onSurface.withValues(alpha: 0.10),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(q.prompt,
                      style: PmpTextStyles.body1Semi
                          .copyWith(color: cs.onSurface, height: 1.4)),
                  const SizedBox(height: 20),
                  if (_isGap)
                    _GapInput(
                      controller: _state.controller,
                      checked: _state.checked,
                      correct: _state.correct,
                      onSubmit: _check,
                    )
                  else
                    for (final option in q.options) ...[
                      _OptionTile(
                        label: option,
                        state: _optState(option),
                        onTap: () => _select(option),
                      ),
                      const SizedBox(height: 10),
                    ],
                  if (_state.checked) ...[
                    const SizedBox(height: 6),
                    _FeedbackCard(
                      correct: _state.correct,
                      answerLine: (_isGap && !_state.correct)
                          ? 'Answer: ${q.answer}'
                          : null,
                      explainMm: q.explainMm,
                      explainEn: q.explainEn,
                    ),
                  ],
                ],
              ),
            ),
          ),
          _BottomBar(
            checked: _state.checked,
            canCheck: _canCheck,
            isLast: _isLast,
            canBack: _index > 0,
            onBack: _back,
            onCheck: _check,
            onNext: _next,
          ),
        ],
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({
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
      height: 50,
      child: checked
          ? FilledButton.icon(
              onPressed: onNext,
              icon: Icon(isLast ? Icons.flag_rounded : Icons.arrow_forward),
              label: Text(isLast ? 'Finish' : 'Next'),
            )
          : FilledButton(
              onPressed: canCheck ? onCheck : null,
              child: const Text('Check'),
            ),
    );
    return Container(
      decoration: BoxDecoration(
        color: cs.surface.withValues(alpha: 0.6),
        border: Border(top: BorderSide(color: cs.outlineVariant)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: Row(
            children: [
              if (canBack) ...[
                SizedBox(
                  height: 50,
                  child: OutlinedButton(
                    onPressed: onBack,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: cs.onSurfaceVariant,
                      side: BorderSide(color: cs.outlineVariant),
                      padding: const EdgeInsets.symmetric(horizontal: 18),
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
      ),
    );
  }
}

class _GapInput extends StatelessWidget {
  const _GapInput({
    required this.controller,
    required this.checked,
    required this.correct,
    required this.onSubmit,
  });

  final TextEditingController controller;
  final bool checked;
  final bool correct;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final border = !checked
        ? cs.outlineVariant
        : correct
            ? PmpColors.success500
            : cs.error;
    return TextField(
      controller: controller,
      enabled: !checked,
      textInputAction: TextInputAction.done,
      onSubmitted: (_) => onSubmit(),
      decoration: InputDecoration(
        hintText: 'Type the missing word',
        filled: true,
        fillColor: cs.surface.withValues(alpha: 0.5),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: border, width: 1.6),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: border, width: 1.6),
        ),
      ),
    );
  }
}

enum _OptState { idle, selected, correct, wrong }

class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.label,
    required this.state,
    required this.onTap,
  });

  final String label;
  final _OptState state;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final (Color border, Color bg, IconData icon, Color iconColor) =
        switch (state) {
      _OptState.selected => (
          cs.primary,
          cs.primary.withValues(alpha: 0.10),
          Icons.radio_button_checked,
          cs.primary
        ),
      _OptState.correct => (
          PmpColors.success500,
          PmpColors.success500.withValues(alpha: 0.12),
          Icons.check_circle,
          PmpColors.success500
        ),
      _OptState.wrong => (
          cs.error,
          cs.error.withValues(alpha: 0.10),
          Icons.cancel,
          cs.error
        ),
      _OptState.idle => (
          cs.outlineVariant,
          cs.surface.withValues(alpha: 0.4),
          Icons.radio_button_unchecked,
          cs.onSurfaceVariant
        ),
    };
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: border,
              width: state == _OptState.idle ? 1.2 : 1.6),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(label,
                  style: PmpTextStyles.body2Semi.copyWith(color: cs.onSurface)),
            ),
            Icon(icon, size: 20, color: iconColor),
          ],
        ),
      ),
    );
  }
}

/// Right/wrong banner + the bilingual "why" explanation, shown after Check.
class _FeedbackCard extends StatelessWidget {
  const _FeedbackCard({
    required this.correct,
    required this.answerLine,
    required this.explainMm,
    required this.explainEn,
  });

  final bool correct;
  final String? answerLine;
  final String explainMm;
  final String explainEn;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final color = correct ? PmpColors.success500 : cs.error;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(correct ? Icons.check_circle : Icons.cancel,
                  size: 18, color: color),
              const SizedBox(width: 6),
              Text(correct ? 'Correct!' : 'Not quite',
                  style: PmpTextStyles.body2Semi.copyWith(color: color)),
            ],
          ),
          if (answerLine != null) ...[
            const SizedBox(height: 6),
            Text(answerLine!,
                style: PmpTextStyles.body2Semi.copyWith(color: cs.onSurface)),
          ],
          if (explainEn.isNotEmpty || explainMm.isNotEmpty) ...[
            const SizedBox(height: 6),
            BilingualText(mm: explainMm, en: explainEn),
          ],
        ],
      ),
    );
  }
}

class _ResultView extends StatelessWidget {
  const _ResultView({
    required this.correct,
    required this.total,
    required this.onRetry,
    required this.onDone,
  });

  final int correct;
  final int total;
  final VoidCallback onRetry;
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final pct = total == 0 ? 0 : (correct * 100 / total).round();
    final good = pct >= 70;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(good ? Icons.emoji_events_rounded : Icons.replay_circle_filled,
                size: 64,
                color: good ? PmpColors.brandOrange : cs.onSurfaceVariant),
            const SizedBox(height: 16),
            Text('$correct / $total correct',
                style:
                    PmpTextStyles.title1SemiBold.copyWith(color: cs.onSurface)),
            const SizedBox(height: 6),
            Text(
              good
                  ? 'Nicely done — you can tell these apart.'
                  : 'Good start. Review the set and try again.',
              textAlign: TextAlign.center,
              style: PmpTextStyles.body2Regular
                  .copyWith(color: cs.onSurfaceVariant),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Try again'),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: onDone,
                child: const Text('Back to words'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
