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
import 'guided_paragraph_actions.dart';

/// The guided on-ramp's recorder. Mirrors `suggested_topic_record_page.dart`,
/// but shows the learner's own assembled paragraph with **visibility faded by
/// level** — the scaffold shrinks as they grow:
///   L1: their full paragraph is visible (reading their own sentences is a
///       legit beginner win)
///   L2: keyword prompts only (sentence openers) — they reconstruct
///   L3: nothing — they speak from memory
///
/// On "Polish & retry" only the topic is carried back (no paragraph/level), so
/// the script block simply doesn't render — a polish attempt is naturally less
/// scaffolded. Converges into choose-feedback exactly like the other on-ramps,
/// carrying the synthetic `id='guided'` topic so the target-phrase checklist
/// and version loop both work.
class GuidedRecordPage extends StatefulWidget {
  const GuidedRecordPage({
    super.key,
    required this.topic,
    this.userParagraph,
    this.level = 3,
    this.topicAttemptId,
    this.revisionNumber = 1,
  });

  final DailySpeakingTopic topic;

  /// The learner's assembled paragraph (null on retry).
  final String? userParagraph;

  /// 1 = show full paragraph, 2 = keyword prompts, 3 = hidden.
  final int level;

  final String? topicAttemptId;
  final int revisionNumber;

  @override
  State<GuidedRecordPage> createState() => _GuidedRecordPageState();
}

class _GuidedRecordPageState extends State<GuidedRecordPage> {
  /// The script the learner reads from. Starts as the assembled paragraph and
  /// can be tweaked via the edit sheet — it's a teleprompter for the recording
  /// (voice is transcribed by the AI, so edits only refine what they read).
  late String _paragraph = (widget.userParagraph ?? '').trim();

  @override
  Widget build(BuildContext context) {
    final topic = widget.topic;
    final hasScript = _paragraph.isNotEmpty;
    return Scaffold(
      appBar: AppBar(title: Text(topic.title)),
      body: SafeArea(
        child: BlocBuilder<DailySpeakingHistoryBloc, DailySpeakingHistoryState>(
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
                  // Reference region — capped at ~40% of the screen and
                  // scrollable inside, so a long paragraph can never push the
                  // mic off-screen (or overflow the column).
                  // Objective is a fixed header. The script takes the flexible
                  // middle and scrolls internally; the mic keeps its natural
                  // height below, so a long paragraph can never starve it (which
                  // overflowed the column before).
                  _ObjectiveHeader(topic: topic),
                  const SizedBox(height: 16),
                  Expanded(
                    child: hasScript
                        ? _ScriptByLevel(
                            paragraph: _paragraph,
                            level: widget.level,
                            onEdit: _editParagraph,
                            onCopy: _copyParagraph,
                          )
                        : Center(child: _SpeakFromMemoryHint()),
                  ),
                  const SizedBox(height: 16),
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
        'onRamp': DailySpeakingOnRamp.guided,
        'audioPath': audioPath,
        'topic': widget.topic,
        'topicAttemptId': widget.topicAttemptId,
        'revisionNumber': widget.revisionNumber,
      },
    );
  }

  void _copyParagraph() => copyParagraphToClipboard(context, _paragraph);

  Future<void> _editParagraph() async {
    final edited = await showEditParagraphSheet(context, _paragraph);
    if (edited != null && edited.isNotEmpty && edited != _paragraph) {
      setState(() => _paragraph = edited);
    }
  }
}

/// Wraps a scrollable with an always-visible scrollbar so learners notice the
/// capped script region scrolls. Owns the [ScrollController] the always-on
/// thumb requires.
class _ScrollbarBox extends StatefulWidget {
  const _ScrollbarBox({required this.builder});
  final Widget Function(ScrollController controller) builder;

  @override
  State<_ScrollbarBox> createState() => _ScrollbarBoxState();
}

class _ScrollbarBoxState extends State<_ScrollbarBox> {
  final ScrollController _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: _controller,
      thumbVisibility: true,
      child: widget.builder(_controller),
    );
  }
}

class _ObjectiveHeader extends StatelessWidget {
  const _ObjectiveHeader({required this.topic});
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
          Icon(Icons.flag_outlined, size: 18, color: colorScheme.primary),
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

/// Renders the learner's paragraph according to the lesson level.
class _ScriptByLevel extends StatelessWidget {
  const _ScriptByLevel({
    required this.paragraph,
    required this.level,
    this.onEdit,
    this.onCopy,
  });
  final String paragraph;
  final int level;
  final VoidCallback? onEdit;
  final VoidCallback? onCopy;

  /// Keyword prompts for L2: the first few words of each sentence, so the
  /// learner has an opener to lean on but must produce the rest themselves.
  List<String> _prompts() {
    return paragraph
        .split(RegExp(r'(?<=[.!?])\s+'))
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .map((s) {
      final words = s.split(RegExp(r'\s+'));
      final head = words.take(3).join(' ');
      return words.length > 3 ? '$head …' : head;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);

    if (level >= 3) return Center(child: _SpeakFromMemoryHint());

    final label = level == 1
        ? l10n.txtDsGuidedYourParagraph
        : l10n.txtDsGuidedYourKeywords;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              level == 1 ? Icons.notes : Icons.short_text,
              size: 14,
              color: colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: PmpTextStyles.labelSemi
                  .copyWith(color: colorScheme.onSurfaceVariant),
            ),
            const Spacer(),
            if (onCopy != null)
              IconButton(
                onPressed: onCopy,
                icon: const Icon(Icons.copy_rounded, size: 18),
                visualDensity: VisualDensity.compact,
                tooltip: l10n.txtDsGuidedCopy,
                color: colorScheme.onSurfaceVariant,
              ),
            if (onEdit != null)
              IconButton(
                onPressed: onEdit,
                icon: const Icon(Icons.edit_outlined, size: 18),
                visualDensity: VisualDensity.compact,
                tooltip: l10n.txtDsGuidedEdit,
                color: colorScheme.onSurfaceVariant,
              ),
          ],
        ),
        const SizedBox(height: 8),
        // The card flexes to fill the space the mic leaves below, and scrolls
        // internally — short scripts shrink-wrap, long ones cap + scroll. Only
        // the paragraph scrolls; the card border and the label above stay put.
        Flexible(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: colorScheme.outlineVariant),
            ),
            child: _ScrollbarBox(
              builder: (controller) => SingleChildScrollView(
                controller: controller,
                child: level == 1
                    ? Text(
                        paragraph,
                        style: PmpTextStyles.body1Regular.copyWith(
                          color: colorScheme.onSurface,
                          height: 1.7,
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _prompts()
                            .map(
                              (p) => Padding(
                                padding: const EdgeInsets.only(bottom: 6),
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 7, right: 8),
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
                                        p,
                                        style: PmpTextStyles.body2Regular
                                            .copyWith(
                                          color: colorScheme.onSurface,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(growable: false),
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SpeakFromMemoryHint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        const Icon(Icons.psychology_outlined,
            size: 16, color: PmpColors.success500),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            AppLocalizations.of(context).txtDsGuidedSpeakFromMemory,
            style: PmpTextStyles.body2Regular
                .copyWith(color: colorScheme.onSurfaceVariant),
          ),
        ),
      ],
    );
  }
}
