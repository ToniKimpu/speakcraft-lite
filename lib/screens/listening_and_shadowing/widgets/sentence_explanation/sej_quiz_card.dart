import 'package:flutter/material.dart';

import '../../../../config/pmp_colors.dart';
import '../../utils/cloze_generator.dart';

/// "Check yourself" card — runtime fill-in-the-blank exercises derived from the
/// sentence's explained terms (see [buildClozeItems]). Renders nothing when
/// there are no usable items, so it's safe to drop in unconditionally.
class SejQuizCard extends StatelessWidget {
  const SejQuizCard({super.key, required this.items});

  final List<ClozeItem> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();
    final cs = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: cs.outlineVariant),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _header(cs),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
            child: Column(
              children: [
                for (int i = 0; i < items.length; i++)
                  Padding(
                    padding: EdgeInsets.only(top: i == 0 ? 12 : 16),
                    child: _ClozeField(item: items[i]),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _header(ColorScheme cs) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
      decoration: BoxDecoration(
        color: PmpColors.info400.withValues(alpha: 0.08),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
        border: Border(bottom: BorderSide(color: cs.outlineVariant)),
      ),
      child: Row(
        children: [
          const Icon(Icons.quiz_outlined, size: 18, color: PmpColors.info400),
          const SizedBox(width: 8),
          Text(
            'Check yourself',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: cs.onSurface,
            ),
          ),
          const Spacer(),
          Text(
            'Fill the blank',
            style: TextStyle(fontSize: 11, color: cs.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}

/// One blank with its own input, check/retry button, answer reveal, and hint
/// toggle. Self-contained: owns its controller and result state, no bloc.
class _ClozeField extends StatefulWidget {
  const _ClozeField({required this.item});

  final ClozeItem item;

  @override
  State<_ClozeField> createState() => _ClozeFieldState();
}

enum _Status { unanswered, correct, incorrect }

class _ClozeFieldState extends State<_ClozeField> {
  final _controller = TextEditingController();
  _Status _status = _Status.unanswered;
  bool _showHint = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _check() {
    final typed = normalizeClozeAnswer(_controller.text);
    if (typed.isEmpty) return;
    final ok = typed == normalizeClozeAnswer(widget.item.answer);
    FocusScope.of(context).unfocus();
    setState(() => _status = ok ? _Status.correct : _Status.incorrect);
  }

  void _reset() {
    setState(() {
      _status = _Status.unanswered;
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final item = widget.item;
    final correct = _status == _Status.correct;
    final incorrect = _status == _Status.incorrect;

    final borderColor = correct
        ? PmpColors.success400
        : incorrect
            ? cs.error
            : cs.outlineVariant;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          _promptSpan(item.promptEn, cs, fill: correct ? item.answer : null),
          style: TextStyle(fontSize: 14, height: 1.6, color: cs.onSurface),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                enabled: !correct,
                onChanged: (_) {
                  // Clear a previous "incorrect" once the learner edits again.
                  if (incorrect) setState(() => _status = _Status.unanswered);
                },
                onSubmitted: (_) => _check(),
                textInputAction: TextInputAction.done,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  isDense: true,
                  hintText: 'Type the missing word(s)',
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: borderColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: borderColor, width: 1.5),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: PmpColors.success400),
                  ),
                  suffixIcon: correct
                      ? const Icon(Icons.check_circle,
                          color: PmpColors.success400)
                      : null,
                ),
              ),
            ),
            const SizedBox(width: 8),
            if (correct)
              IconButton(
                onPressed: _reset,
                tooltip: 'Try again',
                icon: Icon(Icons.refresh, color: cs.onSurfaceVariant),
              )
            else
              FilledButton(
                onPressed: _check,
                style: FilledButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 13),
                ),
                child: const Text('Check'),
              ),
          ],
        ),
        if (incorrect) ...[
          const SizedBox(height: 6),
          Text.rich(
            TextSpan(
              style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant),
              children: [
                const TextSpan(text: 'Answer: '),
                TextSpan(
                  text: item.answer,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: cs.error,
                  ),
                ),
              ],
            ),
          ),
        ],
        if (item.hintMy.isNotEmpty && !correct) ...[
          const SizedBox(height: 6),
          InkWell(
            onTap: () => setState(() => _showHint = !_showHint),
            borderRadius: BorderRadius.circular(6),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                children: [
                  Icon(
                    _showHint ? Icons.lightbulb : Icons.lightbulb_outline,
                    size: 15,
                    color: PmpColors.warning600,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      _showHint ? item.hintMy : 'Show hint',
                      style: const TextStyle(
                        fontSize: 12,
                        color: PmpColors.warning600,
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

  /// Renders the prompt, swapping [clozeBlank] for either an underlined gap or,
  /// once solved, the answer shown in the success color.
  InlineSpan _promptSpan(String prompt, ColorScheme cs, {String? fill}) {
    final parts = prompt.split(clozeBlank);
    final spans = <InlineSpan>[];
    for (int i = 0; i < parts.length; i++) {
      if (parts[i].isNotEmpty) spans.add(TextSpan(text: parts[i]));
      if (i < parts.length - 1) {
        spans.add(TextSpan(
          text: fill ?? ' ______ ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: fill != null ? PmpColors.success400 : cs.onSurfaceVariant,
          ),
        ));
      }
    }
    return TextSpan(children: spans);
  }
}
