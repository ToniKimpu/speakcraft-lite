import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../../config/pmp_colors.dart';
import '../../config/pmp_text_styles.dart';
import '../../config/pmp_routes.dart';
import '../../model/writing/writing_unit.dart';
import '../../model/writing/writing_lexicon.dart';
import 'writing_highlight.dart';

/// Writing module — **step-by-step teach prototype** (one unit: be · am/is/are).
///
/// An experiment that re-segments the long single-scroll teach page
/// ([WritingTeachPage]) into a guided pager: one idea per screen, ending in a
/// quick understanding-check before the exercise ladder.
///
/// Deliberately self-contained — it reuses the shared [WritingUnit] model,
/// [HighlightedText], and the lexicon resolver, but reads the two new optional
/// keys (`teach.walkthrough`, `teach.check`) straight from the raw JSON so the
/// shared model and the old teach screen are untouched. If we keep this, the
/// fields graduate into the model and the old screen retires.
class WritingTeachStepsPage extends StatefulWidget {
  const WritingTeachStepsPage({super.key, this.assetPath = _kDefaultUnitAsset});

  static const _kDefaultUnitAsset =
      'assets/writing/units/l1_be_am_is_are.json';

  final String assetPath;

  @override
  State<WritingTeachStepsPage> createState() => _WritingTeachStepsPageState();
}

/// One walkthrough card — a subject rule + a worked example + the *why*.
class _Walk {
  const _Walk(
      {required this.subject,
      required this.ruleMm,
      required this.en,
      required this.whyMm});
  final String subject;
  final String ruleMm;
  final String en;
  final String whyMm;

  factory _Walk.fromJson(Map<String, dynamic> j) => _Walk(
        subject: j['subject'] as String? ?? '',
        ruleMm: j['rule_mm'] as String? ?? '',
        en: j['en'] as String? ?? '',
        whyMm: j['why_mm'] as String? ?? '',
      );
}

/// The inline understanding-check (one MCQ).
class _Check {
  const _Check(
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

  factory _Check.fromJson(Map<String, dynamic> j) => _Check(
        promptEn: j['prompt_en'] as String? ?? '',
        promptMm: j['prompt_mm'] as String? ?? '',
        options: ((j['options'] as List?) ?? const [])
            .map((e) => e.toString())
            .toList(growable: false),
        answer: j['answer'] as String? ?? '',
        explainMm: j['explain_mm'] as String? ?? '',
      );
}

/// Everything the pager needs: the parsed unit, its resolved toolkit (for the
/// exercise hand-off), and the two prototype-only fields read from raw JSON.
class _StepsData {
  const _StepsData({
    required this.unit,
    required this.toolkit,
    required this.walkthrough,
    required this.checks,
  });
  final WritingUnit unit;
  final ResolvedToolkit toolkit;
  final List<_Walk> walkthrough;
  final List<_Check> checks;
}

class _WritingTeachStepsPageState extends State<WritingTeachStepsPage> {
  late final Future<_StepsData> _data = _load();

  Future<_StepsData> _load() async {
    final raw = await rootBundle.loadString(widget.assetPath);
    final map = jsonDecode(raw) as Map<String, dynamic>;
    final unit = WritingUnit.fromJson(map);

    final teach = (map['teach'] as Map?)?.cast<String, dynamic>() ?? const {};
    final walkthrough = ((teach['walkthrough'] as List?) ?? const [])
        .map((e) => _Walk.fromJson((e as Map).cast<String, dynamic>()))
        .toList(growable: false);
    // Prefer the `checks` list; fall back to a single legacy `check` object.
    final checksRaw = (teach['checks'] as List?) ??
        ((teach['check'] as Map?) == null ? const [] : [teach['check']]);
    final checks = checksRaw
        .map((e) => _Check.fromJson((e as Map).cast<String, dynamic>()))
        .toList(growable: false);

    final lexicon = await loadWritingLexicon();
    final toolkit = ResolvedToolkit(
      verbs: lexicon.resolveVerbs(unit.toolkit.verbIds),
      timeWords: lexicon.resolveTimeWords(unit.toolkit.timeWordIds),
      adjectives: lexicon.resolveAdjectives(unit.toolkit.adjectiveIds),
      nouns: lexicon.resolveNouns(unit.toolkit.nounIds),
    );
    return _StepsData(
        unit: unit, toolkit: toolkit, walkthrough: walkthrough, checks: checks);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Writing')),
      body: FutureBuilder<_StepsData>(
        future: _data,
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError || !snap.hasData) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text('Could not load this lesson.\n${snap.error ?? ''}',
                    textAlign: TextAlign.center),
              ),
            );
          }
          return _StepsBody(data: snap.data!);
        },
      ),
    );
  }
}

class _StepsBody extends StatefulWidget {
  const _StepsBody({required this.data});
  final _StepsData data;

  @override
  State<_StepsBody> createState() => _StepsBodyState();
}

