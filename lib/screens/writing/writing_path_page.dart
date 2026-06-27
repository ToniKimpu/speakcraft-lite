import 'dart:async';

import 'package:flutter/material.dart';
import 'package:speakcraft/shared_widgets/glass.dart';
import 'package:speakcraft/shared_widgets/premium_gate.dart';

import '../../config/pmp_colors.dart';
import '../../config/pmp_text_styles.dart';
import '../../config/pmp_routes.dart';
import '../../model/writing/writing_index.dart';
import '../../repositories/writing/writing_progress_repository.dart';

/// Writing module — **Phase-1 path screen** (the module's landing page).
///
/// Level → Section → Unit, loaded from the bundled manifest (`index.json`).
/// A level pill selector sits on top; each authored level shows a progress
/// header + a per-section [TabBar], so each tab lists just its ~5–7 units
/// instead of one long scroll. Levels with no authored units yet (e.g. the
/// IELTS tier) render locked and show a "coming soon" teaser when selected.
/// Published units open the teach page; the rest render muted so the learner
/// still sees the whole journey.
///
/// Inline English chrome for now (intl-ize before ship); authored data is
/// already bilingual.
class WritingPathPage extends StatefulWidget {
  const WritingPathPage({super.key});

  @override
  State<WritingPathPage> createState() => _WritingPathPageState();
}

class _WritingPathPageState extends State<WritingPathPage> {
  late final Future<List<WritingUnitSummary>> _data = loadWritingUnitsIndex();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
            padding: EdgeInsets.only(left: 8), child: GlassBackButton()),
        title: const Text('Grammar'),
      ),
      body: FutureBuilder<List<WritingUnitSummary>>(
        future: _data,
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError || !snap.hasData) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text('Could not load the lessons.\n${snap.error ?? ''}',
                    textAlign: TextAlign.center),
              ),
            );
          }
          return _PathBody(units: snap.data!);
        },
      ),
    );
  }
}

/// One curriculum level's metadata (name + subtitle for the header/teaser).
class _LevelMeta {
  const _LevelMeta(this.level, this.name, this.subtitle);
  final int level;
  final String name;
  final String subtitle;
}

const _levelMetas = <_LevelMeta>[
  _LevelMeta(1, 'Foundation', 'A1–A2 · grammar from the ground up'),
  _LevelMeta(2, 'Building', 'B1 · perfect tenses, modals, conditionals'),
  _LevelMeta(3, 'Advanced', 'B2–C1 · conditionals, passive, clauses'),
];

/// A section of Level 1 — its id (`1.2`), display name and the units under it.
class _Section {
  const _Section({required this.id, required this.name, required this.units});
  final String id;
  final String name;
  final List<WritingUnitSummary> units;
}

class _PathBody extends StatefulWidget {
  const _PathBody({required this.units});
  final List<WritingUnitSummary> units;

  @override
  State<_PathBody> createState() => _PathBodyState();
}

class _PathBodyState extends State<_PathBody> {
  /// Sections per level, and per-level unit totals — grouped once from the
  /// manifest, preserving its order (curriculum sequence).
  final _byLevel = <int, List<_Section>>{};
  final _total = <int, int>{};
  int _level = 1;

  /// Live set of completed unit ids (local Drift), for the green-check states.
  final _progress = WritingProgressRepository();
  StreamSubscription<Set<String>>? _doneSub;
  Set<String> _done = const {};

  @override
  void initState() {
    super.initState();
    final levelOrder = <int>[];
    final sectionOrder = <int, List<String>>{};
    final byLevelSection = <int, Map<String, List<WritingUnitSummary>>>{};
    for (final u in widget.units) {
      if (!byLevelSection.containsKey(u.level)) {
        byLevelSection[u.level] = {};
        sectionOrder[u.level] = [];
        levelOrder.add(u.level);
      }
      final byId = byLevelSection[u.level]!;
      if (!byId.containsKey(u.sectionId)) sectionOrder[u.level]!.add(u.sectionId);
      byId.putIfAbsent(u.sectionId, () => []).add(u);
    }
    for (final lvl in levelOrder) {
      final byId = byLevelSection[lvl]!;
      _byLevel[lvl] = sectionOrder[lvl]!
          .map((id) =>
              _Section(id: id, name: byId[id]!.first.section, units: byId[id]!))
          .toList(growable: false);
      _total[lvl] = byId.values.expand((e) => e).length;
    }
    _doneSub = _progress.watchCompleted().listen((d) {
      if (mounted) setState(() => _done = d);
    });
  }

