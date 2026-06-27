import 'package:flutter/material.dart';

import '../../config/pmp_colors.dart';
import '../../config/pmp_text_styles.dart';
import '../../model/vocabulary/vocab_models.dart';
import '../../shared_widgets/glass.dart';

/// Contrast practice for one group: a sequence of "which word fits?" multiple
/// choice questions with immediate feedback, then a score summary.
class VocabPracticePage extends StatefulWidget {
  const VocabPracticePage({super.key, required this.group});

  final VocabGroup group;

  @override
  State<VocabPracticePage> createState() => _VocabPracticePageState();
}

class _VocabPracticePageState extends State<VocabPracticePage> {
  late final List<VocabExercise> _questions = widget.group.exercises
      .where((e) => e.type == 'which_word' && e.options.isNotEmpty)
      .toList();

  int _index = 0;
  int _correct = 0;
  String? _picked;
  bool _done = false;

  VocabExercise get _q => _questions[_index];

  void _pick(String option) {
    if (_picked != null) return; // already answered
    setState(() {
      _picked = option;
      if (option == _q.answer) _correct++;
    });
  }

  void _next() {
    if (_index + 1 >= _questions.length) {
      setState(() => _done = true);
    } else {
      setState(() {
        _index++;
        _picked = null;
      });
    }
  }

  void _restart() {
    setState(() {
      _index = 0;
      _correct = 0;
      _picked = null;
      _done = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      title: const Text('Practice'),
      body: _questions.isEmpty
          ? const Center(child: Text('No exercises for this set yet.'))
          : _done
              ? _ResultView(
                  correct: _correct,
                  total: _questions.length,
                  onRetry: _restart,
                  onDone: () => Navigator.pop(context),
                )
              : _QuestionView(
                  index: _index,
                  total: _questions.length,
                  question: _q,
                  picked: _picked,
                  onPick: _pick,
                  onNext: _next,
                ),
    );
  }
}

class _QuestionView extends StatelessWidget {
  const _QuestionView({
    required this.index,
    required this.total,
    required this.question,
    required this.picked,
    required this.onPick,
    required this.onNext,
  });

  final int index;
  final int total;
  final VocabExercise question;
  final String? picked;
  final ValueChanged<String> onPick;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final answered = picked != null;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Progress.
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: (index + 1) / total,
              minHeight: 6,
              backgroundColor: cs.onSurface.withValues(alpha: 0.10),
            ),
          ),
          const SizedBox(height: 8),
          Text('Question ${index + 1} of $total',
              style: PmpTextStyles.label2Regular
                  .copyWith(color: cs.onSurfaceVariant)),
          const SizedBox(height: 20),
          Text(question.prompt,
              style: PmpTextStyles.body1Semi
                  .copyWith(color: cs.onSurface, height: 1.4)),
          const SizedBox(height: 20),
          for (final option in question.options) ...[
            _OptionTile(
              label: option,
              state: !answered
                  ? _OptState.idle
                  : option == question.answer
                      ? _OptState.correct
                      : option == picked
                          ? _OptState.wrong
                          : _OptState.idle,
              onTap: () => onPick(option),
            ),
            const SizedBox(height: 10),
          ],
          const Spacer(),
          if (answered)
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: onNext,
                child: Text(index + 1 >= total ? 'See result' : 'Next'),
              ),
            ),
        ],
      ),
    );
  }
}

enum _OptState { idle, correct, wrong }

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
    final (Color border, Color bg, IconData? icon, Color iconColor) =
        switch (state) {
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
      _OptState.idle => (cs.outlineVariant, cs.surface.withValues(alpha: 0.4),
          null, cs.onSurface),
    };
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: border, width: 1.4),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(label,
                  style: PmpTextStyles.body2Semi.copyWith(color: cs.onSurface)),
            ),
            if (icon != null) Icon(icon, size: 20, color: iconColor),
          ],
        ),
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