class _StepsBodyState extends State<_StepsBody> {
  final _controller = PageController();
  int _page = 0;

  // Per-step interaction state.
  int _walkRevealed = 1; // how many walkthrough cards are shown (reveal-on-tap)
  final Map<int, String> _checkPicks = {}; // question index → chosen option

  late final List<_Step> _steps = _buildSteps();

  /// Index of the step-by-step walkthrough page, so a failed check can send the
  /// learner back to review it (-1 if the unit has no walkthrough).
  late final int _walkStepIndex =
      _steps.indexWhere((s) => s.kicker == 'STEP BY STEP');

  bool get _hasFrequencyScale =>
      widget.data.unit.teach.blocks.any((b) => b.type == 'frequency_scale');

  // ── Quick-check gate ──────────────────────────────────────────────────
  List<_Check> get _checks => widget.data.checks;
  bool get _onCheckStep => _checks.isNotEmpty && _isLast;
  bool get _checksAllAnswered =>
      _checks.isNotEmpty && _checkPicks.length == _checks.length;
  int get _checksCorrect {
    var n = 0;
    for (var i = 0; i < _checks.length; i++) {
      if (_checkPicks[i] == _checks[i].answer) n++;
    }
    return n;
  }

  /// Pass = every question correct (each tests one distinct rule). Loosen here
  /// (e.g. `>= (_checks.length - 1)`) if all-correct proves too strict.
  bool get _checksPassed =>
      _checksAllAnswered && _checksCorrect == _checks.length;

  void _retryChecks() {
    setState(_checkPicks.clear);
  }

  void _goToStep(int index) {
    if (index < 0) return;
    _controller.animateToPage(index,
        duration: const Duration(milliseconds: 280), curve: Curves.easeOut);
  }

  /// The bottom bar's primary action depends on where we are: a plain "Next"
  /// mid-lesson, and on the final check step a gated "Start exercises" that only
  /// unlocks once the learner passes (otherwise "Try again").
  Widget _buildNavBar() {
    if (!_isLast) {
      return _NavBar(
        showBack: _page != 0,
        onBack: _back,
        primaryLabel: 'Next',
        primaryIcon: Icons.arrow_forward_rounded,
        onPrimary: _next,
      );
    }
    // Last step with no check → straight to exercises.
    if (!_onCheckStep) {
      return _NavBar(
        showBack: _page != 0,
        onBack: _back,
        primaryLabel: 'Start exercises',
        primaryIcon: Icons.edit_note_rounded,
        onPrimary: _startExercises,
      );
    }
    // The gated check step.
    if (!_checksAllAnswered) {
      return _NavBar(
        showBack: _page != 0,
        onBack: _back,
        primaryLabel: 'Start exercises',
        primaryIcon: Icons.edit_note_rounded,
        onPrimary: null, // disabled until every question is answered
      );
    }
    if (_checksPassed) {
      return _NavBar(
        showBack: _page != 0,
        onBack: _back,
        primaryLabel: 'Start exercises',
        primaryIcon: Icons.edit_note_rounded,
        onPrimary: _startExercises,
      );
    }
    // Answered but not passed → retry instead of advancing.
    return _NavBar(
      showBack: _page != 0,
      onBack: _back,
      primaryLabel: 'Try again',
      primaryIcon: Icons.refresh_rounded,
      onPrimary: _retryChecks,
    );
  }

