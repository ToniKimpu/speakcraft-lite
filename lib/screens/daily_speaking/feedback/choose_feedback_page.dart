import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speakcraft/bloc/daily_speaking/daily_speaking_bloc.dart';
import 'package:speakcraft/bloc/daily_speaking/daily_speaking_history_bloc.dart';
import 'package:speakcraft/config/pmp_colors.dart';
import 'package:speakcraft/config/pmp_routes.dart';
import 'package:speakcraft/config/pmp_text_styles.dart';
import 'package:speakcraft/l10n/generated/l10n.dart';
import 'package:speakcraft/model/daily_speaking/daily_speaking_session.dart';
import 'package:speakcraft/model/daily_speaking/daily_speaking_topic.dart';
import 'package:speakcraft/model/daily_speaking/feedback_section.dart';

/// Sits between capture (voice/text) and the AI call. The learner picks which
/// optional feedback sections they want; the selection becomes
/// `requested_sections` so unrequested sections cost no tokens.
///
/// All four capture exits (just-talk, own-topic voice, write-path, suggested
/// record) route here. Voice-only options auto-hide on the write path.
///
/// NOTE: section/preset/group labels are kept inline (English) rather than in
/// the ARB — this module shipped UI strings inline first; localize in a later
/// pass alongside the rest of daily-speaking.
class ChooseFeedbackPage extends StatefulWidget {
  const ChooseFeedbackPage({
    super.key,
    required this.inputMode,
    required this.onRamp,
    this.audioPath,
    this.text,
    this.topic,
    this.topicAttemptId,
    this.revisionNumber = 1,
  });

  final String inputMode; // DailySpeakingInputMode.voice | .text
  final String onRamp;
  final String? audioPath;
  final String? text;
  final DailySpeakingTopic? topic;

  /// Version-loop context (suggested / own-topic only). Null + 1 on a first
  /// attempt; carried forward by "Polish & retry".
  final String? topicAttemptId;
  final int revisionNumber;

  bool get _isVoice => inputMode == DailySpeakingInputMode.voice;

  /// Suggested and own-topic support the iterate-and-improve loop, so the
  /// whole-rewrite / sentence-rewrite are deferred to the terminal reveal.
  /// Just-talk is one-shot and keeps them in the menu.
  bool get _supportsLoop => onRamp != DailySpeakingOnRamp.justTalk;

  bool get _isRevision => revisionNumber > 1;

  @override
  State<ChooseFeedbackPage> createState() => _ChooseFeedbackPageState();
}

class _ChooseFeedbackPageState extends State<ChooseFeedbackPage> {
  static const String _prefsKey = 'ds_feedback_sections';

