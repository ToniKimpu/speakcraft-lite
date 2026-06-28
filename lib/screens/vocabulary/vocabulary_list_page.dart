import 'package:flutter/material.dart';

import '../../config/pmp_colors.dart';
import '../../config/pmp_routes.dart';
import '../../config/pmp_text_styles.dart';
import '../../model/vocabulary/vocab_loader.dart';
import '../../model/vocabulary/vocab_models.dart';
import '../../repositories/vocabulary/vocab_review_repository.dart';
import '../../shared_widgets/error_retry_view.dart';
import '../../shared_widgets/glass.dart';
import '../../shared_widgets/premium_gate.dart';

/// Vocabulary home — a level selector (Beginner / Intermediate / Upper) on top,
/// each showing its groups, mirroring the Grammar path's leveled shape. Levels
/// with no groups yet render a "coming soon" teaser.
class VocabularyListPage extends StatefulWidget {
  const VocabularyListPage({super.key});

  @override
  State<VocabularyListPage> createState() => _VocabularyListPageState();
}

class _VocabularyListPageState extends State<VocabularyListPage> {
  late Future<List<VocabIndexEntry>> _future;

  @override
  void initState() {
    super.initState();
    _future = loadVocabIndex();
  }

  void _reload() => setState(() => _future = loadVocabIndex());

  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      title: const Text('Vocabulary'),
      body: Column(
        children: [
          const _ReviewCard(),
          Expanded(child: _buildList()),
        ],
      ),
    );
  }

  Widget _buildList() {
    return FutureBuilder<List<VocabIndexEntry>>(
        future: _future,
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            return ErrorRetryView(error: snap.error, onRetry: _reload);
          }
          final groups = snap.data ?? const [];
          if (groups.isEmpty) {
            return const ErrorRetryView(
              isOffline: false,
              title: 'No word sets yet',
              message: 'Check back soon.',
            );
          }
          return _Body(groups: groups);
        },
      );
  }
}

/// Level metadata for the pills + teaser.
class _LevelMeta {
  const _LevelMeta(this.level, this.name, this.subtitle);
  final int level;
  final String name;
  final String subtitle;
}

const _levels = <_LevelMeta>[
  _LevelMeta(1, 'Beginner', 'Everyday high-frequency words'),
  _LevelMeta(2, 'Intermediate', 'Sharper word choice & nuance'),
  _LevelMeta(3, 'Upper', 'Advanced, precise vocabulary'),
];

class _Body extends StatefulWidget {
  const _Body({required this.groups});
  final List<VocabIndexEntry> groups;

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  final _byLevel = <int, List<VocabIndexEntry>>{};
  int _level = 1;

  @override
  void initState() {
    super.initState();
    for (final g in widget.groups) {
      _byLevel.putIfAbsent(g.level, () => []).add(g);
    }
    // Start on the first level that actually has content.
    if (!_byLevel.containsKey(_level) && _byLevel.isNotEmpty) {
      _level = (_byLevel.keys.toList()..sort()).first;
    }
  }

  /// A level reads as "locked" when it has groups, none are free, and the user
  /// isn't premium — so the pill shows a lock before they tap in.
  bool _levelLocked(int level) {
    final groups = _byLevel[level];
    if (groups == null || groups.isEmpty) return false;
    return !hasPremiumAccess() && groups.every((g) => !g.isFree);
  }

  @override
  Widget build(BuildContext context) {
    final groups = _byLevel[_level] ?? const <VocabIndexEntry>[];
    final meta = _levels[_level - 1];
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
            child: Row(
              children: [
                for (final m in _levels) ...[
                  Expanded(
                    child: _LevelPill(
                      label: m.name,
                      selected: m.level == _level,
                      empty: !_byLevel.containsKey(m.level),
                      locked: _levelLocked(m.level),
                      onTap: () => setState(() => _level = m.level),
                    ),
                  ),
                  if (m.level != _levels.last.level) const SizedBox(width: 8),
                ],
              ],
            ),
          ),
          const SizedBox(height: 14),
          Expanded(child: _content(context, groups, meta)),
        ],
      ),
    );
  }

  Widget _content(
      BuildContext context, List<VocabIndexEntry> groups, _LevelMeta meta) {
    if (groups.isEmpty) return _ComingSoon(meta: meta);

    // Group by section, preserving the (already section-sorted) order.
    final sections = <String>[];
    final bySection = <String, List<VocabIndexEntry>>{};
    for (final g in groups) {
      if (!bySection.containsKey(g.section)) {
        bySection[g.section] = [];
        sections.add(g.section);
      }
      bySection[g.section]!.add(g);
    }

    // No real sections → simple list (e.g. Intermediate).
    final hasSections = sections.any((s) => s.isNotEmpty);
    if (!hasSections) return _list(context, groups, meta.subtitle);

    final cs = Theme.of(context).colorScheme;
    return DefaultTabController(
      key: ValueKey(meta.level),
      length: sections.length,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            labelColor: cs.primary,
            unselectedLabelColor: cs.onSurfaceVariant,
            labelStyle: PmpTextStyles.body2Semi,
            unselectedLabelStyle: PmpTextStyles.body2Regular,
            indicatorColor: cs.primary,
            indicatorWeight: 2.5,
            dividerColor: cs.outlineVariant.withValues(alpha: 0.5),
            tabs: [for (final s in sections) Tab(text: s)],
          ),
          Expanded(
            child: TabBarView(
              children: [
                for (final s in sections) _list(context, bySection[s]!, null),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _list(
      BuildContext context, List<VocabIndexEntry> groups, String? subtitle) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 28),
      children: [
        if (subtitle != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(subtitle,
                style: PmpTextStyles.body2Regular.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant)),
          ),
        for (final entry in groups) ...[
          _GroupCard(entry: entry),
          const SizedBox(height: 12),
        ],
      ],
    );
  }
}

