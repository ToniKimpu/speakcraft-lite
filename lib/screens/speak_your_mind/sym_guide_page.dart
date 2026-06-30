import 'package:flutter/material.dart';

import '../../config/pmp_colors.dart';
import '../../config/pmp_routes.dart';
import '../../config/pmp_text_styles.dart';
import '../../model/speak_your_mind/sym_audio.dart';
import '../../model/speak_your_mind/sym_guide.dart';
import '../../model/speak_your_mind/sym_loader.dart';
import '../../model/speak_your_mind/sym_models.dart';
import '../../services/vocab_tts_service.dart';
import '../../services/analytics_service.dart';
import '../../shared_widgets/error_retry_view.dart';
import '../../shared_widgets/glass.dart';

/// The guided on-ramp — gradual release for learners who freeze at a blank page:
///   1. Model (I do)  — a worked example + line-by-line "what it does".
///   2. Build (We do) — fill only the personal blanks; watch the paragraph
///                      assemble live. Next is gated until every slot is filled.
///   3. Yours (You do)— your assembled draft → hand into the produce flow,
///                      where you expand it and get feedback.
class SymGuidePage extends StatefulWidget {
  const SymGuidePage({super.key, required this.topicId});
  final String topicId;

  @override
  State<SymGuidePage> createState() => _SymGuidePageState();
}

class _SymGuidePageState extends State<SymGuidePage> {
  SymTopic? _topic;
  Object? _error;

  final PageController _pager = PageController();
  int _step = 0;
  static const _stepCount = 3;

  /// slotId → answer.
  final Map<String, String> _answers = {};
  final Map<String, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final t = await loadSymTopic(widget.topicId);
      if (!mounted) return;
      for (final s in t.guide?.slots ?? const <SymSlot>[]) {
        if (s.options.isEmpty) _controllers[s.id] = TextEditingController();
      }
      setState(() => _topic = t);
    } catch (e) {
      if (mounted) setState(() => _error = e);
    }
  }

  @override
  void dispose() {
    _pager.dispose();
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  SymGuide get _guide => _topic!.guide!;

  bool get _allFilled =>
      _guide.slots.every((s) => (_answers[s.id] ?? '').trim().isNotEmpty);

  /// The assembled draft: template with each `{slot}` replaced by the answer
  /// (falls back to the hint for the live preview when a slot is still empty).
  String _assemble({required bool preview}) {
    var out = _guide.template;
    for (final s in _guide.slots) {
      final a = (_answers[s.id] ?? '').trim();
      final v = a.isNotEmpty
          ? a
          : (preview ? '____' : (s.hint.isNotEmpty ? s.hint : s.labelEn));
      out = out.replaceAll('{${s.id}}', v);
    }
    return out;
  }

  void _go(int step) {
    setState(() => _step = step);
    _pager.animateToPage(step,
        duration: const Duration(milliseconds: 240), curve: Curves.easeInOut);
  }

  void _useAsDraft() {
    AnalyticsService.instance.symGuideUsed(widget.topicId);
    Navigator.pushReplacementNamed(
      context,
      PmpRoutes.speakYourMindProduce,
      arguments: {'id': widget.topicId, 'initialText': _assemble(preview: false)},
    );
  }

  @override
  Widget build(BuildContext context) {
    final topic = _topic;
    return GlassScaffold(
      title: Text(topic == null ? 'Guide' : 'Guide — ${topic.titleEn}'),
      body: _error != null
          ? ErrorRetryView(
              error: _error,
              onRetry: () {
                setState(() => _error = null);
                _load();
              },
            )
          : topic == null || topic.guide == null
              ? const Center(child: CircularProgressIndicator())
              : _buildBody(topic),
    );
  }

  Widget _buildBody(SymTopic topic) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: _StepDots(step: _step, count: _stepCount),
        ),
        Expanded(
          child: PageView(
            controller: _pager,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _ModelStep(topic: topic),
              _BuildStep(
                guide: _guide,
                answers: _answers,
                controllers: _controllers,
                preview: _assemble(preview: true),
                onChanged: () => setState(() {}),
              ),
              _YoursStep(draft: _assemble(preview: false)),
            ],
          ),
        ),
        _BottomBar(
          step: _step,
          canAdvance: _step != 1 || _allFilled,
          onBack: _step == 0 ? null : () => _go(_step - 1),
          onNext: _step < _stepCount - 1 ? () => _go(_step + 1) : null,
          onUseDraft: _step == _stepCount - 1 ? _useAsDraft : null,
        ),
      ],
    );
  }
}

