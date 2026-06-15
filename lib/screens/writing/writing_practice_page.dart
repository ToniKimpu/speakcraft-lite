import 'package:flutter/material.dart';

import '../../config/pmp_colors.dart';
import '../../config/pmp_text_styles.dart';
import '../../model/writing/writing_unit.dart';
import '../../model/writing/writing_lexicon.dart';
import 'writing_highlight.dart';

/// Writing module — **Phase-0 prototype**. The practice ladder for one unit,
/// one exercise at a time.
///
/// - **Auto-graded** items (mcq / gap_fill / correct_error) are checked on-device
///   against the unit JSON — free, instant.
/// - **AI-graded** items (join / free_write) have no Gemini key yet, so they are
///   **type-and-reveal**: the learner writes an answer, taps Check, and we reveal
///   the model answer + an encouraging note. (Phase 3 swaps this for the real
///   `writing-review` edge fn, incl. handwrite-and-scan — see WRITING_FEATURE_PLAN.md.)
class WritingPracticePage extends StatefulWidget {
  const WritingPracticePage({super.key, required this.unit, this.toolkit});
  final WritingUnit unit;

  /// The resolved toolkit, shown as a reminder on the handwrite-and-scan tasks
  /// so the learner can see which verbs / time words to use while writing.
  final ResolvedToolkit? toolkit;

  @override
  State<WritingPracticePage> createState() => _WritingPracticePageState();
}

class _WritingPracticePageState extends State<WritingPracticePage> {
  int _index = 0;
  late final List<_ExState> _states = widget.unit.exercises.map((e) {
    // `scan_sentences` gets one controller per sentence row (line-by-line),
    // seeded with the minimum number of rows.
    if (e.kind == 'scan_sentences') {
      return _ExState(
        controller: TextEditingController(),
        lines: List.generate(e.minLines, (_) => TextEditingController()),
      );
    }
    return _ExState(controller: TextEditingController());
  }).toList(growable: false);

  List<WritingExercise> get _exercises => widget.unit.exercises;
  WritingExercise get _current => _exercises[_index];
  _ExState get _state => _states[_index];

  bool get _isLast => _index == _exercises.length - 1;

  @override
  void dispose() {
    for (final s in _states) {
      s.controller.dispose();
      for (final c in s.lines) {
        c.dispose();
      }
    }
    super.dispose();
  }

  /// Non-empty sentence rows for a line-by-line item.
  int _filledLines(_ExState s) =>
      s.lines.where((c) => c.text.trim().isNotEmpty).length;

  bool get _canCheck {
    if (_state.checked) return false;
    if (_current.kind == 'mcq') return _state.selected != null;
    if (_current.kind == 'scan_sentences') {
      return _filledLines(_state) >= _current.minLines;
    }
    return _state.controller.text.trim().isNotEmpty;
  }

  void _addLine() {
    if (_state.lines.length >= _current.maxLines) return;
    setState(() => _state.lines = [..._state.lines, TextEditingController()]);
  }

  void _removeLine(int i) {
    if (_state.lines.length <= _current.minLines) return;
    setState(() {
      final removed = _state.lines[i];
      _state.lines = [..._state.lines]..removeAt(i);
      removed.dispose();
    });
  }

  void _check() {
    final ex = _current;
    setState(() {
      _state.checked = true;
      if (ex.grade == WritingGrade.auto) {
        final answer =
            ex.kind == 'mcq' ? (_state.selected ?? '') : _state.controller.text;
        _state.correct = ex.isCorrect(answer);
      } else {
        // AI item in the stub: there is no right/wrong yet — we reveal the model.
        _state.correct = null;
      }
    });
  }

  void _next() {
    if (_isLast) {
      _showSummary();
    } else {
      setState(() => _index++);
    }
  }

  void _back() {
    if (_index > 0) setState(() => _index--);
  }

  void _showSummary() {
    final auto = _exercises
        .where((e) => e.grade == WritingGrade.auto)
        .toList(growable: false);
    var correct = 0;
    for (var i = 0; i < _exercises.length; i++) {
      if (_exercises[i].grade == WritingGrade.auto &&
          _states[i].correct == true) {
        correct++;
      }
    }
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _SummarySheet(correct: correct, total: auto.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercise ${_index + 1} of ${_exercises.length}'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: LinearProgressIndicator(
            value: (_index + 1) / _exercises.length,
            minHeight: 4,
            backgroundColor: cs.surfaceContainerHighest,
            valueColor: AlwaysStoppedAnimation<Color>(cs.primary),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                child: _ExerciseView(
                  key: ValueKey(_index),
                  exercise: _current,
                  state: _state,
                  toolkit: widget.toolkit,
                  verbForm: widget.unit.toolkit.verbForm,
                  onSelect: (opt) => setState(() => _state.selected = opt),
                  onChanged: () => setState(() {}),
                  onAddLine: _addLine,
                  onRemoveLine: _removeLine,
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
      ),
    );
  }
}

