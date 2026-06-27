import 'package:flutter/material.dart';

import '../../config/pmp_colors.dart';
import '../../config/pmp_text_styles.dart';
import '../../model/vocabulary/vocab_models.dart';
import '../../shared_widgets/glass.dart';

/// Contrast practice for one group: a sequence of "which word fits?" (multiple
/// choice) and "type the word" (gap-fill) questions. Each answer is followed by
/// an explanation — the "why" — shown whether right or wrong.
class VocabPracticePage extends StatefulWidget {
  const VocabPracticePage({super.key, required this.group});

  final VocabGroup group;

  @override
  State<VocabPracticePage> createState() => _VocabPracticePageState();
}

class _VocabPracticePageState extends State<VocabPracticePage> {
  late final List<VocabExercise> _questions = widget.group.exercises
      .where((e) =>
          (e.type == 'which_word' && e.options.isNotEmpty) ||
          e.type == 'gap_fill')
      .toList();

  final TextEditingController _textCtrl = TextEditingController();

  int _index = 0;
  int _correct = 0;
  bool _answered = false;
  bool _wasCorrect = false;
  String? _picked;
  bool _done = false;

  VocabExercise get _q => _questions[_index];

  void _answer(String value) {
    if (_answered) return;
    final correct = _q.isCorrect(value);
    setState(() {
      _answered = true;
      _wasCorrect = correct;
      _picked = value;
      if (correct) _correct++;
    });
  }

  void _submitGap() {
    final text = _textCtrl.text.trim();
    if (text.isEmpty) return;
    _answer(text);
  }

  void _next() {
    if (_index + 1 >= _questions.length) {
      setState(() => _done = true);
      return;
    }
    setState(() {
      _index++;
      _answered = false;
      _wasCorrect = false;
      _picked = null;
      _textCtrl.clear();
    });
  }

  void _restart() {
    setState(() {
      _index = 0;
      _correct = 0;
      _answered = false;
      _wasCorrect = false;
      _picked = null;
      _done = false;
      _textCtrl.clear();
    });
  }

  @override
  void dispose() {
    _textCtrl.dispose();
    super.dispose();
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
                  answered: _answered,
                  wasCorrect: _wasCorrect,
                  picked: _picked,
                  textController: _textCtrl,
                  onPick: _answer,
                  onSubmitGap: _submitGap,
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
    required this.answered,
    required this.wasCorrect,
    required this.picked,
    required this.textController,
    required this.onPick,
    required this.onSubmitGap,
    required this.onNext,
  });

  final int index;
  final int total;
  final VocabExercise question;
  final bool answered;
  final bool wasCorrect;
  final String? picked;
  final TextEditingController textController;
  final ValueChanged<String> onPick;
  final VoidCallback onSubmitGap;
  final VoidCallback onNext;

  bool get _isGap => question.type == 'gap_fill';

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
          Expanded(
            child: ListView(
              children: [
                Text(question.prompt,
                    style: PmpTextStyles.body1Semi
                        .copyWith(color: cs.onSurface, height: 1.4)),
                const SizedBox(height: 20),
                if (_isGap)
                  _GapInput(
                    controller: textController,
                    answered: answered,
                    wasCorrect: wasCorrect,
                    onSubmit: onSubmitGap,
                  )
                else
                  for (final option in question.options) ...[
                    _OptionTile(
                      label: option,
                      state: !answered
                          ? _OptState.idle
                          : question.isCorrect(option)
                              ? _OptState.correct
                              : option == picked
                                  ? _OptState.wrong
                                  : _OptState.idle,
                      onTap: () => onPick(option),
                    ),
                    const SizedBox(height: 10),
                  ],
                if (answered) ...[
                  const SizedBox(height: 6),
                  _FeedbackCard(
                    correct: wasCorrect,
                    answerLine: (_isGap && !wasCorrect)
                        ? 'Answer: ${question.answer}'
                        : null,
                    explain: question.explainEn,
                  ),
                ],
              ],
            ),
          ),
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

class _GapInput extends StatelessWidget {
  const _GapInput({
    required this.controller,
    required this.answered,
    required this.wasCorrect,
    required this.onSubmit,
  });

  final TextEditingController controller;
  final bool answered;
  final bool wasCorrect;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final border = !answered
        ? cs.outlineVariant
        : wasCorrect
            ? PmpColors.success500
            : cs.error;
    return Column(
      children: [
        TextField(
          controller: controller,
          enabled: !answered,
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
        ),
        if (!answered) ...[
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: onSubmit,
              child: const Text('Check'),
            ),
          ),
        ],
      ],
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

/// Right/wrong banner + the "why" explanation, shown after answering.
class _FeedbackCard extends StatelessWidget {
  const _FeedbackCard({
    required this.correct,
    required this.answerLine,
    required this.explain,
  });

  final bool correct;
  final String? answerLine;
  final String explain;

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
          if (explain.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(explain,
                style: PmpTextStyles.body2Regular
                    .copyWith(color: cs.onSurface, height: 1.4)),
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
