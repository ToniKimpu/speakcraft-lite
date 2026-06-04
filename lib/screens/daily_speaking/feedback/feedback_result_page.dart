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
import 'package:speakcraft/screens/daily_speaking/widgets/session_audio_player.dart';
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
class FeedbackResultPage extends StatefulWidget {
  const FeedbackResultPage({
    super.key,
    required this.session,
    this.topic,
    this.lastAudioPath,
    this.lastText,
    this.revealNativeRewrite = false,
  });

  final DailySpeakingSession session;
  final DailySpeakingTopic? topic;
  final String? lastAudioPath;
  final String? lastText;

  /// When opened from history via the ✨ chip of a finished topic, jump straight
  /// to the saved native-rewrite section instead of starting at the top.
  final bool revealNativeRewrite;

  @override
  State<FeedbackResultPage> createState() => _FeedbackResultPageState();
}

class _FeedbackResultPageState extends State<FeedbackResultPage> {
  /// Anchors the native-rewrite section so we can scroll to it on open.
  final GlobalKey _nativeRewriteKey = GlobalKey();

  DailySpeakingSession get session => widget.session;
  DailySpeakingTopic? get topic => widget.topic;
  String? get lastAudioPath => widget.lastAudioPath;
  String? get lastText => widget.lastText;

  /// The topic to resume — passed live, or rebuilt from the saved row when this
  /// page was reopened from history.
  DailySpeakingTopic? get _resumableTopic => topic ?? session.decodedTopic;

  /// "Polish & retry" — offered live AND from history; needs only a topic to
  /// carry forward. All three on-ramps now loop: suggested + own-topic use the
  /// chosen topic, just-talk uses the AI's inferred topic (saved on submit), so
  /// the only sessions without one are just-talk with no inferred topic and
  /// legacy rows.
  bool get _canRetry => _resumableTopic != null;

  bool get _hasNativeVersion => session.feedback.nativeRewrite.isNotEmpty;

  /// Whether we can generate/show the native version. Offered when there's no
  /// saved one yet, as long as we have *some* input to rewrite — the
  /// just-captured input (live) OR the saved transcript/text (from history).
  /// The latter is why a learner who tapped plain "Done" and skipped the reveal
  /// can still get it later: the rewrite only needs the words, and we persist
  /// them in `inputText`.
  bool get _canReveal =>
      !_hasNativeVersion &&
      (lastAudioPath != null ||
          (lastText?.trim().isNotEmpty ?? false) ||
          (session.inputText?.trim().isNotEmpty ?? false));

  /// Live finish (fresh input on hand) vs reopened from history.
  bool get _hasLiveInput =>
      lastAudioPath != null || (lastText?.trim().isNotEmpty ?? false);