/// Per-exercise mutable UI state.
class _ExState {
  _ExState({required this.controller, List<TextEditingController>? lines})
      : lines = lines ?? const [];
  final TextEditingController controller;

  /// One controller per sentence row for `scan_sentences` (empty otherwise).
  /// Mutable so rows can be added / removed.
  List<TextEditingController> lines;
  String? selected; // mcq choice
  bool checked = false;
  bool? correct; // null = AI item (no right/wrong in the stub)
}

/// Handwrite-and-scan task kinds (graded by AI on a scanned notebook page).
bool _isScanTask(String kind) =>
    kind == 'scan_sentences' || kind == 'scan_paragraph';

class _ExerciseView extends StatelessWidget {
  const _ExerciseView({
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
  final _ExState state;
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
        _KindBadge(exercise: exercise),
        const SizedBox(height: 14),
        if (exercise.promptEn.isNotEmpty)
          HighlightedText(exercise.promptEn,
              style: PmpTextStyles.h2.copyWith(color: cs.onSurface)),
        if (exercise.promptMm.isNotEmpty) ...[
          const SizedBox(height: 6),
          Text(exercise.promptMm,
              style: PmpTextStyles.body2Regular
                  .copyWith(color: mm, height: 1.6)),
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

        // Toolkit reminder while writing a scan task.
        if (_isScanTask(exercise.kind) &&
            toolkit != null &&
            !toolkit!.isEmpty &&
            !state.checked) ...[
          _ToolkitReminder(toolkit: toolkit!, formKey: verbForm),
          const SizedBox(height: 14),
        ],

        // The primary "write in your notebook & scan" affordance.
        if (_isScanTask(exercise.kind) && !state.checked) ...[
          const _ScanCallout(),
          const SizedBox(height: 14),
        ],

        // Input area by kind. For scan tasks the text field is the typed fallback.
        if (exercise.kind == 'mcq')
          _McqOptions(
            options: exercise.options,
            selected: state.selected,
            checked: state.checked,
            answers: exercise.answers,
            onSelect: onSelect,
          )
        else if (exercise.kind == 'scan_sentences')
          _SentenceLines(
            lines: state.lines,
            min: exercise.minLines,
            max: exercise.maxLines,
            enabled: !state.checked,
            onChanged: onChanged,
            onAdd: onAddLine,
            onRemove: onRemoveLine,
          )
        else
          _TextAnswer(
            controller: state.controller,
            enabled: !state.checked,
            multiline: exercise.grade == WritingGrade.ai,
            hintText: _isScanTask(exercise.kind)
                ? 'Or type it here instead…'
                : null,
            onChanged: onChanged,
          ),

        // Generic AI hint for non-scan AI items.
        if (exercise.grade == WritingGrade.ai &&
            !_isScanTask(exercise.kind) &&
            !state.checked) ...[
          const SizedBox(height: 10),
          const _ScanHint(),
        ],

        // Feedback after checking.
        if (state.checked) ...[
          const SizedBox(height: 18),
          _Feedback(exercise: exercise, state: state),
        ],
      ],
    );
  }
}

class _KindBadge extends StatelessWidget {
  const _KindBadge({required this.exercise});
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

class _McqOptions extends StatelessWidget {
  const _McqOptions({
    required this.options,
    required this.selected,
    required this.checked,
    required this.answers,
    required this.onSelect,
  });

  final List<String> options;
  final String? selected;
  final bool checked;
  final List<String> answers;
  final ValueChanged<String> onSelect;

