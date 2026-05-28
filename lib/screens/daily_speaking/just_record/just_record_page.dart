import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speakcraft/bloc/daily_speaking/daily_speaking_bloc.dart';
import 'package:speakcraft/bloc/daily_speaking/daily_speaking_history_bloc.dart';
import 'package:speakcraft/config/pmp_routes.dart';
import 'package:speakcraft/config/pmp_text_styles.dart';
import 'package:speakcraft/model/daily_speaking/daily_speaking_session.dart';

import '../daily_speaking_entry_page.dart' show kDailySessionLimit;
import '../widgets/session_recorder.dart';

/// P1 on-ramp: tap, talk, get feedback. No topic.
class JustRecordPage extends StatelessWidget {
  const JustRecordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Just talk'),
      ),
      body: SafeArea(
        child: BlocConsumer<DailySpeakingBloc, DailySpeakingState>(
          listener: (context, state) {
            state.maybeWhen(
              success: (session) {
                Navigator.pushReplacementNamed(
                  context,
                  PmpRoutes.dailySpeakingFeedback,
                  arguments: {'session': session},
                );
                context
                    .read<DailySpeakingHistoryBloc>()
                    .add(const DailySpeakingHistoryEvent.load());
              },
              socketError: () => _showSnack(context, 'No internet connection.'),
              error: (msg) => _showSnack(context, msg),
              orElse: () {},
            );
          },
          builder: (context, state) {
            return BlocBuilder<DailySpeakingHistoryBloc,
                DailySpeakingHistoryState>(
              builder: (context, historyState) {
                final used = historyState.maybeWhen(
                  loaded: (_, n) => n,
                  orElse: () => 0,
                );
                final exhausted = used >= kDailySessionLimit;
                final isSubmitting = state.maybeWhen(
                  submitting: (_) => true,
                  orElse: () => false,
                );

                if (isSubmitting) {
                  return const _SubmittingView();
                }

                return Padding(
                  padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
                  child: Column(
                    children: [
                      const _PromptBlock(),
                      const Spacer(),
                      SessionRecorder(
                        disabled: exhausted,
                        disabledMessage:
                            'Daily limit reached — comes back tomorrow.',
                        onComplete: (audioPath, _) {
                          context.read<DailySpeakingBloc>().add(
                                DailySpeakingEvent.submitVoice(
                                  audioPath: audioPath,
                                  onRamp: DailySpeakingOnRamp.justTalk,
                                ),
                              );
                        },
                      ),
                      const Spacer(),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _showSnack(BuildContext context, String msg) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(SnackBar(content: Text(msg)));
  }
}

class _PromptBlock extends StatelessWidget {
  const _PromptBlock();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
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
                'How it works',
                style: PmpTextStyles.body2Semi
                    .copyWith(color: colorScheme.onSurface),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '• Tap the mic and just talk for up to 5 minutes.\n'
            '• When you stop, the AI gives you a score, strengths, fixes, and a Burmese explanation.\n'
            "• Don't worry about being perfect — the goal is to keep speaking.",
            style: PmpTextStyles.body2Regular.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _SubmittingView extends StatelessWidget {
  const _SubmittingView();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 20),
            Text(
              'Reviewing your recording…',
              style: PmpTextStyles.body1Semi
                  .copyWith(color: colorScheme.onSurface),
            ),
            const SizedBox(height: 8),
            Text(
              'This usually takes a few seconds.',
              style: PmpTextStyles.body2Regular
                  .copyWith(color: colorScheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}