  Set<String> _selected = {};
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _loadSelection();
  }

  Future<void> _loadSelection() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getStringList(_prefsKey);
    final available = sectionsForMode(
      isVoice: widget._isVoice,
      includeTerminalReveal: !widget._supportsLoop,
    );
    final initial = (stored == null || stored.isEmpty)
        ? defaultSelectedSections()
        : stored.toSet();
    if (!mounted) return;
    setState(() {
      // Drop anything not applicable to this input mode (e.g. a voice-only
      // option remembered from a previous voice session, now on the text path).
      _selected = initial.intersection(available);
      _loaded = true;
    });
  }

  Future<void> _persistSelection() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_prefsKey, _selected.toList());
  }

  void _toggle(String key) {
    setState(() {
      if (!_selected.add(key)) _selected.remove(key);
    });
  }

  void _applyPreset(FeedbackPreset preset) {
    final available = sectionsForMode(
      isVoice: widget._isVoice,
      includeTerminalReveal: !widget._supportsLoop,
    );
    final keys = preset == FeedbackPreset.everything
        ? available
        : kPresetSections[preset]!;
    setState(() => _selected = keys.intersection(available));
  }

  void _submit(BuildContext context) {
    _persistSelection();
    final sections = _selected.toList();
    final bloc = context.read<DailySpeakingBloc>();
    if (widget._isVoice) {
      bloc.add(
        DailySpeakingEvent.submitVoice(
          audioPath: widget.audioPath!,
          onRamp: widget.onRamp,
          requestedSections: sections,
          topic: widget.topic,
          topicAttemptId: widget.topicAttemptId,
          revisionNumber: widget.revisionNumber,
        ),
      );
    } else {
      bloc.add(
        DailySpeakingEvent.submitText(
          text: widget.text!,
          onRamp: widget.onRamp,
          requestedSections: sections,
          topic: widget.topic,
          topicAttemptId: widget.topicAttemptId,
          revisionNumber: widget.revisionNumber,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Choose your feedback')),
      body: SafeArea(
        child: BlocConsumer<DailySpeakingBloc, DailySpeakingState>(
          listener: (context, state) {
            state.maybeWhen(
              success: (session) {
                Navigator.pushReplacementNamed(
                  context,
                  PmpRoutes.dailySpeakingFeedback,
                  arguments: {
                    'session': session,
                    // Forward topic for any loop-capable on-ramp so the result
                    // page can offer "Polish & retry" + the terminal reveal.
                    if (widget._supportsLoop) 'topic': widget.topic,
                    // The just-submitted input — the terminal reveal needs it to
                    // generate the native rewrite of the learner's last version.
                    'lastAudioPath': widget.audioPath,
                    'lastText': widget.text,
                  },
                );
                context
                    .read<DailySpeakingHistoryBloc>()
                    .add(const DailySpeakingHistoryEvent.load());
              },
              socketError: () =>
                  _snack(context, l10n.txtNoInternetConnection),
              error: (msg) => _snack(context, msg),
              orElse: () {},
            );
          },
          builder: (context, state) {
            final submitting = state.maybeWhen(
              submitting: (_) => true,
              orElse: () => false,
            );
            if (submitting) return _SubmittingView(isVoice: widget._isVoice);
            if (!_loaded) {
              return const Center(child: CircularProgressIndicator());
            }
            return _buildSelector(context);
          },
        ),
      ),
    );
  }

  Widget _buildSelector(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final sections = kFeedbackSections
        .where((s) => widget._isVoice || !s.voiceOnly)
        .where((s) =>
            !widget._supportsLoop || !kTerminalRevealSections.contains(s.key))
        .toList(growable: false);
    final groups = <FeedbackSectionGroup>[
      for (final g in FeedbackSectionGroup.values)
        if (sections.any((s) => s.group == g)) g,
    ];

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (widget._isRevision) ...[
                  _RevisionBanner(revisionNumber: widget.revisionNumber),
                  const SizedBox(height: 12),
                ],
                Text(
                  'Pick what you want the AI to focus on. You can change this '
                  'anytime — only what you choose is analyzed.',
                  style: PmpTextStyles.body2Regular
                      .copyWith(color: colorScheme.onSurfaceVariant),
                ),
                if (widget._supportsLoop) ...[
                  const SizedBox(height: 6),
                  Text(
                    'You\'ll get a full native rewrite to compare against when '
                    'you finish this topic.',
                    style: PmpTextStyles.label2Regular
                        .copyWith(color: colorScheme.onSurfaceVariant),
                  ),
                ],
                const SizedBox(height: 16),
                _PresetRow(onApply: _applyPreset),
                const SizedBox(height: 8),
                for (final g in groups) ...[
                  const SizedBox(height: 12),
                  _GroupHeader(label: _groupLabel(g)),
                  const SizedBox(height: 8),
                  for (final s in sections.where((s) => s.group == g))
                    _SectionTile(
                      section: s,
                      selected: _selected.contains(s.key),
                      onTap: () => _toggle(s.key),
                    ),
                ],
              ],
            ),
          ),
        ),
        _Footer(
          count: _selected.length,
          onSubmit: _selected.isEmpty ? null : () => _submit(context),
        ),
      ],
    );
  }

  void _snack(BuildContext context, String msg) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(SnackBar(content: Text(msg)));
  }
}

// ---------------------------------------------------------------------------
// Revision banner
// ---------------------------------------------------------------------------

class _RevisionBanner extends StatelessWidget {
  const _RevisionBanner({required this.revisionNumber});
  final int revisionNumber;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: colorScheme.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.primary.withValues(alpha: 0.4)),
      ),
      child: Row(
        children: [
          Icon(Icons.history_edu, size: 18, color: colorScheme.primary),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Version $revisionNumber — polish your answer and see how much '
              'you improve.',
              style: PmpTextStyles.label2Regular
                  .copyWith(color: colorScheme.onSurface),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Presets
// ---------------------------------------------------------------------------

class _PresetRow extends StatelessWidget {
  const _PresetRow({required this.onApply});
  final void Function(FeedbackPreset) onApply;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final p in FeedbackPreset.values)
          ActionChip(
            avatar: Icon(_presetIcon(p), size: 16),
            label: Text(_presetLabel(p)),
            onPressed: () => onApply(p),
          ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Group header + section tile
// ---------------------------------------------------------------------------

class _GroupHeader extends StatelessWidget {
  const _GroupHeader({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Text(
      label.toUpperCase(),
      style: PmpTextStyles.sub.copyWith(
        color: colorScheme.onSurfaceVariant,
        letterSpacing: 0.6,
      ),
    );
  }
}

class _SectionTile extends StatelessWidget {
  const _SectionTile({
    required this.section,
    required this.selected,
    required this.onTap,
  });
  final FeedbackSection section;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: selected
                ? colorScheme.primary.withValues(alpha: 0.08)
                : colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected
                  ? colorScheme.primary.withValues(alpha: 0.5)
                  : colorScheme.outlineVariant,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                selected ? Icons.check_box : Icons.check_box_outline_blank,
                size: 22,
                color: selected
                    ? colorScheme.primary
                    : colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            _sectionLabel(section.key),
                            style: PmpTextStyles.body2Semi
                                .copyWith(color: colorScheme.onSurface),
                          ),
                        ),
                        const SizedBox(width: 8),
                        _CostBadge(cost: section.cost),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _sectionDesc(section.key),
                      style: PmpTextStyles.label2Regular
                          .copyWith(color: colorScheme.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CostBadge extends StatelessWidget {
  const _CostBadge({required this.cost});
  final FeedbackSectionCost cost;

  @override
  Widget build(BuildContext context) {
    final (label, color) = switch (cost) {
      FeedbackSectionCost.low => ('⚡', PmpColors.success500),
      FeedbackSectionCost.medium => ('⚡⚡', PmpColors.warning500),
      FeedbackSectionCost.high => ('⚡⚡⚡', PmpColors.destructive400),
    };
    return Text(label, style: TextStyle(fontSize: 11, color: color));
  }
}

// ---------------------------------------------------------------------------
// Footer
// ---------------------------------------------------------------------------

class _Footer extends StatelessWidget {
  const _Footer({required this.count, required this.onSubmit});
  final int count;
  final VoidCallback? onSubmit;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(top: BorderSide(color: colorScheme.outlineVariant)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            count == 0
                ? 'Select at least one'
                : '$count selected',
            style: PmpTextStyles.label2Regular
                .copyWith(color: colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 8),
          FilledButton.icon(
            onPressed: onSubmit,
            icon: const Icon(Icons.auto_awesome),
            label: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(l10n.txtDsGetFeedback),
            ),
          ),
        ],
      ),
    );
  }
}