// ── Step 0: Model (I do) ─────────────────────────────────────────────────────

class _ModelStep extends StatelessWidget {
  const _ModelStep({required this.topic});
  final SymTopic topic;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final mm = PmpColors.myanmarGloss(Theme.of(context).brightness);
    final g = topic.guide!;
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      children: [
        Row(
          children: [
            Icon(Icons.auto_stories_outlined, size: 18, color: cs.primary),
            const SizedBox(width: 8),
            Expanded(
              child: Text('Here\'s how someone wrote theirs',
                  style: PmpTextStyles.body1Semi.copyWith(color: cs.onSurface)),
            ),
            if (g.modelAudio.isNotEmpty)
              IconButton(
                visualDensity: VisualDensity.compact,
                onPressed: () => VocabTtsService.instance
                    .playUrlOrSpeak(SymAudio.resolve(g.modelAudio), g.modelEn),
                icon: Icon(Icons.volume_up_rounded, color: cs.primary),
                tooltip: 'Listen',
              ),
          ],
        ),
        const SizedBox(height: 4),
        Text('ပထမဆုံး တစ်ယောက်ယောက်ရဲ့ ဥပမာကို ကြည့်ပါ — ပြီးရင် ကိုယ်ပိုင် တစ်ခု လုပ်ပါမယ်။',
            style: PmpTextStyles.label2Regular.copyWith(color: mm, height: 1.5)),
        const SizedBox(height: 14),
        // The worked example.
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: PmpColors.brandCyan.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: PmpColors.brandCyan.withValues(alpha: 0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(g.modelEn,
                  style: PmpTextStyles.body1Semi
                      .copyWith(color: cs.onSurface, height: 1.6)),
              if (g.modelMm.trim().isNotEmpty) ...[
                const SizedBox(height: 10),
                Text(g.modelMm,
                    style: PmpTextStyles.label2Regular
                        .copyWith(color: mm, height: 1.55)),
              ],
            ],
          ),
        ),
        if (g.breakdown.isNotEmpty) ...[
          const SizedBox(height: 20),
          Text('What each sentence does',
              style: PmpTextStyles.labelSemi.copyWith(color: cs.primary)),
          const SizedBox(height: 10),
          for (final line in g.breakdown) ...[
            _BreakdownCard(line: line),
            const SizedBox(height: 8),
          ],
        ],
      ],
    );
  }
}

class _BreakdownCard extends StatelessWidget {
  const _BreakdownCard({required this.line});
  final SymGuideLine line;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final mm = PmpColors.myanmarGloss(Theme.of(context).brightness);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(line.textEn,
              style:
                  PmpTextStyles.body2Semi.copyWith(color: cs.onSurface, height: 1.45)),
          if (line.glossMm.trim().isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(line.glossMm,
                style: PmpTextStyles.label2Regular.copyWith(color: mm, height: 1.45)),
          ],
          if (line.whyMm.trim().isNotEmpty) ...[
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.lightbulb_outline, size: 15, color: cs.primary),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(line.whyMm,
                      style: PmpTextStyles.label2Regular
                          .copyWith(color: cs.onSurfaceVariant, height: 1.45)),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

// ── Step 1: Build (We do) ────────────────────────────────────────────────────

class _BuildStep extends StatefulWidget {
  const _BuildStep({
    required this.guide,
    required this.answers,
    required this.controllers,
    required this.preview,
    required this.onChanged,
  });
  final SymGuide guide;
  final Map<String, String> answers;
  final Map<String, TextEditingController> controllers;
  final String preview;
  final VoidCallback onChanged;