class _LevelPill extends StatelessWidget {
  const _LevelPill({
    required this.label,
    required this.selected,
    required this.empty,
    required this.locked,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final bool empty;
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

class _ComingSoon extends StatelessWidget {
  const _ComingSoon({required this.meta});
  final _LevelMeta meta;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.auto_stories_outlined,
                size: 40, color: cs.onSurfaceVariant),
            const SizedBox(height: 14),
            Text(meta.name,
                style: PmpTextStyles.title2SemiBold.copyWith(color: cs.onSurface)),
            const SizedBox(height: 6),
            Text(meta.subtitle,
                textAlign: TextAlign.center,
                style: PmpTextStyles.body2Regular
                    .copyWith(color: cs.onSurfaceVariant)),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: cs.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: cs.outlineVariant),
              ),
              child: Text('Coming soon',
                  style: PmpTextStyles.labelSemi
                      .copyWith(color: cs.onSurfaceVariant)),
            ),
          ],
        ),
      ),
    );
  }
}

/// Home banner for spaced review — live count of words due, tap to review.
class _ReviewCard extends StatefulWidget {
  const _ReviewCard();

  @override
  State<_ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<_ReviewCard> {
  final Stream<int> _due = VocabReviewRepository().watchDueCount();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return StreamBuilder<int>(
      stream: _due,
      builder: (context, snap) {
        final due = snap.data ?? 0;
        final active = due > 0;
        final fg = active ? cs.onPrimary : cs.onSurface;
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: Material(
            color: active ? cs.primary : cs.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(14),
            child: InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: () =>
                  Navigator.pushNamed(context, PmpRoutes.vocabularyReview),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                child: Row(
                  children: [
                    Icon(Icons.refresh_rounded, color: fg),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Review',
                              style:
                                  PmpTextStyles.body1Semi.copyWith(color: fg)),
                          Text(
                            active
                                ? '$due word${due == 1 ? '' : 's'} due to review'
                                : 'Nothing due — keep practising',
                            style: PmpTextStyles.label2Regular.copyWith(
                                color: active
                                    ? cs.onPrimary.withValues(alpha: 0.85)
                                    : cs.onSurfaceVariant),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.chevron_right, color: fg),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _GroupCard extends StatelessWidget {
  const _GroupCard({required this.entry});
  final VocabIndexEntry entry;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final unlocked = isUnlocked(isFree: entry.isFree);
    return GlassCard(
      borderRadius: 16,
      blur: false,
      padding: const EdgeInsets.all(14),
      onTap: () {
        if (unlocked) {
          Navigator.pushNamed(
            context,
            PmpRoutes.vocabularyGroup,
            arguments: {'id': entry.id, 'title': entry.title},
          );
        } else {
          showPremiumSheet(context, featureName: 'This word set');
        }
      },
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: PmpColors.brandCyan.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(unlocked ? Icons.style_outlined : Icons.lock_outline,
                color: unlocked ? cs.primary : cs.onSurfaceVariant),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(entry.title,
                    style:
                        PmpTextStyles.body1Semi.copyWith(color: cs.onSurface)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(entry.theme,
                        style: PmpTextStyles.label2Regular
                            .copyWith(color: cs.onSurfaceVariant)),
                    Text(
                        '  ·  ${entry.wordCount} ${entry.unit == 'expression' ? 'expressions' : 'words'}',
                        style: PmpTextStyles.label2Regular
                            .copyWith(color: cs.onSurfaceVariant)),
                  ],
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
