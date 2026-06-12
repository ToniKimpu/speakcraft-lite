import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speakcraft/bloc/daily_speaking/daily_speaking_history_bloc.dart';
import 'package:speakcraft/config/pmp_colors.dart';
import 'package:speakcraft/config/pmp_routes.dart';
import 'package:speakcraft/config/pmp_text_styles.dart';
import 'package:speakcraft/l10n/generated/l10n.dart';
import 'package:speakcraft/model/daily_speaking/daily_speaking_session.dart';

class DailySpeakingHistoryPage extends StatefulWidget {
  const DailySpeakingHistoryPage({super.key});

  @override
  State<DailySpeakingHistoryPage> createState() =>
      _DailySpeakingHistoryPageState();
}

class _DailySpeakingHistoryPageState extends State<DailySpeakingHistoryPage> {
  @override
  void initState() {
    super.initState();
    context
        .read<DailySpeakingHistoryBloc>()
        .add(const DailySpeakingHistoryEvent.load());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(AppLocalizations.of(context).txtDsHistoryTitle)),
      body: BlocBuilder<DailySpeakingHistoryBloc, DailySpeakingHistoryState>(
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (msg) => Center(child: Text(msg)),
            loaded: (grouped, _) {
              if (grouped.isEmpty) {
                return const _EmptyState();
              }
              final days = grouped.keys.toList()
                ..sort((a, b) => b.compareTo(a));
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: days.length,
                itemBuilder: (context, i) {
                  final day = days[i];
                  final sessions = grouped[day]!;
                  return _DayGroup(day: day, sessions: sessions);
                },
              );
            },
            orElse: () => const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}

class _DayGroup extends StatelessWidget {
  const _DayGroup({required this.day, required this.sessions});
  final DateTime day;
  final List<DailySpeakingSession> sessions;

  /// Groups the day's sessions into version chains by [topicAttemptId]. Rows
  /// with no chain id (legacy) — and just-talk, which mints a unique id per
  /// session — fall into singleton chains. Day order (newest first) is kept by
  /// first-seen key.
  List<List<DailySpeakingSession>> _chains() {
    final byKey = <String, List<DailySpeakingSession>>{};
    final order = <String>[];
    for (final s in sessions) {
      final key = s.topicAttemptId ?? 'solo-${s.id}';
      if (!byKey.containsKey(key)) order.add(key);
      byKey.putIfAbsent(key, () => []).add(s);
    }
    return [for (final k in order) byKey[k]!];
  }

  String _dayLabel(BuildContext context, DateTime d) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    if (d == today) return AppLocalizations.of(context).txtDsToday;
    if (d == yesterday) return AppLocalizations.of(context).txtDsYesterday;
    return '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 12, bottom: 8),
          child: Text(
            _dayLabel(context, day),
            style: PmpTextStyles.body2Semi
                .copyWith(color: colorScheme.onSurfaceVariant),
          ),
        ),
        ...(() {
          final chains = _chains();
          return chains.map((chain) => chain.length == 1
              ? _SessionTile(session: chain.first)
              : _ChainTile(versions: chain));
        })(),
      ],
    );
  }
}

/// A multi-version topic attempt (the version loop). Shows the topic, the score
/// climb across versions, and a tappable chip per version that opens its full
/// feedback. Collapses what would otherwise be several near-identical tiles.
class _ChainTile extends StatelessWidget {
  const _ChainTile({required this.versions});

  /// All versions of one [topicAttemptId], any order.
  final List<DailySpeakingSession> versions;

  Color _scoreColor(int score) {
    if (score >= 80) return PmpColors.success500;
    if (score >= 60) return PmpColors.warning500;
    return PmpColors.destructive500;
  }