  @override
  State<_BuildStep> createState() => _BuildStepState();
}

class _BuildStepState extends State<_BuildStep> {
  final ScrollController _scroll = ScrollController();

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final guide = widget.guide;
    final answers = widget.answers;
    final controllers = widget.controllers;
    final onChanged = widget.onChanged;
    final cs = Theme.of(context).colorScheme;
    final mm = PmpColors.myanmarGloss(Theme.of(context).brightness);
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Pinned draft preview — stays in view while the slots scroll below, so
        // the learner watches blanks fill in real time. Caps its own height and
        // scrolls internally when the draft is long.
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: _LivePreview(
            template: guide.template,
            answers: answers,
            maxHeight: 150,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Fill in the blanks about YOUR family.',
                  style: PmpTextStyles.label2Regular
                      .copyWith(color: cs.onSurfaceVariant)),
              Text('ကိုယ့်မိသားစုနဲ့ ကိုက်တာ ရွေး/ဖြည့်ပါ။',
                  style: PmpTextStyles.label2Regular.copyWith(color: mm)),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          // Always-on scrollbar so the learner knows more slots wait below.
          child: Scrollbar(
            controller: _scroll,
            thumbVisibility: true,
            child: ListView(
              controller: _scroll,
              padding: EdgeInsets.fromLTRB(16, 0, 20, 24 + bottomInset),
              children: [
                for (final slot in guide.slots) ...[
                  _SlotCard(
                    slot: slot,
                    value: answers[slot.id] ?? '',
                    controller: controllers[slot.id],
                    onChanged: (v) {
                      answers[slot.id] = v;
                      onChanged();
                    },
                  ),
                  const SizedBox(height: 10),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _LivePreview extends StatefulWidget {
  const _LivePreview({
    required this.template,
    required this.answers,
    this.maxHeight = double.infinity,
  });
  final String template;
  final Map<String, String> answers;

  /// Cap so a long draft scrolls inside the pinned card instead of pushing the
  /// form off-screen.
  final double maxHeight;

  @override
  State<_LivePreview> createState() => _LivePreviewState();
}

class _LivePreviewState extends State<_LivePreview> {
  static final _token = RegExp(r'\{(\w+)\}');
  final ScrollController _scroll = ScrollController();

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final template = widget.template;
    final answers = widget.answers;
    final cs = Theme.of(context).colorScheme;
    final base = PmpTextStyles.body1Semi.copyWith(color: cs.onSurface, height: 1.7);
    final filled = base.copyWith(color: PmpColors.success500);
    final blank = base.copyWith(
        color: cs.onSurfaceVariant, fontWeight: FontWeight.w600, letterSpacing: 1);

    final spans = <InlineSpan>[];
    var last = 0;
    for (final m in _token.allMatches(template)) {
      if (m.start > last) spans.add(TextSpan(text: template.substring(last, m.start)));
      final a = (answers[m.group(1)] ?? '').trim();
      spans.add(a.isNotEmpty
          ? TextSpan(text: a, style: filled)
          : const TextSpan(text: '____'));
      last = m.end;
    }
    if (last < template.length) spans.add(TextSpan(text: template.substring(last)));

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: PmpColors.success500.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: PmpColors.success500.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_awesome, size: 14, color: PmpColors.success500),
              const SizedBox(width: 6),
              Text('Your draft so far',
                  style: PmpTextStyles.labelSemi.copyWith(color: PmpColors.success500)),
            ],
          ),
          const SizedBox(height: 8),
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: widget.maxHeight),
            child: Scrollbar(
              controller: _scroll,
              thumbVisibility: true,
              child: SingleChildScrollView(
                controller: _scroll,
                padding: const EdgeInsets.only(right: 10),
                child: Text.rich(TextSpan(style: blank, children: spans)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SlotCard extends StatelessWidget {
  const _SlotCard({
    required this.slot,
    required this.value,
    required this.controller,
    required this.onChanged,
  });
  final SymSlot slot;
  final String value;
  final TextEditingController? controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final mm = PmpColors.myanmarGloss(Theme.of(context).brightness);
    final filled = value.trim().isNotEmpty;
    return GlassCard(
      blur: false,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(filled ? Icons.check_circle : Icons.circle_outlined,
                  size: 16,
                  color: filled ? PmpColors.success500 : cs.onSurfaceVariant),
              const SizedBox(width: 6),
              Flexible(
                child: Text(slot.labelEn,
                    style: PmpTextStyles.body2Semi.copyWith(color: cs.onSurface)),
              ),
              if (slot.labelMm.isNotEmpty) ...[
                const SizedBox(width: 8),
                Flexible(
                  child: Text(slot.labelMm,
                      overflow: TextOverflow.ellipsis,
                      style: PmpTextStyles.label2Regular.copyWith(color: mm)),
                ),
              ],
            ],
          ),
          const SizedBox(height: 10),
          if (slot.options.isNotEmpty)
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final opt in slot.options)
                  ChoiceChip(
                    label: Text(opt),
                    selected: value == opt,
                    onSelected: (_) => onChanged(value == opt ? '' : opt),
                  ),
              ],
            )
          else
            TextField(
              controller: controller,
              textCapitalization: TextCapitalization.words,
              maxLength: 50,
              decoration: InputDecoration(
                hintText: slot.hint,
                isDense: true,
                counterText: '',
                border: const OutlineInputBorder(),
              ),
              onChanged: onChanged,
            ),
        ],
      ),
    );
  }
}

