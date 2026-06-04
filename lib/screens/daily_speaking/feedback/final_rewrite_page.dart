import 'dart:convert';

import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:speakcraft/config/pmp_colors.dart';
import 'package:speakcraft/config/pmp_text_styles.dart';
import 'package:speakcraft/core/logger/app_logger.dart';
import 'package:speakcraft/l10n/generated/l10n.dart';
import 'package:speakcraft/model/daily_speaking/daily_speaking_feedback.dart';
import 'package:speakcraft/model/daily_speaking/daily_speaking_session.dart';
import 'package:speakcraft/model/daily_speaking/daily_speaking_topic.dart';
import 'package:speakcraft/model/daily_speaking/feedback_section.dart';
import 'package:speakcraft/services/app_database/app_database.dart';
import 'package:speakcraft/services/daily_speaking/daily_speaking_service.dart';

/// The **terminal reveal** at the end of the version loop.
///
/// During iterations the whole-rewrite / sentence-rewrite are held back (see
/// [kTerminalRevealSections]) so the learner does their own polishing. When they
/// tap "I'm done with this topic", we make ONE rewrite-only AI request on their
/// final version and show a native-speaker version to compare against.
///
/// This is intentionally NOT routed through `DailySpeakingBloc`: it does not
/// create a *new* history row (the practice attempts are the v1…vN sessions;
/// this is just the model answer for the best of them). It calls the service
/// directly, so the rewrite's token cost is paid exactly once, here. It does
/// however **merge** the generated rewrite back into the final session's row
/// ([sessionId]) so the learner can reopen the native version from history
/// later without paying tokens again — the result page renders the saved
/// `nativeRewrite` / `sentenceRewrites` sections inline.
class FinalRewritePage extends StatefulWidget {
  const FinalRewritePage({
    super.key,
    this.sessionId,
    required this.inputMode,
    required this.onRamp,
    this.audioPath,
    this.text,
    this.learnerWords,
    this.topic,
    this.finalScore,
  });

  /// Row id of the learner's final version. The generated rewrite is merged
  /// into its stored feedback so it survives past this screen. Null only if the
  /// caller couldn't supply it (then the rewrite is shown but not saved).
  final int? sessionId;
  final String inputMode; // DailySpeakingInputMode.voice | .text
  final String onRamp;
  final String? audioPath;
  final String? text;

  /// The learner's own words for the side-by-side display — the AI transcript
  /// for voice, the typed text for the write path. Decoupled from [text] (which
  /// is only the AI input for the text path) so the comparison renders on voice
  /// too. Falls back to [text] when absent.
  final String? learnerWords;
  final DailySpeakingTopic? topic;
  final int? finalScore;

  bool get _isVoice => inputMode == DailySpeakingInputMode.voice;

  @override
  State<FinalRewritePage> createState() => _FinalRewritePageState();
}

class _FinalRewritePageState extends State<FinalRewritePage> {
  late final Future<DailySpeakingFeedback> _future;

  @override
  void initState() {
    super.initState();
    _future = _loadRewrite();
  }

  Future<DailySpeakingFeedback> _loadRewrite() async {
    const sections = [
      FeedbackSectionKey.wholeRewrite,
      FeedbackSectionKey.sentenceRewrite,
    ];
    final input = widget._isVoice
        ? SessionInput.voice(
            audioPath: widget.audioPath!,
            onRamp: widget.onRamp,
            requestedSections: sections,
            topic: widget.topic,
          )
        : SessionInput.text(
            text: widget.text!,
            onRamp: widget.onRamp,
            requestedSections: sections,
            topic: widget.topic,
          );
    final feedback = await DailySpeakingService().reviewSession(input);
    await _persistRewrite(feedback);
    return feedback;
  }

  /// Merges the generated rewrite into the final session's stored feedback so
  /// it's re-viewable from history (no extra tokens on re-open). Best-effort:
  /// a failure here must not block showing the reveal.
  Future<void> _persistRewrite(DailySpeakingFeedback rewrite) async {
    final id = widget.sessionId;
    if (id == null) return;
    if (rewrite.nativeRewrite.isEmpty && rewrite.sentenceRewrites.isEmpty) {
      return;
    }
    try {
      final table = AppDatabase.instance().dailySpeakingSessionTable;
      final row =
          await (table.select()..where((t) => t.id.equals(id))).getSingleOrNull();
      if (row == null) return;
      final existing = DailySpeakingFeedback.fromJson(
        Map<String, dynamic>.from(jsonDecode(row.feedbackJson) as Map),
      );
      final merged = existing.copyWith(
        nativeRewrite: rewrite.nativeRewrite,
        sentenceRewrites: rewrite.sentenceRewrites,
      );
      await (table.update()..where((t) => t.id.equals(id))).write(
        DailySpeakingSessionTableCompanion(
          feedbackJson: drift.Value(jsonEncode(merged.toJson())),
        ),
      );
    } catch (e) {
      AppLogger.instance
          .error('FinalRewrite: persist rewrite failed: $e', error: e);
    }
  }

