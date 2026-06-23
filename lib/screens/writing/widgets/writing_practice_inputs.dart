import 'package:flutter/material.dart';

import '../../../config/pmp_colors.dart';
import '../../../config/pmp_text_styles.dart';
import '../../../model/writing/writing_lexicon.dart';
import '../../../model/writing/writing_review.dart';
import '../../../model/writing/writing_unit.dart';
import '../writing_highlight.dart';

/// The input controls + per-exercise UI state for [WritingPracticePage]. Each
/// widget is a self-contained control the exercise view swaps in by kind (mcq /
/// text / line-by-line / scan).

/// Per-exercise mutable UI state.
class ExState {
  ExState({required this.controller, List<TextEditingController>? lines})
      : lines = lines ?? const [];
  final TextEditingController controller;

  /// One controller per sentence row for `scan_sentences` (empty otherwise).
  /// Mutable so rows can be added / removed.
  List<TextEditingController> lines;
  String? selected; // mcq choice
  bool checked = false;
  bool? correct; // null = AI item (graded by the reviewer, not right/wrong)

  // AI grading state for `free_write` items.
  bool reviewing = false; // the reviewer call is in flight
  WritingReview? review; // the result, once it lands
  bool reviewFailed = false; // call errored → fall back to revealing the model
}

/// Handwrite-and-scan task kinds (graded by AI on a scanned notebook page).
bool isScanTask(String kind) =>
    kind == 'scan_sentences' || kind == 'scan_paragraph';

class McqOptions extends StatelessWidget {
  const McqOptions({
    super.key,
    required this.options,
    required this.selected,
    required this.checked,
    required this.answers,
    required this.onSelect,
  });

  final List<String> options;
  final String? selected;
  final bool checked;
  final List<String> answers;
  final ValueChanged<String> onSelect;

  bool _isAnswer(String o) {
    final got = WritingExercise.normalize(o);
    return answers.any((a) => WritingExercise.normalize(a) == got);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      children: [
        for (final o in options)
          Builder(builder: (context) {
            final isSelected = selected == o;
            Color border = cs.outlineVariant;
            Color bg = cs.surfaceContainerHighest;
            Color fg = cs.onSurface;
            IconData? trailing;
            Color trailingColor = cs.primary;

            if (checked) {
              if (_isAnswer(o)) {
                border = PmpColors.success500;
                bg = PmpColors.success500.withValues(alpha: 0.10);
                trailing = Icons.check_circle;
                trailingColor = PmpColors.success500;
              } else if (isSelected) {
                border = PmpColors.destructive500;
                bg = PmpColors.destructive500.withValues(alpha: 0.10);
                trailing = Icons.cancel;
                trailingColor = PmpColors.destructive500;
              }
            } else if (isSelected) {
              border = cs.primary;
              bg = cs.primary.withValues(alpha: 0.08);
              fg = cs.primary;
            }

            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Material(
                color: bg,
                borderRadius: BorderRadius.circular(12),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: checked ? null : () => onSelect(o),
                  child: Ink(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: border, width: isSelected || checked ? 1.5 : 1),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(o,
                              style: PmpTextStyles.body1Regular
                                  .copyWith(color: fg)),
                        ),
                        if (trailing != null)
                          Icon(trailing, size: 20, color: trailingColor),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
      ],
    );
  }
}

class TextAnswer extends StatelessWidget {
  const TextAnswer({
    super.key,
    required this.controller,
    required this.enabled,
    required this.multiline,
    required this.onChanged,
    this.hintText,
  });

  final TextEditingController controller;
  final bool enabled;
  final bool multiline;
  final VoidCallback onChanged;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return TextField(
      controller: controller,
      enabled: enabled,
      minLines: multiline ? 3 : 1,
      maxLines: multiline ? 6 : 2,
      onChanged: (_) => onChanged(),
      textCapitalization: TextCapitalization.sentences,
      style: PmpTextStyles.body1Regular.copyWith(color: cs.onSurface),
      decoration: InputDecoration(
        hintText: hintText ?? (multiline ? 'Type your answer…' : 'Your answer'),
        filled: true,
        fillColor: cs.surfaceContainerHighest,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: cs.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: cs.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: cs.primary, width: 1.5),
        ),
      ),
    );
  }
}

