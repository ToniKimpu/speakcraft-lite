import 'package:speakcraft/repositories/daily_speaking/daily_speaking_session_repository.dart';
import 'package:flutter/material.dart';
import 'package:speakcraft/config/pmp_colors.dart';
import 'package:speakcraft/config/pmp_routes.dart';
import 'package:speakcraft/config/pmp_text_styles.dart';
import 'package:speakcraft/l10n/generated/l10n.dart';
import 'package:speakcraft/model/daily_speaking/daily_speaking_feedback.dart';
import 'package:speakcraft/model/daily_speaking/daily_speaking_session.dart';
import 'package:speakcraft/model/daily_speaking/daily_speaking_topic.dart';
import 'package:speakcraft/screens/daily_speaking/widgets/session_audio_player.dart';
import 'package:speakcraft/shared_widgets/pronounce_button.dart';

part 'feedback_result_page.summary.dart';
part 'feedback_result_page.cards.dart';

/// Shared result screen for all three on-ramps.
///
/// Renders every section that the [DailySpeakingFeedback] payload may include
/// — `targetPhraseResults` only appears when the session had a topic with
/// target phrases (i.e. the P3 suggested-topic path).
///
/// [topic] is non-null for loop-capable on-ramps (suggested + own-topic), or is
/// rebuilt from the saved row when reopened from history. Its presence enables
/// "Polish & retry" — re-recording the same topic as the next version. The
/// native version of each attempt ships inside that attempt's own feedback
/// (`sentences[].native`, seen in the Review screen's Compare view), so there's
/// no separate reveal step.
class FeedbackResultPage extends StatefulWidget {
  const FeedbackResultPage({
    super.key,
    required this.session,
    this.topic,
  });

  final DailySpeakingSession session;
  final DailySpeakingTopic? topic;

  @override
  State<FeedbackResultPage> createState() => _FeedbackResultPageState();
}

class _FeedbackResultPageState extends State<FeedbackResultPage> {
  DailySpeakingSession get session => widget.session;
  DailySpeakingTopic? get topic => widget.topic;

  /// The topic to resume — passed live, or rebuilt from the saved row when this
  /// page was reopened from history.
  DailySpeakingTopic? get _resumableTopic => topic ?? session.decodedTopic;

  /// "Polish & retry" — offered live AND from history; needs only a topic to
  /// carry forward. All three on-ramps loop: suggested + own-topic use the
  /// chosen topic, just-talk uses the AI's inferred topic (saved on submit), so
  /// the only sessions without one are just-talk with no inferred topic and
  /// legacy rows.
  bool get _canRetry => _resumableTopic != null;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final feedback = session.feedback;
    final isText = session.inputMode == DailySpeakingInputMode.text;
    final transcript = feedback.hasSentences
        ? feedback.effectiveTranscript
        : (session.inputText ?? '').trim();
    final hasInput = transcript.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.txtDsFeedback),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => _goHome(context),
        ),
      ),
      // Single scrolling page; only the action bar is pinned at the bottom so
      // the primary choices stay reachable however long the feedback runs.
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _ResultHeader(session: session),
                    if (hasInput) ...[
                      const SizedBox(height: 20),
                      _InputPreviewCard(
                        title: isText
                        
                            ? l10n.txtDsWhatYouWrote
                            : l10n.txtDsWhatYouSaid,
                        text: transcript,
                        canReview: feedback.hasSentences,
                        onReview: () => _openReview(context),
                      ),
                    ],
                    _FeedbackSections(session: session),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                border: Border(
                  top: BorderSide(color: colorScheme.outlineVariant),
                ),
              ),
              child: _ResultActions(
                canRetry: _canRetry,
                onRetry: () => _polishAndRetry(context),
                onDone: () => _finishDone(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Opens the Review & highlights screen for this session's annotated
  /// transcript (inline error highlights + sentence-aligned native compare).
  void _openReview(BuildContext context) {
    Navigator.pushNamed(
      context,
      PmpRoutes.dailySpeakingReview,
      arguments: {'feedback': session.feedback},
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
    } else if (session.onRamp == DailySpeakingOnRamp.guided) {
      // Polish a guided attempt by re-recording the same topic. Only the topic
      // rides along (no paragraph/level) — a retry is naturally less scaffolded,
      // so the record page shows just the objective banner and the "speak from
      // memory" hint.
      route = PmpRoutes.dailySpeakingGuidedRecord;
    } else {
      // Own-topic — always re-record now (the text path is retired, so even a
      // legacy text session is polished by speaking it).
      route = PmpRoutes.dailySpeakingOwnTopicRecord;
    }
    Navigator.pushReplacementNamed(context, route, arguments: args);
  }

  /// Next revision for this chain = the highest stored `revisionNumber` + 1.
  Future<int> _nextRevisionForChain() async {
    final attemptId = session.topicAttemptId;
    if (attemptId == null) return session.revisionNumber + 1;
    final chain =
        await DailySpeakingSessionRepository().chain(attemptId);
    final maxRev = chain.isEmpty
        ? session.revisionNumber
        : chain.map((s) => s.revisionNumber).reduce((a, b) => a > b ? a : b);
    return maxRev + 1;
  }

  /// Finish: if this session is part of a multi-version chain, show a quick
  /// progression recap (v1 → v2 → … score deltas, all from local Drift — no AI
  /// call) before leaving; otherwise go straight home. The recap is the loop's
  /// payoff now that the native rewrite isn't gated behind a reveal.
  Future<void> _finishDone(BuildContext context) async {
    final versions = await _chainScores();
    if (!context.mounted) return;
    if (versions.length < 2) {
      _goHome(context);
      return;
    }
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (sheetContext) => _ProgressionRecap(
        versions: versions,
        onFinish: () {
          Navigator.pop(sheetContext);
          _goHome(context);
        },
      ),
    );
  }

  /// Every version of this topic attempt as (revision, score), ascending. Empty
  /// or single-entry when there's no chain to recap.
  Future<List<({int revision, int score})>> _chainScores() async {
    final attemptId = session.topicAttemptId;
    if (attemptId == null) return const [];
    final chain = await DailySpeakingSessionRepository().chain(attemptId);
    return chain
        .map((s) => (revision: s.revisionNumber, score: s.feedback.score))
        .toList(growable: false);
  }

  void _goHome(BuildContext context) {
    Navigator.popUntil(
      context,
      (route) => route.isFirst || route.settings.name == '/home',
    );
  }
}
