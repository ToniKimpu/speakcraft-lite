import 'dart:convert';

import 'package:flutter/material.dart';

import '../../config/pmp_colors.dart';
import '../../config/pmp_routes.dart';
import '../../config/pmp_text_styles.dart';
import '../../model/speak_your_mind/sym_loader.dart';
import '../../model/speak_your_mind/sym_version.dart';
import '../../repositories/speak_your_mind/sym_session_repository.dart';
import '../../services/app_database/app_database.dart';
import '../../shared_widgets/error_retry_view.dart';
import '../../shared_widgets/glass.dart';

/// "My practice" — every saved produce attempt as a compact tile (score + topic
/// + version chips). Tapping a tile (or a v1/v2 chip) opens the full detail.
/// All local; nothing leaves the phone.
class SymHistoryPage extends StatefulWidget {
  const SymHistoryPage({super.key});

  @override
  State<SymHistoryPage> createState() => _SymHistoryPageState();
}

class _SymHistoryPageState extends State<SymHistoryPage> {
  final SymSessionRepository _repo = SymSessionRepository();

  // Held in state (not a Future) so returning from detail can update the list
  // in place — no full-screen spinner flash, and a delete/new version shows
  // immediately. Topic titles are loaded once (they don't change).
  Map<String, String> _titles = const {};
  List<SymSessionTableData> _rows = const [];
  bool _loading = true;
  Object? _error;

  @override
  void initState() {
    super.initState();
    _loadInitial();
  }

  Future<void> _loadInitial() async {
    try {
      final topics = await loadSymTopics();
      final rows = await _repo.listAll();
      if (!mounted) return;
      setState(() {
        _titles = {for (final t in topics) t.id: t.titleEn};
        _rows = rows;
        _loading = false;
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e;
          _loading = false;
        });
      }
    }
  }

  /// Re-query rows only, keeping the current list visible (no spinner). Used
  /// after a "Polish & retry" appended a version, so the new chain shows at once.
  Future<void> _refreshRows() async {
    try {
      final rows = await _repo.listAll();
      if (mounted) setState(() => _rows = rows);
    } catch (_) {}
  }

  Future<void> _open(
      SymSessionTableData row, String title, int versionIndex) async {
    final result = await Navigator.pushNamed(
      context,
      PmpRoutes.speakYourMindSessionDetail,
      arguments: {'row': row, 'title': title, 'index': versionIndex},
    );
    if (!mounted) return;
    if (result is int) {
      // Detail returned the id it deleted — drop it instantly, no re-query.
      setState(() => _rows = _rows.where((r) => r.id != result).toList());
    } else {
      // Came back normally (maybe after a polish & retry) — sync the chain.
      await _refreshRows();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      title: const Text('My practice'),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return ErrorRetryView(
        error: _error,
        onRetry: () {
          setState(() {
            _loading = true;
            _error = null;
          });
          _loadInitial();
        },
      );
    }
    if (_rows.isEmpty) return const _EmptyState();

    // Group attempts under their topic, preserving newest-first order: a
    // topic's section appears where its most recent attempt falls, and the
    // attempts within stay newest-first (rows arrive sorted).
    final groups = <String, List<SymSessionTableData>>{};
    final order = <String>[];
    for (final row in _rows) {
      if (!groups.containsKey(row.topicId)) order.add(row.topicId);
      (groups[row.topicId] ??= []).add(row);
    }
    final totalChecks = _rows.fold<int>(0, (sum, r) => sum + r.versions);

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
      children: [
        _UsageHeader(sessions: _rows.length, checks: totalChecks),
        const SizedBox(height: 14),
        for (final topicId in order) ...[
          _TopicSectionHeader(
            title: _titles[topicId] ?? topicId,
            attempts: groups[topicId]!.length,
          ),
          const SizedBox(height: 10),
          for (final row in groups[topicId]!) ...[
            _SessionTile(
              row: row,
              onOpen: (idx) => _open(row, _titles[topicId] ?? topicId, idx),
            ),
            const SizedBox(height: 10),
          ],
          const SizedBox(height: 8),
        ],
      ],
    );
  }
}

/// Parse the version chain from a row (fallback: a single version from the
/// summary columns).
List<SymVersion> versionsOf(SymSessionTableData row) {
  final raw = row.versionsJson;
  if (raw != null && raw.trim().isNotEmpty) {
    try {
      final list = (jsonDecode(raw) as List)
          .map((e) => SymVersion.fromJson((e as Map).cast<String, dynamic>()))
          .toList()
        ..sort((a, b) => a.version.compareTo(b.version));
      if (list.isNotEmpty) return list;
    } catch (_) {}
  }
  return [
    SymVersion(
      version: 1,
      text: row.finalText,
      score: row.score ?? 0,
      band: row.band ?? 'good',
      naturalVersion: row.naturalVersion ?? '',
      tokens: row.tokens,
    ),
  ];
}

({Color color, String label}) bandOf(String band, int score) {
  final b = band.isNotEmpty
      ? band
      : (score >= 85 ? 'great' : (score >= 65 ? 'good' : 'keep_going'));
  return switch (b) {
    'great' => (color: PmpColors.success500, label: 'Great'),
    'keep_going' => (color: PmpColors.brandOrange, label: 'Keep going'),
    _ => (color: PmpColors.brandCyan, label: 'Good'),
  };
}

class _UsageHeader extends StatelessWidget {
  const _UsageHeader({required this.sessions, required this.checks});
  final int sessions;

