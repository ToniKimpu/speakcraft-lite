import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/pmp_colors.dart';
import '../../config/pmp_routes.dart';
import '../../config/pmp_text_styles.dart';
import '../../model/vocabulary/vocab_audio.dart';
import '../../model/vocabulary/vocab_loader.dart';
import '../../model/vocabulary/vocab_models.dart';
import '../../services/vocab_tts_service.dart';
import '../../shared_widgets/error_retry_view.dart';
import '../../shared_widgets/glass.dart';
import '../../shared_widgets/premium_gate.dart';
import 'widgets/bilingual_text.dart';

/// The "learn" flow for one group, as a pager:
///   intro (why grouped) → one page per word → a comparison page (the
/// "which one, when?" table + minimal pairs) → Practice.
///
/// Pager gives each word room and a guided feel (like the Grammar teach-steps
/// pager); the comparison page brings the words back side-by-side so the
/// decision lands. Audio is on-device TTS in the prototype.
class VocabGroupPage extends StatefulWidget {
  const VocabGroupPage({super.key, required this.groupId, this.title});

  final String groupId;
  final String? title;

  @override
  State<VocabGroupPage> createState() => _VocabGroupPageState();
}

class _VocabGroupPageState extends State<VocabGroupPage> {
  final PageController _controller = PageController();
  VocabGroup? _group;
  Object? _error;
  bool _locked = false;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final g = await loadVocabGroup(widget.groupId);
      if (!mounted) return;
      // Defence-in-depth: the list screen gates before navigation, but guard
      // here too (deep links / stale state) so premium content never opens.
      if (!isUnlocked(isFree: g.isFree)) {
        setState(() => _locked = true);
        return;
      }
      setState(() => _group = g);
    } catch (e) {
      if (mounted) setState(() => _error = e);
    }
  }

  @override
  void dispose() {
    VocabTtsService.instance.stop();
    _controller.dispose();
    super.dispose();
  }

  /// pages = intro + one per word + comparison.
  int get _pageCount => _group == null ? 0 : _group!.words.length + 2;
  int get _comparisonIndex => _pageCount - 1;

  @override
  Widget build(BuildContext context) {
    final group = _group;
    return GlassScaffold(
      title: Text(widget.title ?? 'Vocabulary'),
      actions: [
        if (group != null)
          TextButton.icon(
            onPressed: () => _controller.animateToPage(
              _comparisonIndex,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            ),
            icon: const Icon(Icons.summarize_outlined, size: 18),
            label: const Text('Summary'),
          ),
      ],
      body: _locked
          ? _LockedView(onUnlock: () => showPremiumSheet(context))
          : _error != null
              ? ErrorRetryView(
                  error: _error,
                  onRetry: () {
                    setState(() => _error = null);
                    _load();
                  },
                )
              : group == null
                  ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Expanded(
                      child: PageView(
                        controller: _controller,
                        onPageChanged: (i) => setState(() => _page = i),
                        children: [
                          _IntroPage(group: group),
                          for (var i = 0; i < group.words.length; i++)
                            _WordPage(
                                word: group.words[i],
                                group: group,
                                wordIndex: i),
                          _ComparisonPage(
                            group: group,
                            onPractice: () => Navigator.pushNamed(
                              context,
                              PmpRoutes.vocabularyPractice,
                              arguments: {'group': group},
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        children: [
                          IconButton(
                            tooltip: 'Previous',
                            onPressed: _page > 0
                                ? () => _controller.previousPage(
                                    duration:
                                        const Duration(milliseconds: 280),
                                    curve: Curves.easeOut)
                                : null,
                            icon: const Icon(Icons.chevron_left_rounded),
                          ),
                          Expanded(
                              child: _Dots(count: _pageCount, active: _page)),
                          IconButton(
                            tooltip: 'Next',
                            onPressed: _page < _pageCount - 1
                                ? () => _controller.nextPage(
                                    duration:
                                        const Duration(milliseconds: 280),
                                    curve: Curves.easeOut)
                                : null,
                            icon: const Icon(Icons.chevron_right_rounded),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
    );
  }
}

/// Shown when a premium group is opened without access (deep link / stale nav).
class _LockedView extends StatelessWidget {
  const _LockedView({required this.onUnlock});
  final VoidCallback onUnlock;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.workspace_premium_rounded, size: 44, color: cs.primary),
            const SizedBox(height: 14),
            Text('Premium word set',
                style:
                    PmpTextStyles.title1SemiBold.copyWith(color: cs.onSurface)),
            const SizedBox(height: 6),
            Text(
              'This set is part of Premium. Unlock it to learn these words with '
              'audio, examples and practice.',
              textAlign: TextAlign.center,
              style: PmpTextStyles.body2Regular
                  .copyWith(color: cs.onSurfaceVariant, height: 1.5),
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: onUnlock,
              icon: const Icon(Icons.workspace_premium_rounded),
              label: const Text('Get Premium'),
            ),
          ],
        ),
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  const _Dots({required this.count, required this.active});
  final int count;
  final int active;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int i = 0; i < count; i++)
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: i == active ? 18 : 7,
              height: 7,
              decoration: BoxDecoration(
                color: i == active
                    ? cs.primary
                    : cs.onSurfaceVariant.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
        ],
      ),
    );
  }
}