  List<_Step> _buildSteps() {
    final unit = widget.data.unit;
    final teach = unit.teach;
    final steps = <_Step>[];

    // A unit may override any step's Burmese heading via `step_titles_mm` in its
    // JSON; otherwise we use the generic default below. This keeps the heading
    // matched to the topic (e.g. the "pattern" step is Subject+Verb agreement
    // for verb units but noun forms / article choice / preposition choice for
    // others).
    String title(String key, String fallback) {
      final v = teach.stepTitlesMm[key];
      return (v != null && v.isNotEmpty) ? v : fallback;
    }

    // 1 — When + Read.
    steps.add(_Step(
      kicker: 'WHEN TO USE',
      titleMm: title('when', 'ဘယ်အချိန်မှာ သုံးမလဲ'),
      builder: (_) => _WhenStep(teach: teach),
    ));

    // 2 — The pattern (form + agreement). Default heading is topic-neutral; verb
    // units override it to the Subject+Verb wording via step_titles_mm.
    steps.add(_Step(
      kicker: 'THE PATTERN',
      titleMm: title('pattern', 'ပုံစံ — ဘယ်လို ဖွဲ့မလဲ'),
      builder: (_) => _PatternStep(teach: teach),
    ));

    // 3 — Worked examples, explained (progressive).
    if (widget.data.walkthrough.isNotEmpty) {
      steps.add(_Step(
        kicker: 'STEP BY STEP',
        titleMm: title('walkthrough', 'ဥပမာတွေနဲ့ နားလည်အောင်'),
        builder: (_) => _WalkthroughStep(
          items: widget.data.walkthrough,
          revealed: _walkRevealed,
          onReveal: () => setState(() => _walkRevealed++),
        ),
      ));
    }

    // 4 — Concept block (e.g. the frequency scale for present simple): a
    // bespoke teaching visual that sits in the flow, not the reference toolkit.
    if (_hasFrequencyScale &&
        _frequencyAdverbs(widget.data.toolkit).isNotEmpty) {
      steps.add(_Step(
        kicker: 'HOW OFTEN',
        titleMm: title('frequency', 'ဘယ်လောက် မကြာခဏလဲ — verb ရှေ့မှာ'),
        builder: (_) =>
            _FrequencyScale(adverbs: _frequencyAdverbs(widget.data.toolkit)),
      ));
    }

    // 5 — Watch out (trap).
    if (teach.trapMm.isNotEmpty) {
      steps.add(_Step(
        kicker: 'WATCH OUT',
        titleMm: title('trap', 'အမှားများတဲ့ နေရာ'),
        builder: (_) => _TrapStep(mm: teach.trapMm),
      ));
    }

    // 6 — Get ready to write: the reference word banks + the model paragraph,
    // the bridge into the exercises (the toolkit is also handed to the practice
    // screen). Shown only when the unit actually carries banks or a model.
    if (!widget.data.toolkit.isEmpty || teach.hasModelParagraph) {
      steps.add(_Step(
        kicker: 'GET READY TO WRITE',
        titleMm: title('toolkit', 'ဒီစကားလုံးတွေနဲ့ ရေးကြည့်ရအောင်'),
        builder: (_) =>
            _ToolkitStep(unit: widget.data.unit, toolkit: widget.data.toolkit),
      ));
    }

    // 7 — Quick check (one MCQ per subject rule).
    if (widget.data.checks.isNotEmpty) {
      steps.add(_Step(
        kicker: 'QUICK CHECK',
        titleMm: title('check', 'နားလည်ရဲ့လား စမ်းကြည့်ရအောင်'),
        builder: (_) => _CheckStep(
          checks: widget.data.checks,
          picks: _checkPicks,
          onPick: (i, v) => setState(() => _checkPicks[i] = v),
          passed: _checksPassed,
          onReview:
              _walkStepIndex >= 0 ? () => _goToStep(_walkStepIndex) : null,
        ),
      ));
    }

    return steps;
  }

  bool get _isLast => _page == _steps.length - 1;

  void _next() {
    if (_isLast) {
      _startExercises();
      return;
    }
    _controller.nextPage(
        duration: const Duration(milliseconds: 280), curve: Curves.easeOut);
  }

  void _back() {
    _controller.previousPage(
        duration: const Duration(milliseconds: 280), curve: Curves.easeOut);
  }

  void _startExercises() {
    Navigator.pushNamed(
      context,
      PmpRoutes.writingPractice,
      arguments: {'unit': widget.data.unit, 'toolkit': widget.data.toolkit},
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final unit = widget.data.unit;

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header: title + step progress bar.
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(unit.title,
                    style: PmpTextStyles.h2.copyWith(
                        color: cs.onSurface,
                        fontFamily: 'ArchivoBlack Regular')),
                if (unit.subtitleMm.isNotEmpty)
                  Text(unit.subtitleMm,
                      style: PmpTextStyles.sub.copyWith(
                          color:
                              PmpColors.myanmarGloss(Theme.of(context).brightness))),
                const SizedBox(height: 12),
                _StepDots(count: _steps.length, active: _page),
              ],
            ),
          ),
          const SizedBox(height: 8),

          Expanded(
            child: PageView.builder(
              controller: _controller,
              onPageChanged: (i) => setState(() => _page = i),
              itemCount: _steps.length,
              itemBuilder: (context, i) {
                final step = _steps[i];
                return SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(step.kicker,
                          style: PmpTextStyles.labelSemi.copyWith(
                              color: cs.primary, letterSpacing: 0.8)),
                      const SizedBox(height: 2),
                      Text(step.titleMm,
                          style: PmpTextStyles.body1Semi.copyWith(
                              color: PmpColors.myanmarGloss(
                                  Theme.of(context).brightness))),
                      const SizedBox(height: 16),
                      step.builder(context),
                    ],
                  ),
                );
              },
            ),
          ),

          _buildNavBar(),
        ],
      ),
    );
  }
}

/// One pager step: a kicker + Burmese title + its body builder.
class _Step {
  const _Step(
      {required this.kicker, required this.titleMm, required this.builder});
  final String kicker;
  final String titleMm;
  final WidgetBuilder builder;
}

