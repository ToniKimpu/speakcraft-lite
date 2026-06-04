import 'dart:convert';

import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:speakcraft/config/pmp_colors.dart';
import 'package:speakcraft/config/pmp_routes.dart';
import 'package:speakcraft/config/pmp_text_styles.dart';
import 'package:speakcraft/l10n/generated/l10n.dart';
import 'package:speakcraft/model/daily_speaking/daily_speaking_feedback.dart';
import 'package:speakcraft/model/daily_speaking/daily_speaking_session.dart';
import 'package:speakcraft/model/daily_speaking/daily_speaking_topic.dart';
import 'package:speakcraft/services/app_database/app_database.dart';

/// Shared result screen for all three on-ramps.
///
/// Renders every section that the [DailySpeakingFeedback] payload may include
/// — `targetPhraseResults` only appears when the session had a topic with
/// target phrases (i.e. the P3 suggested-topic path).
///
/// [topic] is non-null for loop-capable on-ramps (suggested + own-topic). Its
/// presence enables the version loop: "Polish & retry" (start the next version)
/// and "I'm done" (the terminal native-rewrite reveal). Just-talk has no topic,
/// so it stays a one-shot terminal result.
///
/// [lastAudioPath] / [lastText] are the input that produced *this* session —
/// the terminal reveal needs them to generate the native rewrite of the
/// learner's final version.
class FeedbackResultPage extends StatelessWidget {
  const FeedbackResultPage({
    super.key,
    required this.session,
    this.topic,
    this.lastAudioPath,
    this.lastText,
  });

  final DailySpeakingSession session;
  final DailySpeakingTopic? topic;
  final String? lastAudioPath;
  final String? lastText;

  bool get _canLoop =>
      topic != null && session.onRamp != DailySpeakingOnRamp.justTalk;

