import 'package:flutter/material.dart';
import 'package:speakcraft/config/pmp_colors.dart';
import 'package:speakcraft/config/pmp_routes.dart';
import 'package:speakcraft/config/pmp_text_styles.dart';
import 'package:speakcraft/l10n/generated/l10n.dart';
import 'package:speakcraft/model/daily_speaking/daily_speaking_topic.dart';
import 'package:speakcraft/model/daily_speaking/guided_lesson.dart';

import 'guided_paragraph_actions.dart';

/// The guided wizard — gradual release in four steps:
///   0. Objective  — the payoff up front ("by the end you'll be able to…")
///   1. Model      — the worked example + line-by-line breakdown (I do)
///   2. Build      — fill the slots with your own life; **record is gated** here
///                   (Next stays disabled until every blank is filled) (We do)
///   3. Yours      — your assembled paragraph; the model is now hidden →
///                   hand off to the recorder (You do)
///
/// Slot answers live in local state (no bloc — they only matter inside this
/// screen, like the own-topic scaffold). The assembled paragraph + the lesson's
/// level travel to `guided_record_page.dart`.
class GuidedLessonPage extends StatefulWidget {
  const GuidedLessonPage({super.key, required this.lesson});

  final GuidedLesson lesson;

  @override
  State<GuidedLessonPage> createState() => _GuidedLessonPageState();
}

class _GuidedLessonPageState extends State<GuidedLessonPage> {
  static const int _stepCount = 4;

  final PageController _pageController = PageController();
  int _step = 0;

  /// slotId → the learner's answer.
  final Map<String, String> _answers = {};

  /// Controllers for free-text slots (those without preset options).
  final Map<String, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    for (final slot in widget.lesson.slots) {
      if (slot.options.isEmpty) {
        _controllers[slot.id] = TextEditingController();
      }
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  bool get _allSlotsFilled => widget.lesson.slots
      .every((s) => (_answers[s.id] ?? '').trim().isNotEmpty);

  /// The learner's paragraph: the template with each `{slotId}` replaced by
  /// their answer. Unfilled tokens fall back to the slot hint so the live
  /// preview stays readable (the record gate still requires every slot filled).
  String get _userParagraph {
    final lesson = widget.lesson;
    if (lesson.template.isEmpty) return lesson.modelParagraphEn;
    var out = lesson.template;
    for (final slot in lesson.slots) {
      final answer = (_answers[slot.id] ?? '').trim();
      final value = answer.isNotEmpty
          ? answer
          : (slot.hint.isNotEmpty ? slot.hint : slot.labelEn);
      out = out.replaceAll('{${slot.id}}', value);
    }
    return out;
  }

  /// A manual edit made on the "This is yours" step, or null to use the derived
  /// paragraph. Cleared whenever an answer changes, so going back to tweak a
  /// slot regenerates the paragraph instead of keeping a stale edit.
  String? _paragraphOverride;

  String get _effectiveParagraph => _paragraphOverride ?? _userParagraph;

  void _copyParagraph() =>
      copyParagraphToClipboard(context, _effectiveParagraph);

  Future<void> _editParagraph() async {
    final edited = await showEditParagraphSheet(context, _effectiveParagraph);
    if (edited != null && edited.isNotEmpty && edited != _effectiveParagraph) {
      setState(() => _paragraphOverride = edited);
    }
  }

  void _goTo(int step) {
    setState(() => _step = step);
    _pageController.animateToPage(
      step,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
  }

  void _next() {
    if (_step < _stepCount - 1) _goTo(_step + 1);
  }

  void _back() {
    if (_step > 0) _goTo(_step - 1);
  }

  void _startRecording() {
    final lesson = widget.lesson;
    final topic = DailySpeakingTopic(
      id: 'guided',
      title: lesson.title,
      promptEn: lesson.objectiveEn,
      promptMm: lesson.objectiveMm,
      difficulty: _difficultyForLevel(lesson.level),
      durationTargetSeconds: lesson.durationTargetSeconds,
      vocabulary: lesson.vocabulary,
      targetPhrases: lesson.targetPhrases,
      warmupQuestions: lesson.warmupQuestions,
      tags: const ['guided'],
    );
    Navigator.pushNamed(
      context,
      PmpRoutes.dailySpeakingGuidedRecord,
      arguments: {
        'topic': topic,
        'userParagraph': _effectiveParagraph,
        'level': lesson.level,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      // Keep the Back/Next bar pinned at the bottom (under the keyboard) instead
      // of floating it up and squeezing the form. The form pads itself by the
      // keyboard height so focused fields still scroll above the keyboard.
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.lesson.title),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: LinearProgressIndicator(
            value: (_step + 1) / _stepCount,
            minHeight: 4,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _ObjectiveStep(lesson: widget.lesson),
                  _ModelStep(lesson: widget.lesson),
                  _BuildStep(
                    lesson: widget.lesson,
                    answers: _answers,
                    controllers: _controllers,
                    // Clear any manual edit when an answer changes so the
                    // paragraph regenerates from the new slots.
                    onChanged: () => setState(() => _paragraphOverride = null),
                  ),
                  _YoursStep(
                    userParagraph: _effectiveParagraph,
                    onEdit: _editParagraph,
                    onCopy: _copyParagraph,
                  ),
                ],
              ),
            ),
            _BottomBar(
              step: _step,
              l10n: l10n,
              canAdvanceFromBuild: _allSlotsFilled,
              onBack: _back,
              onNext: _next,
              onRecord: _startRecording,
            ),
          ],
        ),
      ),
    );
  }
}