// ─────────────────────────────────────────────────────────────────────────
// Step 1 — When + Read
// ─────────────────────────────────────────────────────────────────────────
class _WhenStep extends StatelessWidget {
  const _WhenStep({required this.teach});
  final WritingTeach teach;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final mm = PmpColors.myanmarGloss(Theme.of(context).brightness);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (teach.useMm.isNotEmpty)
          _Card(
            icon: Icons.lightbulb_outline,
            child: Text(teach.useMm,
                style: PmpTextStyles.body2Regular
                    .copyWith(color: mm, height: 1.7)),
          ),
        const SizedBox(height: 14),
        const HighlightLegend(),
        const SizedBox(height: 12),
        _Card(
          icon: Icons.menu_book_outlined,
          label: 'ဒါလေးကို အရင်ဖတ်ကြည့်ပါ',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HighlightedText(teach.situationEn,
                  style: PmpTextStyles.body1Regular
                      .copyWith(color: cs.onSurface, height: 1.7)),
              if (teach.situationMm.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(teach.situationMm,
                    style: PmpTextStyles.body2Regular
                        .copyWith(color: mm, height: 1.7)),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Step 2 — The pattern (form table + agreement buckets)
// ─────────────────────────────────────────────────────────────────────────
class _PatternStep extends StatelessWidget {
  const _PatternStep({required this.teach});
  final WritingTeach teach;

  Map<String, dynamic>? get _agreement {
    for (final b in teach.blocks) {
      if (b.type == 'agreement') return b.data;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final agreement = _agreement;
    final buckets = ((agreement?['buckets'] as List?) ?? const [])
        .map((e) => (e as Map).cast<String, dynamic>())
        .toList(growable: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (buckets.isNotEmpty)
          for (final b in buckets) ...[
            _AgreementCard(data: b),
            const SizedBox(height: 8),
          ]
        else
          _Card(child: _FormTable(rows: teach.form)),
        if (teach.formNoteMm.isNotEmpty) ...[
          const SizedBox(height: 6),
          _NoteCard(mm: teach.formNoteMm),
        ],
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Step 3 — Worked examples, explained (progressive reveal)
// ─────────────────────────────────────────────────────────────────────────
class _WalkthroughStep extends StatelessWidget {
  const _WalkthroughStep(
      {required this.items, required this.revealed, required this.onReveal});
  final List<_Walk> items;
  final int revealed;
  final VoidCallback onReveal;

  @override
  Widget build(BuildContext context) {
    final shown = revealed.clamp(1, items.length);
    final hasMore = shown < items.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var i = 0; i < shown; i++) ...[
          _WalkCard(item: items[i], index: i),
          const SizedBox(height: 10),
        ],
        if (hasMore)
          OutlinedButton.icon(
            onPressed: onReveal,
            icon: const Icon(Icons.add_rounded, size: 18),
            label: const Text('Next example'),
          ),
      ],
    );
  }
}

class _WalkCard extends StatelessWidget {
  const _WalkCard({required this.item, required this.index});
  final _Walk item;
  final int index;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final mm = PmpColors.myanmarGloss(Theme.of(context).brightness);
    final verbColor = writingVerbColor(Theme.of(context).brightness);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // subject pill → rule
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: verbColor.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(item.subject,
                    style:
                        PmpTextStyles.body2Semi.copyWith(color: verbColor)),
              ),
            ],
          ),
          if (item.ruleMm.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(item.ruleMm,
                style: PmpTextStyles.body2Semi.copyWith(color: mm)),
          ],
          const SizedBox(height: 10),
          HighlightedText('“${item.en}”',
              style: PmpTextStyles.body1Regular
                  .copyWith(color: cs.onSurface, height: 1.5)),
          if (item.whyMm.isNotEmpty) ...[
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: cs.primary.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.help_outline_rounded,
                      size: 16, color: cs.primary),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(item.whyMm,
                        style: PmpTextStyles.body2Regular
                            .copyWith(color: mm, height: 1.7)),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Step 4 — Watch out (trap)
// ─────────────────────────────────────────────────────────────────────────
class _TrapStep extends StatelessWidget {
  const _TrapStep({required this.mm});
  final String mm;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: PmpColors.warning500.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: PmpColors.warning500.withValues(alpha: 0.4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.warning_amber_rounded,
              size: 20, color: PmpColors.warning600),
          const SizedBox(width: 10),
          Expanded(
            child: Text(mm,
                style: PmpTextStyles.body2Regular
                    .copyWith(color: cs.onSurfaceVariant, height: 1.7)),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Step 5 — Quick check (one MCQ, instant feedback)
// ─────────────────────────────────────────────────────────────────────────
class _CheckStep extends StatelessWidget {
  const _CheckStep(
      {required this.checks,
      required this.picks,
      required this.onPick,
      required this.passed,
      required this.onReview});
  final List<_Check> checks;
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
          _CheckQuestion(
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
          _ScoreTally(
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
class _CheckQuestion extends StatelessWidget {
  const _CheckQuestion(
      {required this.check,
      required this.number,
      required this.total,
      required this.picked,
      required this.onPick});
  final _Check check;
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
        _Card(
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
          _OptionTile(
            label: opt,
            state: !answered
                ? _OptState.idle
                : opt == check.answer
                    ? _OptState.correct
                    : (opt == picked ? _OptState.wrong : _OptState.idle),
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
                      correct ? 'Correct!  ${check.explainMm}' : check.explainMm,
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
class _ScoreTally extends StatelessWidget {
  const _ScoreTally(
      {required this.correct,
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

enum _OptState { idle, correct, wrong }

class _OptionTile extends StatelessWidget {
  const _OptionTile(
      {required this.label, required this.state, required this.onTap});
  final String label;
  final _OptState state;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    Color border = cs.outlineVariant;
    Color bg = cs.surfaceContainerHighest;
    Color fg = cs.onSurface;
    IconData? trailing;
    switch (state) {
      case _OptState.correct:
        border = PmpColors.primary500;
        bg = PmpColors.primary500.withValues(alpha: 0.12);
        trailing = Icons.check_rounded;
        break;
      case _OptState.wrong:
        border = PmpColors.warning500;
        bg = PmpColors.warning500.withValues(alpha: 0.12);
        trailing = Icons.close_rounded;
        break;
      case _OptState.idle:
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
                    style:
                        PmpTextStyles.body1Semi.copyWith(color: fg)),
              ),
              if (trailing != null) Icon(trailing, size: 20, color: border),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Step 4 — Concept block: the frequency scale (how often → before the verb)
// ─────────────────────────────────────────────────────────────────────────

/// Frequency adverbs (how often → before the verb), highest frequency first.
List<LexiconTimeWord> _frequencyAdverbs(ResolvedToolkit t) {
  final list =
      t.timeWords.where((w) => w.isFrequencyAdverb).toList(growable: false);
  list.sort((a, b) => (b.frequency ?? 0).compareTo(a.frequency ?? 0));
  return list;
}

/// Time phrases (when → end of sentence), in authored order.
List<LexiconTimeWord> _timePhrases(ResolvedToolkit t) =>
    t.timeWords.where((w) => !w.isFrequencyAdverb).toList(growable: false);

/// The shared lexicon stores positive present-simple examples, so they only fit
/// an affirmative present-simple unit (`verb_form: third`). Other forms show
/// the banks form-only (the unit's own examples carry the tense-correct lines).
bool _showBankExamples(WritingUnit unit) => unit.toolkit.verbForm == 'third';

/// The frequency scale — each adverb on a bar from 100% (always) to 0% (never),
/// so learners *see* "how often" and that these words cluster before the verb.
class _FrequencyScale extends StatelessWidget {
  const _FrequencyScale({required this.adverbs});
  final List<LexiconTimeWord> adverbs;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final mm = PmpColors.myanmarGloss(Theme.of(context).brightness);
    const bar = PmpColors.accentOrange;
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              'always, usually, often … စတဲ့ စကားလုံးတွေက verb ရဲ့ ရှေ့မှာ နေပါတယ်။',
              style: PmpTextStyles.body2Regular.copyWith(color: mm, height: 1.6)),
          const SizedBox(height: 12),
          for (final w in adverbs)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  SizedBox(
                    width: 84,
                    child: Text(w.en,
                        style:
                            PmpTextStyles.body2Semi.copyWith(color: bar)),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Container(
                        height: 12,
                        color: bar.withValues(alpha: 0.12),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor:
                              ((w.frequency ?? 0) / 100).clamp(0.0, 1.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: bar.withValues(alpha: 0.55),
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 36,
                    child: Text('${w.frequency ?? 0}%',
                        textAlign: TextAlign.right,
                        style: PmpTextStyles.sub
                            .copyWith(color: cs.onSurfaceVariant)),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Step 6 — Get ready to write: word banks + model paragraph
// ─────────────────────────────────────────────────────────────────────────

/// The reference step before the exercises: every word bank the unit carries
/// (verbs / jobs / describing words / time phrases) + its notes, ending with the
/// model paragraph so the learner sees the target output before writing.
class _ToolkitStep extends StatelessWidget {
  const _ToolkitStep({required this.unit, required this.toolkit});
  final WritingUnit unit;
  final ResolvedToolkit toolkit;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final mm = PmpColors.myanmarGloss(Theme.of(context).brightness);
    final teach = unit.teach;
    final showExamples = _showBankExamples(unit);
    final phrases = _timePhrases(toolkit);

    final sections = <Widget>[];
    void add(Widget w) {
      if (sections.isNotEmpty) sections.add(const SizedBox(height: 14));
      sections.add(w);
    }

    if (toolkit.verbs.isNotEmpty) {
      add(_Card(
        icon: Icons.handyman_outlined,
        label: 'Verbs you can use',
        child: _VerbBank(
            verbs: toolkit.verbs,
            formKey: unit.toolkit.verbForm,
            showExamples: showExamples,
            overrides: unit.toolkit.verbExamples),
      ));
    }
    if (toolkit.nouns.isNotEmpty) {
      add(_Card(
        icon: Icons.badge_outlined,
        label: 'Jobs & roles  ·  I am a …',
        child: _SimpleWordBank(
          entries: [
            for (final n in toolkit.nouns)
              _WordEntry(en: n.withArticle, mm: n.mm, examples: n.examples),
          ],
          showExamples: showExamples,
        ),
      ));
    }
    if (toolkit.adjectives.isNotEmpty) {
      add(_Card(
        icon: Icons.palette_outlined,
        label: 'Describing words  ·  She is …',
        child: _SimpleWordBank(
          entries: [
            for (final a in toolkit.adjectives)
              _WordEntry(en: a.en, mm: a.mm, examples: a.examples),
          ],
          showExamples: showExamples,
        ),
      ));
    }
    if (unit.toolkit.noteMm.isNotEmpty) add(_NoteCard(mm: unit.toolkit.noteMm));
    if (phrases.isNotEmpty) {
      add(_Card(
        icon: Icons.event_outlined,
        label: 'Time phrases  ·  when',
        child: _TimeWordBank(
            words: phrases,
            showExamples: showExamples,
            overrides: unit.toolkit.timeWordExamples),
      ));
    }
    if (unit.toolkit.timeWordsNoteMm.isNotEmpty) {
      add(_NoteCard(mm: unit.toolkit.timeWordsNoteMm));
    }
    if (teach.hasModelParagraph) {
      add(_Card(
        icon: Icons.auto_stories_outlined,
        label: 'See it all together',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HighlightedText(teach.modelParagraphEn,
                style: PmpTextStyles.body1Regular
                    .copyWith(color: cs.onSurface, height: 1.7)),
            if (teach.modelParagraphMm.isNotEmpty) ...[
              const SizedBox(height: 10),
              Text(teach.modelParagraphMm,
                  style: PmpTextStyles.body2Regular
                      .copyWith(color: mm, height: 1.7)),
            ],
          ],
        ),
      ));
    }

    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, children: sections);
  }
}

/// A bilingual example row (bullet + English with highlight + Burmese gloss).
class _ExampleRow extends StatelessWidget {
  const _ExampleRow({required this.en, required this.mm});
  final String en;
  final String mm;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final mmColor = PmpColors.myanmarGloss(Theme.of(context).brightness);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2, right: 8),
            child: Icon(Icons.circle, size: 6, color: cs.primary),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HighlightedText(en,
                    style: PmpTextStyles.body1Regular
                        .copyWith(color: cs.onSurface)),
                if (mm.isNotEmpty)
                  Text(mm,
                      style:
                          PmpTextStyles.body2Regular.copyWith(color: mmColor)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// The verb bank — each row collapses to `base → second-form` + gloss, and
/// expands to a bilingual example. Ported from the single-scroll teach page.
class _VerbBank extends StatelessWidget {
  const _VerbBank(
      {required this.verbs,
      required this.formKey,
      required this.showExamples,
      required this.overrides});
  final List<LexiconVerb> verbs;
  final String formKey;
  final bool showExamples;
  final Map<String, ExamplePair> overrides;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < verbs.length; i++) ...[
            if (i > 0)
              Divider(
                  height: 1, color: cs.outlineVariant.withValues(alpha: 0.5)),
            _VerbTile(
                verb: verbs[i],
                formKey: formKey,
                showExamples: showExamples,
                exampleOverride: overrides[verbs[i].id]),
          ],
        ],
      ),
    );
  }
}

class _VerbTile extends StatelessWidget {
  const _VerbTile(
      {required this.verb,
      required this.formKey,
      required this.showExamples,
      required this.exampleOverride});
  final LexiconVerb verb;
  final String formKey;
  final bool showExamples;
  final ExamplePair? exampleOverride;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final mmColor = PmpColors.myanmarGloss(Theme.of(context).brightness);
    final second = verb.secondForm(formKey);
    final verbColor = writingVerbColor(Theme.of(context).brightness);
    final examples = exampleOverride != null
        ? [exampleOverride!]
        : (showExamples ? verb.examples : const <ExamplePair>[]);

    final title = (second == verb.base)
        ? Text(verb.base,
            style: PmpTextStyles.body1Semi.copyWith(color: verbColor))
        : RichText(
            text: TextSpan(
              style: PmpTextStyles.body1Regular.copyWith(color: cs.onSurface),
              children: [
                TextSpan(text: verb.base),
                TextSpan(
                    text: '  →  ',
                    style: TextStyle(color: cs.onSurfaceVariant)),
                TextSpan(
                    text: second,
                    style: PmpTextStyles.body1Semi.copyWith(color: verbColor)),
              ],
            ),
          );
    final subtitle = verb.mm.isEmpty
        ? null
        : Text(verb.mm,
            style: PmpTextStyles.body2Regular.copyWith(color: mmColor));

    if (examples.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [title, if (subtitle != null) subtitle],
        ),
      );
    }
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      childrenPadding: const EdgeInsets.only(left: 4, bottom: 10),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      title: title,
      subtitle: subtitle,
      children: [for (final ex in examples) _ExampleRow(en: ex.en, mm: ex.mm)],
    );
  }
}

/// The time-phrase bank — header shows the phrase + its position rule; expands
/// to a bilingual example. Ported from the single-scroll teach page.
class _TimeWordBank extends StatelessWidget {
  const _TimeWordBank(
      {required this.words,
      required this.showExamples,
      required this.overrides});
  final List<LexiconTimeWord> words;
  final bool showExamples;
  final Map<String, ExamplePair> overrides;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < words.length; i++) ...[
            if (i > 0)
              Divider(
                  height: 1, color: cs.outlineVariant.withValues(alpha: 0.5)),
            _TimeWordTile(
                word: words[i],
                showExamples: showExamples,
                exampleOverride: overrides[words[i].id]),
          ],
        ],
      ),
    );
  }
}