  bool _isAnswer(String o) {
    final got = WritingExercise.normalize(o);
    return answers.any((a) => WritingExercise.normalize(a) == got);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      children: [
        for (final o in options)
          Builder(builder: (context) {
            final isSelected = selected == o;
            Color border = cs.outlineVariant;
            Color bg = cs.surfaceContainerHighest;
            Color fg = cs.onSurface;
            IconData? trailing;
            Color trailingColor = cs.primary;

            if (checked) {
              if (_isAnswer(o)) {
                border = PmpColors.success500;
                bg = PmpColors.success500.withValues(alpha: 0.10);
                trailing = Icons.check_circle;
                trailingColor = PmpColors.success500;
              } else if (isSelected) {
                border = PmpColors.destructive500;
                bg = PmpColors.destructive500.withValues(alpha: 0.10);
                trailing = Icons.cancel;
                trailingColor = PmpColors.destructive500;
              }
            } else if (isSelected) {
              border = cs.primary;
              bg = cs.primary.withValues(alpha: 0.08);
              fg = cs.primary;
            }

            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Material(
                color: bg,
                borderRadius: BorderRadius.circular(12),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: checked ? null : () => onSelect(o),
                  child: Ink(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: border, width: isSelected || checked ? 1.5 : 1),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(o,
                              style: PmpTextStyles.body1Regular
                                  .copyWith(color: fg)),
                        ),
                        if (trailing != null)
                          Icon(trailing, size: 20, color: trailingColor),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
      ],
    );
  }
}

class _TextAnswer extends StatelessWidget {
  const _TextAnswer({
    required this.controller,
    required this.enabled,
    required this.multiline,
    required this.onChanged,
    this.hintText,
  });

  final TextEditingController controller;
  final bool enabled;
  final bool multiline;
  final VoidCallback onChanged;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return TextField(
      controller: controller,
      enabled: enabled,
      minLines: multiline ? 3 : 1,
      maxLines: multiline ? 6 : 2,
      onChanged: (_) => onChanged(),
      textCapitalization: TextCapitalization.sentences,
      style: PmpTextStyles.body1Regular.copyWith(color: cs.onSurface),
      decoration: InputDecoration(
        hintText: hintText ?? (multiline ? 'Type your answer…' : 'Your answer'),
        filled: true,
        fillColor: cs.surfaceContainerHighest,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: cs.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: cs.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: cs.primary, width: 1.5),
        ),
      ),
    );
  }
}

/// Line-by-line sentence input for `scan_sentences`: one numbered row per
/// sentence, so the learner sees the "write N sentences" expectation, each row
/// is unambiguously one sentence (no need to guess boundaries later), and they
/// can add / remove rows between [min] and [max]. A live counter gates Check.
class _SentenceLines extends StatelessWidget {
  const _SentenceLines({
    required this.lines,
    required this.min,
    required this.max,
    required this.enabled,
    required this.onChanged,
    required this.onAdd,
    required this.onRemove,
  });

  final List<TextEditingController> lines;
  final int min;
  final int max;
  final bool enabled;
  final VoidCallback onChanged;
  final VoidCallback onAdd;
  final ValueChanged<int> onRemove;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    const accent = PmpColors.accentOrange;
    final filled = lines.where((c) => c.text.trim().isNotEmpty).length;
    final enough = filled >= min;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Or type your sentences — one per line:',
            style: PmpTextStyles.sub.copyWith(color: cs.onSurfaceVariant)),
        const SizedBox(height: 10),
        for (var i = 0; i < lines.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 24,
                  height: 24,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Text('${i + 1}',
                      style: PmpTextStyles.sub.copyWith(
                          color: accent, fontWeight: FontWeight.w700)),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: lines[i],
                    enabled: enabled,
                    onChanged: (_) => onChanged(),
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.next,
                    style: PmpTextStyles.body1Regular
                        .copyWith(color: cs.onSurface),
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: 'Sentence ${i + 1}',
                      filled: true,
                      fillColor: cs.surfaceContainerHighest,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: cs.outlineVariant),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: cs.outlineVariant),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: accent, width: 1.5),
                      ),
                    ),
                  ),
                ),
                if (enabled && lines.length > min)
                  IconButton(
                    onPressed: () => onRemove(i),
                    visualDensity: VisualDensity.compact,
                    icon: Icon(Icons.close_rounded,
                        size: 18, color: cs.onSurfaceVariant),
                    tooltip: 'Remove',
                  ),
              ],
            ),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (enabled && lines.length < max)
              TextButton.icon(
                onPressed: onAdd,
                icon: const Icon(Icons.add_rounded, size: 18),
                label: const Text('Add sentence'),
                style: TextButton.styleFrom(
                  foregroundColor: accent,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  textStyle: PmpTextStyles.body2Semi,
                ),
              )
            else
              const SizedBox.shrink(),
            Text(
              enough
                  ? '$filled sentences  ·  ready'
                  : '$filled / $min — write at least $min',
              style: PmpTextStyles.sub.copyWith(
                  color: enough ? PmpColors.success500 : cs.onSurfaceVariant),
            ),
          ],
        ),
      ],
    );
  }
}