TopicDifficulty _difficultyForLevel(int level) {
  switch (level) {
    case 1:
      return TopicDifficulty.beginner;
    case 2:
      return TopicDifficulty.intermediate;
    default:
      return TopicDifficulty.advanced;
  }
}

// ─────────────────────────────────────── Step 0: Objective ──────────────────

class _ObjectiveStep extends StatelessWidget {
  const _ObjectiveStep({required this.lesson});
  final GuidedLesson lesson;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.flag_rounded, size: 40, color: colorScheme.primary),
          const SizedBox(height: 16),
          Text(
            l10n.txtDsGuidedObjectiveHeading,
            style: PmpTextStyles.labelSemi.copyWith(color: colorScheme.primary),
          ),
          const SizedBox(height: 8),
          Text(
            lesson.objectiveEn,
            style: PmpTextStyles.h2.copyWith(
              color: colorScheme.onSurface,
              height: 1.4,
            ),
          ),
          if (lesson.objectiveMm.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              lesson.objectiveMm,
              style: PmpTextStyles.body2Regular.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontFamily: 'Noto Sans Myanmar',
                height: 1.7,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ─────────────────────────────────────── Step 1: Model (I do) ───────────────

class _ModelStep extends StatelessWidget {
  const _ModelStep({required this.lesson});
  final GuidedLesson lesson;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _GuidedSectionHeader(
            icon: Icons.menu_book_outlined,
            iconColor: colorScheme.primary,
            title: l10n.txtDsGuidedModelHeading,
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colorScheme.primary.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(14),
              border:
                  Border.all(color: colorScheme.primary.withValues(alpha: 0.3)),
            ),
            child: Text(
              lesson.modelParagraphEn,
              style: PmpTextStyles.body1Regular.copyWith(
                color: colorScheme.onSurface,
                height: 1.6,
              ),
            ),
          ),
          if (lesson.sentences.isNotEmpty) ...[
            const SizedBox(height: 20),
            _GuidedSectionHeader(
              icon: Icons.segment,
              iconColor: PmpColors.info500,
              title: l10n.txtDsGuidedBreakdownHeading,
            ),
            const SizedBox(height: 10),
            ...lesson.sentences.map(
              (s) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _SentenceCard(sentence: s),
              ),
            ),
          ],
          if (lesson.vocabulary.isNotEmpty) ...[
            const SizedBox(height: 10),
            _GuidedSectionHeader(
              icon: Icons.translate,
              iconColor: colorScheme.primary,
              title: l10n.txtDsWordsYouMightUse,
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: lesson.vocabulary
                  .map((v) => _VocabChip(item: v))
                  .toList(growable: false),
            ),
          ],
          if (lesson.targetPhrases.isNotEmpty) ...[
            const SizedBox(height: 20),
            _GuidedSectionHeader(
              icon: Icons.flag_outlined,
              iconColor: PmpColors.warning500,
              title: l10n.txtDsTryUseThesePhrases,
            ),
            const SizedBox(height: 10),
            ...lesson.targetPhrases.map(
              (p) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _TargetPhraseCard(phrase: p),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _SentenceCard extends StatelessWidget {
  const _SentenceCard({required this.sentence});
  final GuidedSentence sentence;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            sentence.textEn,
            style: PmpTextStyles.body2Semi.copyWith(
              color: colorScheme.onSurface,
            ),
          ),
          if (sentence.explanationMm.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(
              sentence.explanationMm,
              style: PmpTextStyles.label2Regular.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontFamily: 'Noto Sans Myanmar',
                height: 1.6,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ─────────────────────────────────────── Step 2: Build (We do) ──────────────

class _BuildStep extends StatelessWidget {
  const _BuildStep({
    required this.lesson,
    required this.answers,
    required this.controllers,
    required this.onChanged,
  });

  final GuidedLesson lesson;
  final Map<String, String> answers;
  final Map<String, TextEditingController> controllers;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        // Preview is capped to a slice of the page so it can't swallow the
        // form. The Scaffold doesn't resize for the keyboard (see
        // resizeToAvoidBottomInset above), so the form pads itself by the
        // keyboard height instead, letting focused fields scroll above it.
        final previewMax =
            (constraints.maxHeight * 0.26).clamp(72.0, 220.0);
        final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
        return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Pinned live preview: the learner watches each blank become their own
        // word inside the real sentence as they fill the slots below.
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
          child: _LivePreviewCard(
            lesson: lesson,
            answers: answers,
            maxPreviewHeight: previewMax,
          ),
        ),
        Expanded(
          child: _ScrollbarBox(
            builder: (controller) => ListView(
            controller: controller,
            padding: EdgeInsets.fromLTRB(20, 8, 20, 16 + bottomInset),
            children: [
              Text(
                l10n.txtDsGuidedBuildSubhead,
                style: PmpTextStyles.label2Regular.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 12),
              ...lesson.slots.map(
                (slot) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _SlotCard(
                    slot: slot,
                    value: answers[slot.id] ?? '',
                    controller: controllers[slot.id],
                    filled: (answers[slot.id] ?? '').trim().isNotEmpty,
                    onChanged: (v) {
                      answers[slot.id] = v;
                      onChanged();
                    },
                  ),
                ),
              ),
            ],
          ),
          ),
        ),
      ],
        );
      },
    );
  }
}