  @override
  Widget build(BuildContext context) {
    final feedback = session.feedback;
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.txtDsFeedback),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.popUntil(
              context,
              (route) => route.isFirst || route.settings.name == '/home',
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _ScoreHeader(feedback: feedback),
            if (session.revisionNumber > 1) ...[
              const SizedBox(height: 12),
              _VersionCompareStrip(session: session),
            ],
            const SizedBox(height: 20),
            _MetricsRow(feedback: feedback),
            if (feedback.subScores != null) ...[
              const SizedBox(height: 16),
              _Section(
                icon: Icons.bar_chart,
                iconColor: colorScheme.primary,
                title: 'Skill breakdown',
                child: _SubScoresCard(scores: feedback.subScores!),
              ),
            ],
            if (feedback.inferredTopic != null) ...[
              const SizedBox(height: 16),
              _TopicChip(label: feedback.inferredTopic!),
            ],
            if (feedback.strengths.isNotEmpty) ...[
              const SizedBox(height: 20),
              _Section(
                icon: Icons.star_outline,
                iconColor: PmpColors.success500,
                title: l10n.txtDsWhatYouDidWell,
                child: _BulletList(items: feedback.strengths),
              ),
            ],
            if (feedback.fixes.isNotEmpty) ...[
              const SizedBox(height: 16),
              _Section(
                icon: Icons.tune,
                iconColor: PmpColors.warning500,
                title: l10n.txtDsThingsToFix,
                child: Column(
                  children: feedback.fixes
                      .map((f) => _FixCard(fix: f))
                      .toList(growable: false),
                ),
              ),
            ],
            if (feedback.grammarPatterns.isNotEmpty) ...[
              const SizedBox(height: 16),
              _Section(
                icon: Icons.rule,
                iconColor: PmpColors.warning500,
                title: 'Grammar patterns',
                child: _BulletList(items: feedback.grammarPatterns),
              ),
            ],
            if (feedback.interferenceNotes.isNotEmpty) ...[
              const SizedBox(height: 16),
              _Section(
                icon: Icons.translate,
                iconColor: PmpColors.destructive400,
                title: 'Burmese-English errors',
                child: Column(
                  children: feedback.interferenceNotes
                      .map((f) => _FixCard(fix: f))
                      .toList(growable: false),
                ),
              ),
            ],
            if (feedback.vocabUpgrades.isNotEmpty) ...[
              const SizedBox(height: 16),
              _Section(
                icon: Icons.upgrade,
                iconColor: PmpColors.info500,
                title: 'Better word choices',
                child: Column(
                  children: feedback.vocabUpgrades
                      .map((v) => _VocabUpgradeRow(upgrade: v))
                      .toList(growable: false),
                ),
              ),
            ],
            if (feedback.collocations.isNotEmpty) ...[
              const SizedBox(height: 16),
              _Section(
                icon: Icons.link,
                iconColor: PmpColors.info500,
                title: 'Collocations',
                child: _ChipWrap(labels: feedback.collocations),
              ),
            ],
            if (feedback.idioms.isNotEmpty) ...[
              const SizedBox(height: 16),
              _Section(
                icon: Icons.auto_awesome,
                iconColor: PmpColors.accentOrange,
                title: 'Idioms & phrasal verbs',
                child: Column(
                  children: feedback.idioms
                      .map((i) => _IdiomRow(idiom: i))
                      .toList(growable: false),
                ),
              ),
            ],
            if (feedback.nativeRewrite.isNotEmpty) ...[
              const SizedBox(height: 16),
              _Section(
                icon: Icons.record_voice_over,
                iconColor: colorScheme.primary,
                title: l10n.txtDsNativeRewrite,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: colorScheme.primary.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Text(
                    feedback.nativeRewrite,
                    style: PmpTextStyles.body1Regular.copyWith(
                      color: colorScheme.onSurface,
                      height: 1.6,
                    ),
                  ),
                ),
              ),
            ],
            if (feedback.sentenceRewrites.isNotEmpty) ...[
              const SizedBox(height: 16),
              _Section(
                icon: Icons.format_quote,
                iconColor: colorScheme.primary,
                title: 'Sentence rewrites',
                child: Column(
                  children: feedback.sentenceRewrites
                      .map((s) => _SentenceRewriteCard(rewrite: s))
                      .toList(growable: false),
                ),
              ),
            ],
            if (feedback.targetPhraseResults.isNotEmpty) ...[
              const SizedBox(height: 16),
              _Section(
                icon: Icons.flag_outlined,
                iconColor: PmpColors.info500,
                title: l10n.txtDsTargetPhrases,
                child: Column(
                  children: feedback.targetPhraseResults
                      .map((p) => _TargetPhraseRow(result: p))
                      .toList(growable: false),
                ),
              ),
            ],
            if (feedback.pronunciationNotes.isNotEmpty) ...[
              const SizedBox(height: 16),
              _Section(
                icon: Icons.graphic_eq,
                iconColor: colorScheme.tertiary,
                title: l10n.txtDsPronunciationNotes,
                child: _BulletList(items: feedback.pronunciationNotes),
              ),
            ],
            if (feedback.fillerWords.isNotEmpty) ...[
              const SizedBox(height: 16),
              _Section(
                icon: Icons.bubble_chart_outlined,
                iconColor: colorScheme.tertiary,
                title: 'Filler words',
                child: _ChipWrap(
                  labels: feedback.fillerWords
                      .map((f) => '${f.word} ×${f.count}')
                      .toList(growable: false),
                ),
              ),
            ],
            if (feedback.explanationMm.isNotEmpty) ...[
              const SizedBox(height: 16),
              _Section(
                icon: Icons.translate,
                iconColor: PmpColors.accentOrange,
                title: l10n.txtDsSummaryMm,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: colorScheme.outlineVariant),
                  ),
                  child: Text(
                    feedback.explanationMm,
                    style: PmpTextStyles.body1Regular.copyWith(
                      color: colorScheme.onSurface,
                      fontFamily: 'Noto Sans Myanmar',
                      height: 1.7,
                    ),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 24),
            if (_canLoop) ...[
              FilledButton.icon(
                onPressed: () => _polishAndRetry(context),
                icon: const Icon(Icons.refresh),
                label: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text('Polish & retry'),
                ),
              ),
              const SizedBox(height: 10),
              OutlinedButton.icon(
                onPressed: () => _finishTopic(context),
                icon: const Icon(Icons.auto_awesome),
                label: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text('I\'m done — see native version'),
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () => _goHome(context),
                child: Text(l10n.txtDone),
              ),
            ] else
              FilledButton(
                onPressed: () => _goHome(context),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(l10n.txtDone),
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// Start the next version: re-capture on the same topic, carrying the chain id
  /// and an incremented revision so the next result can show the improvement.
  void _polishAndRetry(BuildContext context) {
    final args = {
      'topic': topic,
      'topicAttemptId': session.topicAttemptId,
      'revisionNumber': session.revisionNumber + 1,
    };
    final String route;
    if (session.onRamp == DailySpeakingOnRamp.suggested) {
      route = PmpRoutes.dailySpeakingSuggestedRecord;
    } else if (session.inputMode == DailySpeakingInputMode.text) {
      route = PmpRoutes.dailySpeakingWritePath;
    } else {
      route = PmpRoutes.dailySpeakingOwnTopicRecord;
    }
    Navigator.pushReplacementNamed(context, route, arguments: args);
  }

  /// End the loop and reveal the native rewrite of the learner's final version.
  void _finishTopic(BuildContext context) {
    Navigator.pushNamed(
      context,
      PmpRoutes.dailySpeakingFinalRewrite,
      arguments: {
        'inputMode': session.inputMode,
        'onRamp': session.onRamp,
        'audioPath': lastAudioPath,
        'text': lastText,
        'topic': topic,
        'finalScore': session.feedback.score,
      },
    );
  }

  void _goHome(BuildContext context) {
    Navigator.popUntil(
      context,
      (route) => route.isFirst || route.settings.name == '/home',
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
    final prevRev = session.revisionNumber - 1;
    return FutureBuilder<int?>(
      future: _previousScore(),
      builder: (context, snap) {
        final prev = snap.data;
        final delta = prev == null ? null : session.feedback.score - prev;
        final String message;
        if (delta == null) {
          message = 'Your latest attempt at this topic.';
        } else if (delta > 0) {
          message = 'Up $delta from v$prevRev (was $prev).';
        } else if (delta < 0) {
          message = 'Down ${-delta} from v$prevRev (was $prev).';
        } else {
          message = 'Same score as v$prevRev ($prev).';
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
        'v$revision',
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

class _Section extends StatelessWidget {
  const _Section({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.child,
  });
  final IconData icon;
  final Color iconColor;
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: iconColor),
            const SizedBox(width: 8),
            Text(
              title,
              style: PmpTextStyles.body2Semi
                  .copyWith(color: colorScheme.onSurface),
            ),
          ],
        ),
        const SizedBox(height: 10),
        child,
      ],
    );
  }
}