/// The prominent "study with a tutor" affordance for scan tasks: write it in
/// your notebook, then scan. The scan button is disabled until Phase 3 (camera
/// + AI); for now learners can type the answer in the field below.
class _ScanCallout extends StatelessWidget {
  const _ScanCallout();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    const color = PmpColors.accentOrange;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.menu_book_rounded, size: 18, color: color),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Write it in your notebook, then scan the page.',
                  style: PmpTextStyles.body1Semi.copyWith(color: cs.onSurface),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 46,
            child: FilledButton.icon(
              // Phase 3: opens the camera → AI transcribes + grades the page.
              onPressed: null,
              icon: const Icon(Icons.photo_camera_outlined),
              label: const Text('Scan my notebook  ·  soon'),
              style: FilledButton.styleFrom(
                backgroundColor: color,
                foregroundColor: Colors.white,
                disabledBackgroundColor: color.withValues(alpha: 0.25),
                disabledForegroundColor: cs.onSurface.withValues(alpha: 0.5),
                textStyle: PmpTextStyles.body2Semi,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// A collapsible reminder of the unit's toolkit, shown while writing a scan task
/// so the learner can pull verbs / time words without flipping back.
class _ToolkitReminder extends StatelessWidget {
  const _ToolkitReminder({required this.toolkit, required this.formKey});
  final ResolvedToolkit toolkit;
  final String formKey;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: Container(
        decoration: BoxDecoration(
          color: cs.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: cs.outlineVariant),
        ),
        clipBehavior: Clip.antiAlias,
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 14),
          childrenPadding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
          leading: Icon(Icons.handyman_outlined, size: 18, color: cs.primary),
          title: Text('Open your toolkit',
              style: PmpTextStyles.body2Semi.copyWith(color: cs.onSurface)),
          children: [
            if (toolkit.verbs.isNotEmpty) ...[
              _ChipWrap(
                labels: [
                  for (final v in toolkit.verbs)
                    v.secondForm(formKey) == v.base
                        ? v.base
                        : '${v.base} / ${v.secondForm(formKey)}'
                ],
                color: writingVerbColor(Theme.of(context).brightness),
              ),
            ],
            if (toolkit.timeWords.isNotEmpty) ...[
              const SizedBox(height: 10),
              _ChipWrap(
                labels: [for (final w in toolkit.timeWords) w.en],
                color: PmpColors.accentOrange,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ChipWrap extends StatelessWidget {
  const _ChipWrap({required this.labels, required this.color});
  final List<String> labels;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final l in labels)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: color.withValues(alpha: 0.30)),
            ),
            child: Text(l, style: PmpTextStyles.sub.copyWith(color: color)),
          ),
      ],
    );
  }
}

/// Placeholder for the Phase-3 "write in your notebook and scan" path.
class _ScanHint extends StatelessWidget {
  const _ScanHint();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Row(
        children: [
          Icon(Icons.photo_camera_outlined,
              size: 18, color: cs.onSurfaceVariant),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Soon: write it in your notebook and scan it — we’ll read and check it.',
              style: PmpTextStyles.sub.copyWith(color: cs.onSurfaceVariant),
            ),
          ),
        ],
      ),
    );
  }
}

class _Feedback extends StatelessWidget {
  const _Feedback({required this.exercise, required this.state});
  final WritingExercise exercise;
  final _ExState state;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final mm = PmpColors.myanmarGloss(Theme.of(context).brightness);
    final isAi = exercise.grade == WritingGrade.ai;
    final correct = state.correct;

    final Color color;
    final IconData icon;
    final String title;
    if (isAi) {
      color = PmpColors.accentOrange;
      icon = Icons.auto_awesome;
      title = 'Here’s a model answer';
    } else if (correct == true) {
      color = PmpColors.success500;
      icon = Icons.check_circle;
      title = 'Correct!';
    } else {
      color = PmpColors.destructive500;
      icon = Icons.cancel;
      title = 'Not quite';
    }

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
            ],
          ),
          // Show the right answer when an auto item was wrong.
          if (!isAi && correct == false && exercise.answers.isNotEmpty) ...[
            const SizedBox(height: 8),
            RichText(
              text: TextSpan(
                style: PmpTextStyles.body2Regular
                    .copyWith(color: cs.onSurface),
                children: [
                  const TextSpan(text: 'Answer: '),
                  TextSpan(
                    text: exercise.answers.first,
                    style: PmpTextStyles.body2Semi
                        .copyWith(color: cs.onSurface),
                  ),
                ],
              ),
            ),
          ],
          // Reveal the model answer for AI items.
          if (isAi && exercise.model.isNotEmpty) ...[
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

class _SummarySheet extends StatelessWidget {
  const _SummarySheet({required this.correct, required this.total});
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
