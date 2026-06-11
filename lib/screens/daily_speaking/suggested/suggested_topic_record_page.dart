import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speakcraft/bloc/daily_speaking/daily_speaking_history_bloc.dart';
import 'package:speakcraft/config/pmp_colors.dart';
import 'package:speakcraft/config/pmp_routes.dart';
import 'package:speakcraft/config/pmp_text_styles.dart';
import 'package:speakcraft/l10n/generated/l10n.dart';
import 'package:speakcraft/model/daily_speaking/daily_speaking_session.dart';
import 'package:speakcraft/model/daily_speaking/daily_speaking_topic.dart';

import '../daily_speaking_entry_page.dart' show kDailySessionLimit;
import '../widgets/import_audio_sheet.dart';
import '../widgets/session_recorder.dart';

/// P3 — recorder with the topic header pinned and target-phrase chips
/// visible as passive reminders. The chips don't get ticked off here (we
/// don't know what the learner said yet) — they appear ticked / missed on
/// the result page once the edge function scores them.
class SuggestedTopicRecordPage extends StatelessWidget {
  const SuggestedTopicRecordPage({
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
      appBar: AppBar(title: Text(topic.title)),
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
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _TopicHeader(topic: topic),
                  if (topic.targetPhrases.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    _PhraseReminders(phrases: topic.targetPhrases),
                  ],
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
        'onRamp': DailySpeakingOnRamp.suggested,
        'audioPath': audioPath,
        'topic': topic,
        'topicAttemptId': topicAttemptId,
        'revisionNumber': revisionNumber,
      },
    );
  }
}

class _TopicHeader extends StatelessWidget {
  const _TopicHeader({required this.topic});
  final DailySpeakingTopic topic;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.primary.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.primary.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.menu_book, size: 18, color: colorScheme.primary),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              topic.promptEn,
              style: PmpTextStyles.body2Regular.copyWith(
                color: colorScheme.onSurface,
                height: 1.4,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _PhraseReminders extends StatelessWidget {
  const _PhraseReminders({required this.phrases});
  final List<TopicTargetPhrase> phrases;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.flag_outlined,
                size: 14, color: PmpColors.info500),
            const SizedBox(width: 6),
            Text(
              AppLocalizations.of(context).txtDsTryToUse,
              style: PmpTextStyles.labelSemi.copyWith(
                color: PmpColors.info500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: phrases
              .map(
                (p) => Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: colorScheme.outlineVariant),
                  ),
                  child: Text(
                    p.phraseEn,
                    style: PmpTextStyles.sub.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              )
              .toList(growable: false),
        ),
      ],
    );
  }
}
