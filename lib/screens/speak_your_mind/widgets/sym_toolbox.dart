import 'package:flutter/material.dart';

import '../../../config/pmp_colors.dart';
import '../../../config/pmp_text_styles.dart';
import '../../../model/speak_your_mind/sym_audio.dart';
import '../../../model/speak_your_mind/sym_models.dart';
import '../../../services/vocab_tts_service.dart';
import '../../../shared_widgets/glass.dart';

/// The toolbox accordion — each move is a collapsible group of reusable chunks
/// (pattern highlighted + swappable fillers + audio + Burmese gloss). Shared
/// between the topic page (full screen) and the writing screen's reference
/// bottom sheet, so a learner can peek at phrases without leaving their writing.
class SymToolboxList extends StatelessWidget {
  const SymToolboxList({
    super.key,
    required this.moves,
    this.firstExpanded = true,
  });
  final List<SymMove> moves;

  /// Open the first move by default (the topic page does; the reference sheet
  /// keeps everything collapsed so it reads as a scannable menu).
  final bool firstExpanded;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < moves.length; i++) ...[
          SymMoveGroup(
            index: i + 1,
            move: moves[i],
            initiallyExpanded: firstExpanded && i == 0,
          ),
          const SizedBox(height: 10),
        ],
      ],
    );
  }
}

/// A draggable bottom sheet that shows [topic]'s toolbox — opened from the
/// writing screen so reference is one tap away while composing.
class SymToolboxSheet extends StatelessWidget {
  const SymToolboxSheet({super.key, required this.topic});
  final SymTopic topic;