/// Line-by-line sentence input for `scan_sentences`: one numbered row per
/// sentence, so the learner sees the "write N sentences" expectation, each row
/// is unambiguously one sentence (no need to guess boundaries later), and they
/// can add / remove rows between [min] and [max]. A live counter gates Check.
class SentenceLines extends StatelessWidget {
  const SentenceLines({
    super.key,
    required this.lines,
    required this.min,
    required this.max,
    required this.enabled,
    required this.onChanged,
    required this.onAdd,
    required this.onRemove,
  });

  final List<TextEditingController> lines;
  final int min;
  final int max;
  final bool enabled;
  final VoidCallback onChanged;
  final VoidCallback onAdd;
  final ValueChanged<int> onRemove;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    const accent = PmpColors.accentOrange;
    final filled = lines.where((c) => c.text.trim().isNotEmpty).length;
    final enough = filled >= min;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Or type your sentences — one per line:',
            style: PmpTextStyles.sub.copyWith(color: cs.onSurfaceVariant)),
        const SizedBox(height: 10),
        for (var i = 0; i < lines.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 24,
                  height: 24,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Text('${i + 1}',
                      style: PmpTextStyles.sub.copyWith(
                          color: accent, fontWeight: FontWeight.w700)),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: lines[i],
                    enabled: enabled,
                    onChanged: (_) => onChanged(),
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.next,
                    style: PmpTextStyles.body1Regular
                        .copyWith(color: cs.onSurface),
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: 'Sentence ${i + 1}',
                      filled: true,
                      fillColor: cs.surfaceContainerHighest,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: cs.outlineVariant),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: cs.outlineVariant),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: accent, width: 1.5),
                      ),
                    ),
                  ),
                ),
                if (enabled && lines.length > min)
                  IconButton(
                    onPressed: () => onRemove(i),
                    visualDensity: VisualDensity.compact,
                    icon: Icon(Icons.close_rounded,
                        size: 18, color: cs.onSurfaceVariant),
                    tooltip: 'Remove',
                  ),
              ],
            ),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (enabled && lines.length < max)
              TextButton.icon(
                onPressed: onAdd,
                icon: const Icon(Icons.add_rounded, size: 18),
                label: const Text('Add sentence'),
                style: TextButton.styleFrom(
                  foregroundColor: accent,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  textStyle: PmpTextStyles.body2Semi,
                ),
              )
            else
              const SizedBox.shrink(),
            Text(
              enough
                  ? '$filled sentences  ·  ready'
                  : '$filled / $min — write at least $min',
              style: PmpTextStyles.sub.copyWith(
                  color: enough ? PmpColors.success500 : cs.onSurfaceVariant),
            ),
          ],
        ),
      ],
    );
  }
}

/// Tap-to-arrange word builder for the `word_order` (translate & arrange) kind:
/// the learner reads the Burmese prompt above and taps the English word chips in
/// order to build the sentence.
///
/// The chips never move — a tapped word stays in its slot as an empty "ghost"
/// placeholder, so the grid never reflows (the jarring part of a remove-and-
/// reflow layout). The sentence builds in a "Your answer" box with an **undo**
/// that removes the last word. The built sentence is written straight into
/// [controller], so grading and the Check gate reuse the typed-input path.
class WordOrderBuilder extends StatefulWidget {
  const WordOrderBuilder({
    super.key,
    required this.words,
    required this.controller,
    required this.enabled,
    required this.onChanged,
  });

  /// The word pool (authored in the exercise `options`).
  final List<String> words;
  final TextEditingController controller;
  final bool enabled;
  final VoidCallback onChanged;

  @override
  State<WordOrderBuilder> createState() => _WordOrderBuilderState();
}

class _WordOrderBuilderState extends State<WordOrderBuilder> {
  /// A stable, shuffled view of the pool as (original index, word) pairs — the
  /// index keeps duplicate words distinct and fixes each chip's slot.
  late final List<MapEntry<int, String>> _shuffled;

  /// Original indices the learner has tapped, in order (the source of truth for
  /// both the answer text and which chips are ghosted).
  final List<int> _order = [];
  final Set<int> _used = {};

  /// The chip momentarily scaled down on press, for tactile feedback.
  int? _pressed;

  @override
  void initState() {
    super.initState();
    _shuffled = widget.words.asMap().entries.toList()..shuffle();
    _restoreFromController();
  }