class _TimeWordTile extends StatelessWidget {
  const _TimeWordTile(
      {required this.word,
      required this.showExamples,
      required this.exampleOverride});
  final LexiconTimeWord word;
  final bool showExamples;
  final ExamplePair? exampleOverride;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final mmColor = PmpColors.myanmarGloss(Theme.of(context).brightness);
    final title = Row(
      children: [
        Flexible(
          child: Text(word.en,
              style: PmpTextStyles.body1Semi.copyWith(color: cs.onSurface)),
        ),
        if (word.positionLabel.isNotEmpty) ...[
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: cs.primary.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(word.positionLabel,
                style: PmpTextStyles.sub.copyWith(color: cs.primary)),
          ),
        ],
      ],
    );
    final subtitle = word.mm.isEmpty
        ? null
        : Text(word.mm,
            style: PmpTextStyles.body2Regular.copyWith(color: mmColor));
    final examples = exampleOverride != null
        ? [exampleOverride!]
        : (showExamples ? word.examples : const <ExamplePair>[]);

    if (examples.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [title, if (subtitle != null) subtitle],
        ),
      );
    }
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      childrenPadding: const EdgeInsets.only(left: 4, bottom: 10),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      title: title,
      subtitle: subtitle,
      children: [for (final ex in examples) _ExampleRow(en: ex.en, mm: ex.mm)],
    );
  }
}

