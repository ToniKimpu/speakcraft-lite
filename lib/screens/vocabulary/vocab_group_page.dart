import 'package:flutter/material.dart';

import '../../config/pmp_colors.dart';
import '../../config/pmp_routes.dart';
import '../../config/pmp_text_styles.dart';
import '../../model/vocabulary/vocab_loader.dart';
import '../../model/vocabulary/vocab_models.dart';
import '../../services/vocab_tts_service.dart';
import '../../shared_widgets/error_retry_view.dart';
import '../../shared_widgets/glass.dart';

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
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final g = await loadVocabGroup(widget.groupId);
      if (mounted) setState(() => _group = g);
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
          IconButton(
            tooltip: 'Compare all',
            icon: const Icon(Icons.table_rows_rounded),
            onPressed: () => _controller.animateToPage(
              _comparisonIndex,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            ),
          ),
      ],
      body: _error != null
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
                          for (final word in group.words)
                            _WordPage(word: word),
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
                    _Dots(count: _pageCount, active: _page),
                  ],
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
                    Text('Why these go together',
                        style: PmpTextStyles.body1Semi
                            .copyWith(color: cs.onSurface)),
                  ],
                ),
                const SizedBox(height: 8),
                Text(group.whyGroupedEn,
                    style: PmpTextStyles.body2Regular
                        .copyWith(color: cs.onSurface, height: 1.5)),
                if (group.whyGroupedMm.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(group.whyGroupedMm,
                      style: PmpTextStyles.label2Regular
                          .copyWith(color: cs.onSurfaceVariant, height: 1.5)),
                ],
              ],
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Icon(Icons.swipe_left_alt_rounded,
                  size: 18, color: cs.onSurfaceVariant),
              const SizedBox(width: 8),
              Text('Swipe to meet the ${group.words.length} words',
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
  const _WordPage({required this.word});
  final VocabWord word;

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
              _SpeakButton(text: word.word),
            ],
          ),
          if (word.ipa.isNotEmpty)
            Text(word.ipa,
                style: PmpTextStyles.label2Regular
                    .copyWith(color: cs.onSurfaceVariant)),
          const SizedBox(height: 4),
          Text(word.shortEn,
              style: PmpTextStyles.body2Semi.copyWith(color: cs.onSurface)),

          // The decision rule — the takeaway, up top.
          if (word.useWhenEn.isNotEmpty) ...[
            const SizedBox(height: 16),
            _Callout(
              icon: Icons.check_circle_outline,
              color: PmpColors.success500,
              label: 'Use it when',
              text: word.useWhenEn,
            ),
          ],

          // Often used with — the collocation/partners block.
          if (word.goesWithEn.isNotEmpty || word.collocations.isNotEmpty) ...[
            const SizedBox(height: 10),
            _GoesWithBlock(word: word),
          ],

          if (word.explanationEn.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text(word.explanationEn,
                style: PmpTextStyles.body2Regular
                    .copyWith(color: cs.onSurface, height: 1.5)),
          ],
          if (word.nuanceEn.isNotEmpty) ...[
            const SizedBox(height: 12),
            _Callout(
              icon: Icons.priority_high_rounded,
              color: PmpColors.brandOrange,
              label: 'Watch out',
              text: word.nuanceEn,
            ),
          ],
          if (word.examples.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text('Examples',
                style: PmpTextStyles.label2Regular
                    .copyWith(color: cs.onSurfaceVariant)),
            const SizedBox(height: 6),
            for (final ex in word.examples) _ExampleRow(example: ex),
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
    required this.text,
  });

  final IconData icon;
  final Color color;
  final String label;
  final String text;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
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
          Text(text,
              style: PmpTextStyles.body2Regular
                  .copyWith(color: cs.onSurface, height: 1.4)),
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
          if (word.goesWithEn.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(word.goesWithEn,
                style: PmpTextStyles.body2Regular
                    .copyWith(color: cs.onSurface, height: 1.4)),
          ],
          if (word.collocations.isNotEmpty) ...[
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                for (final c in word.collocations)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: cs.surface.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: cs.outlineVariant),
                    ),
                    child: Text(c,
                        style: PmpTextStyles.label2Regular
                            .copyWith(color: cs.onSurfaceVariant)),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _ExampleRow extends StatelessWidget {
  const _ExampleRow({required this.example});
  final VocabExample example;

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
                Text(example.en,
                    style: PmpTextStyles.body2Regular
                        .copyWith(color: cs.onSurface, height: 1.4)),
                if (example.mm.isNotEmpty)
                  Text(example.mm,
                      style: PmpTextStyles.label2Regular
                          .copyWith(color: cs.onSurfaceVariant)),
              ],
            ),
          ),
          _SpeakButton(text: example.en, small: true),
        ],
      ),
    );
  }
}

class _SpeakButton extends StatelessWidget {
  const _SpeakButton({required this.text, this.small = false});
  final String text;
  final bool small;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return IconButton(
      visualDensity: VisualDensity.compact,
      iconSize: small ? 18 : 22,
      icon: Icon(Icons.volume_up_rounded, color: cs.primary),
      onPressed: () => VocabTtsService.instance.speak(text),
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
                    Icon(Icons.fact_check_outlined, size: 20, color: cs.primary),
                    const SizedBox(width: 8),
                    Text('Which one, when?',
                        style: PmpTextStyles.title2SemiBold
                            .copyWith(color: cs.onSurface)),
                  ],
                ),
                const SizedBox(height: 14),
                // Comparison table — generated from each word's use-when rule.
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
                label: Text('Practice these ${group.words.length} words'),
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
            child: Text(
              word.useWhenEn.isNotEmpty ? word.useWhenEn : word.shortEn,
              style: PmpTextStyles.label2Regular
                  .copyWith(color: cs.onSurface, height: 1.35),
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
          if (pair.why.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(pair.why,
                style: PmpTextStyles.label2Regular
                    .copyWith(color: cs.onSurfaceVariant, height: 1.35)),
          ],
        ],
      ),
    );
  }
}
