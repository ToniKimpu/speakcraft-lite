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

  /// All three on-ramps now iterate, so the whole-rewrite / sentence-rewrite are
  /// always deferred to the terminal reveal (just-talk seeds its loop from the
  /// AI's inferred topic — see `DailySpeakingBloc._inferredTopic`).
  bool get _supportsLoop => true;

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

  /// The preset whose resolved set exactly matches the current selection, so the
  /// matching quick-pick chip can show as active. Null when the selection is a
  /// custom mix. Pure UI — derived from [_selected], no extra state.
  FeedbackPreset? _activePreset(Set<String> available) {
    for (final p in FeedbackPreset.values) {
      final keys = p == FeedbackPreset.everything
          ? available
          : kPresetSections[p]!.intersection(available);
      if (_selected.length == keys.length && _selected.containsAll(keys)) {
        return p;
      }
    }
    return null;
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
      appBar: AppBar(title: Text(l10n.txtDsChooseFeedbackTitle)),
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
                    // page can offer "Polish & retry".
                    if (widget._supportsLoop) 'topic': widget.topic,
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
    final l10n = AppLocalizations.of(context);
    final sections = kFeedbackSections
        .where((s) => widget._isVoice || !s.voiceOnly)
        .where((s) =>
            !widget._supportsLoop || !kTerminalRevealSections.contains(s.key))
        .toList(growable: false);
    final groups = <FeedbackSectionGroup>[
      for (final g in FeedbackSectionGroup.values)
        if (sections.any((s) => s.group == g)) g,
    ];
    final available = sections.map((s) => s.key).toSet();
    final activePreset = _activePreset(available);

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
                  l10n.txtDsChooseFeedbackIntro,
                  style: PmpTextStyles.body2Regular
                      .copyWith(color: colorScheme.onSurfaceVariant),
                ),
                if (widget._supportsLoop) ...[
                  const SizedBox(height: 6),
                  Text(
                    l10n.txtDsChooseRewriteNote,
                    style: PmpTextStyles.label2Regular
                        .copyWith(color: colorScheme.onSurfaceVariant),
                  ),
                ],
                const SizedBox(height: 18),
                _GroupHeader(label: l10n.txtDsQuickPicks),
                const SizedBox(height: 10),
                _PresetRow(onApply: _applyPreset, active: activePreset),
                const SizedBox(height: 4),
                for (final g in groups) ...[
                  const SizedBox(height: 12),
                  _GroupHeader(label: _groupLabel(context, g)),
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
              AppLocalizations.of(context).txtDsVersionBanner(revisionNumber),
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
  const _PresetRow({required this.onApply, this.active});
  final void Function(FeedbackPreset) onApply;
  final FeedbackPreset? active;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final p in FeedbackPreset.values)
          _PresetChip(
            label: _presetLabel(context, p),
            icon: _presetIcon(p),
            active: p == active,
            onTap: () => onApply(p),
            colorScheme: colorScheme,
          ),
      ],
    );
  }
}

class _PresetChip extends StatelessWidget {
  const _PresetChip({
    required this.label,
    required this.icon,
    required this.active,
    required this.onTap,
    required this.colorScheme,
  });
  final String label;
  final IconData icon;
  final bool active;
  final VoidCallback onTap;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    final fg = active ? colorScheme.onPrimary : colorScheme.onSurface;
    return Material(
      color: active ? colorScheme.primary : colorScheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: active
                  ? colorScheme.primary
                  : colorScheme.outlineVariant,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 16, color: active ? fg : colorScheme.primary),
              const SizedBox(width: 6),
              Text(
                label,
                style: PmpTextStyles.label2Regular.copyWith(
                  color: fg,
                  fontWeight: active ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
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
    final (icon, accent) = _sectionVisual(context, section.key);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: selected
            ? accent.withValues(alpha: 0.10)
            : colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: selected
                    ? accent.withValues(alpha: 0.55)
                    : colorScheme.outlineVariant,
                width: selected ? 1.5 : 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: selected ? 0.18 : 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, size: 19, color: accent),
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
                              _sectionLabel(context, section.key),
                              style: PmpTextStyles.body2Semi
                                  .copyWith(color: colorScheme.onSurface),
                            ),
                          ),
                          const SizedBox(width: 8),
                          _CostBadge(cost: section.cost),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Text(
                        _sectionDesc(context, section.key),
                        style: PmpTextStyles.label2Regular.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                _CheckCircle(selected: selected, color: accent),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Trailing selection indicator — a filled check when selected, a hollow ring
/// when not. Clearer and more "tappable" than a leading checkbox.
class _CheckCircle extends StatelessWidget {
  const _CheckCircle({required this.selected, required this.color});
  final bool selected;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: selected ? color : Colors.transparent,
        border: Border.all(
          color: selected ? color : colorScheme.outline,
          width: 2,
        ),
      ),
      child: selected
          ? const Icon(Icons.check, size: 15, color: Colors.white)
          : null,
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
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 12),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: PmpColors.black.withValues(alpha: 0.18),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              count == 0
                  ? l10n.txtDsSelectAtLeastOne
                  : l10n.txtDsNSelected(count),
              style: PmpTextStyles.label2Regular
                  .copyWith(color: colorScheme.onSurfaceVariant),
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            height: 48,
            child: FilledButton.icon(
              onPressed: onSubmit,
              icon: const Icon(Icons.auto_awesome, size: 18),
              label: Text(l10n.txtDsGetFeedback),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 22),
              ),
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