  /// Convenience opener (dismisses the keyboard first so the sheet has room).
  static Future<void> show(BuildContext context, SymTopic topic) {
    FocusScope.of(context).unfocus();
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => SymToolboxSheet(topic: topic),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, controller) {
        return Container(
          decoration: BoxDecoration(
            color: cs.surface,
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(20)),
            border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.5)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 8),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: cs.outlineVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 6, 8),
                child: Row(
                  children: [
                    Icon(Icons.handyman_outlined, size: 18, color: cs.primary),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text('Your toolbox',
                          style: PmpTextStyles.body1Semi
                              .copyWith(color: cs.onSurface)),
                    ),
                    Text('${topic.toolbox.length} moves',
                        style: PmpTextStyles.label2Regular
                            .copyWith(color: cs.onSurfaceVariant)),
                    IconButton(
                      tooltip: 'Close',
                      visualDensity: VisualDensity.compact,
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close_rounded),
                    ),
                  ],
                ),
              ),
              Divider(height: 1, color: cs.outlineVariant.withValues(alpha: 0.6)),
              Expanded(
                child: ListView(
                  controller: controller,
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
                  children: [
                    SymToolboxList(moves: topic.toolbox, firstExpanded: false),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// One move = a collapsible function header + its chunk cards (accordion). The
/// toolbox can be large, so moves collapse to just their title — turning ~60
/// phrases into a scannable menu the learner opens only where it fits them.
class SymMoveGroup extends StatefulWidget {
  const SymMoveGroup({
    super.key,
    required this.index,
    required this.move,
    this.initiallyExpanded = false,
  });
  final int index;
  final SymMove move;
  final bool initiallyExpanded;

  @override
  State<SymMoveGroup> createState() => _SymMoveGroupState();
}

class _SymMoveGroupState extends State<SymMoveGroup> {
  late bool _expanded = widget.initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final move = widget.move;
    return GlassCard(
      blur: false,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header — always visible; tap to toggle.
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () => setState(() => _expanded = !_expanded),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 22,
                    height: 22,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 1),
                    decoration: BoxDecoration(
                      color: cs.primary.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Text('${widget.index}',
                        style: PmpTextStyles.label2Regular.copyWith(
                            color: cs.primary, fontWeight: FontWeight.w700)),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(move.moveEn,
                            style: PmpTextStyles.body1Semi
                                .copyWith(color: cs.onSurface)),
                        const SizedBox(height: 1),
                        Text(
                          _expanded
                              ? move.moveMm
                              : '${move.moveMm}  ·  ${move.items.length}',
                          style: PmpTextStyles.label2Regular.copyWith(
                              color: PmpColors.myanmarGloss(
                                  Theme.of(context).brightness)),
                        ),
                      ],
                    ),
                  ),
                  AnimatedRotation(
                    turns: _expanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 180),
                    child: Icon(Icons.expand_more_rounded,
                        color: cs.onSurfaceVariant),
                  ),
                ],
              ),
            ),
          ),
          if (_expanded)
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: Column(
                children: [
                  for (final chunk in move.items) ...[
                    _ChunkCard(chunk: chunk),
                    const SizedBox(height: 8),
                  ],
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _ChunkCard extends StatelessWidget {
  const _ChunkCard({required this.chunk});
  final SymChunk chunk;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final mm = PmpColors.myanmarGloss(Theme.of(context).brightness);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(12, 10, 6, 10),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _HighlightedSentence(chunk: chunk)),
              if (chunk.tag.isNotEmpty) ...[
                const SizedBox(width: 6),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: _TagPill(tag: chunk.tag),
                ),
              ],
              // 🔊 only when a real (EdgeTTS/Bunny) clip exists — never a robotic
              // on-device TTS fallback, which would cheapen the app.
              if (chunk.audio.isNotEmpty)
                _Speak(url: chunk.audio, text: chunk.textEn)
              else
                const SizedBox(width: 8),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(chunk.glossMm,
                    style: PmpTextStyles.label2Regular
                        .copyWith(color: mm, height: 1.45)),
                if (chunk.swapEn.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  _SwapRow(swap: chunk.swapEn, cs: cs),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Register tag — lets different learners self-select: simple / natural /
/// advanced. Colour-coded so it's scannable without reading.
class _TagPill extends StatelessWidget {
  const _TagPill({required this.tag});
  final String tag;

  @override
  Widget build(BuildContext context) {
    final color = switch (tag) {
      'simple' => PmpColors.success500,
      'advanced' => PmpColors.brandOrange,
      _ => PmpColors.brandCyan,
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(tag,
          style: PmpTextStyles.label2Regular
              .copyWith(color: color, fontWeight: FontWeight.w600)),
    );
  }
}

/// The example sentence with the reusable pattern in bold + primary colour.
class _HighlightedSentence extends StatelessWidget {
  const _HighlightedSentence({required this.chunk});
  final SymChunk chunk;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final base =
        PmpTextStyles.body2Medium.copyWith(color: cs.onSurface, height: 1.45);
    final hi = chunk.highlight;
    final text = chunk.textEn;
    final idx = hi.isEmpty ? -1 : text.indexOf(hi);

    final spans = <TextSpan>[];
    if (idx < 0) {
      spans.add(TextSpan(text: text));
    } else {
      if (idx > 0) spans.add(TextSpan(text: text.substring(0, idx)));
      spans.add(TextSpan(
        text: hi,
        style: base.copyWith(color: cs.primary, fontWeight: FontWeight.w700),
      ));
      final end = idx + hi.length;
      if (end < text.length) spans.add(TextSpan(text: text.substring(end)));
    }
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: RichText(text: TextSpan(style: base, children: spans)),
    );
  }
}

class _SwapRow extends StatelessWidget {
  const _SwapRow({required this.swap, required this.cs});
  final String swap;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.swap_horiz_rounded, size: 15, color: cs.primary),
        const SizedBox(width: 6),
        Expanded(
          child: Text(swap,
              style: PmpTextStyles.label2Regular
                  .copyWith(color: cs.onSurfaceVariant, height: 1.45)),
        ),
      ],
    );
  }
}

/// Speaker button — plays the Bunny clip at [url] if present, else falls back to
/// device TTS of [text] (reused from Vocabulary).
class _Speak extends StatelessWidget {
  const _Speak({required this.url, required this.text});
  final String url;
  final String text;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return IconButton(
      visualDensity: VisualDensity.compact,
      onPressed: () =>
          VocabTtsService.instance.playUrlOrSpeak(SymAudio.resolve(url), text),
      icon: Icon(Icons.volume_up_rounded, color: cs.primary),
      tooltip: 'Listen',
    );
  }
}
