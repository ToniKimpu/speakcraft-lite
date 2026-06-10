import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:speakcraft/config/pmp_colors.dart';
import 'package:speakcraft/config/pmp_text_styles.dart';
import 'package:speakcraft/l10n/generated/l10n.dart';
import 'package:speakcraft/model/daily_speaking/daily_speaking_feedback.dart';

/// Full annotated transcript: the learner's words with inline error highlights
/// (tap a highlight for the fix + reason), plus a sentence-aligned "Compare"
/// view (your sentence vs. the native version) that only appears when a native
/// rewrite exists.
///
/// Consumes [DailySpeakingFeedback.sentences] — the single source of truth for
/// the highlights and the split. If a sentence's segments don't reconstruct its
/// original text we still render the plain original, so broken markup never
/// shows.
class ReviewHighlightsPage extends StatefulWidget {
  const ReviewHighlightsPage({super.key, required this.feedback});

  final DailySpeakingFeedback feedback;

  @override
  State<ReviewHighlightsPage> createState() => _ReviewHighlightsPageState();
}

enum _ReviewMode { highlights, compare }

class _ReviewHighlightsPageState extends State<ReviewHighlightsPage> {
  _ReviewMode _mode = _ReviewMode.highlights;

  /// Tap recognizers for the highlighted runs. Rebuilt each [build]; the
  /// previous batch is disposed first so we never leak them.
  final List<TapGestureRecognizer> _recognizers = [];

  @override
  void dispose() {
    for (final r in _recognizers) {
      r.dispose();
    }
    super.dispose();
  }

  DailySpeakingFeedback get feedback => widget.feedback;

  /// The error categories that actually appear in this transcript — only these
  /// get a filter chip.
  late final Set<SegmentType> _presentTypes = {
    for (final s in feedback.sentences)
      for (final seg in s.segments)
        if (seg.type != null) seg.type!,
  };

  /// Which categories are currently highlighted. Starts with everything on;
  /// unchecking one renders its runs as plain text.
  late final Set<SegmentType> _active = {..._presentTypes};

  bool get _hasNative =>
      feedback.sentences.any((s) => s.changed && s.native.isNotEmpty);

  static Color _typeColor(SegmentType type, ColorScheme cs) {
    switch (type) {
      case SegmentType.grammar:
        return PmpColors.warning500;
      case SegmentType.vocab:
        return PmpColors.info500;
      case SegmentType.interference:
        return PmpColors.destructive400;
      case SegmentType.filler:
        return cs.onSurfaceVariant;
    }
  }