class _BulletList extends StatelessWidget {
  const _BulletList({required this.items});
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .map(
            (text) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 7, right: 8),
                    child: Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                        color: colorScheme.onSurface,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      text,
                      style: PmpTextStyles.body2Regular.copyWith(
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(growable: false),
    );
  }
}

class _FixCard extends StatelessWidget {
  const _FixCard({required this.fix});
  final FeedbackFix fix;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            fix.original,
            style: PmpTextStyles.body2Regular.copyWith(
              color: PmpColors.destructive400,
              decoration: TextDecoration.lineThrough,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            fix.corrected,
            style: PmpTextStyles.body1Semi.copyWith(
              color: PmpColors.success500,
            ),
          ),
          if (fix.reasonMm.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              fix.reasonMm,
              style: PmpTextStyles.body2Regular.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontFamily: 'Noto Sans Myanmar',
                height: 1.6,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _TargetPhraseRow extends StatelessWidget {
  const _TargetPhraseRow({required this.result});
  final TargetPhraseResult result;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final Color fg = result.used
        ? (result.usedCorrectly
            ? PmpColors.success500
            : PmpColors.warning500)
        : colorScheme.onSurfaceVariant;
    final IconData icon = result.used
        ? (result.usedCorrectly
            ? Icons.check_circle
            : Icons.error_outline)
        : Icons.radio_button_unchecked;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: fg),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              result.phraseEn,
              style: PmpTextStyles.body2Regular.copyWith(
                color: result.used ? colorScheme.onSurface : fg,
                fontStyle:
                    result.used ? FontStyle.normal : FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SubScoresCard extends StatelessWidget {
  const _SubScoresCard({required this.scores});
  final SubScores scores;

  Color _barColor(int v) {
    if (v >= 80) return PmpColors.success500;
    if (v >= 60) return PmpColors.warning500;
    return PmpColors.destructive500;
  }

  @override
  Widget build(BuildContext context) {
    final rows = <(String, int)>[
      ('Grammar', scores.grammar),
      ('Vocabulary', scores.vocabulary),
      ('Fluency', scores.fluency),
      ('Pronunciation', scores.pronunciation),
    ];
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        for (final (label, value) in rows)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                SizedBox(
                  width: 96,
                  child: Text(
                    label,
                    style: PmpTextStyles.label2Regular
                        .copyWith(color: colorScheme.onSurfaceVariant),
                  ),
                ),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: LinearProgressIndicator(
                      value: value.clamp(0, 100) / 100.0,
                      minHeight: 8,
                      backgroundColor: _barColor(value).withValues(alpha: 0.15),
                      valueColor:
                          AlwaysStoppedAnimation<Color>(_barColor(value)),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 28,
                  child: Text(
                    '$value',
                    textAlign: TextAlign.right,
                    style: PmpTextStyles.body2Semi
                        .copyWith(color: colorScheme.onSurface),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _VocabUpgradeRow extends StatelessWidget {
  const _VocabUpgradeRow({required this.upgrade});
  final VocabUpgrade upgrade;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Flexible(
                child: Text(
                  upgrade.original,
                  style: PmpTextStyles.body2Regular.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Icon(Icons.arrow_forward, size: 14),
              ),
              Flexible(
                child: Text(
                  upgrade.suggestion,
                  style: PmpTextStyles.body1Semi
                      .copyWith(color: PmpColors.success500),
                ),
              ),
            ],
          ),
          if (upgrade.reasonMm.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              upgrade.reasonMm,
              style: PmpTextStyles.body2Regular.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontFamily: 'Noto Sans Myanmar',
                height: 1.6,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _IdiomRow extends StatelessWidget {
  const _IdiomRow({required this.idiom});
  final IdiomSuggestion idiom;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            idiom.expression,
            style: PmpTextStyles.body1Semi
                .copyWith(color: colorScheme.onSurface),
          ),
          if (idiom.meaningMm.isNotEmpty) ...[
            const SizedBox(height: 2),
            Text(
              idiom.meaningMm,
              style: PmpTextStyles.body2Regular.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontFamily: 'Noto Sans Myanmar',
                height: 1.6,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _SentenceRewriteCard extends StatelessWidget {
  const _SentenceRewriteCard({required this.rewrite});
  final SentenceRewrite rewrite;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            rewrite.original,
            style: PmpTextStyles.body2Regular.copyWith(
              color: colorScheme.onSurfaceVariant,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            rewrite.rewrite,
            style: PmpTextStyles.body1Semi
                .copyWith(color: PmpColors.success500, height: 1.5),
          ),
        ],
      ),
    );
  }
}

class _ChipWrap extends StatelessWidget {
  const _ChipWrap({required this.labels});
  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: labels
          .map(
            (label) => Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: colorScheme.outlineVariant),
              ),
              child: Text(
                label,
                style: PmpTextStyles.sub
                    .copyWith(color: colorScheme.onSurface),
              ),
            ),
          )
          .toList(growable: false),
    );
  }
}
