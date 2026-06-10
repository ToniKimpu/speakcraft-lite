part of 'feedback_result_page.dart';

/// The pinned top of the result screen — always visible above the tabs: the
/// score, the version-compare strip (v2+), the time/words/pace metrics, and the
/// recording player. Everything here anchors the session; the tabs below carry
/// the variable-length content.
class _ResultHeader extends StatelessWidget {
  const _ResultHeader({required this.session});

  final DailySpeakingSession session;

  @override
  Widget build(BuildContext context) {
    final feedback = session.feedback;
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _ScoreHeader(feedback: feedback),
        if (session.revisionNumber > 1) ...[
          const SizedBox(height: 12),
          _VersionCompareStrip(session: session),
        ],
        const SizedBox(height: 20),
        _MetricsRow(feedback: feedback),
        if (session.audioPath != null) ...[
          const SizedBox(height: 16),
          _Section(
            icon: Icons.mic_none,
            iconColor: colorScheme.primary,
            title: session.revisionNumber > 1
                ? l10n.txtDsHearYourProgress
                : l10n.txtDsYourRecording,
            child: _AudioSection(session: session),
          ),
        ],
      ],
    );
  }
}

class _ScoreHeader extends StatelessWidget {
  const _ScoreHeader({required this.feedback});
  final DailySpeakingFeedback feedback;

  Color _scoreColor() {
    if (feedback.score >= 80) return PmpColors.success500;
    if (feedback.score >= 60) return PmpColors.warning500;
    return PmpColors.destructive500;
  }

  String _levelLabel(BuildContext context, CefrLevel level) {
    final l10n = AppLocalizations.of(context);
    switch (level) {
      case CefrLevel.beginner:
        return l10n.txtDsLevelBeginner;
      case CefrLevel.elementary:
        return l10n.txtDsLevelElementary;
      case CefrLevel.intermediate:
        return l10n.txtDsLevelIntermediate;
      case CefrLevel.upperIntermediate:
        return l10n.txtDsLevelUpperIntermediate;
      case CefrLevel.advanced:
        return l10n.txtDsLevelAdvanced;
      case CefrLevel.fluent:
        return l10n.txtDsLevelFluent;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final scoreColor = _scoreColor();
    return Row(
      children: [
        SizedBox(
          width: 88,
          height: 88,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CircularProgressIndicator(
                value: feedback.score.clamp(0, 100) / 100.0,
                strokeWidth: 8,
                backgroundColor: scoreColor.withValues(alpha: 0.15),
                valueColor: AlwaysStoppedAnimation<Color>(scoreColor),
              ),
              Center(
                child: Text(
                  '${feedback.score}',
                  style: TextStyle(
                    fontSize: 28,
                    fontFamily: 'ArchivoBlack Regular',
                    color: scoreColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _levelLabel(context, feedback.level),
                style: PmpTextStyles.h2.copyWith(
                  color: colorScheme.onSurface,
                  fontFamily: 'ArchivoBlack Regular',
                ),
              ),
              const SizedBox(height: 2),
              Text(
                AppLocalizations.of(context).txtOutOf(100),
                style: PmpTextStyles.label2Regular
                    .copyWith(color: colorScheme.onSurfaceVariant),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Shown on v2+ results: the version number and the score change vs the
/// previous version of the same topic attempt. The previous score is read
/// straight from local Drift (no extra AI call / tokens).
class _VersionCompareStrip extends StatelessWidget {
  const _VersionCompareStrip({required this.session});
  final DailySpeakingSession session;

  Future<int?> _previousScore() async {
    final attemptId = session.topicAttemptId;
    if (attemptId == null) return null;
    final table = AppDatabase.instance().dailySpeakingSessionTable;
    final rows = await (table.select()
          ..where((t) =>
              t.topicAttemptId.equals(attemptId) &
              t.revisionNumber.isSmallerThanValue(session.revisionNumber))
          ..orderBy([
            (t) => drift.OrderingTerm(
                  expression: t.revisionNumber,
                  mode: drift.OrderingMode.desc,
                ),
          ])
          ..limit(1))
        .get();
    if (rows.isEmpty) return null;
    final fb = DailySpeakingFeedback.fromJson(
      Map<String, dynamic>.from(jsonDecode(rows.first.feedbackJson) as Map),
    );
    return fb.score;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final prevRev = session.revisionNumber - 1;
    return FutureBuilder<int?>(
      future: _previousScore(),
      builder: (context, snap) {
        final prev = snap.data;
        final delta = prev == null ? null : session.feedback.score - prev;
        final String message;
        if (delta == null) {
          message = l10n.txtDsLatestAttempt;
        } else if (delta > 0) {
          message = l10n.txtDsScoreUp(delta, prevRev, prev!);
        } else if (delta < 0) {
          message = l10n.txtDsScoreDown(-delta, prevRev, prev!);
        } else {
          message = l10n.txtDsScoreSame(prevRev, prev!);
        }
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: colorScheme.outlineVariant),
          ),
          child: Row(
            children: [
              _VersionChip(revision: session.revisionNumber),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: PmpTextStyles.label2Regular
                      .copyWith(color: colorScheme.onSurface),
                ),
              ),
              if (delta != null && delta != 0) _DeltaBadge(delta: delta),
            ],
          ),
        );
      },
    );
  }
}

/// The recording player. On a v2+ result it loads the previous version's clip
/// (if still on disk) and shows both so the learner can A/B their progress —
/// the most motivating use of replay. Otherwise it's a single player.
class _AudioSection extends StatelessWidget {
  const _AudioSection({required this.session});
  final DailySpeakingSession session;

  /// Path to the previous version's saved audio, or null if this is v1, the
  /// chain is unknown, or the older clip was pruned.
  Future<String?> _previousAudioPath() async {
    final attemptId = session.topicAttemptId;
    if (attemptId == null || session.revisionNumber <= 1) return null;
    final table = AppDatabase.instance().dailySpeakingSessionTable;
    final rows = await (table.select()
          ..where((t) =>
              t.topicAttemptId.equals(attemptId) &
              t.revisionNumber.isSmallerThanValue(session.revisionNumber) &
              t.audioPath.isNotNull())
          ..orderBy([
            (t) => drift.OrderingTerm(
                  expression: t.revisionNumber,
                  mode: drift.OrderingMode.desc,
                ),
          ])
          ..limit(1))
        .get();
    if (rows.isEmpty) return null;
    return rows.first.audioPath;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final current = session.audioPath!;
    if (session.revisionNumber <= 1) {
      return SessionAudioPlayer(audioPath: current);
    }
    final prevRev = session.revisionNumber - 1;
    return FutureBuilder<String?>(
      future: _previousAudioPath(),
      builder: (context, snap) {
        final prev = snap.data;
        if (prev == null) {
          // Older clip pruned / unavailable — just the current one.
          return SessionAudioPlayer(
            audioPath: current,
            label: l10n.txtDsVersionShort(session.revisionNumber),
          );
        }
        return Column(
          children: [
            SessionAudioPlayer(
              audioPath: prev,
              label: l10n.txtDsVersionShort(prevRev),
              compact: true,
            ),
            const SizedBox(height: 8),
            SessionAudioPlayer(
              audioPath: current,
              label: l10n.txtDsVersionThisOne(session.revisionNumber),
              compact: true,
            ),
          ],
        );
      },
    );
  }
}

class _VersionChip extends StatelessWidget {
  const _VersionChip({required this.revision});
  final int revision;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: colorScheme.primary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        AppLocalizations.of(context).txtDsVersionShort(revision),
        style: PmpTextStyles.labelSemi.copyWith(color: colorScheme.primary),
      ),
    );
  }
}

class _DeltaBadge extends StatelessWidget {
  const _DeltaBadge({required this.delta});
  final int delta;

