import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:speakcraft/bloc/video_step_progress/video_step_progress_bloc.dart';
import 'package:speakcraft/model/video_step_progress/video_step_progress.dart';

import '../../config/pmp_colors.dart';
import '../../shared_widgets/glass.dart';

/// "Key Takeaways" deck for a video.
///
/// Fetches the deck JSON over HTTP from the listening's [keyTakeawaysPath]
/// (Bunny URL) and renders the ~15-30 curated keepers grouped by category, each
/// as an expandable card. The step is only shown when the path is set, so this
/// page is never opened with an empty url.
///
/// Schema:
///   { title, title_my, summary_my, takeaway_count, takeaways: [
///       { id, category, headword, pos, phonetic, gloss_my, explanation_my,
///         examples:[{english,burmese,highlight}], source:{english,sentence_id},
///         tip_my } ] }
class KeyTakeawaysPage extends StatefulWidget {
  const KeyTakeawaysPage({
    super.key,
    required this.url,
    this.youtubeId,
  });

  /// Full Bunny URL to this video's key_takeaways.json.
  final String url;

  /// When provided, this step's progress is tracked on the lesson hub
  /// (in-progress on open, done once the learner opens any takeaway).
  final String? youtubeId;

  @override
  State<KeyTakeawaysPage> createState() => _KeyTakeawaysPageState();
}

class _KeyTakeawaysPageState extends State<KeyTakeawaysPage> {
  Map<String, dynamic>? _data;
  bool _loading = true;
  String? _error;
  bool _markedDone = false;

  @override
  void initState() {
    super.initState();
    _load();
    final id = widget.youtubeId;
    if (id != null) {
      context.read<VideoStepProgressBloc>().add(
            VideoStepProgressEvent.markInProgress(
              id,
              VideoLessonStep.keyTakeaways,
            ),
          );
    }
  }

  void _markDoneOnce() {
    final id = widget.youtubeId;
    if (_markedDone || id == null) return;
    _markedDone = true;
    context.read<VideoStepProgressBloc>().add(
          VideoStepProgressEvent.markDone(id, VideoLessonStep.keyTakeaways),
        );
  }

  Future<void> _load() async {
    try {
      final res = await http
          .get(Uri.parse(widget.url))
          .timeout(const Duration(seconds: 15));
      if (res.statusCode != 200) {
        throw Exception('HTTP ${res.statusCode}');
      }
      final decoded =
          json.decode(utf8.decode(res.bodyBytes)) as Map<String, dynamic>;
      if (!mounted) return;
      setState(() {
        _data = decoded;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final data = _data;

    return GlassScaffold(
      title: const Text('Key Takeaways'),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null || data == null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.workspace_premium_outlined,
                            size: 44, color: cs.onSurfaceVariant),
                        const SizedBox(height: 12),
                        Text(
                          'Key Takeaways for this video are coming soon.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14, color: cs.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                )
              : _buildDeck(context, data),
    );
  }

  Widget _buildDeck(BuildContext context, Map<String, dynamic> data) {
    final cs = Theme.of(context).colorScheme;
    final takeaways =
        (data['takeaways'] as List<dynamic>? ?? []).cast<Map<String, dynamic>>();

    // Group by category, preserving the canonical display order.
    final grouped = <String, List<Map<String, dynamic>>>{};
    for (final t in takeaways) {
      final cat = t['category'] as String? ?? 'vocabulary';
      grouped.putIfAbsent(cat, () => []).add(t);
    }
    final orderedCats =
        _categoryOrder.where((c) => grouped.containsKey(c)).toList();

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      children: [
        _DeckHeader(
          titleMy: data['title_my'] as String? ?? data['title'] as String? ?? '',
          summaryMy: data['summary_my'] as String? ?? '',
          count: takeaways.length,
        ),
        const SizedBox(height: 20),
        for (final cat in orderedCats) ...[
          _SectionHeader(category: cat, count: grouped[cat]!.length),
          const SizedBox(height: 10),
          for (final t in grouped[cat]!) ...[
            _TakeawayCard(takeaway: t, onExpand: _markDoneOnce),
            const SizedBox(height: 10),
          ],
          const SizedBox(height: 14),
        ],
        Center(
          child: Text(
            '${takeaways.length} takeaways',
            style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------- deck header

class _DeckHeader extends StatelessWidget {
  const _DeckHeader({
    required this.titleMy,
    required this.summaryMy,
    required this.count,
  });

  final String titleMy;
  final String summaryMy;
  final int count;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final myColor = PmpColors.myanmarGloss(Theme.of(context).brightness);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            cs.primary.withValues(alpha: 0.12),
            PmpColors.accentOrange.withValues(alpha: 0.08),
          ],
        ),
        border: Border.all(color: cs.primary.withValues(alpha: 0.22)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.workspace_premium_rounded,
                  size: 22, color: cs.primary),
              const SizedBox(width: 8),
              Text(
                'Key Takeaways',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: cs.onSurface,
                ),
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: cs.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '$count',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: cs.primary,
                  ),
                ),
              ),
            ],
          ),
          if (titleMy.isNotEmpty) ...[
            const SizedBox(height: 10),
            Text(
              titleMy,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: cs.onSurface,
                height: 1.5,
              ),
            ),
          ],
          if (summaryMy.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              summaryMy,
              style: TextStyle(fontSize: 13, color: myColor, height: 1.7),
            ),
          ],
        ],
      ),
    );
  }
}