  /// Best-effort rebuild from the controller, so returning to a part-built
  /// answer (e.g. via Back) keeps the chips the learner already tapped.
  void _restoreFromController() {
    final text = widget.controller.text.trim();
    if (text.isEmpty) return;
    for (final tok in text.split(RegExp(r'\s+'))) {
      final entry = _shuffled.firstWhere(
        (e) => !_used.contains(e.key) && e.value == tok,
        orElse: () => const MapEntry(-1, ''),
      );
      if (entry.key == -1) {
        _order.clear();
        _used.clear();
        return; // text doesn't line up with the pool — start fresh.
      }
      _order.add(entry.key);
      _used.add(entry.key);
    }
  }

  void _sync() {
    final byIndex = {for (final e in _shuffled) e.key: e.value};
    widget.controller.text = _order.map((i) => byIndex[i]).join(' ');
    widget.onChanged();
  }

  void _place(int index) {
    setState(() {
      _order.add(index);
      _used.add(index);
    });
    _sync();
  }

  void _undo() {
    if (_order.isEmpty) return;
    setState(() => _used.remove(_order.removeLast()));
    _sync();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final text = _order.isEmpty
        ? null
        : _order
            .map((i) => _shuffled.firstWhere((e) => e.key == i).value)
            .join(' ');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('YOUR ANSWER',
            style: PmpTextStyles.sub.copyWith(
                color: cs.onSurfaceVariant,
                letterSpacing: 0.6,
                fontWeight: FontWeight.w700)),
        const SizedBox(height: 6),
        // The sentence so far + an undo for the last word.
        Container(
          width: double.infinity,
          constraints: const BoxConstraints(minHeight: 52),
          padding: const EdgeInsets.fromLTRB(14, 10, 6, 10),
          decoration: BoxDecoration(
            color: cs.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: cs.outlineVariant),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  text ?? 'Tap the words below…',
                  style: PmpTextStyles.body1Semi.copyWith(
                      color: text == null ? cs.onSurfaceVariant : cs.onSurface),
                ),
              ),
              if (widget.enabled && _order.isNotEmpty)
                IconButton(
                  onPressed: _undo,
                  visualDensity: VisualDensity.compact,
                  tooltip: 'Undo last word',
                  icon: Icon(Icons.undo_rounded,
                      size: 20, color: cs.onSurfaceVariant),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        // The word pool — fixed positions; tapped words become ghost slots.
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final e in _shuffled)
              _WordChip(
                label: e.value,
                used: _used.contains(e.key),
                pressed: _pressed == e.key,
                onTap: (!widget.enabled || _used.contains(e.key))
                    ? null
                    : () async {
                        setState(() => _pressed = e.key);
                        await Future<void>.delayed(
                            const Duration(milliseconds: 110));
                        if (!mounted) return;
                        setState(() => _pressed = null);
                        _place(e.key);
                      },
              ),
          ],
        ),
      ],
    );
  }
}

class _WordChip extends StatelessWidget {
  const _WordChip(
      {required this.label,
      required this.used,
      required this.pressed,
      required this.onTap});
  final String label;
  final bool used;
  final bool pressed;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    // A used chip keeps its exact footprint (so the grid never shifts) but goes
    // empty — a faint outlined placeholder where the word was.
    return AnimatedScale(
      scale: pressed ? 0.94 : 1.0,
      duration: const Duration(milliseconds: 110),
      curve: Curves.easeOut,
      child: Material(
        color: used ? Colors.transparent : cs.surface,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: used
                    ? cs.outlineVariant.withValues(alpha: 0.4)
                    : cs.outlineVariant,
              ),
            ),
            // Invisible (but space-occupying) text keeps the slot the same size.
            child: Opacity(
              opacity: used ? 0.0 : 1.0,
              child: Text(label,
                  style:
                      PmpTextStyles.body1Regular.copyWith(color: cs.onSurface)),
            ),
          ),
        ),
      ),
    );
  }
}

