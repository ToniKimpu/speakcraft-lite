import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speakcraft/bloc/daily_speaking/daily_speaking_prep_bloc.dart';
import 'package:speakcraft/config/pmp_colors.dart';
import 'package:speakcraft/config/pmp_routes.dart';
import 'package:speakcraft/config/pmp_text_styles.dart';
import 'package:speakcraft/l10n/generated/l10n.dart';
import 'package:speakcraft/model/daily_speaking/daily_speaking_topic.dart';
import 'package:speakcraft/services/daily_speaking/daily_speaking_service.dart'
    show PrepAskKind;

/// P2 — own-topic AI prep scaffold. Mirrors [SuggestedTopicPrepPage] but is
/// driven by [DailySpeakingPrepBloc] state instead of a const topic: the typed
/// topic is expanded by an AI call into vocab / target phrases / warmups, then
/// a small set of constrained follow-up "ask" chips append more.
///
/// The section widgets here are intentionally copied from
/// `suggested/suggested_topic_prep_page.dart` (not shared) to keep that working
/// flow untouched — a small de-dup opportunity flagged for later cleanup.
class OwnTopicScaffoldPage extends StatelessWidget {
  const OwnTopicScaffoldPage({super.key, required this.topicText});

  /// The bare typed topic — kept so Retry can re-dispatch [expand] and the
  /// "record without prep" escape can build a minimal synthetic topic.
  final String topicText;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.txtDsOwnTopic)),
      body: SafeArea(
        child: BlocBuilder<DailySpeakingPrepBloc, DailySpeakingPrepState>(
          builder: (context, state) {
            return state.when(
              initial: () => const _PrepLoading(),
              loading: () => const _PrepLoading(),
              loaded: (topic, asking, asksUsed) => _PrepLoaded(
                topic: topic,
                asking: asking,
                asksUsed: asksUsed,
                topicText: topicText,
              ),
              error: (_) => _PrepError(topicText: topicText),
            );
          },
        ),
      ),
    );
  }
}

class _PrepLoading extends StatelessWidget {
  const _PrepLoading();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context).txtDsBuildingPrep,
            style: PmpTextStyles.body2Regular.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _PrepError extends StatelessWidget {
  const _PrepError({required this.topicText});
  final String topicText;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline,
                size: 40, color: colorScheme.onSurfaceVariant),
            const SizedBox(height: 12),
            Text(
              l10n.txtDsPrepFailed,
              textAlign: TextAlign.center,
              style: PmpTextStyles.body1Regular.copyWith(
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: () => context
                  .read<DailySpeakingPrepBloc>()
                  .add(DailySpeakingPrepEvent.expand(topicText)),
              icon: const Icon(Icons.refresh),
              label: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(l10n.txtDsRetry),
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => _recordWithoutPrep(context, topicText),
              child: Text(l10n.txtDsRecordWithoutPrep),
            ),
          ],
        ),
      ),
    );
  }
}

/// Navigate straight into the recorder with a minimal synthetic topic (the prep
/// fields stay empty) — the "skip prep" escape hatch. Uses `pushReplacement` so
/// back doesn't return to a stale/failed scaffold mid-record.
void _recordWithoutPrep(BuildContext context, String topicText) {
  final text = topicText.trim();
  Navigator.pushReplacementNamed(
    context,
    PmpRoutes.dailySpeakingOwnTopicRecord,
    arguments: {
      'topic': DailySpeakingTopic(
        id: 'own',
        title: text,
        promptEn: text,
        promptMm: '',
      ),
    },
  );
}

class _PrepLoaded extends StatelessWidget {
  const _PrepLoaded({
    required this.topic,
    required this.asking,
    required this.asksUsed,
    required this.topicText,
  });

  final DailySpeakingTopic topic;
  final bool asking;
  final int asksUsed;
  final String topicText;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final mins = (topic.durationTargetSeconds / 60).round();
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _PromptCard(topic: topic, mins: mins),
                if (topic.vocabulary.isNotEmpty) ...[
                  const SizedBox(height: 20),
                  _SectionHeader(
                    icon: Icons.translate,
                    iconColor: colorScheme.primary,
                    title: l10n.txtDsWordsYouMightUse,
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: topic.vocabulary
                        .map((v) => _VocabChip(item: v))
                        .toList(growable: false),
                  ),
                ],
                if (topic.targetPhrases.isNotEmpty) ...[
                  const SizedBox(height: 20),
                  _SectionHeader(
                    icon: Icons.flag_outlined,
                    iconColor: PmpColors.info500,
                    title: l10n.txtDsTryUseThesePhrases,
                  ),
                  const SizedBox(height: 10),
                  ...topic.targetPhrases.map(
                    (p) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: _TargetPhraseCard(phrase: p),
                    ),
                  ),
                ],
                if (topic.warmupQuestions.isNotEmpty) ...[
                  const SizedBox(height: 20),
                  _SectionHeader(
                    icon: Icons.help_outline,
                    iconColor: PmpColors.warning500,
                    title: l10n.txtDsThingsYouCanMention,
                  ),
                  const SizedBox(height: 8),
                  ...topic.warmupQuestions.map(
                    (q) => Padding(
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
                              q,
                              style: PmpTextStyles.body2Regular.copyWith(
                                color: colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 24),
                _AskMoreSection(asking: asking, asksUsed: asksUsed),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
          child: FilledButton.icon(
            onPressed: () {
              Navigator.pushReplacementNamed(
                context,
                PmpRoutes.dailySpeakingOwnTopicRecord,
                arguments: {'topic': topic},
              );
            },
            icon: const Icon(Icons.mic),
            label: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(l10n.txtDsStartRecording),
            ),
          ),
        ),
      ],
    );
  }
}