// -------------------------------------------------------------- section header

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.category, required this.count});

  final String category;
  final int count;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final meta = _catMeta[category] ?? _catMeta['vocabulary']!;

    return Row(
      children: [
        Icon(meta.icon, size: 18, color: meta.color),
        const SizedBox(width: 8),
        Text(
          meta.label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: cs.onSurface,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          '($count)',
          style: TextStyle(fontSize: 13, color: cs.onSurfaceVariant),
        ),
      ],
    );
  }
}

// ----------------------------------------------------------------- card

class _TakeawayCard extends StatefulWidget {
  const _TakeawayCard({required this.takeaway, this.onExpand});

  final Map<String, dynamic> takeaway;
  final VoidCallback? onExpand;

  @override
  State<_TakeawayCard> createState() => _TakeawayCardState();
}

class _TakeawayCardState extends State<_TakeawayCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final myColor = PmpColors.myanmarGloss(Theme.of(context).brightness);
    final t = widget.takeaway;

    final category = t['category'] as String? ?? 'vocabulary';
    final meta = _catMeta[category] ?? _catMeta['vocabulary']!;
    final headword = t['headword'] as String? ?? '';
    final pos = t['pos'] as String? ?? '';
    final phonetic = t['phonetic'] as String? ?? '';
    final glossMy = t['gloss_my'] as String? ?? '';
    final explanationMy = t['explanation_my'] as String? ?? '';
    final examples =
        (t['examples'] as List<dynamic>? ?? []).cast<Map<String, dynamic>>();
    final tipMy = t['tip_my'] as String? ?? '';
    final source = t['source'] as Map<String, dynamic>?;
    final sourceEn = source?['english'] as String? ?? '';

    return GlassCard(
      borderRadius: 14,
      padding: EdgeInsets.zero,
      onTap: () {
        setState(() => _expanded = !_expanded);
        if (_expanded) widget.onExpand?.call();
      },
      child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---- collapsed header: headword + gloss + category tag ----
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 12, 12, 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Flexible(
                                child: Text(
                                  headword,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: cs.onSurface,
                                  ),
                                ),
                              ),
                              if (phonetic.isNotEmpty) ...[
                                const SizedBox(width: 8),
                                Text(
                                  phonetic,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: cs.onSurfaceVariant,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ],
                          ),
                          if (pos.isNotEmpty) ...[
                            const SizedBox(height: 2),
                            Text(
                              pos,
                              style: TextStyle(
                                fontSize: 11,
                                color: cs.onSurfaceVariant,
                              ),
                            ),
                          ],
                          if (glossMy.isNotEmpty) ...[
                            const SizedBox(height: 5),
                            Text(
                              glossMy,
                              style: TextStyle(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w600,
                                color: myColor,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _CategoryChip(meta: meta),
                        const SizedBox(height: 6),
                        Icon(
                          _expanded
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          size: 20,
                          color: cs.onSurfaceVariant,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // ---- expanded body ----
              if (_expanded) ...[
                Divider(height: 1, color: cs.outlineVariant),
                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (explanationMy.isNotEmpty)
                        Text(
                          explanationMy,
                          style: TextStyle(
                            fontSize: 13,
                            color: cs.onSurfaceVariant,
                            height: 1.7,
                          ),
                        ),
                      if (examples.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        for (final ex in examples)
                          _ExampleRow(
                            english: ex['english'] as String? ?? '',
                            burmese: ex['burmese'] as String? ?? '',
                            highlights: (ex['highlight'] as List<dynamic>? ?? [])
                                .cast<String>(),
                            accent: meta.color,
                            myColor: myColor,
                          ),
                      ],
                      if (tipMy.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color:
                                PmpColors.accentOrange.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(8),
                            border: Border(
                              left: BorderSide(
                                color: PmpColors.accentOrange
                                    .withValues(alpha: 0.6),
                                width: 3,
                              ),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.lightbulb_outline,
                                  size: 16, color: PmpColors.accentOrange),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  tipMy,
                                  style: TextStyle(
                                    fontSize: 12.5,
                                    color: cs.onSurface,
                                    height: 1.6,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      if (sourceEn.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.subdirectory_arrow_right,
                                size: 14, color: cs.onSurfaceVariant),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                'From the video: "$sourceEn"',
                                style: TextStyle(
                                  fontSize: 11.5,
                                  fontStyle: FontStyle.italic,
                                  color: cs.onSurfaceVariant,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ],
          ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({required this.meta});

  final _CatMeta meta;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: meta.color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(meta.icon, size: 12, color: meta.color),
          const SizedBox(width: 4),
          Text(
            meta.shortEn,
            style: TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w600,
              color: meta.color,
            ),
          ),
        ],
      ),
    );
  }
}

class _ExampleRow extends StatelessWidget {
  const _ExampleRow({
    required this.english,
    required this.burmese,
    required this.myColor,
    required this.accent,
    this.highlights = const [],
  });

  final String english;
  final String burmese;
  final Color myColor;
  final Color accent;
  final List<String> highlights;

  /// Splits [text] into spans, styling any occurrence of a [highlights] phrase
  /// with [hl]. Longest-first, non-overlapping, case-insensitive — so inflected
  /// forms stored in the JSON ("stuck with") are matched as authored.
  List<InlineSpan> _spans(String text, TextStyle base, TextStyle hl) {
    if (highlights.isEmpty) return [TextSpan(text: text, style: base)];
    final low = text.toLowerCase();
    final ranges = <List<int>>[];
    final sorted = [...highlights]
      ..sort((a, b) => b.length.compareTo(a.length));
    for (final p in sorted) {
      if (p.isEmpty) continue;
      final pl = p.toLowerCase();
      var start = 0;
      while (true) {
        final i = low.indexOf(pl, start);
        if (i < 0) break;
        final j = i + pl.length;
        start = i + 1;
        final overlaps = ranges.any((r) => !(j <= r[0] || i >= r[1]));
        if (!overlaps) ranges.add([i, j]);
      }
    }
    ranges.sort((a, b) => a[0].compareTo(b[0]));
    final spans = <InlineSpan>[];
    var cur = 0;
    for (final r in ranges) {
      if (r[0] > cur) {
        spans.add(TextSpan(text: text.substring(cur, r[0]), style: base));
      }
      spans.add(TextSpan(text: text.substring(r[0], r[1]), style: hl));
      cur = r[1];
    }
    if (cur < text.length) {
      spans.add(TextSpan(text: text.substring(cur), style: base));
    }
    return spans;
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final base = TextStyle(fontSize: 13.5, color: cs.onSurface, height: 1.5);
    final hl = base.copyWith(fontWeight: FontWeight.w700, color: accent);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 2, right: 6),
                child: Icon(Icons.chat_bubble_outline,
                    size: 13, color: cs.onSurfaceVariant),
              ),
              Expanded(
                child: Text.rich(
                  TextSpan(children: _spans(english, base, hl)),
                ),
              ),
            ],
          ),
          if (burmese.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 19, top: 2),
              child: Text(
                burmese,
                style: TextStyle(fontSize: 12.5, color: myColor, height: 1.6),
              ),
            ),
        ],
      ),
    );
  }
}