/// Per-section identity: a leading icon + accent colour, mirroring the result
/// page's section colours so the two screens speak the same visual language.
(IconData, Color) _sectionVisual(BuildContext context, String key) {
  final colorScheme = Theme.of(context).colorScheme;
  return switch (key) {
    FeedbackSectionKey.sentenceFixes => (Icons.tune, PmpColors.warning500),
    FeedbackSectionKey.grammarPatterns => (Icons.rule, PmpColors.warning500),
    FeedbackSectionKey.burmeseInterference => (
        Icons.translate,
        PmpColors.destructive400
      ),
    FeedbackSectionKey.betterVocab => (Icons.upgrade, PmpColors.info500),
    FeedbackSectionKey.collocations => (Icons.link, PmpColors.info500),
    FeedbackSectionKey.idioms => (Icons.auto_awesome, PmpColors.accentOrange),
    FeedbackSectionKey.wholeRewrite => (
        Icons.article_outlined,
        colorScheme.primary
      ),
    FeedbackSectionKey.sentenceRewrite => (
        Icons.format_quote,
        colorScheme.primary
      ),
    FeedbackSectionKey.pronunciation => (Icons.graphic_eq, colorScheme.tertiary),
    FeedbackSectionKey.fillerWords => (
        Icons.bubble_chart_outlined,
        colorScheme.tertiary
      ),
    FeedbackSectionKey.subScores => (Icons.bar_chart, colorScheme.primary),
    _ => (Icons.check_circle_outline, colorScheme.primary),
  };
}

String _groupLabel(BuildContext context, FeedbackSectionGroup g) {
  final l10n = AppLocalizations.of(context);
  return switch (g) {
    FeedbackSectionGroup.accuracy => l10n.txtDsGroupAccuracy,
    FeedbackSectionGroup.vocabulary => l10n.txtDsVocabulary,
    FeedbackSectionGroup.style => l10n.txtDsGroupStyle,
    FeedbackSectionGroup.delivery => l10n.txtDsGroupDelivery,
    FeedbackSectionGroup.scoring => l10n.txtDsGroupScoring,
  };
}

String _presetLabel(BuildContext context, FeedbackPreset p) {
  final l10n = AppLocalizations.of(context);
  return switch (p) {
    FeedbackPreset.recommended => l10n.txtDsPresetRecommended,
    FeedbackPreset.soundNatural => l10n.txtDsPresetSoundNatural,
    FeedbackPreset.grammarFocus => l10n.txtDsPresetGrammarFocus,
    FeedbackPreset.everything => l10n.txtDsPresetEverything,
  };
}

IconData _presetIcon(FeedbackPreset p) => switch (p) {
      FeedbackPreset.recommended => Icons.star_outline,
      FeedbackPreset.soundNatural => Icons.record_voice_over,
      FeedbackPreset.grammarFocus => Icons.spellcheck,
      FeedbackPreset.everything => Icons.all_inclusive,
    };

String _sectionLabel(BuildContext context, String key) {
  final l10n = AppLocalizations.of(context);
  return switch (key) {
    FeedbackSectionKey.sentenceFixes => l10n.txtDsSecSentenceFixes,
    FeedbackSectionKey.grammarPatterns => l10n.txtDsGrammarPatterns,
    FeedbackSectionKey.burmeseInterference => l10n.txtDsBurmeseErrors,
    FeedbackSectionKey.betterVocab => l10n.txtDsBetterWordChoices,
    FeedbackSectionKey.collocations => l10n.txtDsCollocations,
    FeedbackSectionKey.idioms => l10n.txtDsIdioms,
    FeedbackSectionKey.wholeRewrite => l10n.txtDsWholeRewriteLabel,
    FeedbackSectionKey.sentenceRewrite => l10n.txtDsSentenceRewriteLabel,
    FeedbackSectionKey.pronunciation => l10n.txtDsPronunciationNotes,
    FeedbackSectionKey.fillerWords => l10n.txtDsFillerWords,
    FeedbackSectionKey.subScores => l10n.txtDsSkillSubScores,
    _ => key,
  };
}

String _sectionDesc(BuildContext context, String key) {
  final l10n = AppLocalizations.of(context);
  return switch (key) {
    FeedbackSectionKey.sentenceFixes => l10n.txtDsDescSentenceFixes,
    FeedbackSectionKey.grammarPatterns => l10n.txtDsDescGrammarPatterns,
    FeedbackSectionKey.burmeseInterference => l10n.txtDsDescBurmeseErrors,
    FeedbackSectionKey.betterVocab => l10n.txtDsDescBetterVocab,
    FeedbackSectionKey.collocations => l10n.txtDsDescCollocations,
    FeedbackSectionKey.idioms => l10n.txtDsDescIdioms,
    FeedbackSectionKey.wholeRewrite => l10n.txtDsDescWholeRewrite,
    FeedbackSectionKey.sentenceRewrite => l10n.txtDsDescSentenceRewrite,
    FeedbackSectionKey.pronunciation => l10n.txtDsDescPronunciation,
    FeedbackSectionKey.fillerWords => l10n.txtDsDescFillerWords,
    FeedbackSectionKey.subScores => l10n.txtDsDescSubScores,
    _ => '',
  };
}
