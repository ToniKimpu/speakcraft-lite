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
        ...sessions.map((s) => _SessionTile(session: s)),
      ],
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
      default:
        return session.onRamp;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final scoreColor = _scoreColor();
    final feedback = session.feedback;
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
              arguments: {'session': session},
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
