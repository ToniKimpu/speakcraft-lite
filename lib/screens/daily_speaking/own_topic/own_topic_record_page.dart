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

/// P2 — own-topic voice recorder. Same recorder UI as just-record, with the
/// user's typed topic pinned at the top so they don't lose track.
class OwnTopicRecordPage extends StatelessWidget {
  const OwnTopicRecordPage({
    super.key,
    required this.topic,
    this.topicAttemptId,
    this.revisionNumber = 1,
  });

  final DailySpeakingTopic topic;

  /// Version-loop context — set when arriving from "Polish & retry".
  final String? topicAttemptId;
  final int revisionNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context).txtDsOwnTopic)),
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
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
              child: Column(
                children: [
                  _TopicBanner(topic: topic),
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
        'onRamp': DailySpeakingOnRamp.ownTopic,
        'audioPath': audioPath,
        'topic': topic,
        'topicAttemptId': topicAttemptId,
        'revisionNumber': revisionNumber,
      },
    );
  }
}

class _TopicBanner extends StatelessWidget {
  const _TopicBanner({required this.topic});
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
          Icon(Icons.edit_note, size: 18, color: colorScheme.secondary),
          const SizedBox(width: 8),
          Text(
            AppLocalizations.of(context).txtDsYourTopic,
            style: PmpTextStyles.labelSemi.copyWith(
              color: colorScheme.secondary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              topic.title,
              style: PmpTextStyles.body1Semi.copyWith(
                color: colorScheme.onSurface,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
