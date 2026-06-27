import 'package:flutter/material.dart';

import '../../config/pmp_colors.dart';
import '../../config/pmp_routes.dart';
import '../../config/pmp_text_styles.dart';
import '../../model/vocabulary/vocab_loader.dart';
import '../../model/vocabulary/vocab_models.dart';
import '../../services/vocab_tts_service.dart';
import '../../shared_widgets/error_retry_view.dart';
import '../../shared_widgets/glass.dart';

/// The "learn" screen for one group: the why-grouped framing, then a card per
/// word (definition + nuance + examples), then a button into the contrast
/// practice. Audio is on-device TTS in the prototype.
class VocabGroupPage extends StatefulWidget {
  const VocabGroupPage({super.key, required this.groupId, this.title});

  final String groupId;
  final String? title;

  @override
  State<VocabGroupPage> createState() => _VocabGroupPageState();
}

class _VocabGroupPageState extends State<VocabGroupPage> {
  late Future<VocabGroup> _future;

  @override
  void initState() {
    super.initState();
    _future = loadVocabGroup(widget.groupId);
  }

  void _reload() => setState(() => _future = loadVocabGroup(widget.groupId));

  @override
  void dispose() {
    VocabTtsService.instance.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      title: Text(widget.title ?? 'Vocabulary'),
      body: FutureBuilder<VocabGroup>(
        future: _future,
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError || !snap.hasData) {
            return ErrorRetryView(error: snap.error, onRetry: _reload);
          }
          final group = snap.data!;
          return Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                  children: [
                    _WhyGroupedCard(group: group),
                    const SizedBox(height: 16),
                    for (final word in group.words) ...[
                      _WordCard(word: word),
                      const SizedBox(height: 14),
                    ],
                  ],
                ),
              ),
              if (group.exercises.isNotEmpty)
                _PracticeBar(group: group),
            ],
          );
        },
      ),
    );
  }
}

class _WhyGroupedCard extends StatelessWidget {
  const _WhyGroupedCard({required this.group});
  final VocabGroup group;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
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
        border: Border.all(color: PmpColors.brandCyan.withValues(alpha: 0.22)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb_outline, size: 18, color: cs.primary),
              const SizedBox(width: 8),
              Expanded(
                child: Text('Why these go together',
                    style:
                        PmpTextStyles.body1Semi.copyWith(color: cs.onSurface)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(group.whyGroupedEn,
              style: PmpTextStyles.body2Regular
                  .copyWith(color: cs.onSurface, height: 1.45)),
          if (group.whyGroupedMm.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(group.whyGroupedMm,
                style: PmpTextStyles.label2Regular
                    .copyWith(color: cs.onSurfaceVariant, height: 1.5)),
          ],
        ],
      ),
    );
  }
}

class _WordCard extends StatelessWidget {
  const _WordCard({required this.word});
  final VocabWord word;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Headword + speak button.
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 8,
                  children: [
                    Text(word.word,
                        style: PmpTextStyles.title2SemiBold
                            .copyWith(color: cs.onSurface)),
                    if (word.pos.isNotEmpty)
                      Text(word.pos,
                          style: PmpTextStyles.label2Regular.copyWith(
                              color: cs.primary,
                              fontStyle: FontStyle.italic)),
                  ],
                ),
              ),
              _SpeakButton(text: word.word),
            ],
          ),
          if (word.ipa.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(word.ipa,
                  style: PmpTextStyles.label2Regular
                      .copyWith(color: cs.onSurfaceVariant)),
            ),
          const SizedBox(height: 10),
          // Short meaning.
          Text(word.shortEn,
              style: PmpTextStyles.body2Semi.copyWith(color: cs.onSurface)),
          if (word.shortMm.isNotEmpty)
            Text(word.shortMm,
                style: PmpTextStyles.label2Regular
                    .copyWith(color: cs.onSurfaceVariant)),
          if (word.explanationEn.isNotEmpty) ...[
            const SizedBox(height: 10),
            Text(word.explanationEn,
                style: PmpTextStyles.body2Regular
                    .copyWith(color: cs.onSurface, height: 1.45)),
          ],
          if (word.nuanceEn.isNotEmpty) ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: PmpColors.brandOrange.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.priority_high_rounded,
                      size: 16, color: PmpColors.brandOrange),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(word.nuanceEn,
                        style: PmpTextStyles.label2Regular.copyWith(
                            color: cs.onSurface, height: 1.4)),
                  ),
                ],
              ),
            ),
          ],
          if (word.examples.isNotEmpty) ...[
            const SizedBox(height: 12),
            for (final ex in word.examples) _ExampleRow(example: ex),
          ],
          if (word.collocations.isNotEmpty) ...[
            const SizedBox(height: 10),
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
          if (word.confuseWith.isNotEmpty) ...[
            const SizedBox(height: 10),
            Text('Don\'t confuse with: ${word.confuseWith.join(", ")}',
                style: PmpTextStyles.label2Regular.copyWith(
                    color: cs.error, fontStyle: FontStyle.italic)),
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

class _PracticeBar extends StatelessWidget {
  const _PracticeBar({required this.group});
  final VocabGroup group;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
        child: SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: () => Navigator.pushNamed(
              context,
              PmpRoutes.vocabularyPractice,
              arguments: {'group': group},
            ),
            icon: const Icon(Icons.quiz_outlined),
            label: Text('Practice these ${group.words.length} words'),
          ),
        ),
      ),
    );
  }
}