  void _goHome() {
    Navigator.popUntil(
      context,
      (route) => route.isFirst || route.settings.name == '/home',
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.txtDsNativeVersion)),
      body: SafeArea(
        child: FutureBuilder<DailySpeakingFeedback>(
          future: _future,
          builder: (context, snap) {
            if (snap.connectionState != ConnectionState.done) {
              return const _LoadingView();
            }
            if (snap.hasError || snap.data == null) {
              return _ErrorView(onRetry: () => setState(() {
                    _future = _loadRewrite();
                  }));
            }
            return _RewriteView(
              feedback: snap.data!,
              learnerText: widget.learnerWords ?? widget.text,
              finalScore: widget.finalScore,
              onDone: _goHome,
              doneLabel: l10n.txtDone,
            );
          },
        ),
      ),
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 20),
          Text(
            AppLocalizations.of(context).txtDsWritingNativeVersion,
            textAlign: TextAlign.center,
            style:
                PmpTextStyles.body1Semi.copyWith(color: colorScheme.onSurface),
          ),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.onRetry});
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 40, color: colorScheme.error),
            const SizedBox(height: 12),
            Text(
              AppLocalizations.of(context).txtDsCouldntGenerateNative,
              textAlign: TextAlign.center,
              style: PmpTextStyles.body1Semi
                  .copyWith(color: colorScheme.onSurface),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: onRetry,
              child: Text(AppLocalizations.of(context).txtDsTryAgain),
            ),
          ],
        ),
      ),
    );
  }
}

class _RewriteView extends StatelessWidget {
  const _RewriteView({
    required this.feedback,
    required this.learnerText,
    required this.finalScore,
    required this.onDone,
    required this.doneLabel,
  });

  final DailySpeakingFeedback feedback;
  final String? learnerText;
  final int? finalScore;
  final VoidCallback onDone;
  final String doneLabel;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Icon(Icons.emoji_events,
                  size: 22, color: PmpColors.accentOrange),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  finalScore == null
                      ? l10n.txtDsNativeHeaderNoScore
                      : l10n.txtDsNativeHeaderScore(finalScore!),
                  style: PmpTextStyles.body1Semi
                      .copyWith(color: colorScheme.onSurface),
                ),
              ),
            ],
          ),
          // Show the learner's own words (typed text, or the voice transcript)
          // side-by-side with the native version when we have them.
          if (learnerText != null && learnerText!.trim().isNotEmpty) ...[
            const SizedBox(height: 20),
            _Label(text: l10n.txtDsYourVersion),
            const SizedBox(height: 8),
            _PlainCard(text: learnerText!.trim()),
          ],
          if (feedback.nativeRewrite.isNotEmpty) ...[
            const SizedBox(height: 20),
            _Label(text: l10n.txtDsNativeVersion),
            const SizedBox(height: 8),
            Container(
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
          ],
          if (feedback.sentenceRewrites.isNotEmpty) ...[
            const SizedBox(height: 20),
            _Label(text: l10n.txtDsSentenceBySentence),
            const SizedBox(height: 8),
            for (final s in feedback.sentenceRewrites)
              _SentencePair(original: s.original, rewrite: s.rewrite),
          ],
          const SizedBox(height: 28),
          FilledButton(
            onPressed: onDone,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(doneLabel),
            ),
          ),
        ],
      ),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Text(
      text.toUpperCase(),
      style: PmpTextStyles.sub.copyWith(
        color: colorScheme.onSurfaceVariant,
        letterSpacing: 0.6,
      ),
    );
  }
}

class _PlainCard extends StatelessWidget {
  const _PlainCard({required this.text});
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
          color: colorScheme.onSurfaceVariant,
          height: 1.6,
        ),
      ),
    );
  }
}

class _SentencePair extends StatelessWidget {
  const _SentencePair({required this.original, required this.rewrite});
  final String original;
  final String rewrite;

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
            original,
            style: PmpTextStyles.body2Regular.copyWith(
              color: colorScheme.onSurfaceVariant,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            rewrite,
            style: PmpTextStyles.body1Semi
                .copyWith(color: PmpColors.success500, height: 1.5),
          ),
        ],
      ),
    );
  }
}