class _IntroPage extends StatelessWidget {
  const _IntroPage({required this.group});
  final VocabGroup group;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(group.theme.toUpperCase(),
              style: PmpTextStyles.label2Regular.copyWith(
                  color: cs.primary, letterSpacing: 1.2)),
          const SizedBox(height: 6),
          Text(group.title,
              style:
                  PmpTextStyles.title1SemiBold.copyWith(color: cs.onSurface)),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  PmpColors.brandCyan.withValues(alpha: 0.14),
                  PmpColors.brandOrange.withValues(alpha: 0.07),
                ],
              ),
              border:
                  Border.all(color: PmpColors.brandCyan.withValues(alpha: 0.22)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.lightbulb_outline, size: 18, color: cs.primary),
                    const SizedBox(width: 8),
                    Text(group.style == 'theme' ? 'About this set' : 'Why these go together',
                        style: PmpTextStyles.body1Semi
                            .copyWith(color: cs.onSurface)),
                  ],
                ),
                const SizedBox(height: 8),
                BilingualText(
                  mm: group.whyGroupedMm,
                  en: group.whyGroupedEn,
                  long: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Icon(Icons.swipe_left_alt_rounded,
                  size: 18, color: cs.onSurfaceVariant),
              const SizedBox(width: 8),
              Text(
                  'Swipe to meet the ${group.words.length} ${group.unit == 'expression' ? 'expressions' : 'words'}',
                  style: PmpTextStyles.label2Regular
                      .copyWith(color: cs.onSurfaceVariant)),
            ],
          ),
        ],
      ),
    );
  }
}

class _WordPage extends StatelessWidget {
  const _WordPage(
      {required this.word, required this.group, required this.wordIndex});
  final VocabWord word;
  final VocabGroup group;
  final int wordIndex;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Headword + speak.
          Row(
            children: [
              Expanded(
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 8,
                  children: [
                    Text(word.word,
                        style: PmpTextStyles.title1SemiBold
                            .copyWith(color: cs.onSurface)),
                    if (word.pos.isNotEmpty)
                      Text(word.pos,
                          style: PmpTextStyles.label2Regular.copyWith(
                              color: cs.primary, fontStyle: FontStyle.italic)),
                  ],
                ),
              ),
              _SpeakButton(
                  text: word.word,
                  audioUrl: VocabAudio.wordUrl(group, wordIndex)),
            ],
          ),
          if (word.ipa.isNotEmpty)
            // IPA must render in a font with full IPA-Extensions coverage. The
            // app's Plus Jakarta Sans lacks those glyphs (ɪ ə ˈ ː ɡ ʃ …) and
            // they fall back inconsistently / show as tofu; Noto Sans covers
            // the whole block, so the phonetics render cleanly everywhere.
            Text(word.ipa,
                style: GoogleFonts.notoSans(
                  textStyle: PmpTextStyles.label2Regular,
                  color: cs.onSurfaceVariant,
                )),
          const SizedBox(height: 4),
          BilingualText(
            mm: word.shortMm,
            en: word.shortEn,
            style: PmpTextStyles.body2Semi,
          ),

          // The decision rule — the takeaway, up top.
          if (word.useWhenEn.isNotEmpty || word.useWhenMm.isNotEmpty) ...[
            const SizedBox(height: 16),
            _Callout(
              icon: Icons.check_circle_outline,
              color: PmpColors.success500,
              label: 'Use it when',
              mm: word.useWhenMm,
              en: word.useWhenEn,
            ),
          ],

          // Often used with — the collocation/partners block.
          if (word.goesWithEn.isNotEmpty || word.collocations.isNotEmpty) ...[
            const SizedBox(height: 10),
            _GoesWithBlock(word: word),
          ],

          if (word.explanationEn.isNotEmpty ||
              word.explanationMm.isNotEmpty) ...[
            const SizedBox(height: 16),
            BilingualText(
              mm: word.explanationMm,
              en: word.explanationEn,
              long: true,
            ),
          ],
          if (word.nuanceEn.isNotEmpty || word.nuanceMm.isNotEmpty) ...[
            const SizedBox(height: 12),
            _Callout(
              icon: Icons.priority_high_rounded,
              color: PmpColors.brandOrange,
              label: 'Watch out',
              mm: word.nuanceMm,
              en: word.nuanceEn,
            ),
          ],
          if (word.examples.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text('Examples',
                style: PmpTextStyles.label2Regular
                    .copyWith(color: cs.onSurfaceVariant)),
            const SizedBox(height: 6),
            for (var j = 0; j < word.examples.length; j++)
              _ExampleRow(
                  example: word.examples[j],
                  audioUrl: VocabAudio.exampleUrl(group, wordIndex, j)),
          ],
          if (word.confuseWith.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text('Don\'t confuse with: ${word.confuseWith.join(", ")}',
                style: PmpTextStyles.label2Regular.copyWith(
                    color: cs.error, fontStyle: FontStyle.italic)),
          ],
        ],
      ),
    );
  }
}

