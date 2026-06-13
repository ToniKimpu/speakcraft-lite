import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speakcraft/bloc/daily_speaking/daily_speaking_prep_bloc.dart';
import 'package:speakcraft/config/pmp_routes.dart';
import 'package:speakcraft/config/pmp_text_styles.dart';
import 'package:speakcraft/l10n/generated/l10n.dart';
import 'package:speakcraft/model/daily_speaking/daily_speaking_topic.dart';
import 'package:speakcraft/model/daily_speaking/prep_section.dart';
import 'package:speakcraft/screens/daily_speaking/widgets/prep_sections.dart';

/// P2 — own-topic AI prep scaffold. The typed topic is expanded by an AI call
/// (stubbed) into the sections the learner chose on the choose-prep screen, then
/// rendered with the **shared** prep layout ([PrepGuideSections]) so it matches
/// the suggested-topic prep exactly. An "Add more help" row pulls any sections
/// the learner didn't pick up front.
class OwnTopicScaffoldPage extends StatelessWidget {
  const OwnTopicScaffoldPage({
    super.key,
    required this.topicText,
    required this.sections,
  });

  /// The bare typed topic — kept so Retry can re-dispatch [expand] and the
  /// "record without prep" escape can build a minimal synthetic topic.
  final String topicText;

  /// The sections the learner chose — kept so Retry regenerates the same set.
  final Set<PrepSection> sections;

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
              loaded: (topic, asking) => _PrepLoaded(
                topic: topic,
                asking: asking,
              ),
              error: (_) => _PrepError(topicText: topicText, sections: sections),
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
  const _PrepError({required this.topicText, required this.sections});
  final String topicText;
  final Set<PrepSection> sections;

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
              onPressed: () => context.read<DailySpeakingPrepBloc>().add(
                    DailySpeakingPrepEvent.expand(topicText, sections),
                  ),
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
  const _PrepLoaded({required this.topic, required this.asking});

  final DailySpeakingTopic topic;
  final bool asking;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final mins = (topic.durationTargetSeconds / 60).round();
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
            children: [
              PrepPromptCard(topic: topic, mins: mins),
              PrepGuideSections(topic: topic),
              const SizedBox(height: 20),
              _AddMoreHelp(topic: topic, asking: asking),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
          child: SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  PmpRoutes.dailySpeakingOwnTopicRecord,
                  arguments: {'topic': topic},
                );
              },
              icon: const Icon(Icons.mic, size: 20),
              label: Text(l10n.txtDsStartRecording),
            ),
          ),
        ),
      ],
    );
  }
}

/// Quick-add chips for the prep sections the learner didn't pick up front. Each
/// generates just that section and merges it in. Disappears once every section
/// is present.
class _AddMoreHelp extends StatelessWidget {
  const _AddMoreHelp({required this.topic, required this.asking});

  final DailySpeakingTopic topic;
  final bool asking;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final missing = kPrepSections
        .where((s) => !prepSectionPresent(s, topic))
        .toList(growable: false);
    if (missing.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.auto_awesome, size: 18, color: colorScheme.primary),
            const SizedBox(width: 8),
            Text(
              l10n.txtDsAddMoreHelp,
              style: PmpTextStyles.body2Semi
                  .copyWith(color: colorScheme.onSurface),
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
          children: missing
              .map(
                (s) => ActionChip(
                  avatar: const Icon(Icons.add, size: 16),
                  label: Text(_sectionTitle(context, s)),
                  onPressed: asking
                      ? null
                      : () => context
                          .read<DailySpeakingPrepBloc>()
                          .add(DailySpeakingPrepEvent.askMore(s)),
                ),
              )
              .toList(growable: false),
        ),
      ],
    );
  }
}

String _sectionTitle(BuildContext context, PrepSection s) {
  final l10n = AppLocalizations.of(context);
  switch (s) {
    case PrepSection.structure:
      return l10n.txtDsHowToStructure;
    case PrepSection.vocab:
      return l10n.txtDsWordsYouMightUse;
    case PrepSection.phrases:
      return l10n.txtDsTryUseThesePhrases;
    case PrepSection.grammar:
      return l10n.txtDsGrammarPatterns;
    case PrepSection.mistakes:
      return l10n.txtDsWatchOutFor;
    case PrepSection.example:
      return l10n.txtDsExampleAnswer;
  }
}