/// The constrained follow-up "ask" chips. Disabled while a request is in flight
/// or once the per-topic cap is hit; a gentle message replaces them at the cap.
class _AskMoreSection extends StatelessWidget {
  const _AskMoreSection({required this.asking, required this.asksUsed});

  final bool asking;
  final int asksUsed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final atCap = asksUsed >= DailySpeakingPrepBloc.maxAsks;
    final enabled = !asking && !atCap;

    final asks = <(PrepAskKind, String)>[
      (PrepAskKind.moreVocab, l10n.txtDsAskMoreVocab),
      (PrepAskKind.usefulPhrases, l10n.txtDsAskUsefulPhrases),
      (PrepAskKind.howToStart, l10n.txtDsAskHowToStart),
      (PrepAskKind.harderWords, l10n.txtDsAskHarderWords),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _SectionHeader(
              icon: Icons.auto_awesome,
              iconColor: colorScheme.primary,
              title: l10n.txtDsAskForMore,
            ),
            if (asking) ...[
              const SizedBox(width: 10),
              const SizedBox(
                width: 14,
                height: 14,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ],
          ],
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: asks
              .map(
                (a) => ActionChip(
                  label: Text(a.$2),
                  onPressed: enabled
                      ? () => context
                          .read<DailySpeakingPrepBloc>()
                          .add(DailySpeakingPrepEvent.askMore(a.$1))
                      : null,
                ),
              )
              .toList(growable: false),
        ),
        if (atCap) ...[
          const SizedBox(height: 8),
          Text(
            l10n.txtDsAsksUsedUp,
            style: PmpTextStyles.sub.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Section widgets — copied from suggested_topic_prep_page.dart (see class doc).
// ---------------------------------------------------------------------------

class _PromptCard extends StatelessWidget {
  const _PromptCard({required this.topic, required this.mins});
  final DailySpeakingTopic topic;
  final int mins;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.primary.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colorScheme.primary.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.format_quote, size: 18, color: colorScheme.primary),
              const SizedBox(width: 6),
              Text(
                AppLocalizations.of(context).txtDsYourPrompt,
                style: PmpTextStyles.labelSemi.copyWith(
                  color: colorScheme.primary,
                ),
              ),
              const Spacer(),
              Icon(Icons.timer_outlined,
                  size: 14, color: colorScheme.onSurfaceVariant),
              const SizedBox(width: 4),
              Text(
                AppLocalizations.of(context).txtDsApproxMin(mins),
                style: PmpTextStyles.sub
                    .copyWith(color: colorScheme.onSurfaceVariant),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            topic.promptEn,
            style: PmpTextStyles.body1Regular.copyWith(
              color: colorScheme.onSurface,
              height: 1.5,
            ),
          ),
          if (topic.promptMm.isNotEmpty) ...[
            const SizedBox(height: 10),
            Text(
              topic.promptMm,
              style: PmpTextStyles.body2Regular.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontFamily: 'Noto Sans Myanmar',
                height: 1.7,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.icon,
    required this.iconColor,
    required this.title,
  });
  final IconData icon;
  final Color iconColor;
  final String title;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Icon(icon, size: 18, color: iconColor),
        const SizedBox(width: 8),
        Text(
          title,
          style:
              PmpTextStyles.body2Semi.copyWith(color: colorScheme.onSurface),
        ),
      ],
    );
  }
}

class _VocabChip extends StatelessWidget {
  const _VocabChip({required this.item});
  final TopicVocabItem item;

  void _showDetail(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (_) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.term,
              style: PmpTextStyles.h2.copyWith(
                color: colorScheme.onSurface,
                fontFamily: 'ArchivoBlack Regular',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              item.definitionMm,
              style: PmpTextStyles.body1Regular.copyWith(
                color: colorScheme.onSurface,
                fontFamily: 'Noto Sans Myanmar',
                height: 1.6,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context).txtDsExample,
              style: PmpTextStyles.labelSemi.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              item.exampleEn,
              style: PmpTextStyles.body2Regular.copyWith(
                color: colorScheme.onSurface,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      avatar: const Icon(Icons.book_outlined, size: 16),
      label: Text(item.term),
      onPressed: () => _showDetail(context),
    );
  }
}

class _TargetPhraseCard extends StatelessWidget {
  const _TargetPhraseCard({required this.phrase});
  final TopicTargetPhrase phrase;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            phrase.phraseEn,
            style: PmpTextStyles.body2Semi.copyWith(
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            phrase.translationMm,
            style: PmpTextStyles.body2Regular.copyWith(
              color: colorScheme.onSurfaceVariant,
              fontFamily: 'Noto Sans Myanmar',
            ),
          ),
        ],
      ),
    );
  }
}
