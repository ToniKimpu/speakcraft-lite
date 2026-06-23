import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:speakcraft/shared_widgets/glass.dart';

import '../../config/pmp_colors.dart';
import '../../config/pmp_routes.dart';
import '../../config/pmp_text_styles.dart';
import '../../model/writing/writing_lexicon.dart';
import '../../model/writing/writing_unit.dart';
import 'widgets/writing_steps_check.dart';
import 'widgets/writing_steps_widgets.dart';
import 'widgets/writing_teach_helpers.dart';

/// Writing module — the **step-by-step teach screen** for a grammar unit.
///
/// A guided pager: one idea per screen (when → pattern → walkthrough → trap →
/// toolkit), ending in a quick understanding-check before the exercise ladder.
/// Every unit (Levels 1–3) opens here.
///
/// It reuses the shared [WritingUnit] model, [HighlightedText], and the lexicon
/// resolver, and reads the optional `teach.walkthrough` / `teach.check` keys
/// straight from the raw JSON.
///
/// The per-step bodies live in `widgets/writing_steps_widgets.dart`; the
/// understanding-check in `widgets/writing_steps_check.dart`. This file keeps the
/// pager state machine (page index, reveal/check gates, navigation).
class WritingTeachStepsPage extends StatefulWidget {
  const WritingTeachStepsPage({super.key, this.assetPath = _kDefaultUnitAsset});

  static const _kDefaultUnitAsset = 'assets/writing/units/l1_be_am_is_are.json';

  final String assetPath;

  @override
  State<WritingTeachStepsPage> createState() => _WritingTeachStepsPageState();
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
  final List<Walk> walkthrough;
  final List<Check> checks;
}

class _WritingTeachStepsPageState extends State<WritingTeachStepsPage> {
  late final Future<_StepsData> _data = _load();

  Future<_StepsData> _load() async {
    final raw = await rootBundle.loadString(widget.assetPath);
    final map = jsonDecode(raw) as Map<String, dynamic>;
    final unit = WritingUnit.fromJson(map);

    final teach = (map['teach'] as Map?)?.cast<String, dynamic>() ?? const {};
    final walkthrough = ((teach['walkthrough'] as List?) ?? const [])
        .map((e) => Walk.fromJson((e as Map).cast<String, dynamic>()))
        .toList(growable: false);
    // Prefer the `checks` list; fall back to a single legacy `check` object.
    final checksRaw = (teach['checks'] as List?) ??
        ((teach['check'] as Map?) == null ? const [] : [teach['check']]);
    final checks = checksRaw
        .map((e) => Check.fromJson((e as Map).cast<String, dynamic>()))
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
      appBar: AppBar(
        leading: const Padding(
            padding: EdgeInsets.only(left: 8), child: GlassBackButton()),
        title: const Text('Writing'),
      ),
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
  List<Check> get _checks => widget.data.checks;
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
      return NavBar(
        showBack: _page != 0,
        onBack: _back,
        primaryLabel: 'Next',
        primaryIcon: Icons.arrow_forward_rounded,
        onPrimary: _next,
      );
    }
    // Last step with no check → straight to exercises.
    if (!_onCheckStep) {
      return NavBar(
        showBack: _page != 0,
        onBack: _back,
        primaryLabel: 'Start exercises',
        primaryIcon: Icons.edit_note_rounded,
        onPrimary: _startExercises,
      );
    }
    // The gated check step.
    if (!_checksAllAnswered) {
      return NavBar(
        showBack: _page != 0,
        onBack: _back,
        primaryLabel: 'Start exercises',
        primaryIcon: Icons.edit_note_rounded,
        onPrimary: null, // disabled until every question is answered
      );
    }
    if (_checksPassed) {
      return NavBar(
        showBack: _page != 0,
        onBack: _back,
        primaryLabel: 'Start exercises',
        primaryIcon: Icons.edit_note_rounded,
        onPrimary: _startExercises,
      );
    }
    // Answered but not passed → retry instead of advancing.
    return NavBar(
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
      builder: (_) => WhenStep(teach: teach),
    ));

    // 2 — The pattern (form + agreement). Default heading is topic-neutral; verb
    // units override it to the Subject+Verb wording via step_titles_mm.
    steps.add(_Step(
      kicker: 'THE PATTERN',
      titleMm: title('pattern', 'ပုံစံ — ဘယ်လို ဖွဲ့မလဲ'),
      builder: (_) => PatternStep(teach: teach),
    ));

    // 3 — Worked examples, explained (progressive).
    if (widget.data.walkthrough.isNotEmpty) {
      steps.add(_Step(
        kicker: 'STEP BY STEP',
        titleMm: title('walkthrough', 'ဥပမာတွေနဲ့ ကြည့်ရအောင်'),
        builder: (_) => WalkthroughStep(
          items: widget.data.walkthrough,
          revealed: _walkRevealed,
          onReveal: () => setState(() => _walkRevealed++),
        ),
      ));
    }

    // 4 — Concept block (e.g. the frequency scale for present simple): a
    // bespoke teaching visual that sits in the flow, not the reference toolkit.
    if (_hasFrequencyScale &&
        frequencyAdverbs(widget.data.toolkit).isNotEmpty) {
      steps.add(_Step(
        kicker: 'HOW OFTEN',
        titleMm: title('frequency', 'ဘယ်လောက် မကြာခဏလဲ — verb ရှေ့မှာ'),
        builder: (_) =>
            StepFrequencyScale(adverbs: frequencyAdverbs(widget.data.toolkit)),
      ));
    }

    // 5 — Watch out (trap).
    if (teach.trapMm.isNotEmpty) {
      steps.add(_Step(
        kicker: 'WATCH OUT',
        titleMm: title('trap', 'အမှားများတဲ့ နေရာ'),
        builder: (_) => TrapStep(mm: teach.trapMm),
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
            ToolkitStep(unit: widget.data.unit, toolkit: widget.data.toolkit),
      ));
    }

    // 7 — Quick check (one MCQ per subject rule).
    if (widget.data.checks.isNotEmpty) {
      steps.add(_Step(
        kicker: 'QUICK CHECK',
        titleMm: title('check', 'နားလည်ရဲ့လား စမ်းကြည့်ရအောင်'),
        builder: (_) => CheckStep(
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
                          color: PmpColors.myanmarGloss(
                              Theme.of(context).brightness))),
                const SizedBox(height: 12),
                StepDots(count: _steps.length, active: _page),
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
                          style: PmpTextStyles.labelSemi
                              .copyWith(color: cs.primary, letterSpacing: 0.8)),
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