/// The prominent "study with a tutor" affordance for scan tasks: write it in
/// your notebook, then scan. The scan button is disabled until Phase 3 (camera
/// + AI); for now learners can type the answer in the field below.
class ScanCallout extends StatelessWidget {
  const ScanCallout({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    const color = PmpColors.accentOrange;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.menu_book_rounded, size: 18, color: color),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Write it in your notebook, then scan the page.',
                  style: PmpTextStyles.body1Semi.copyWith(color: cs.onSurface),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 46,
            child: FilledButton.icon(
              // Phase 3: opens the camera → AI transcribes + grades the page.
              onPressed: null,
              icon: const Icon(Icons.photo_camera_outlined),
              label: const Text('Scan my notebook  ·  soon'),
              style: FilledButton.styleFrom(
                backgroundColor: color,
                foregroundColor: Colors.white,
                disabledBackgroundColor: color.withValues(alpha: 0.25),
                disabledForegroundColor: cs.onSurface.withValues(alpha: 0.5),
                textStyle: PmpTextStyles.body2Semi,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// A collapsible reminder of the unit's toolkit, shown while writing so the
/// learner can pull words without flipping back. Surfaces every bank the unit
/// carries — verbs, jobs/roles (nouns), describing words (adjectives) and time
/// words — each as a labelled, colour-coded chip group. Starts expanded so the
/// help is visible without a tap.
class ToolkitReminder extends StatelessWidget {
  const ToolkitReminder(
      {super.key, required this.toolkit, required this.formKey});
  final ResolvedToolkit toolkit;
  final String formKey;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final verbColor = writingVerbColor(Theme.of(context).brightness);
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: Container(
        decoration: BoxDecoration(
          color: cs.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: cs.outlineVariant),
        ),
        clipBehavior: Clip.antiAlias,
        child: ExpansionTile(
          initiallyExpanded: true,
          tilePadding: const EdgeInsets.symmetric(horizontal: 14),
          childrenPadding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
          leading: Icon(Icons.handyman_outlined, size: 18, color: cs.primary),
          title: Text('Your toolkit  ·  words you can use',
              style: PmpTextStyles.body2Semi.copyWith(color: cs.onSurface)),
          children: [
            if (toolkit.verbs.isNotEmpty)
              _ToolkitGroup(
                label: 'Verbs',
                color: verbColor,
                labels: [
                  for (final v in toolkit.verbs)
                    v.secondForm(formKey) == v.base
                        ? v.base
                        : '${v.base} / ${v.secondForm(formKey)}'
                ],
              ),
            if (toolkit.nouns.isNotEmpty)
              _ToolkitGroup(
                label: 'Jobs & roles',
                color: cs.primary,
                labels: [for (final n in toolkit.nouns) n.withArticle],
              ),
            if (toolkit.adjectives.isNotEmpty)
              _ToolkitGroup(
                label: 'Describing words',
                color: verbColor,
                labels: [for (final a in toolkit.adjectives) a.en],
              ),
            if (toolkit.timeWords.isNotEmpty)
              _ToolkitGroup(
                label: 'Time words',
                color: PmpColors.accentOrange,
                labels: [for (final w in toolkit.timeWords) w.en],
              ),
          ],
        ),
      ),
    );
  }
}

/// One labelled group inside the [ToolkitReminder] — a caption + its chips.
class _ToolkitGroup extends StatelessWidget {
  const _ToolkitGroup(
      {required this.label, required this.color, required this.labels});
  final String label;
  final Color color;
  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label.toUpperCase(),
              style: PmpTextStyles.sub.copyWith(
                  color: cs.onSurfaceVariant,
                  letterSpacing: 0.6,
                  fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          ChipWrap(labels: labels, color: color),
        ],
      ),
    );
  }
}

class ChipWrap extends StatelessWidget {
  const ChipWrap({super.key, required this.labels, required this.color});
  final List<String> labels;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final l in labels)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: color.withValues(alpha: 0.30)),
            ),
            child: Text(l, style: PmpTextStyles.sub.copyWith(color: color)),
          ),
      ],
    );
  }
}

/// Placeholder for the Phase-3 "write in your notebook and scan" path.
class ScanHint extends StatelessWidget {
  const ScanHint({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Row(
        children: [
          Icon(Icons.photo_camera_outlined,
              size: 18, color: cs.onSurfaceVariant),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Soon: write it in your notebook and scan it — we’ll read and check it.',
              style: PmpTextStyles.sub.copyWith(color: cs.onSurfaceVariant),
            ),
          ),
        ],
      ),
    );
  }
}
