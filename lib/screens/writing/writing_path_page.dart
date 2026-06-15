import 'package:flutter/material.dart';

import '../../config/pmp_colors.dart';
import '../../config/pmp_text_styles.dart';
import '../../config/pmp_routes.dart';
import '../../model/writing/writing_index.dart';

/// Writing module — **Phase-1 path screen** (the module's landing page).
///
/// A single scrolling path: Level → Section → Unit cards, loaded from the
/// bundled manifest (`index.json`). Published units are tappable and open the
/// teach page; the rest render as muted "coming soon" cards so the learner sees
/// the whole journey. Levels 2–3 show as teaser banners until authored.
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
      appBar: AppBar(title: const Text('Writing')),
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

class _PathBody extends StatelessWidget {
  const _PathBody({required this.units});
  final List<WritingUnitSummary> units;

  @override
  Widget build(BuildContext context) {
    // Level 1 units, grouped into sections preserving manifest order.
    final l1 = units.where((u) => u.level == 1).toList(growable: false);
    final sections = <String, List<WritingUnitSummary>>{};
    for (final u in l1) {
      sections.putIfAbsent('${u.sectionId}  ${u.section}', () => []).add(u);
    }
    final openCount = l1.where((u) => u.isOpen).length;

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
        children: [
          _LevelHeader(
            level: 1,
            name: 'Foundation',
            subtitle: 'A1–A2 · grammar from the ground up',
            done: openCount,
            total: l1.length,
          ),
          const SizedBox(height: 16),
          for (final entry in sections.entries) ...[
            _SectionHeader(label: entry.key),
            const SizedBox(height: 8),
            for (final u in entry.value) _UnitCard(unit: u),
            const SizedBox(height: 14),
          ],
          const SizedBox(height: 4),
          const _LevelTeaser(
            level: 2,
            name: 'Building',
            subtitle: 'B1 · perfect tenses, modals, conditionals',
          ),
          const SizedBox(height: 10),
          const _LevelTeaser(
            level: 3,
            name: 'Advanced & IELTS',
            subtitle: 'B2–C1 · passive, clauses, IELTS writing',
          ),
        ],
      ),
    );
  }
}

class _LevelHeader extends StatelessWidget {
  const _LevelHeader({
    required this.level,
    required this.name,
    required this.subtitle,
    required this.done,
    required this.total,
  });

  final int level;
  final String name;
  final String subtitle;
  final int done;
  final int total;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('LEVEL $level',
            style: PmpTextStyles.labelSemi
                .copyWith(color: cs.primary, letterSpacing: 1.0)),
        const SizedBox(height: 2),
        Text(name,
            style: PmpTextStyles.h1.copyWith(
                color: cs.onSurface, fontFamily: 'ArchivoBlack Regular')),
        const SizedBox(height: 4),
        Text(subtitle,
            style:
                PmpTextStyles.body2Regular.copyWith(color: cs.onSurfaceVariant)),
        const SizedBox(height: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: LinearProgressIndicator(
            value: total == 0 ? 0 : done / total,
            minHeight: 6,
            backgroundColor: cs.surfaceContainerHighest,
            valueColor: AlwaysStoppedAnimation<Color>(cs.primary),
          ),
        ),
        const SizedBox(height: 6),
        Text('$done of $total lessons ready',
            style: PmpTextStyles.sub.copyWith(color: cs.onSurfaceVariant)),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(top: 6, bottom: 2),
      child: Text(label.toUpperCase(),
          style: PmpTextStyles.labelSemi
              .copyWith(color: cs.onSurfaceVariant, letterSpacing: 0.6)),
    );
  }
}

class _UnitCard extends StatelessWidget {
  const _UnitCard({required this.unit});
  final WritingUnitSummary unit;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final open = unit.isOpen;
    final mm = PmpColors.myanmarGloss(Theme.of(context).brightness);

    final card = Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: open
            ? cs.surfaceContainerHighest
            : cs.surfaceContainerHighest.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
            color: open ? cs.outlineVariant : cs.outlineVariant.withValues(alpha: 0.5)),
      ),
      child: Row(
        children: [
          // Leading status dot / check.
          Container(
            width: 30,
            height: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: open
                  ? cs.primary.withValues(alpha: 0.12)
                  : cs.outlineVariant.withValues(alpha: 0.4),
              shape: BoxShape.circle,
            ),
            child: Icon(
              open ? Icons.play_arrow_rounded : Icons.lock_outline_rounded,
              size: 18,
              color: open ? cs.primary : cs.onSurfaceVariant,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(unit.title,
                    style: PmpTextStyles.body1Semi.copyWith(
                        color: open
                            ? cs.onSurface
                            : cs.onSurface.withValues(alpha: 0.55))),
                if (open && unit.subtitleMm.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(unit.subtitleMm,
                        style: PmpTextStyles.sub.copyWith(color: mm)),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          if (open)
            Icon(Icons.chevron_right_rounded, color: cs.onSurfaceVariant)
          else
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: cs.outlineVariant.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text('soon',
                  style: PmpTextStyles.sub.copyWith(color: cs.onSurfaceVariant)),
            ),
        ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: open
          ? Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(14),
                onTap: () => Navigator.pushNamed(
                  context,
                  PmpRoutes.writingTeach,
                  arguments: {'asset': unit.asset},
                ),
                child: card,
              ),
            )
          : card,
    );
  }
}

/// A whole-level "coming soon" banner for levels not yet authored.
class _LevelTeaser extends StatelessWidget {
  const _LevelTeaser({
    required this.level,
    required this.name,
    required this.subtitle,
  });

  final int level;
  final String name;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.5)),
      ),
      child: Row(
        children: [
          Icon(Icons.lock_outline_rounded, size: 18, color: cs.onSurfaceVariant),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Level $level · $name',
                    style: PmpTextStyles.body1Semi.copyWith(
                        color: cs.onSurface.withValues(alpha: 0.7))),
                const SizedBox(height: 2),
                Text(subtitle,
                    style:
                        PmpTextStyles.sub.copyWith(color: cs.onSurfaceVariant)),
              ],
            ),
          ),
          Text('soon',
              style: PmpTextStyles.sub.copyWith(color: cs.onSurfaceVariant)),
        ],
      ),
    );
  }
}
