import 'package:flutter/material.dart';
import 'package:speakcraft/shared_widgets/glass.dart';

import '../../config/pmp_colors.dart';
import '../../model/writing/writing_unit.dart';
import '../../model/writing/writing_lexicon.dart';
import '../../repositories/writing/writing_progress_repository.dart';
import '../../repositories/writing/writing_reviewer.dart';
import 'widgets/writing_practice_inputs.dart';
import 'widgets/writing_practice_widgets.dart';

/// Writing module — **Phase-0 prototype**. The practice ladder for one unit,
/// one exercise at a time.
///
/// - **Auto-graded** items (mcq / gap_fill / correct_error) are checked on-device
///   against the unit JSON — free, instant.
/// - **AI-graded** items (join / free_write) have no Gemini key yet, so they are
///   **type-and-reveal**: the learner writes an answer, taps Check, and we reveal
///   the model answer + an encouraging note. (Phase 3 swaps this for the real
///   `writing-review` edge fn, incl. handwrite-and-scan — see WRITING_FEATURE_PLAN.md.)
///
/// The exercise frame + input controls live in `widgets/` ([ExerciseView],
/// [BottomBar], [SummarySheet] and the per-kind inputs); this file owns the
/// exercise flow — indexing, grading, line management, navigation.
class WritingPracticePage extends StatefulWidget {
  const WritingPracticePage({
    super.key,
    required this.unit,
    this.toolkit,
    this.onCompleted,
  });
  final WritingUnit unit;

  /// The resolved toolkit, shown as a reminder on the handwrite-and-scan tasks
  /// so the learner can see which verbs / time words to use while writing.
  final ResolvedToolkit? toolkit;

  /// Fired once when the learner reaches the end-of-ladder summary, in addition
  /// to the unit's own local progress marker. Lets a host (e.g. the listening
  /// "Key Takeaways" step) treat *finishing the exercise* as its completion.
  final VoidCallback? onCompleted;

  @override
  State<WritingPracticePage> createState() => _WritingPracticePageState();
}

class _WritingPracticePageState extends State<WritingPracticePage> {
  /// Grades the open `free_write` answers via the `writing-review` edge function.
  /// Swap to [MockWritingReviewer] to work offline without the backend.
  final WritingReviewer _reviewer = const RemoteWritingReviewer();

  /// Marks the unit done (locally) when the ladder is finished.
  final WritingProgressRepository _progress = WritingProgressRepository();

  int _index = 0;
  late final List<ExState> _states = widget.unit.exercises.map((e) {
    // `scan_sentences` gets one controller per sentence row (line-by-line),
    // seeded with the minimum number of rows.
    if (e.kind == 'scan_sentences') {
      return ExState(
        controller: TextEditingController(),
        lines: List.generate(e.minLines, (_) => TextEditingController()),
      );
    }
    return ExState(controller: TextEditingController());
  }).toList(growable: false);

  List<WritingExercise> get _exercises => widget.unit.exercises;
  WritingExercise get _current => _exercises[_index];
  ExState get _state => _states[_index];

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
  int _filledLines(ExState s) =>
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
        // AI item: no on-device right/wrong — the reviewer grades the writing.
        _state.correct = null;
        _state.reviewing = true;
      }
    });
    if (ex.grade == WritingGrade.ai) _runReview(ex, _state);
  }

  /// Sends an open answer to the reviewer and folds the result into [st]. On
  /// failure we fall back to revealing the model answer (handled by the UI).
  Future<void> _runReview(WritingExercise ex, ExState st) async {
    try {
      final result =
          await _reviewer.review(exercise: ex, text: st.controller.text);
      if (!mounted) return;
      setState(() {
        st.review = result;
        st.reviewing = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        st.reviewFailed = true;
        st.reviewing = false;
      });
    }
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
    // Reaching the end marks the unit done (any score). Fire-and-forget; the
    // path screen's stream picks it up.
    _progress.markDone(widget.unit.id);
    // Notify any host that owns its own completion (e.g. the Key Takeaways step).
    widget.onCompleted?.call();

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
      builder: (_) => SummarySheet(correct: correct, total: auto.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
            padding: EdgeInsets.only(left: 8), child: GlassBackButton()),
        title: Text('Exercise ${_index + 1} of ${_exercises.length}'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: LinearProgressIndicator(
            value: (_index + 1) / _exercises.length,
            minHeight: 4,
            backgroundColor: cs.surfaceContainerHighest,
            valueColor: const AlwaysStoppedAnimation<Color>(
                PmpColors.brandOrange),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // A rule recap above the very first exercise.
                    if (_index == 0 &&
                        (widget.unit.practiceRecapEn.isNotEmpty ||
                            widget.unit.practiceRecapMm.isNotEmpty))
                      RecapCard(
                        en: widget.unit.practiceRecapEn,
                        mm: widget.unit.practiceRecapMm,
                      ),
                    ExerciseView(
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
                  ],
                ),
              ),
            ),
            BottomBar(
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
