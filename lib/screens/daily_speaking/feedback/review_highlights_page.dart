import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:speakcraft/config/pmp_colors.dart';
import 'package:speakcraft/config/pmp_text_styles.dart';
import 'package:speakcraft/l10n/generated/l10n.dart';
import 'package:speakcraft/model/daily_speaking/daily_speaking_feedback.dart';
import 'package:speakcraft/shared_widgets/pronounce_button.dart';

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

class _ReviewHighlightsPageState extends State<ReviewHighlightsPage> {
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

  /// Corrections to locate in the transcript. Prefers the flat, model-filled
  /// `fixes` list (the reliable source); for legacy annotated-segment payloads
  /// it synthesizes equivalents from the actionable segments.
  late final List<FeedbackFix> _fixes = _collectFixes();

  List<FeedbackFix> _collectFixes() {
    if (feedback.fixes.isNotEmpty) return feedback.fixes;
    return [
      for (final s in feedback.sentences)
        for (final seg in s.segments)
          if (seg.isActionable)
            FeedbackFix(
              original: seg.text.trim(),
              corrected: seg.correction,
              type: seg.type,
              reasonMm: seg.reasonMm,
              reasonEn: seg.reasonEn,
            ),
    ];
  }

  /// The error categories that actually appear — only these get a filter chip.
  late final Set<SegmentType> _presentTypes = {
    for (final f in _fixes)
      if (f.type != null) f.type!,
  };

  /// Which categories are currently highlighted. Starts with everything on;
  /// unchecking one renders its runs as plain text.
  late final Set<SegmentType> _active = {..._presentTypes};

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
      body: SafeArea(top: false, child: _buildHighlights(context)),
    );
  }

  // --- Highlights view ------------------------------------------------------

  Widget _buildHighlights(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    for (final r in _recognizers) {
      r.dispose();
    }
    _recognizers.clear();

    // Active corrections, longest first so a longer span wins over a shorter one
    // it contains when we locate them in the text.
    final active = _fixes
        .where((f) => f.type != null && _active.contains(f.type))
        .where((f) => f.original.trim().isNotEmpty)
        .toList()
      ..sort((a, b) =>
          b.original.trim().length.compareTo(a.original.trim().length));

    final spans = <InlineSpan>[];
    for (final sentence in feedback.sentences) {
      for (final run in _annotate(sentence.original, active)) {
        if (run.fix == null) {
          spans.add(TextSpan(text: run.text));
          continue;
        }
        final color = _typeColor(run.fix!.type!, colorScheme);
        final recognizer = TapGestureRecognizer()
          ..onTap = () => _showFixSheet(context, run.fix!);
        _recognizers.add(recognizer);
        spans.add(
          TextSpan(
            text: run.text,
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

  /// Split [sentence] into runs, marking the first non-overlapping occurrence of
  /// each fix's `original` (case-insensitive). A fix whose text isn't found is
  /// simply not highlighted here (it still appears in the result-page list), so
  /// the transcript never renders broken markup.
  List<_Run> _annotate(String sentence, List<FeedbackFix> fixes) {
    final lower = sentence.toLowerCase();
    final claimed = List<bool>.filled(sentence.length, false);
    final hits = <_Hit>[];
    for (final f in fixes) {
      final needle = f.original.trim().toLowerCase();
      if (needle.isEmpty) continue;
      var from = 0;
      while (from <= lower.length - needle.length) {
        final idx = lower.indexOf(needle, from);
        if (idx < 0) break;
        final end = idx + needle.length;
        var overlap = false;
        for (var i = idx; i < end; i++) {
          if (claimed[i]) {
            overlap = true;
            break;
          }
        }
        if (!overlap) {
          for (var i = idx; i < end; i++) {
            claimed[i] = true;
          }
          hits.add(_Hit(idx, end, f));
          break;
        }
        from = idx + 1;
      }
    }
    hits.sort((a, b) => a.start.compareTo(b.start));
    final runs = <_Run>[];
    var cursor = 0;
    for (final h in hits) {
      if (h.start > cursor) {
        runs.add(_Run(sentence.substring(cursor, h.start), null));
      }
      runs.add(_Run(sentence.substring(h.start, h.end), h.fix));
      cursor = h.end;
    }
    if (cursor < sentence.length) {
      runs.add(_Run(sentence.substring(cursor), null));
    }
    return runs;
  }

  void _showFixSheet(BuildContext context, FeedbackFix fix) {
    final colorScheme = Theme.of(context).colorScheme;
    final color = _typeColor(fix.type!, colorScheme);
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
                  _typeLabel(context, fix.type!),
                  style: PmpTextStyles.labelSemi.copyWith(color: color),
                ),
              ),
              const SizedBox(height: 14),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      fix.original.trim(),
                      style: PmpTextStyles.body1Regular.copyWith(
                        color: PmpColors.destructive400,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ),
                  if (fix.corrected.isNotEmpty) ...[
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Icon(Icons.arrow_forward, size: 16),
                    ),
                    Flexible(
                      child: Text(
                        fix.corrected,
                        style: PmpTextStyles.body1Semi
                            .copyWith(color: PmpColors.success500),
                      ),
                    ),
                    PronounceButton(
                      text: fix.corrected,
                      color: PmpColors.success500,
                    ),
                  ],
                ],
              ),
              if (fix.reasonMm.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  fix.reasonMm,
                  style: PmpTextStyles.body2Regular.copyWith(
                    color: colorScheme.onSurface,
                    fontFamily: 'Noto Sans Myanmar',
                    height: 1.7,
                  ),
                ),
              ],
              if (fix.reasonEn.isNotEmpty) ...[
                const SizedBox(height: 10),
                Text(
                  fix.reasonEn,
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

}

/// A run of transcript text — plain when [fix] is null, otherwise a located
/// correction to highlight + make tappable.
class _Run {
  const _Run(this.text, this.fix);
  final String text;
  final FeedbackFix? fix;
}

/// A located occurrence of a fix's `original` within a sentence ([start], [end]
/// are indices into the sentence).
class _Hit {
  const _Hit(this.start, this.end, this.fix);
  final int start;
  final int end;
  final FeedbackFix fix;
}