  String _title(BuildContext context, DailySpeakingSession s) {
    final l10n = AppLocalizations.of(context);
    final fromOnRamp = switch (s.onRamp) {
      DailySpeakingOnRamp.justTalk => l10n.txtDsJustTalk,
      DailySpeakingOnRamp.ownTopic => l10n.txtDsOwnTopic,
      DailySpeakingOnRamp.suggested => l10n.txtDsSuggested,
      DailySpeakingOnRamp.guided => l10n.txtDsGuided,
      _ => s.onRamp,
    };
    return s.decodedTopic?.title ??
        s.feedback.inferredTopic ??
        s.topicId ??
        fromOnRamp;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final sorted = [...versions]
      ..sort((a, b) => a.revisionNumber.compareTo(b.revisionNumber));
    final latest = sorted.last;
    final first = sorted.first;
    final latestColor = _scoreColor(latest.feedback.score);
    final climb = latest.feedback.score - first.feedback.score;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: colorScheme.outlineVariant),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: latestColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                    border:
                        Border.all(color: latestColor.withValues(alpha: 0.4)),
                  ),
                  child: Text(
                    '${latest.feedback.score}',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'ArchivoBlack Regular',
                      color: latestColor,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _title(context, latest),
                        style: PmpTextStyles.body2Semi
                            .copyWith(color: colorScheme.onSurface),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        climb > 0
                            ? l10n.txtDsChainVersionsUp(sorted.length, climb)
                            : l10n.txtDsChainVersions(sorted.length),
                        style: PmpTextStyles.sub
                            .copyWith(color: colorScheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final v in sorted)
                  () {
                    final hasNative =
                        v.feedback.effectiveNativeRewrite.isNotEmpty;
                    return _VersionScoreChip(
                      revision: v.revisionNumber,
                      score: v.feedback.score,
                      color: _scoreColor(v.feedback.score),
                      hasNativeVersion: hasNative,
                      onTap: () => Navigator.pushNamed(
                        context,
                        PmpRoutes.dailySpeakingFeedback,
                        arguments: {
                          'session': v,
                        },
                      ),
                    );
                  }(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _VersionScoreChip extends StatelessWidget {
  const _VersionScoreChip({
    required this.revision,
    required this.score,
    required this.color,
    required this.onTap,
    this.hasNativeVersion = false,
  });
  final int revision;
  final int score;
  final Color color;
  final VoidCallback onTap;

  /// This version has a saved native rewrite — flagged with ✨ and, on tap,
  /// jumps straight to that section.
  final bool hasNativeVersion;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withValues(alpha: 0.4)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'v$revision',
              style: PmpTextStyles.labelSemi.copyWith(color: color),
            ),
            const SizedBox(width: 6),
            Text(
              '$score',
              style: PmpTextStyles.body2Semi
                  .copyWith(color: colorScheme.onSurface),
            ),
            if (hasNativeVersion) ...[
              const SizedBox(width: 4),
              const Icon(Icons.auto_awesome,
                  size: 13, color: PmpColors.accentOrange),
            ],
          ],
        ),
      ),
    );
  }
}

class _SessionTile extends StatelessWidget {
  const _SessionTile({required this.session});
  final DailySpeakingSession session;

  Color _scoreColor() {
    final score = session.feedback.score;
    if (score >= 80) return PmpColors.success500;
    if (score >= 60) return PmpColors.warning500;
    return PmpColors.destructive500;
  }

  String _onRampLabel(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    switch (session.onRamp) {
      case DailySpeakingOnRamp.justTalk:
        return l10n.txtDsJustTalk;
      case DailySpeakingOnRamp.ownTopic:
        return l10n.txtDsOwnTopic;
      case DailySpeakingOnRamp.suggested:
        return l10n.txtDsSuggested;
      case DailySpeakingOnRamp.guided:
        return l10n.txtDsGuided;
      default:
        return session.onRamp;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final scoreColor = _scoreColor();
    final feedback = session.feedback;
    // Has a saved native version to jump to (the loop's terminal reveal). All
    // three on-ramps loop now — just-talk via the AI's inferred topic — so any
    // on-ramp can carry one.
    final hasNative = feedback.effectiveNativeRewrite.isNotEmpty;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              PmpRoutes.dailySpeakingFeedback,
              arguments: {
                'session': session,
              },
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: scoreColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: scoreColor.withValues(alpha: 0.4),
                    ),
                  ),
                  child: Text(
                    '${feedback.score}',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'ArchivoBlack Regular',
                      color: scoreColor,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        session.decodedTopic?.title ??
                            feedback.inferredTopic ??
                            session.topicId ??
                            _onRampLabel(context),
                        style: PmpTextStyles.body2Semi
                            .copyWith(color: colorScheme.onSurface),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        AppLocalizations.of(context).txtDsSessionMeta(
                          _onRampLabel(context),
                          feedback.durationSeconds,
                          feedback.wordCount,
                        ),
                        style: PmpTextStyles.sub.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                if (hasNative)
                  const Padding(
                    padding: EdgeInsets.only(right: 4),
                    child: Icon(Icons.auto_awesome,
                        size: 15, color: PmpColors.accentOrange),
                  ),
                Icon(
                  Icons.chevron_right,
                  color: colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.history_toggle_off,
                size: 56, color: colorScheme.onSurfaceVariant),
            const SizedBox(height: 12),
            Text(
              AppLocalizations.of(context).txtDsNoSessionsYet,
              style: PmpTextStyles.h2.copyWith(color: colorScheme.onSurface),
            ),
            const SizedBox(height: 4),
            Text(
              AppLocalizations.of(context).txtDsNoSessionsBody,
              textAlign: TextAlign.center,
              style: PmpTextStyles.body2Regular
                  .copyWith(color: colorScheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}