class _Callout extends StatelessWidget {
  const _Callout({
    required this.icon,
    required this.color,
    required this.label,
    required this.mm,
    required this.en,
  });

  final IconData icon;
  final Color color;
  final String label;
  final String mm;
  final String en;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: color),
              const SizedBox(width: 6),
              Text(label,
                  style: PmpTextStyles.label2Regular.copyWith(
                      color: color, fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 4),
          BilingualText(mm: mm, en: en),
        ],
      ),
    );
  }
}

class _GoesWithBlock extends StatelessWidget {
  const _GoesWithBlock({required this.word});
  final VocabWord word;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    // Each ` · `-separated chunk is one pattern, shown on its own line.
    final patterns = word.goesWithEn
        .split('·')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.link_rounded, size: 16, color: cs.primary),
              const SizedBox(width: 6),
              Text('Often used with',
                  style: PmpTextStyles.label2Regular.copyWith(
                      color: cs.onSurface, fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 8),
          if (word.goesWithNoteEn.isNotEmpty ||
              word.goesWithNoteMm.isNotEmpty) ...[
            BilingualText(
              mm: word.goesWithNoteMm,
              en: word.goesWithNoteEn,
              style: PmpTextStyles.label2Regular,
            ),
            const SizedBox(height: 10),
          ],
          if (patterns.isNotEmpty)
            for (final p in patterns)
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: _PatternLine(pattern: p),
              )
          else
            Text(word.collocations.join('   ·   '),
                style: PmpTextStyles.body2Regular
                    .copyWith(color: cs.onSurface)),
        ],
      ),
    );
  }
}

/// One collocation pattern, e.g. "a great + idea / time / news". The base
/// (before " + ") is emphasized; the slot fillers after it are muted, so the
/// shape of the pattern reads at a glance.
class _PatternLine extends StatelessWidget {
  const _PatternLine({required this.pattern});
  final String pattern;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final base = PmpTextStyles.body2Regular;
    final plus = pattern.indexOf(' + ');
    final List<InlineSpan> spans = plus >= 0
        ? [
            TextSpan(
                text: pattern.substring(0, plus),
                style: base.copyWith(
                    color: cs.onSurface, fontWeight: FontWeight.w600)),
            TextSpan(
                text: pattern.substring(plus),
                style: base.copyWith(color: cs.onSurfaceVariant)),
          ]
        : [TextSpan(text: pattern, style: base.copyWith(color: cs.onSurface))];
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Icon(Icons.circle, size: 5, color: cs.onSurfaceVariant),
        ),
        const SizedBox(width: 8),
        Expanded(child: RichText(text: TextSpan(children: spans))),
      ],
    );
  }
}

class _ExampleRow extends StatelessWidget {
  const _ExampleRow({required this.example, this.audioUrl});
  final VocabExample example;
  final String? audioUrl;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.subdirectory_arrow_right_rounded,
              size: 16, color: cs.onSurfaceVariant),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ExampleText(text: example.en),
                if (example.mm.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 1),
                    child: Text(example.mm,
                        style: PmpTextStyles.label2Regular
                            .copyWith(color: cs.onSurfaceVariant)),
                  ),
              ],
            ),
          ),
          _SpeakButton(
              text: stripExampleMarkup(example.en),
              audioUrl: audioUrl,
              small: true),
        ],
      ),
    );
  }
}

/// Strips the {w}/{c} highlight markup from an example (for TTS / plain use).
String stripExampleMarkup(String s) =>
    s.replaceAll(RegExp(r'\{/?[wc]\}'), '');