  @override
  void dispose() {
    _doneSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sections = _byLevel[_level];
    final meta = _levelMetas[_level - 1];
    final premium = hasPremiumAccess();
    // Level 1 is free; Levels 2 & 3 are premium.
    final levelLocked = !isUnlocked(isFree: _level == 1);
    final doneCount = (sections ?? const <_Section>[])
        .expand((s) => s.units)
        .where((u) => _done.contains(u.id))
        .length;
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            child: _LevelSelector(
              selected: _level,
              available: _byLevel.keys.toSet(),
              premium: premium,
              onSelect: (l) => setState(() => _level = l),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: (sections != null && sections.isNotEmpty)
                ? _LevelTabsView(
                    key: ValueKey(_level),
                    meta: meta,
                    sections: sections,
                    done: doneCount,
                    total: _total[_level] ?? 0,
                    completedIds: _done,
                    levelLocked: levelLocked,
                  )
                : _LevelTeaserPanel(meta: meta),
          ),
        ],
      ),
    );
  }
}

/// One level's content: progress header + scrollable section tabs, each listing
/// only that section's units. A fresh [DefaultTabController] (via the [ValueKey]
/// on the level) sizes itself to the level's section count.
class _LevelTabsView extends StatelessWidget {
  const _LevelTabsView({
    super.key,
    required this.meta,
    required this.sections,
    required this.done,
    required this.total,
    required this.completedIds,
    required this.levelLocked,
  });

  final _LevelMeta meta;
  final List<_Section> sections;
  final int done;
  final int total;