// ----------------------------------------------------- category metadata

class _CatMeta {
  const _CatMeta(this.label, this.shortEn, this.icon, this.color);

  final String label; // Burmese section label
  final String shortEn; // chip label
  final IconData icon;
  final Color color;
}

const List<String> _categoryOrder = [
  'grammar_pattern',
  'phrase',
  'idiom',
  'vocabulary',
  'pronunciation',
];

final Map<String, _CatMeta> _catMeta = {
  'grammar_pattern': const _CatMeta(
      'သဒ္ဒါပုံစံ (Grammar Patterns)', 'Pattern', Icons.construction_outlined,
      PmpColors.info500),
  'phrase': const _CatMeta('အသုံးအနှုန်း (Phrases)', 'Phrase',
      Icons.chat_bubble_outline, PmpColors.primary400),
  'idiom': const _CatMeta('အီဒီယမ် (Idioms)', 'Idiom', Icons.auto_awesome,
      PmpColors.secondary400),
  'vocabulary': const _CatMeta('ဝေါဟာရ (Vocabulary)', 'Vocab',
      Icons.menu_book_outlined, PmpColors.success500),
  'pronunciation': const _CatMeta('အသံထွက် (Pronunciation)', 'Sound',
      Icons.graphic_eq, PmpColors.accentOrange),
};
