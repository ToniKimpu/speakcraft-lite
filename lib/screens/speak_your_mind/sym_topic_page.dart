import 'package:flutter/material.dart';

import '../../config/pmp_colors.dart';
import '../../config/pmp_routes.dart';
import '../../config/pmp_text_styles.dart';
import '../../model/speak_your_mind/sym_loader.dart';
import '../../model/speak_your_mind/sym_models.dart';
import '../../services/vocab_tts_service.dart';
import '../../shared_widgets/error_retry_view.dart';
import '../../shared_widgets/glass.dart';
import '../vocabulary/widgets/bilingual_text.dart';
import 'widgets/sym_toolbox.dart';

/// A topic's **toolbox** — the reference the learner returns to. Each move is a
/// communicative function with a few reusable chunks (the pattern highlighted +
/// swappable fillers + audio + a Burmese gloss). A sticky CTA leads into the
/// produce step, where they write about their own life.
class SymTopicPage extends StatefulWidget {
  const SymTopicPage({super.key, required this.topicId});
  final String topicId;

  @override
  State<SymTopicPage> createState() => _SymTopicPageState();
}

class _SymTopicPageState extends State<SymTopicPage> {
  SymTopic? _topic;
  Object? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final t = await loadSymTopic(widget.topicId);
      if (mounted) setState(() => _topic = t);
    } catch (e) {
      if (mounted) setState(() => _error = e);
    }
  }

  @override
  void dispose() {
    VocabTtsService.instance.stop();
    super.dispose();
  }

  void _openProduce() {
    Navigator.pushNamed(
      context,
      PmpRoutes.speakYourMindProduce,
      arguments: {'id': widget.topicId},
    );
  }

  void _openGuide() {
    Navigator.pushNamed(
      context,
      PmpRoutes.speakYourMindGuide,
      arguments: {'id': widget.topicId},
    );
  }

  @override
  Widget build(BuildContext context) {
    final topic = _topic;
    return GlassScaffold(
      title: Text(topic?.titleEn ?? 'Speak Your Mind'),
      body: _error != null
          ? ErrorRetryView(
              error: _error,
              onRetry: () {
                setState(() => _error = null);
                _load();
              },
            )
          : topic == null
              ? const Center(child: CircularProgressIndicator())
              : _Body(
                  topic: topic,
                  onProduce: _openProduce,
                  onGuide: _openGuide,
                ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    required this.topic,
    required this.onProduce,
    required this.onGuide,
  });
  final SymTopic topic;
  final VoidCallback onProduce;
  final VoidCallback onGuide;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final dark = Theme.of(context).brightness == Brightness.dark;
    final bg1 = dark ? PmpColors.glassDarkBg1 : PmpColors.glassLightBg1;
    return Stack(
      children: [
        ListView(
          padding: EdgeInsets.fromLTRB(16, 12, 16, topic.hasGuide ? 168 : 108),
          children: [
            _TopicHeader(topic: topic),
            const SizedBox(height: 18),
            Text('Your toolbox',
                style: PmpTextStyles.labelSemi.copyWith(color: cs.primary)),
            const SizedBox(height: 4),
            Text(
              '${topic.toolbox.length} moves to talk about ${topic.titleEn.toLowerCase()}',
              style: PmpTextStyles.body1Semi.copyWith(color: cs.onSurface),
            ),
            const SizedBox(height: 14),
            SymToolboxList(moves: topic.toolbox),
          ],
        ),
        // Sticky CTAs: a step-by-step guide for the stuck, then the direct
        // write. A bottom gradient fades the scrolling list out behind them so
        // the buttons stay clearly readable instead of bleeding into content.
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            padding: const EdgeInsets.fromLTRB(16, 28, 16, 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  bg1.withValues(alpha: 0),
                  bg1.withValues(alpha: 0.85),
                  bg1,
                ],
                stops: const [0, 0.5, 1],
              ),
            ),
            child: SafeArea(
              top: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (topic.hasGuide) ...[
                    _GuideCta(onTap: onGuide),
                    const SizedBox(height: 10),
                  ],
                  _ProduceCta(onTap: onProduce),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// For the learner who feels stuck after browsing — a step-by-step on-ramp that
/// builds their first draft from fill-in blanks, then hands it to the writer.
class _GuideCta extends StatelessWidget {
  const _GuideCta({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    // Solid, fully opaque accent (distinct from the cyan "write" button) so it
    // stays clearly readable even as the toolbox list scrolls behind it.
    return FilledButton.icon(
      onPressed: onTap,
      style: FilledButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
        backgroundColor: PmpColors.brandOrange,
        foregroundColor: Colors.white,
        textStyle: PmpTextStyles.body1Semi,
      ),
      icon: const Icon(Icons.auto_stories_outlined),
      label: const Text('Not sure? Guide me step by step'),
    );
  }
}

class _TopicHeader extends StatelessWidget {
  const _TopicHeader({required this.topic});
  final SymTopic topic;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GlassCard(
      blur: false,
      highlight: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.workspace_premium_outlined,
                  size: 16, color: cs.primary),
              const SizedBox(width: 6),
              Expanded(
                child: Text(topic.domainEn.toUpperCase(),
                    style: PmpTextStyles.labelSemi
                        .copyWith(color: cs.primary, letterSpacing: 0.4)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          BilingualText(
            mm: topic.promiseMm,
            en: topic.promiseEn,
            style: PmpTextStyles.body2Semi,
            long: true,
          ),
          const SizedBox(height: 10),
          Text(topic.introMm,
              style: PmpTextStyles.label2Regular.copyWith(
                  color: PmpColors.myanmarGloss(Theme.of(context).brightness),
                  height: 1.55)),
        ],
      ),
    );
  }
}

class _ProduceCta extends StatelessWidget {
  const _ProduceCta({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: onTap,
      style: FilledButton.styleFrom(
        minimumSize: const Size.fromHeight(52),
        textStyle: PmpTextStyles.body1Semi,
      ),
      icon: const Icon(Icons.edit_outlined),
      label: const Text('Now write your own'),
    );
  }
}