  /// Completed unit ids (for the green check) and whether this whole level is
  /// premium-locked for the current user (cards show the lock + paywall tap).
  final Set<String> completedIds;
  final bool levelLocked;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return DefaultTabController(
      length: sections.length,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _LevelHeader(
              name: meta.name,
              subtitle: meta.subtitle,
              done: done,
              total: total,
              locked: levelLocked,
            ),
          ),
          const SizedBox(height: 14),
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
            tabs: [
              for (final s in sections) Tab(text: '${s.id}  ${s.name}'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                for (final s in sections)
                  ListView(
                    padding: const EdgeInsets.fromLTRB(20, 14, 20, 28),
                    children: [
                      for (final u in s.units)
                        _UnitCard(
                          unit: u,
                          done: completedIds.contains(u.id),
                          locked: levelLocked,
                        ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// A pill/segmented selector for the levels, mirroring the guided-lessons
/// pattern. Level 1 is open; locked levels carry a lock and show a teaser.
class _LevelSelector extends StatelessWidget {
  const _LevelSelector({
    required this.selected,
    required this.available,
    required this.premium,
    required this.onSelect,
  });
  final int selected;

  /// The levels that actually have authored units in the manifest. A level with
  /// no content renders locked (a "coming soon" teaser on tap).
  final Set<int> available;

  /// Whether the current user has premium. Levels 2 & 3 are premium, so their
  /// pills carry a lock for free users (the level still opens, but its units
  /// are locked — a soft paywall).
  final bool premium;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (final m in _levelMetas) ...[
          Expanded(
            child: _LevelPill(
              label: 'Level ${m.level}',
              selected: m.level == selected,
              locked: !available.contains(m.level) ||
                  (m.level >= 2 && !premium),
              onTap: () => onSelect(m.level),
            ),
          ),
          if (m.level != _levelMetas.last.level) const SizedBox(width: 8),
        ],
      ],
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
            border: selected
                ? null
                : Border.all(color: cs.outlineVariant),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (locked) ...[
                Icon(Icons.lock_outline_rounded, size: 13, color: fg),
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

/// Shown when a locked level's pill is selected — a "coming soon" panel reusing
/// the level's name/subtitle.
class _LevelTeaserPanel extends StatelessWidget {
  const _LevelTeaserPanel({required this.meta});
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
            Icon(Icons.lock_outline_rounded,
                size: 40, color: cs.onSurfaceVariant),
            const SizedBox(height: 14),
            Text('Level ${meta.level} · ${meta.name}',
                textAlign: TextAlign.center,
                style: PmpTextStyles.h2.copyWith(color: cs.onSurface)),
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

class _LevelHeader extends StatelessWidget {
  const _LevelHeader({
    required this.name,
    required this.subtitle,
    required this.done,
    required this.total,
    required this.locked,
  });

  final String name;
  final String subtitle;
  final int done;
  final int total;
  final bool locked;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name,
            style: PmpTextStyles.h2.copyWith(
                color: cs.onSurface, fontFamily: 'ArchivoBlack Regular')),
        const SizedBox(height: 2),
        Text(subtitle,
            style:
                PmpTextStyles.body2Regular.copyWith(color: cs.onSurfaceVariant)),
        const SizedBox(height: 10),
        // For a premium-locked level, show the unlock prompt instead of a
        // 0-progress bar (the learner can't make progress until they upgrade).
        if (locked)
          Row(
            children: [
              const Icon(Icons.lock_rounded,
                  size: 14, color: PmpColors.premiumGoldDeep),
              const SizedBox(width: 6),
              Text('Premium — unlock to start',
                  style: PmpTextStyles.sub.copyWith(
                      color: PmpColors.premiumGoldDeep,
                      fontWeight: FontWeight.w700)),
            ],
          )
        else ...[
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: total == 0 ? 0 : done / total,
              minHeight: 6,
              backgroundColor: cs.surfaceContainerHighest,
              valueColor: const AlwaysStoppedAnimation<Color>(
                  PmpColors.brandOrange),
            ),
          ),
          const SizedBox(height: 6),
          Text('$done of $total done',
              style: PmpTextStyles.sub.copyWith(color: cs.onSurfaceVariant)),
        ],
      ],
    );
  }
}

class _UnitCard extends StatelessWidget {
  const _UnitCard({
    required this.unit,
    required this.done,
    required this.locked,
  });
  final WritingUnitSummary unit;

  /// Completed (green check, still redoable).
  final bool done;

  /// Premium-locked (this level is paid and the user is free) → paywall on tap.
  final bool locked;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final mm = PmpColors.myanmarGloss(Theme.of(context).brightness);
    final published = unit.isOpen;

    // State → leading icon + accent + whether the row reads as muted.
    final IconData leadingIcon;
    final Color accent;
    final bool muted;
    if (!published) {
      leadingIcon = Icons.lock_outline_rounded;
      accent = cs.onSurfaceVariant;
      muted = true;
    } else if (locked) {
      leadingIcon = Icons.lock_rounded;
      accent = PmpColors.premiumGoldDeep;
      muted = true;
    } else if (done) {
      leadingIcon = Icons.check_rounded;
      accent = PmpColors.success500;
      muted = false;
    } else {
      leadingIcon = Icons.play_arrow_rounded;
      accent = cs.primary;
      muted = false;
    }

    final card = Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: muted
            ? cs.surfaceContainerHighest.withValues(alpha: 0.5)
            : cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
            color: muted
                ? cs.outlineVariant.withValues(alpha: 0.5)
                : cs.outlineVariant),
      ),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.14),
              shape: BoxShape.circle,
            ),
            child: Icon(leadingIcon, size: 18, color: accent),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(unit.title,
                    style: PmpTextStyles.body1Semi.copyWith(
                        color: muted
                            ? cs.onSurface.withValues(alpha: 0.55)
                            : cs.onSurface)),
                if (published && unit.subtitleMm.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(unit.subtitleMm,
                        style: PmpTextStyles.sub.copyWith(color: mm)),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // Trailing affordance by state.
          if (!published)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: cs.outlineVariant.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text('soon',
                  style:
                      PmpTextStyles.sub.copyWith(color: cs.onSurfaceVariant)),
            )
          else if (locked)
            const PremiumLockBadge()
          else
            Icon(Icons.chevron_right_rounded, color: cs.onSurfaceVariant),
        ],
      ),
    );

    final VoidCallback? onTap = !published
        ? null
        : locked
            ? () => showPremiumSheet(context, featureName: 'Level ${unit.level}')
            : () => Navigator.pushNamed(
                  context,
                  PmpRoutes.writingTeachSteps,
                  arguments: {'id': unit.id},
                );

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: onTap == null
          ? card
          : Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(14),
                onTap: onTap,
                child: card,
              ),
            ),
    );
  }
}