/// A plain (en + Burmese gloss) word for the adjective / noun banks.
class _WordEntry {
  const _WordEntry(
      {required this.en, required this.mm, required this.examples});
  final String en;
  final String mm;
  final List<ExamplePair> examples;
}

/// A simple word bank (adjectives / nouns) — expandable bilingual rows, mirroring
/// the verb / time-word banks but without a form column.
class _SimpleWordBank extends StatelessWidget {
  const _SimpleWordBank({required this.entries, required this.showExamples});
  final List<_WordEntry> entries;
  final bool showExamples;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < entries.length; i++) ...[
            if (i > 0)
              Divider(
                  height: 1, color: cs.outlineVariant.withValues(alpha: 0.5)),
            _SimpleWordTile(entry: entries[i], showExamples: showExamples),
          ],
        ],
      ),
    );
  }
}

class _SimpleWordTile extends StatelessWidget {
  const _SimpleWordTile({required this.entry, required this.showExamples});
  final _WordEntry entry;
  final bool showExamples;

  @override
  Widget build(BuildContext context) {
    final verbColor = writingVerbColor(Theme.of(context).brightness);
    final mmColor = PmpColors.myanmarGloss(Theme.of(context).brightness);
    final title = Text(entry.en,
        style: PmpTextStyles.body1Semi.copyWith(color: verbColor));
    final subtitle = entry.mm.isEmpty
        ? null
        : Text(entry.mm,
            style: PmpTextStyles.body2Regular.copyWith(color: mmColor));
    final examples = showExamples ? entry.examples : const <ExamplePair>[];

    if (examples.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [title, if (subtitle != null) subtitle],
        ),
      );
    }
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      childrenPadding: const EdgeInsets.only(left: 4, bottom: 10),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      title: title,
      subtitle: subtitle,
      children: [for (final ex in examples) _ExampleRow(en: ex.en, mm: ex.mm)],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Shared chrome