  String _typeLabel(BuildContext context, SegmentType type) {
    final l10n = AppLocalizations.of(context);
    switch (type) {
      case SegmentType.grammar:
        return l10n.txtDsGrammar;
      case SegmentType.vocab:
        return l10n.txtDsVocabulary;
      case SegmentType.interference:
        return l10n.txtDsInterference;
      case SegmentType.filler:
        return l10n.txtDsFiller;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.txtDsReviewHighlights)),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            if (_hasNative)
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 4),
                child: SegmentedButton<_ReviewMode>(
                  segments: [
                    ButtonSegment(
                      value: _ReviewMode.highlights,
                      icon: const Icon(Icons.highlight_alt, size: 18),
                      label: Text(l10n.txtDsHighlights),
                    ),
                    ButtonSegment(
                      value: _ReviewMode.compare,
                      icon: const Icon(Icons.compare_arrows, size: 18),
                      label: Text(l10n.txtDsCompare),
                    ),
                  ],
                  selected: {_mode},
                  onSelectionChanged: (s) => setState(() => _mode = s.first),
                ),
              ),
            Expanded(
              child: _mode == _ReviewMode.highlights
                  ? _buildHighlights(context)
                  : _buildCompare(context),
            ),
          ],
        ),
      ),
    );
  }

  // --- Highlights view ------------------------------------------------------

  Widget _buildHighlights(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    for (final r in _recognizers) {
      r.dispose();
    }
    _recognizers.clear();

    final spans = <InlineSpan>[];
    for (final sentence in feedback.sentences) {
      // Guard the invariant: if the segments don't reconstruct the original,
      // fall back to the plain sentence so we never render broken markup.
      final joined = sentence.segments.map((s) => s.text).join();
      if (sentence.segments.isEmpty || joined != sentence.original) {
        spans.add(TextSpan(text: sentence.original));
        spans.add(const TextSpan(text: ' '));
        continue;
      }
      for (final seg in sentence.segments) {
        // Plain runs, and flagged runs whose category is filtered off, render
        // as ordinary text with no highlight or tap target.
        if (seg.isPlain || !_active.contains(seg.type)) {
          spans.add(TextSpan(text: seg.text));
          continue;
        }
        final color = _typeColor(seg.type!, colorScheme);
        final recognizer = TapGestureRecognizer()
          ..onTap = () => _showSegmentSheet(context, seg);
        _recognizers.add(recognizer);
        spans.add(
          TextSpan(
            text: seg.text,
            recognizer: recognizer,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
              backgroundColor: color.withValues(alpha: 0.12),
              decoration: TextDecoration.underline,
              decorationColor: color.withValues(alpha: 0.6),
            ),
          ),
        );
      }
      spans.add(const TextSpan(text: ' '));
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      children: [
        _buildFilters(context),
        const SizedBox(height: 16),
        Text.rich(
          TextSpan(
            style: PmpTextStyles.body1Regular.copyWith(
              color: colorScheme.onSurface,
              height: 1.9,
            ),
            children: spans,
          ),
        ),
      ],
    );
  }

  void _showSegmentSheet(BuildContext context, FeedbackSegment seg) {
    final colorScheme = Theme.of(context).colorScheme;
    final color = _typeColor(seg.type!, colorScheme);
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  _typeLabel(context, seg.type!),
                  style: PmpTextStyles.labelSemi.copyWith(color: color),
                ),
              ),
              const SizedBox(height: 14),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      seg.text.trim(),
                      style: PmpTextStyles.body1Regular.copyWith(
                        color: PmpColors.destructive400,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ),
                  if (seg.correction.isNotEmpty) ...[
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Icon(Icons.arrow_forward, size: 16),
                    ),
                    Flexible(
                      child: Text(
                        seg.correction,
                        style: PmpTextStyles.body1Semi
                            .copyWith(color: PmpColors.success500),
                      ),
                    ),
                  ],
                ],
              ),
              if (seg.reasonMm.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  seg.reasonMm,
                  style: PmpTextStyles.body2Regular.copyWith(
                    color: colorScheme.onSurface,
                    fontFamily: 'Noto Sans Myanmar',
                    height: 1.7,
                  ),
                ),
              ],
              if (seg.reasonEn.isNotEmpty) ...[
                const SizedBox(height: 10),
                Text(
                  seg.reasonEn,
                  style: PmpTextStyles.body2Regular.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    height: 1.6,
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  /// The category filter row — one chip per error type present in the take.
  /// Checking/unchecking a chip toggles whether that category is highlighted;
  /// the chips double as the colour legend.
  Widget _buildFilters(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final types =
        SegmentType.values.where(_presentTypes.contains).toList(growable: false);
    if (types.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.txtDsReviewTapHint,
          style: PmpTextStyles.sub.copyWith(color: colorScheme.onSurfaceVariant),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: types.map((t) {
            final color = _typeColor(t, colorScheme);
            final selected = _active.contains(t);
            return FilterChip(
              label: Text(_typeLabel(context, t)),
              selected: selected,
              showCheckmark: true,
              checkmarkColor: color,
              selectedColor: color.withValues(alpha: 0.18),
              backgroundColor: colorScheme.surface,
              side: BorderSide(
                color: selected ? color : colorScheme.outlineVariant,
              ),
              labelStyle: PmpTextStyles.sub.copyWith(
                color: selected ? color : colorScheme.onSurfaceVariant,
              ),
              onSelected: (on) => setState(() {
                if (on) {
                  _active.add(t);
                } else {
                  _active.remove(t);
                }
              }),
            );
          }).toList(growable: false),
        ),
      ],
    );
  }

  // --- Compare view ---------------------------------------------------------

  Widget _buildCompare(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      itemCount: feedback.sentences.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, i) {
        final s = feedback.sentences[i];
        if (!s.changed || s.native.isEmpty || s.native == s.original) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: colorScheme.outlineVariant),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.check_circle_outline,
                    size: 16, color: PmpColors.success500),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    s.original,
                    style: PmpTextStyles.body2Regular
                        .copyWith(color: colorScheme.onSurfaceVariant),
                  ),
                ),
              ],
            ),
          );
        }
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: colorScheme.outlineVariant),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _CompareRow(
                label: l10n.txtDsTabYours,
                text: s.original,
                color: colorScheme.onSurfaceVariant,
              ),
              const SizedBox(height: 8),
              _CompareRow(
                label: l10n.txtDsTabNative,
                text: s.native,
                color: PmpColors.success500,
                emphasise: true,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CompareRow extends StatelessWidget {
  const _CompareRow({
    required this.label,
    required this.text,
    required this.color,
    this.emphasise = false,
  });

  final String label;
  final String text;
  final Color color;
  final bool emphasise;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: PmpTextStyles.sub.copyWith(color: color),
        ),
        const SizedBox(height: 2),
        Text(
          text,
          style: (emphasise
                  ? PmpTextStyles.body1Semi
                  : PmpTextStyles.body1Regular)
              .copyWith(color: color, height: 1.5),
        ),
      ],
    );
  }
}