  @override
  Widget build(BuildContext context) {
    final improved = delta >= 0;
    final color = improved ? PmpColors.success500 : PmpColors.destructive500;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          improved ? Icons.arrow_upward : Icons.arrow_downward,
          size: 14,
          color: color,
        ),
        const SizedBox(width: 2),
        Text(
          '${delta.abs()}',
          style: PmpTextStyles.body2Semi.copyWith(color: color),
        ),
      ],
    );
  }
}

class _MetricsRow extends StatelessWidget {
  const _MetricsRow({required this.feedback});
  final DailySpeakingFeedback feedback;

  @override
  Widget build(BuildContext context) {
    final mm = (feedback.durationSeconds ~/ 60).toString().padLeft(2, '0');
    final ss = (feedback.durationSeconds % 60).toString().padLeft(2, '0');
    final l10n = AppLocalizations.of(context);
    return Row(
      children: [
        Expanded(child: _MetricTile(label: l10n.txtDsTime, value: '$mm:$ss')),
        const SizedBox(width: 10),
        Expanded(
          child: _MetricTile(
              label: l10n.txtDsWords, value: '${feedback.wordCount}'),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _MetricTile(
            label: l10n.txtDsPace,
            value: l10n.txtDsPaceWpm(feedback.speakingPaceWpm),
          ),
        ),
      ],
    );
  }
}

class _MetricTile extends StatelessWidget {
  const _MetricTile({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: PmpTextStyles.body1Semi.copyWith(
              color: colorScheme.onSurface,
              fontFamily: 'ArchivoBlack Regular',
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: PmpTextStyles.sub.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _TopicChip extends StatelessWidget {
  const _TopicChip({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: colorScheme.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: colorScheme.primary.withValues(alpha: 0.4)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.label_outline, size: 14, color: colorScheme.primary),
            const SizedBox(width: 6),
            Text(
              AppLocalizations.of(context).txtDsTopicColon(label),
              style: PmpTextStyles.labelSemi.copyWith(
                color: colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