  /// Total AI feedback checks across all sessions (one per saved version).
  final int checks;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GlassCard(
      blur: false,
      highlight: true,
      child: Row(
        children: [
          _Stat(value: '$sessions', label: 'sessions'),
          Container(
            width: 1,
            height: 34,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            color: cs.outlineVariant,
          ),
          _Stat(value: '$checks', label: 'AI checks'),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label});
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value,
            style: PmpTextStyles.title1SemiBold.copyWith(color: cs.primary)),
        Text(label,
            style: PmpTextStyles.label2Regular
                .copyWith(color: cs.onSurfaceVariant)),
      ],
    );
  }
}

/// A topic's section header in the grouped history — the topic name and how
/// many separate attempts sit under it.
class _TopicSectionHeader extends StatelessWidget {
  const _TopicSectionHeader({required this.title, required this.attempts});
  final String title;
  final int attempts;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      children: [
        Expanded(
          child: Text(title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: PmpTextStyles.body1Semi.copyWith(color: cs.onSurface)),
        ),
        const SizedBox(width: 8),
        Text(attempts == 1 ? '1 attempt' : '$attempts attempts',
            style: PmpTextStyles.label2Regular
                .copyWith(color: cs.onSurfaceVariant)),
      ],
    );
  }
}

/// Compact attempt tile under a topic section: latest-version score badge +
/// version count (with score climb) + date. Multi-version attempts show
/// tappable v1/v2 chips; single-version tiles tap straight in. The topic name
/// lives in the section header, so it's not repeated here.
class _SessionTile extends StatelessWidget {
  const _SessionTile({
    required this.row,
    required this.onOpen,
  });
  final SymSessionTableData row;

  /// Opens detail at the given version index.
  final ValueChanged<int> onOpen;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final mm = PmpColors.myanmarGloss(Theme.of(context).brightness);
    final versions = versionsOf(row);
    final latestIdx = versions.length - 1;
    final latest = versions[latestIdx];
    final band = bandOf(latest.band, latest.score);
    final multi = versions.length > 1;
    // How much the score climbed v1 → latest — the payoff of the revise loop.
    final climb = multi ? latest.score - versions.first.score : 0;
    // A one-line preview of the latest writing — the human "title" for the
    // attempt (newlines collapsed). Falls back to the band label if somehow
    // empty.
    final excerpt = latest.text.trim().replaceAll(RegExp(r'\s+'), ' ');
    final lead = excerpt.isEmpty ? band.label : '“$excerpt”';
    final versionsMeta =
        versions.length == 1 ? '1 version' : '${versions.length} versions';
    // Tokens this whole attempt billed (sum across its versions).
    final tokenMeta = row.tokens > 0 ? ' · ${_fmtTokens(row.tokens)} tok' : '';

    return GlassCard(
      blur: false,
      padding: const EdgeInsets.all(12),
      onTap: multi ? null : () => onOpen(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 46,
                height: 46,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: band.color.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: band.color.withValues(alpha: 0.4)),
                ),
                child: Text('${latest.score}',
                    style: PmpTextStyles.body1Semi.copyWith(color: band.color)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lead,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: PmpTextStyles.body2Semi
                          .copyWith(color: cs.onSurface, height: 1.3),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            '$versionsMeta · ${_shortDate(row.createdAt)}$tokenMeta',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: PmpTextStyles.label2Regular
                                .copyWith(color: mm),
                          ),
                        ),
                        if (multi && climb > 0) ...[
                          const SizedBox(width: 6),
                          _ClimbBadge(climb: climb),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              if (!multi)
                Icon(Icons.chevron_right, color: cs.onSurfaceVariant),
            ],
          ),
          if (multi) ...[
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (var i = 0; i < versions.length; i++)
                  _VersionChip(
                    version: versions[i].version,
                    score: versions[i].score,
                    color: bandOf(versions[i].band, versions[i].score).color,
                    onTap: () => onOpen(i),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

/// "↗ +12" — how many points the score climbed across this attempt's versions.
/// The visible reward for revising, shown only on multi-version tiles.
class _ClimbBadge extends StatelessWidget {
  const _ClimbBadge({required this.climb});
  final int climb;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
      decoration: BoxDecoration(
        color: PmpColors.success500.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.trending_up_rounded,
              size: 13, color: PmpColors.success500),
          const SizedBox(width: 2),
          Text('+$climb',
              style: PmpTextStyles.label2Regular.copyWith(
                  color: PmpColors.success500, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _VersionChip extends StatelessWidget {
  const _VersionChip({
    required this.version,
    required this.score,
    required this.color,
    required this.onTap,
  });
  final int version;
  final int score;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withValues(alpha: 0.4)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('v$version',
                style: PmpTextStyles.labelSemi.copyWith(color: color)),
            const SizedBox(width: 6),
            Text('$score',
                style: PmpTextStyles.body2Semi.copyWith(color: cs.onSurface)),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final mm = PmpColors.myanmarGloss(Theme.of(context).brightness);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.history_edu_outlined, size: 46, color: cs.primary),
            const SizedBox(height: 14),
            Text('No practice yet',
                style: PmpTextStyles.body1Semi.copyWith(color: cs.onSurface)),
            const SizedBox(height: 8),
            Text(
              'topic တစ်ခု ရွေးပြီး ကိုယ်ပိုင်အကြောင်း ရေးကြည့်ပါ။ '
              'ရေးပြီးတိုင်း ဒီမှာ သိမ်းသွားပါမယ်။',
              textAlign: TextAlign.center,
              style: PmpTextStyles.label2Regular.copyWith(color: mm, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}

const _shortMonths = [
  'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
  'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
];

String _shortDate(DateTime d) => '${_shortMonths[d.month - 1]} ${d.day}, ${d.year}';

/// Compact token count: `840`, `1.2k`, `15k`.
String _fmtTokens(int n) {
  if (n < 1000) return '$n';
  final k = n / 1000;
  return '${k.toStringAsFixed(k >= 10 ? 0 : 1)}k';
}
