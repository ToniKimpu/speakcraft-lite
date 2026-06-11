import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speakcraft/bloc/daily_speaking/daily_speaking_history_bloc.dart';
import 'package:speakcraft/config/pmp_routes.dart';
import 'package:speakcraft/config/pmp_text_styles.dart';
import 'package:speakcraft/l10n/generated/l10n.dart';
import 'package:speakcraft/model/daily_speaking/daily_speaking_session.dart';
import 'package:speakcraft/model/daily_speaking/daily_speaking_topic.dart';

import '../daily_speaking_entry_page.dart' show kDailySessionLimit;
import '../widgets/import_audio_sheet.dart';
import '../widgets/session_recorder.dart';

/// P1 on-ramp: tap, talk, then choose feedback.
///
/// The first attempt has no topic (pure free-talk). On "Polish & retry" from a
/// previous just-talk session, the AI's inferred [topic] is carried in so v2+
/// is focused on the same subject — the chain stays `onRamp == just_talk`.
class JustRecordPage extends StatelessWidget {
  const JustRecordPage({
    super.key,
    this.topic,
    this.topicAttemptId,
    this.revisionNumber = 1,
  });

  /// Set only when retrying — the inferred topic to keep talking about.
  final DailySpeakingTopic? topic;
  final String? topicAttemptId;
  final int revisionNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).txtDsJustTalk),
      ),
      body: SafeArea(
        child: BlocBuilder<DailySpeakingHistoryBloc,
            DailySpeakingHistoryState>(
          builder: (context, historyState) {
            final used = historyState.maybeWhen(
              loaded: (_, n) => n,
              orElse: () => 0,
            );
            final exhausted = used >= kDailySessionLimit;
            return Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
              child: Column(
                children: [
                  if (topic != null)
                    _InferredTopicBanner(topic: topic!)
                  else
                    const _PromptBlock(),
                  const Spacer(),
                  SessionRecorder(
                    disabled: exhausted,
                    disabledMessage:
                        AppLocalizations.of(context).txtDsDailyLimitReached,
                    onComplete: (audioPath, _) =>
                        _goToFeedback(context, audioPath),
                  ),
                  const SizedBox(height: 8),
                  ImportInsteadButton(
                    enabled: !exhausted,
                    onImported: (audioPath) =>
                        _goToFeedback(context, audioPath),
                  ),
                  const Spacer(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _goToFeedback(BuildContext context, String audioPath) {
    Navigator.pushNamed(
      context,
      PmpRoutes.dailySpeakingChooseFeedback,
      arguments: {
        'inputMode': DailySpeakingInputMode.voice,
        'onRamp': DailySpeakingOnRamp.justTalk,
        'audioPath': audioPath,
        if (topic != null) 'topic': topic,
        if (topicAttemptId != null) 'topicAttemptId': topicAttemptId,
        'revisionNumber': revisionNumber,
      },
    );
  }
}

/// Shown on a just-talk retry: the AI's inferred topic from the previous
/// attempt, so the learner stays on the same subject.
class _InferredTopicBanner extends StatelessWidget {
  const _InferredTopicBanner({required this.topic});
  final DailySpeakingTopic topic;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colorScheme.secondary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.secondary.withValues(alpha: 0.4)),
      ),
      child: Row(
        children: [
          Icon(Icons.refresh, size: 18, color: colorScheme.secondary),
          const SizedBox(width: 8),
          Text(
            AppLocalizations.of(context).txtDsTalkAbout,
            style: PmpTextStyles.labelSemi
                .copyWith(color: colorScheme.secondary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              topic.title,
              style: PmpTextStyles.body1Semi
                  .copyWith(color: colorScheme.onSurface),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _PromptBlock extends StatelessWidget {
  const _PromptBlock();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
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
              Icon(Icons.tips_and_updates_outlined,
                  size: 18, color: colorScheme.primary),
              const SizedBox(width: 8),
              Text(
                l10n.txtDsHowItWorks,
                style: PmpTextStyles.body2Semi
                    .copyWith(color: colorScheme.onSurface),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            l10n.txtDsHowItWorksBody,
            style: PmpTextStyles.body2Regular.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
