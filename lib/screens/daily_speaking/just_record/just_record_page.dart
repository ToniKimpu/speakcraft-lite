import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speakcraft/bloc/daily_speaking/daily_speaking_history_bloc.dart';
import 'package:speakcraft/config/pmp_routes.dart';
import 'package:speakcraft/config/pmp_text_styles.dart';
import 'package:speakcraft/l10n/generated/l10n.dart';
import 'package:speakcraft/model/daily_speaking/daily_speaking_session.dart';

import '../daily_speaking_entry_page.dart' show kDailySessionLimit;
import '../widgets/session_recorder.dart';

/// P1 on-ramp: tap, talk, then choose feedback. No topic.
class JustRecordPage extends StatelessWidget {
  const JustRecordPage({super.key});

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
                  const _PromptBlock(),
                  const Spacer(),
                  SessionRecorder(
                    disabled: exhausted,
                    disabledMessage:
                        AppLocalizations.of(context).txtDsDailyLimitReached,
                    onComplete: (audioPath, _) {
                      Navigator.pushNamed(
                        context,
                        PmpRoutes.dailySpeakingChooseFeedback,
                        arguments: {
                          'inputMode': DailySpeakingInputMode.voice,
                          'onRamp': DailySpeakingOnRamp.justTalk,
                          'audioPath': audioPath,
                        },
                      );
                    },
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