  @override
  void initState() {
    super.initState();
    if (widget.revealNativeRewrite &&
        session.feedback.nativeRewrite.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final ctx = _nativeRewriteKey.currentContext;
        if (ctx != null) {
          Scrollable.ensureVisible(
            ctx,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            alignment: 0.05,
          );
        }
      });
    }
  }

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
            if ((session.inputText ?? '').trim().isNotEmpty) ...[
              const SizedBox(height: 16),
              _Section(
                icon: Icons.notes,
                iconColor: colorScheme.secondary,
                title: session.inputMode == DailySpeakingInputMode.voice
                    ? l10n.txtDsWhatYouSaid
                    : l10n.txtDsWhatYouWrote,
                child: _InputCard(text: session.inputText!.trim()),
              ),
            ],
            if (feedback.subScores != null) ...[
              const SizedBox(height: 16),
              _Section(
                icon: Icons.bar_chart,
                iconColor: colorScheme.primary,
                title: l10n.txtDsSkillBreakdown,
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
                title: l10n.txtDsGrammarPatterns,
                child: _BulletList(items: feedback.grammarPatterns),
              ),
            ],
            if (feedback.interferenceNotes.isNotEmpty) ...[
              const SizedBox(height: 16),
              _Section(
                icon: Icons.translate,
                iconColor: PmpColors.destructive400,
                title: l10n.txtDsBurmeseErrors,
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
                title: l10n.txtDsBetterWordChoices,
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
                title: l10n.txtDsCollocations,
                child: _ChipWrap(labels: feedback.collocations),
              ),
            ],
            if (feedback.idioms.isNotEmpty) ...[
              const SizedBox(height: 16),
              _Section(
                icon: Icons.auto_awesome,
                iconColor: PmpColors.accentOrange,
                title: l10n.txtDsIdioms,
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
                key: _nativeRewriteKey,
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
                title: l10n.txtDsSentenceRewritesTitle,
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
                title: l10n.txtDsFillerWords,
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
            if (_canRetry) ...[
              FilledButton.icon(
                onPressed: () => _polishAndRetry(context),
                icon: const Icon(Icons.refresh),
                label: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(l10n.txtDsPolishRetry),
                ),
              ),
              const SizedBox(height: 10),
            ],
            if (_canReveal) ...[
              OutlinedButton.icon(
                onPressed: () => _finishTopic(context),
                icon: const Icon(Icons.auto_awesome),
                label: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(_hasLiveInput
                      ? l10n.txtDsImDoneSeeNative
                      : l10n.txtDsSeeNativeVersion),
                ),
              ),
              const SizedBox(height: 10),
            ],
            if (_canRetry || _canReveal)
              TextButton(
                onPressed: () => _goHome(context),
                child: Text(l10n.txtDone),
              )
            else
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
  /// and the next revision so the next result can show the improvement. Works
  /// both live and when reopened from history (the topic is rebuilt from the
  /// saved row). Always continues from the chain's *latest* version, so
  /// polishing an old history entry appends (a v3 chain makes v4) rather than
  /// overwriting an existing version.
  Future<void> _polishAndRetry(BuildContext context) async {
    final resumeTopic = _resumableTopic;
    if (resumeTopic == null) return;
    final nextRevision = await _nextRevisionForChain();
    if (!context.mounted) return;
    final args = {
      'topic': resumeTopic,
      'topicAttemptId': session.topicAttemptId,
      'revisionNumber': nextRevision,
    };
    final String route;
    if (session.onRamp == DailySpeakingOnRamp.justTalk) {
      // Retry in the just-talk recorder (keeps onRamp == just_talk); the
      // inferred topic rides along as a focus banner.
      route = PmpRoutes.dailySpeakingJustRecord;
    } else if (session.onRamp == DailySpeakingOnRamp.suggested) {
      route = PmpRoutes.dailySpeakingSuggestedRecord;
    } else if (session.inputMode == DailySpeakingInputMode.text) {
      route = PmpRoutes.dailySpeakingWritePath;
    } else {
      route = PmpRoutes.dailySpeakingOwnTopicRecord;
    }
    Navigator.pushReplacementNamed(context, route, arguments: args);
  }

  /// Next revision for this chain = the highest stored `revisionNumber` + 1.
  Future<int> _nextRevisionForChain() async {
    final attemptId = session.topicAttemptId;
    if (attemptId == null) return session.revisionNumber + 1;
    final table = AppDatabase.instance().dailySpeakingSessionTable;
    final rows = await (table.select()
          ..where((t) => t.topicAttemptId.equals(attemptId))
          ..orderBy([
            (t) => drift.OrderingTerm(
                  expression: t.revisionNumber,
                  mode: drift.OrderingMode.desc,
                ),
          ])
          ..limit(1))
        .get();
    final maxRev =
        rows.isEmpty ? session.revisionNumber : rows.first.revisionNumber;
    return maxRev + 1;
  }

  /// Reveal the native rewrite of this version. Live, it rewrites the just-
  /// captured input (audio or text). From history — where the learner skipped
  /// the reveal and the audio may be pruned — it falls back to the saved words
  /// via the text path (the rewrite only needs the words). Either way the
  /// result is merged into this row so it's there next time (see
  /// `FinalRewritePage._persistRewrite`).
  void _finishTopic(BuildContext context) {
    final useLive = _hasLiveInput;
    Navigator.pushNamed(
      context,
      PmpRoutes.dailySpeakingFinalRewrite,
      arguments: {
        'sessionId': session.id,
        'inputMode':
            useLive ? session.inputMode : DailySpeakingInputMode.text,
        'onRamp': session.onRamp,
        'audioPath': useLive ? lastAudioPath : null,
        'text': useLive ? lastText : session.inputText,
        // The learner's own words to show side-by-side against the native
        // version. For voice this is the transcript (now stored in inputText),
        // so the comparison renders on the voice path too — not just text.
        'learnerWords': session.inputText,
        'topic': _resumableTopic,
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

/// The learner's own words — the AI transcript for voice, the typed text for
/// the write path (both live in `session.inputText`). Shown so a session is no
/// longer "write-only": you can re-read what you actually said.
class _InputCard extends StatelessWidget {
  const _InputCard({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Text(
        text,
        style: PmpTextStyles.body1Regular.copyWith(
          color: colorScheme.onSurface,
          height: 1.6,
        ),
      ),
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

class _Section extends StatelessWidget {
  const _Section({
    super.key,
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
    final l10n = AppLocalizations.of(context);
    final rows = <(String, int)>[
      (l10n.txtDsGrammar, scores.grammar),
      (l10n.txtDsVocabulary, scores.vocabulary),
      (l10n.txtDsFluency, scores.fluency),
      (l10n.txtDsPronunciation, scores.pronunciation),
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