// ── Step 2: Yours (You do) ───────────────────────────────────────────────────

class _YoursStep extends StatelessWidget {
  const _YoursStep({required this.draft});
  final String draft;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final mm = PmpColors.myanmarGloss(Theme.of(context).brightness);
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
      children: [
        const Icon(Icons.check_circle_outline, size: 40, color: PmpColors.success500),
        const SizedBox(height: 14),
        Text('You wrote your first draft! 🎉',
            style: PmpTextStyles.title1SemiBold.copyWith(color: cs.onSurface)),
        const SizedBox(height: 6),
        Text('ပထမဆုံး မူကြမ်း ရပြီ! အခု ဒါကို ကိုယ်ပိုင်စကားနဲ့ ထပ်ဖြည့်ပြီး '
            'feedback ယူကြည့်ပါ။',
            style: PmpTextStyles.label2Regular.copyWith(color: mm, height: 1.5)),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: cs.surfaceContainerHighest.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: PmpColors.success500.withValues(alpha: 0.4)),
          ),
          child: Text(draft,
              style: PmpTextStyles.body1Regular
                  .copyWith(color: cs.onSurface, height: 1.7)),
        ),
        const SizedBox(height: 12),
        Text('Next: add a sentence or two of your own, then get feedback.',
            style: PmpTextStyles.label2Regular.copyWith(color: cs.onSurfaceVariant)),
      ],
    );
  }
}

// ── Chrome ───────────────────────────────────────────────────────────────────

class _StepDots extends StatelessWidget {
  const _StepDots({required this.step, required this.count});
  final int step;
  final int count;

  static const _labels = ['See an example', 'Fill the blanks', 'Your draft'];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      children: [
        Row(
          children: [
            for (var i = 0; i < count; i++) ...[
              Expanded(
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: i <= step
                        ? cs.primary
                        : cs.surfaceContainerHighest.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              if (i < count - 1) const SizedBox(width: 6),
            ],
          ],
        ),
        const SizedBox(height: 6),
        Align(
          alignment: Alignment.centerLeft,
          child: Text('Step ${step + 1} of $count · ${_labels[step]}',
              style: PmpTextStyles.label2Regular.copyWith(color: cs.onSurfaceVariant)),
        ),
      ],
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({
    required this.step,
    required this.canAdvance,
    required this.onBack,
    required this.onNext,
    required this.onUseDraft,
  });
  final int step;
  final bool canAdvance;
  final VoidCallback? onBack;
  final VoidCallback? onNext;
  final VoidCallback? onUseDraft;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (step == 1 && !canAdvance)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text('Fill in every blank to continue',
                    style: PmpTextStyles.label2Regular
                        .copyWith(color: cs.onSurfaceVariant)),
              ),
            Row(
              children: [
                if (onBack != null) ...[
                  OutlinedButton(
                    onPressed: onBack,
                    style: OutlinedButton.styleFrom(
                        minimumSize: const Size(0, 50)),
                    child: const Text('Back'),
                  ),
                  const SizedBox(width: 12),
                ],
                Expanded(
                  child: onUseDraft != null
                      ? FilledButton.icon(
                          onPressed: onUseDraft,
                          style: FilledButton.styleFrom(
                            minimumSize: const Size.fromHeight(52),
                            textStyle: PmpTextStyles.body1Semi,
                          ),
                          icon: const Icon(Icons.edit_outlined),
                          label: const Text('Use this & get feedback'),
                        )
                      : FilledButton(
                          onPressed: canAdvance ? onNext : null,
                          style: FilledButton.styleFrom(
                            minimumSize: const Size.fromHeight(52),
                            textStyle: PmpTextStyles.body1Semi,
                          ),
                          child: Text(step == 0 ? 'Start' : 'Next'),
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