/// Renders an example, colouring the target word ({w}…{/w}, cyan) and its
/// collocation partner ({c}…{/c}, orange) so the pairing stands out in context.
class _ExampleText extends StatelessWidget {
  const _ExampleText({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final base =
        PmpTextStyles.body2Regular.copyWith(color: cs.onSurface, height: 1.4);
    final spans = <TextSpan>[];
    final re = RegExp(r'\{(w|c)\}(.*?)\{/\1\}');
    var last = 0;
    for (final m in re.allMatches(text)) {
      if (m.start > last) {
        spans.add(TextSpan(text: text.substring(last, m.start)));
      }
      final color = m.group(1) == 'w' ? cs.primary : PmpColors.brandOrange;
      spans.add(TextSpan(
          text: m.group(2),
          style: base.copyWith(color: color, fontWeight: FontWeight.w700)));
      last = m.end;
    }
    if (last < text.length) spans.add(TextSpan(text: text.substring(last)));
    return Text.rich(TextSpan(style: base, children: spans));
  }
}

class _SpeakButton extends StatelessWidget {
  const _SpeakButton({required this.text, this.audioUrl, this.small = false});
  final String text;
  final String? audioUrl;
  final bool small;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return IconButton(
      visualDensity: VisualDensity.compact,
      iconSize: small ? 18 : 22,
      icon: Icon(Icons.volume_up_rounded, color: cs.primary),
      onPressed: () =>
          VocabTtsService.instance.playUrlOrSpeak(audioUrl, text),
      tooltip: 'Listen',
    );
  }
}

/// The synthesis page: every word's "use it when" rule in one table, plus
/// right-vs-wrong minimal pairs, then the practice CTA.
class _ComparisonPage extends StatelessWidget {
  const _ComparisonPage({required this.group, required this.onPractice});
  final VocabGroup group;
  final VoidCallback onPractice;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                        group.style == 'theme'
                            ? Icons.checklist_rounded
                            : Icons.fact_check_outlined,
                        size: 20,
                        color: cs.primary),
                    const SizedBox(width: 8),
                    Text(
                        group.style != 'theme'
                            ? 'Which one, when?'
                            : group.unit == 'expression'
                                ? 'Expressions in this set'
                                : 'Words in this set',
                        style: PmpTextStyles.title2SemiBold
                            .copyWith(color: cs.onSurface)),
                  ],
                ),
                const SizedBox(height: 14),
                // Recap (theme) / comparison (contrast) — both fall out of the
                // same rows: use-when rule when present, else the meaning.
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: cs.outlineVariant),
                  ),
                  child: Column(
                    children: [
                      for (int i = 0; i < group.words.length; i++) ...[
                        if (i > 0)
                          Divider(height: 1, color: cs.outlineVariant),
                        _CompareRow(word: group.words[i]),
                      ],
                    ],
                  ),
                ),
                if (group.minimalPairs.isNotEmpty) ...[
                  const SizedBox(height: 22),
                  Text('Spot the difference',
                      style: PmpTextStyles.body1Semi
                          .copyWith(color: cs.onSurface)),
                  const SizedBox(height: 10),
                  for (final mp in group.minimalPairs)
                    _MinimalPairCard(pair: mp),
                ],
              ],
            ),
          ),
        ),
        SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: onPractice,
                icon: const Icon(Icons.quiz_outlined),
                label: Text(
                    'Practice these ${group.words.length} ${group.unit == 'expression' ? 'expressions' : 'words'}'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CompareRow extends StatelessWidget {
  const _CompareRow({required this.word});
  final VocabWord word;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 96,
            child: Text(word.word,
                style: PmpTextStyles.body2Semi.copyWith(color: cs.primary)),
          ),
          const SizedBox(width: 10),
          Expanded(
            // Falls back to the word's meaning when there's no use-when rule
            // (theme groups), so the recap shows word -> meaning bilingually.
            child: BilingualText(
              mm: word.useWhenMm.isNotEmpty ? word.useWhenMm : word.shortMm,
              en: word.useWhenEn.isNotEmpty ? word.useWhenEn : word.shortEn,
              style: PmpTextStyles.label2Regular,
            ),
          ),
        ],
      ),
    );
  }
}

class _MinimalPairCard extends StatelessWidget {
  const _MinimalPairCard({required this.pair});
  final VocabMinimalPair pair;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(pair.prompt,
              style: PmpTextStyles.body2Regular
                  .copyWith(color: cs.onSurface, height: 1.4)),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.check_circle, size: 16, color: PmpColors.success500),
              const SizedBox(width: 6),
              Text(pair.right,
                  style: PmpTextStyles.body2Semi
                      .copyWith(color: PmpColors.success500)),
              const SizedBox(width: 16),
              Icon(Icons.cancel, size: 16, color: cs.error),
              const SizedBox(width: 6),
              Text(pair.wrong,
                  style: PmpTextStyles.body2Semi.copyWith(color: cs.error)),
            ],
          ),
          if (pair.why.isNotEmpty || pair.whyMm.isNotEmpty) ...[
            const SizedBox(height: 6),
            BilingualText(
              mm: pair.whyMm,
              en: pair.why,
              style: PmpTextStyles.label2Regular,
            ),
          ],
        ],
      ),
    );
  }
}