// ─────────────────────────────────────────────────────────────────────────

/// A labelled content card — optional icon + label header over its child.
class _Card extends StatelessWidget {
  const _Card({this.icon, this.label, required this.child});
  final IconData? icon;
  final String? label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null || icon != null) ...[
            Row(
              children: [
                if (icon != null) ...[
                  Icon(icon, size: 16, color: cs.primary),
                  const SizedBox(width: 6),
                ],
                if (label != null)
                  Text(label!.toUpperCase(),
                      style: PmpTextStyles.labelSemi.copyWith(
                          color: cs.onSurfaceVariant, letterSpacing: 0.6)),
              ],
            ),
            const SizedBox(height: 10),
          ],
          child,
        ],
      ),
    );
  }
}

class _FormTable extends StatelessWidget {
  const _FormTable({required this.rows});
  final List<FormRow> rows;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final verbColor = writingVerbColor(Theme.of(context).brightness);
    return Column(
      children: [
        for (var i = 0; i < rows.length; i++) ...[
          if (i > 0)
            Divider(height: 16, color: cs.outlineVariant.withValues(alpha: 0.6)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child: Text(rows[i].subject,
                    style: PmpTextStyles.body2Regular
                        .copyWith(color: cs.onSurfaceVariant)),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 4,
                child: Text(rows[i].form,
                    style:
                        PmpTextStyles.body2Semi.copyWith(color: verbColor)),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

/// One subject "bucket" — subject group → form + tag, with the worked example.
class _AgreementCard extends StatelessWidget {
  const _AgreementCard({required this.data});
  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final verbColor = writingVerbColor(Theme.of(context).brightness);
    final subjects = data['subjects']?.toString() ?? '';
    final form = data['form']?.toString() ?? '';
    final tag = data['tag']?.toString() ?? '';
    final example = data['example']?.toString() ?? '';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(subjects,
              style: PmpTextStyles.body2Semi.copyWith(color: cs.onSurface)),
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(Icons.arrow_forward_rounded,
                  size: 16, color: cs.onSurfaceVariant),
              const SizedBox(width: 6),
              Flexible(
                child: Text(form,
                    style:
                        PmpTextStyles.body1Semi.copyWith(color: verbColor)),
              ),
              if (tag.isNotEmpty) ...[
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: cs.onSurfaceVariant.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(tag,
                      style: PmpTextStyles.sub.copyWith(
                          color: cs.onSurfaceVariant,
                          fontWeight: FontWeight.w600)),
                ),
              ],
            ],
          ),
          if (example.isNotEmpty) ...[
            const SizedBox(height: 6),
            HighlightedText('“$example”',
                style: PmpTextStyles.body2Regular
                    .copyWith(color: cs.onSurfaceVariant)),
          ],
        ],
      ),
    );
  }
}