class _SubmittingView extends StatelessWidget {
  const _SubmittingView({required this.isVoice});
  final bool isVoice;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 20),
          Text(
            isVoice
                ? l10n.txtDsReviewingRecording
                : l10n.txtDsReviewingWriting,
            style:
                PmpTextStyles.body1Semi.copyWith(color: colorScheme.onSurface),
          ),
          const SizedBox(height: 8),
          Text(
            AppLocalizations.of(context).txtDsReviewingTakesSeconds,
            style: PmpTextStyles.body2Regular
                .copyWith(color: colorScheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Inline display strings (localize later)
// ---------------------------------------------------------------------------

String _groupLabel(FeedbackSectionGroup g) => switch (g) {
      FeedbackSectionGroup.accuracy => 'Accuracy',
      FeedbackSectionGroup.vocabulary => 'Vocabulary',
      FeedbackSectionGroup.style => 'Style & naturalness',
      FeedbackSectionGroup.delivery => 'Delivery',
      FeedbackSectionGroup.scoring => 'Scoring',
    };

String _presetLabel(FeedbackPreset p) => switch (p) {
      FeedbackPreset.recommended => 'Recommended',
      FeedbackPreset.soundNatural => 'Sound natural',
      FeedbackPreset.grammarFocus => 'Grammar focus',
      FeedbackPreset.everything => 'Everything',
    };

IconData _presetIcon(FeedbackPreset p) => switch (p) {
      FeedbackPreset.recommended => Icons.star_outline,
      FeedbackPreset.soundNatural => Icons.record_voice_over,
      FeedbackPreset.grammarFocus => Icons.spellcheck,
      FeedbackPreset.everything => Icons.all_inclusive,
    };

String _sectionLabel(String key) => switch (key) {
      FeedbackSectionKey.sentenceFixes => 'Sentence fixes',
      FeedbackSectionKey.grammarPatterns => 'Grammar patterns',
      FeedbackSectionKey.burmeseInterference => 'Burmese-English errors',
      FeedbackSectionKey.betterVocab => 'Better word choices',
      FeedbackSectionKey.collocations => 'Collocations',
      FeedbackSectionKey.idioms => 'Idioms & phrasal verbs',
      FeedbackSectionKey.wholeRewrite => 'Native rewrite',
      FeedbackSectionKey.sentenceRewrite => 'Sentence-by-sentence rewrite',
      FeedbackSectionKey.pronunciation => 'Pronunciation notes',
      FeedbackSectionKey.fillerWords => 'Filler words',
      FeedbackSectionKey.subScores => 'Skill sub-scores',
      _ => key,
    };

String _sectionDesc(String key) => switch (key) {
      FeedbackSectionKey.sentenceFixes =>
        'Corrects your mistakes with a Burmese reason.',
      FeedbackSectionKey.grammarPatterns =>
        'Groups recurring grammar issues so you see the pattern.',
      FeedbackSectionKey.burmeseInterference =>
        'Flags direct Burmese→English translations.',
      FeedbackSectionKey.betterVocab =>
        'Upgrades basic words to more precise ones.',
      FeedbackSectionKey.collocations =>
        'Natural word pairings ("make a decision").',
      FeedbackSectionKey.idioms =>
        'Idioms and phrasal verbs you could have used.',
      FeedbackSectionKey.wholeRewrite =>
        'One polished version of your whole talk.',
      FeedbackSectionKey.sentenceRewrite =>
        'Each sentence rewritten to sound native.',
      FeedbackSectionKey.pronunciation => 'Sounds to work on.',
      FeedbackSectionKey.fillerWords => 'Counts "um", "uh", "like", etc.',
      FeedbackSectionKey.subScores =>
        'Breaks your score into grammar / vocab / fluency / pronunciation.',
      _ => '',
    };
