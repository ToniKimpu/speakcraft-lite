import 'package:flutter/material.dart';

import '../../config/pmp_colors.dart';
import '../../config/pmp_routes.dart';
import '../../config/pmp_text_styles.dart';
import '../../model/speak_your_mind/sym_loader.dart';
import '../../shared_widgets/error_retry_view.dart';
import '../../shared_widgets/glass.dart';
import '../../shared_widgets/premium_gate.dart';

/// Speak Your Mind — the "production bridge" between knowing and using English.
/// Topics are organised into levels; a level-pill selector keeps each level to
/// its own screen (mirroring Vocabulary/Grammar) instead of one long scroll.
class SpeakYourMindPage extends StatefulWidget {
  const SpeakYourMindPage({super.key});

  @override
  State<SpeakYourMindPage> createState() => _SpeakYourMindPageState();
}

class _SpeakYourMindPageState extends State<SpeakYourMindPage> {
  late Future<List<SymTopicIndex>> _future;

  @override
  void initState() {
    super.initState();
    _future = loadSymIndex();
  }

  void _reload() => setState(() => _future = loadSymIndex());

  /// The completion promise shown at the top of each level.
  static const _levelPromise = <int, String>{
    1: "Finish Level 1 → you can introduce yourself and talk about your everyday life.",
    2: "Finish Level 2 → you can tell stories and give your opinions.",
    3: "Finish Level 3 → you can discuss issues and current topics.",
  };

  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      title: const Text('Speak Your Mind'),
      body: FutureBuilder<List<SymTopicIndex>>(
        future: _future,
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            return ErrorRetryView(error: snap.error, onRetry: _reload);
          }
          final topics = snap.data ?? const <SymTopicIndex>[];
          final byLevel = <int, List<SymTopicIndex>>{};
          for (final t in topics) {
            (byLevel[t.level] ??= []).add(t);
          }
          final levels = byLevel.keys.toList()..sort();

          return Column(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
                child: _MyPracticeEntry(),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: levels.isEmpty
                    ? const Center(child: Text('No topics yet'))
                    : _LevelsView(
                        byLevel: byLevel,
                        levels: levels,
                        promises: _levelPromise,
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

/// The level selector + the selected level's topic list. One level on screen at
/// a time, so a long level no longer pushes the others off the bottom.
class _LevelsView extends StatefulWidget {
  const _LevelsView({
    required this.byLevel,
    required this.levels,
    required this.promises,
  });
  final Map<int, List<SymTopicIndex>> byLevel;
  final List<int> levels;
  final Map<int, String> promises;

  @override
  State<_LevelsView> createState() => _LevelsViewState();
}

class _LevelsViewState extends State<_LevelsView> {
  late int _level = widget.levels.first;

  /// A level reads as "locked" when none of its topics are free and the user
  /// isn't premium — so the pill shows a lock before they tap in.
  bool _levelLocked(int level) {
    final topics = widget.byLevel[level];
    if (topics == null || topics.isEmpty) return false;
    return !hasPremiumAccess() && topics.every((t) => !t.isFree);
  }

  @override
  Widget build(BuildContext context) {
    final mm = PmpColors.myanmarGloss(Theme.of(context).brightness);
    final topics = widget.byLevel[_level] ?? const <SymTopicIndex>[];
    final promise = widget.promises[_level] ?? '';
    return SafeArea(
      top: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
            child: Row(
              children: [
                for (final lvl in widget.levels) ...[
                  Expanded(
                    child: _LevelPill(
                      label: 'Level $lvl',
                      selected: lvl == _level,
                      locked: _levelLocked(lvl),
                      onTap: () => setState(() => _level = lvl),
                    ),
                  ),
                  if (lvl != widget.levels.last) const SizedBox(width: 8),
                ],
              ],
            ),
          ),
          const SizedBox(height: 14),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 28),
              children: [
                if (promise.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: Text(promise,
                        style: PmpTextStyles.label2Regular
                            .copyWith(color: mm, height: 1.45)),
                  ),
                for (final t in topics) ...[
                  _TopicCard(topic: t),
                  const SizedBox(height: 12),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LevelPill extends StatelessWidget {
  const _LevelPill({
    required this.label,
    required this.selected,
    required this.locked,
    required this.onTap,
  });
  final String label;
  final bool selected;
  final bool locked;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final bg = selected ? cs.primary : cs.surfaceContainerHighest;
    final fg = selected ? cs.onPrimary : cs.onSurfaceVariant;
    return Material(
      color: bg,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          height: 38,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: selected ? null : Border.all(color: cs.outlineVariant),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (locked) ...[
                Icon(Icons.lock_rounded, size: 13, color: fg),
                const SizedBox(width: 4),
              ],
              Flexible(
                child: Text(label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: PmpTextStyles.labelSemi.copyWith(color: fg)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// The obvious way into saved history — a labelled card (the app-bar icon alone
/// read as "refresh" to learners). Tap → "My practice" list.
class _MyPracticeEntry extends StatelessWidget {
  const _MyPracticeEntry();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final mm = PmpColors.myanmarGloss(Theme.of(context).brightness);
    return GlassCard(
      borderRadius: 16,
      blur: false,
      highlight: true,
      padding: const EdgeInsets.all(14),
      onTap: () =>
          Navigator.pushNamed(context, PmpRoutes.speakYourMindHistory),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: cs.primary.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.history_edu_outlined, color: cs.primary),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('My practice',
                    style:
                        PmpTextStyles.body1Semi.copyWith(color: cs.onSurface)),
                const SizedBox(height: 2),
                Text('ကိုယ်ရေးခဲ့တာတွေ ပြန်ကြည့်ပြီး ထပ်လေ့ကျင့်ရန်',
                    style: PmpTextStyles.label2Regular.copyWith(color: mm)),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: cs.onSurfaceVariant),
        ],
      ),
    );
  }
}

class _TopicCard extends StatelessWidget {
  const _TopicCard({required this.topic});
  final SymTopicIndex topic;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final unlocked = isUnlocked(isFree: topic.isFree);
    return GlassCard(
      borderRadius: 16,
      blur: false,
      padding: const EdgeInsets.all(14),
      onTap: () {
        if (unlocked) {
          Navigator.pushNamed(
            context,
            PmpRoutes.speakYourMindTopic,
            arguments: {'id': topic.id},
          );
        } else {
          showPremiumSheet(context, featureName: topic.titleEn);
        }
      },
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: PmpColors.brandCyan.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(unlocked ? Icons.lightbulb_outline : Icons.lock_outline,
                color: unlocked ? cs.primary : cs.onSurfaceVariant),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(topic.titleEn,
                    style:
                        PmpTextStyles.body1Semi.copyWith(color: cs.onSurface)),
                const SizedBox(height: 4),
                Text(
                  '${topic.moveCount} moves · ${topic.phraseCount} phrases',
                  style: PmpTextStyles.label2Regular
                      .copyWith(color: cs.onSurfaceVariant),
                ),
              ],
            ),
          ),
          unlocked
              ? Icon(Icons.chevron_right, color: cs.onSurfaceVariant)
              : const PremiumLockBadge(),
        ],
      ),
    );
  }
}