class _NoteCard extends StatelessWidget {
  const _NoteCard({required this.mm});
  final String mm;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final mmColor = PmpColors.myanmarGloss(Theme.of(context).brightness);
    final lines = mm
        .split('\n')
        .map((l) => l.trim())
        .where((l) => l.isNotEmpty)
        .toList(growable: false);
    final style =
        PmpTextStyles.body2Regular.copyWith(color: mmColor, height: 1.7);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cs.primary.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: cs.primary.withValues(alpha: 0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.tips_and_updates_outlined, size: 18, color: cs.primary),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var i = 0; i < lines.length; i++)
                  Padding(
                    padding: EdgeInsets.only(top: i == 0 ? 0 : 7),
                    child: lines.length > 1
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('•  ', style: style),
                              Expanded(
                                  child:
                                      HighlightedText(lines[i], style: style)),
                            ],
                          )
                        : HighlightedText(lines[i], style: style),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// The step progress dots — the active one stretches into a pill.
class _StepDots extends StatelessWidget {
  const _StepDots({required this.count, required this.active});
  final int count;
  final int active;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      children: [
        for (var i = 0; i < count; i++) ...[
          AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            height: 6,
            width: i == active ? 26 : 6,
            decoration: BoxDecoration(
              color: i <= active
                  ? cs.primary
                  : cs.outlineVariant.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          if (i != count - 1) const SizedBox(width: 6),
        ],
      ],
    );
  }
}

class _NavBar extends StatelessWidget {
  const _NavBar({
    required this.showBack,
    required this.onBack,
    required this.primaryLabel,
    required this.primaryIcon,
    required this.onPrimary,
  });
  final bool showBack;
  final VoidCallback onBack;
  final String primaryLabel;
  final IconData primaryIcon;

  /// Null disables the primary button (e.g. the check gate before all answered).
  final VoidCallback? onPrimary;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 14),
      decoration: BoxDecoration(
        color: cs.surface,
        border: Border(top: BorderSide(color: cs.outlineVariant)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            if (showBack) ...[
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: OutlinedButton(
                    onPressed: onBack,
                    child: const Text('Back'),
                  ),
                ),
              ),
              const SizedBox(width: 12),
            ],
            Expanded(
              flex: 2,
              child: SizedBox(
                height: 50,
                child: FilledButton.icon(
                  onPressed: onPrimary,
                  icon: Icon(primaryIcon),
                  label: Text(primaryLabel),
                  style: FilledButton.styleFrom(
                    backgroundColor: cs.primary,
                    foregroundColor: cs.onPrimary,
                    disabledBackgroundColor:
                        cs.onSurface.withValues(alpha: 0.12),
                    disabledForegroundColor:
                        cs.onSurface.withValues(alpha: 0.38),
                    textStyle: PmpTextStyles.body1Semi,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