/// The pinned "Your paragraph so far" header. Filled slots show as bold accent
/// words; unfilled slots show as blanks (____) — so the learner sees their
/// answers land inside a real, grammatical sentence in real time.
class _LivePreviewCard extends StatelessWidget {
  const _LivePreviewCard({
    required this.lesson,
    required this.answers,
    required this.maxPreviewHeight,
  });
  final GuidedLesson lesson;
  final Map<String, String> answers;
  final double maxPreviewHeight;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
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
              const Icon(Icons.auto_awesome,
                  size: 14, color: PmpColors.success500),
              const SizedBox(width: 6),
              Text(
                l10n.txtDsGuidedPreviewHeading,
                style: PmpTextStyles.labelSemi
                    .copyWith(color: PmpColors.success500),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Cap the paragraph height so a long lesson can't swallow the form
          // below; it scrolls inside while the header stays pinned. The cap is
          // computed against the space available right now (shrinks with the
          // keyboard) — see _BuildStep's LayoutBuilder.
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: maxPreviewHeight),
            child: _ScrollbarBox(
              builder: (controller) => SingleChildScrollView(
                controller: controller,
                child: _ParagraphPreview(lesson: lesson, answers: answers),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ParagraphPreview extends StatelessWidget {
  const _ParagraphPreview({required this.lesson, required this.answers});
  final GuidedLesson lesson;
  final Map<String, String> answers;

  static final _tokenRegex = RegExp(r'\{(\w+)\}');

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final base = PmpTextStyles.body1Regular.copyWith(
      color: colorScheme.onSurface,
      height: 1.7,
    );
    final filledStyle = base.copyWith(
      fontWeight: FontWeight.w700,
      color: PmpColors.success500,
    );
    final blankStyle = base.copyWith(
      color: colorScheme.onSurfaceVariant,
      fontWeight: FontWeight.w600,
      letterSpacing: 1,
    );

    final template = lesson.template;
    if (template.isEmpty) {
      return Text(lesson.modelParagraphEn, style: base);
    }

    final spans = <InlineSpan>[];
    var last = 0;
    for (final m in _tokenRegex.allMatches(template)) {
      if (m.start > last) {
        spans.add(TextSpan(text: template.substring(last, m.start)));
      }
      final answer = (answers[m.group(1)] ?? '').trim();
      spans.add(answer.isNotEmpty
          ? TextSpan(text: answer, style: filledStyle)
          : TextSpan(text: '____', style: blankStyle));
      last = m.end;
    }
    if (last < template.length) {
      spans.add(TextSpan(text: template.substring(last)));
    }
    return Text.rich(TextSpan(style: base, children: spans));
  }
}

/// One slot as a card. Turns green with a check once filled — reinforcing
/// progress toward the record gate.
class _SlotCard extends StatelessWidget {
  const _SlotCard({
    required this.slot,
    required this.value,
    required this.controller,
    required this.filled,
    required this.onChanged,
  });

  final GuidedSlot slot;
  final String value;
  final TextEditingController? controller;
  final bool filled;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: filled
              ? PmpColors.success500.withValues(alpha: 0.4)
              : colorScheme.outlineVariant,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (filled) ...[
                const Icon(Icons.check_circle,
                    size: 16, color: PmpColors.success500),
                const SizedBox(width: 6),
              ],
              Flexible(
                child: Text(
                  slot.labelEn,
                  style: PmpTextStyles.body2Semi
                      .copyWith(color: colorScheme.onSurface),
                ),
              ),
              if (slot.labelMm.isNotEmpty) ...[
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    slot.labelMm,
                    style: PmpTextStyles.sub.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      fontFamily: 'Noto Sans Myanmar',
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 10),
          if (slot.options.isNotEmpty)
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: slot.options
                  .map(
                    (opt) => ChoiceChip(
                      label: Text(opt),
                      selected: value == opt,
                      onSelected: (_) => onChanged(opt),
                    ),
                  )
                  .toList(growable: false),
            )
          else
            TextField(
              controller: controller,
              textCapitalization: TextCapitalization.sentences,
              // A slot is a word or short phrase — cap it so it can't be
              // spammed with a wall of text. Counter hidden (keeps it clean).
              maxLength: 40,
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

// ─────────────────────────────────────── Step 3: Yours ──────────────────────

class _YoursStep extends StatelessWidget {
  const _YoursStep({
    required this.userParagraph,
    this.onEdit,
    this.onCopy,
  });
  final String userParagraph;
  final VoidCallback? onEdit;
  final VoidCallback? onCopy;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_outline,
              size: 40, color: PmpColors.success500),
          const SizedBox(height: 16),
          Text(
            l10n.txtDsGuidedYoursHeading,
            style: PmpTextStyles.h2.copyWith(color: colorScheme.onSurface),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.txtDsGuidedYoursSubhead,
            style: PmpTextStyles.body2Regular.copyWith(
              color: colorScheme.onSurfaceVariant,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(
                l10n.txtDsGuidedYourParagraph,
                style: PmpTextStyles.labelSemi
                    .copyWith(color: colorScheme.onSurfaceVariant),
              ),
              const Spacer(),
              if (onCopy != null)
                IconButton(
                  onPressed: onCopy,
                  icon: const Icon(Icons.copy_rounded, size: 18),
                  visualDensity: VisualDensity.compact,
                  tooltip: l10n.txtDsGuidedCopy,
                  color: colorScheme.onSurfaceVariant,
                ),
              if (onEdit != null)
                IconButton(
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit_outlined, size: 18),
                  visualDensity: VisualDensity.compact,
                  tooltip: l10n.txtDsGuidedEdit,
                  color: colorScheme.onSurfaceVariant,
                ),
            ],
          ),
          const SizedBox(height: 4),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                  color: PmpColors.success500.withValues(alpha: 0.4)),
            ),
            child: Text(
              userParagraph,
              style: PmpTextStyles.body1Regular.copyWith(
                color: colorScheme.onSurface,
                height: 1.7,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────── Bottom bar ─────────────────────────

class _BottomBar extends StatelessWidget {
  const _BottomBar({
    required this.step,
    required this.l10n,
    required this.canAdvanceFromBuild,
    required this.onBack,
    required this.onNext,
    required this.onRecord,
  });

  final int step;
  final AppLocalizations l10n;
  final bool canAdvanceFromBuild;
  final VoidCallback onBack;
  final VoidCallback onNext;
  final VoidCallback onRecord;

  @override
  Widget build(BuildContext context) {
    final isBuildStep = step == 2;
    final isLastStep = step == 3;
    final nextEnabled = !isBuildStep || canAdvanceFromBuild;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // The record gate: tell the learner what's missing before they can move on.
          if (isBuildStep && !canAdvanceFromBuild)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                l10n.txtDsGuidedFillToContinue,
                style: PmpTextStyles.sub.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          Row(
            children: [
              if (step > 0)
                OutlinedButton(
                  onPressed: onBack,
                  child: Text(l10n.txtDsGuidedBack),
                ),
              if (step > 0) const SizedBox(width: 12),
              Expanded(
                child: isLastStep
                    ? FilledButton.icon(
                        onPressed: onRecord,
                        icon: const Icon(Icons.mic),
                        label: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Text(l10n.txtDsGuidedReadyRecord),
                        ),
                      )
                    : FilledButton(
                        onPressed: nextEnabled ? onNext : null,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Text(
                            step == 0
                                ? l10n.txtDsGuidedStart
                                : l10n.txtDsGuidedNext,
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────── Shared small widgets ───────────────

/// Wraps a scrollable with an always-visible scrollbar so learners notice the
/// content scrolls (the capped preview and the form can both overflow). Owns
/// the [ScrollController] the always-on thumb requires.
class _ScrollbarBox extends StatefulWidget {
  const _ScrollbarBox({required this.builder});
  final Widget Function(ScrollController controller) builder;

  @override
  State<_ScrollbarBox> createState() => _ScrollbarBoxState();
}

class _ScrollbarBoxState extends State<_ScrollbarBox> {
  final ScrollController _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: _controller,
      thumbVisibility: true,
      child: widget.builder(_controller),
    );
  }
}

class _GuidedSectionHeader extends StatelessWidget {
  const _GuidedSectionHeader({
    required this.icon,
    required this.iconColor,
    required this.title,
  });
  final IconData icon;
  final Color iconColor;
  final String title;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Icon(icon, size: 18, color: iconColor),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style:
                PmpTextStyles.body2Semi.copyWith(color: colorScheme.onSurface),
          ),
        ),
      ],
    );
  }
}

class _VocabChip extends StatelessWidget {
  const _VocabChip({required this.item});
  final TopicVocabItem item;

  void _showDetail(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (_) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.term,
              style: PmpTextStyles.h2.copyWith(color: colorScheme.onSurface),
            ),
            const SizedBox(height: 8),
            Text(
              item.definitionMm,
              style: PmpTextStyles.body1Regular.copyWith(
                color: colorScheme.onSurface,
                fontFamily: 'Noto Sans Myanmar',
                height: 1.6,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context).txtDsExample,
              style: PmpTextStyles.labelSemi
                  .copyWith(color: colorScheme.onSurfaceVariant),
            ),
            const SizedBox(height: 6),
            Text(
              item.exampleEn,
              style: PmpTextStyles.body2Regular.copyWith(
                color: colorScheme.onSurface,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      avatar: const Icon(Icons.book_outlined, size: 16),
      label: Text(item.term),
      onPressed: () => _showDetail(context),
    );
  }
}

class _TargetPhraseCard extends StatelessWidget {
  const _TargetPhraseCard({required this.phrase});
  final TopicTargetPhrase phrase;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            phrase.phraseEn,
            style:
                PmpTextStyles.body2Semi.copyWith(color: colorScheme.onSurface),
          ),
          const SizedBox(height: 4),
          Text(
            phrase.translationMm,
            style: PmpTextStyles.body2Regular.copyWith(
              color: colorScheme.onSurfaceVariant,
              fontFamily: 'Noto Sans Myanmar',
            ),
          ),
        ],
      ),
    );
  }
}
