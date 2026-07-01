import 'dart:ui' show ImageFilter;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:speakcraft/bloc/video_step_progress/video_step_progress_bloc.dart';
import 'package:speakcraft/config/pmp_colors.dart';
import 'package:speakcraft/config/pmp_routes.dart';
import 'package:speakcraft/config/pmp_text_styles.dart';
import 'package:speakcraft/core/logger/app_logger.dart';
import 'package:speakcraft/l10n/generated/l10n.dart';
import 'package:speakcraft/model/listening/listening.dart';
import 'package:speakcraft/model/video_step_progress/video_step_progress.dart';
import 'package:speakcraft/repositories/youtube_import/youtube_import_repository.dart';
import 'package:speakcraft/screens/listening_and_shadowing/utils/lesson_steps.dart';
import 'package:speakcraft/shared_widgets/glass.dart';
import 'package:speakcraft/shared_widgets/guest_gate.dart';
import 'package:speakcraft/shared_widgets/premium_gate.dart';

class LessonHubPage extends StatefulWidget {
  const LessonHubPage({super.key, required this.listening});

  final Listening listening;

  @override
  State<LessonHubPage> createState() => _LessonHubPageState();
}

class _LessonHubPageState extends State<LessonHubPage> {
  final _importRepo = YoutubeImportRepository();

  // Local, mutable copy of the lesson. For imports we populate the
  // record/key-takeaways paths in place after lazy generation, so the step
  // pages we navigate to receive a listening with the freshly-generated path.
  late Listening _listening;

  @override
  void initState() {
    super.initState();
    _listening = widget.listening;
    context
        .read<VideoStepProgressBloc>()
        .add(VideoStepProgressEvent.loadVideo(_listening.youtubeId));
  }

  List<_StepConfig> _visibleSteps() {
    return [
      for (final step in visibleLessonSteps(_listening)) _configForStep(step),
    ];
  }

  _StepConfig _configForStep(VideoLessonStep step) {
    switch (step) {
      case VideoLessonStep.watch:
        return _StepConfig(
          step: VideoLessonStep.watch,
          title: AppLocalizations.of(context).txtStepWatchTitle,
          subtitle: AppLocalizations.of(context).txtStepWatchSubtitle,
          icon: Symbols.play_circle,
          route: PmpRoutes.youtubeVideoPage,
        );
      case VideoLessonStep.keyTakeaways:
        return _StepConfig(
          step: VideoLessonStep.keyTakeaways,
          title: AppLocalizations.of(context).txtStepTakeawaysTitle,
          subtitle: AppLocalizations.of(context).txtStepTakeawaysSubtitle,
          icon: Symbols.workspace_premium,
          route: PmpRoutes.keyTakeawaysPage,
        );
      case VideoLessonStep.explanation:
        return _StepConfig(
          step: VideoLessonStep.explanation,
          title: AppLocalizations.of(context).txtStepStudyTitle,
          subtitle: AppLocalizations.of(context).txtStepStudySubtitle,
          icon: Symbols.menu_book,
          route: PmpRoutes.sentenceExplanationList,
        );
      case VideoLessonStep.shadowing:
        return _StepConfig(
          step: VideoLessonStep.shadowing,
          title: AppLocalizations.of(context).txtStepShadowTitle,
          subtitle: AppLocalizations.of(context).txtStepShadowSubtitle,
          icon: Symbols.headphones,
          route: PmpRoutes.shadowingPage,
        );
      case VideoLessonStep.record:
        return _StepConfig(
          step: VideoLessonStep.record,
          title: AppLocalizations.of(context).txtStepRecordTitle,
          subtitle: AppLocalizations.of(context).txtStepRecordSubtitle,
          icon: Symbols.mic,
          route: PmpRoutes.speechPracticeSessionPage,
        );
      case VideoLessonStep.challenge:
        return const _StepConfig(
          step: VideoLessonStep.challenge,
          title: 'Listening Challenge',
          subtitle: 'No subtitles — mark the sentences you can\'t catch.',
          icon: Symbols.hearing,
          route: PmpRoutes.listeningChallengePage,
        );
    }
  }

  bool _isLocked(VideoLessonStep step) =>
      step != VideoLessonStep.watch &&
      !isUnlocked(isFree: _listening.isFree);

  Future<void> _openStep(_StepConfig config) async {
    if (_isLocked(config.step)) {
      showPremiumSheet(context, featureName: config.title);
      return;
    }
    // Imported videos generate Key Takeaways / Speak-on-your-own on first open
    // (mutually exclusive steps). Generate, populate the path, then continue.
    final needsKeyTakeaways = config.step == VideoLessonStep.keyTakeaways &&
        _listening.keyTakeawaysPath.isEmpty &&
        _listening.importId.isNotEmpty;
    final needsRecord = config.step == VideoLessonStep.record &&
        _listening.recordSubtitlePath.isEmpty &&
        _listening.importId.isNotEmpty;
    if (needsKeyTakeaways || needsRecord) {
      // Generation runs Gemini; guests must create an account. (Reachable for a
      // free imported video, which isn't premium-locked above.)
      if (await blockAiForGuest(context, featureName: config.title)) return;
      if (!mounted) return;
      final step = needsKeyTakeaways ? 'key_takeaways' : 'record';
      if (!await _generate(step, config.title)) return;
    }

    if (!mounted) return;
    if (config.step == VideoLessonStep.record) {
      _showSpeakModeSheet();
      return;
    }
    Navigator.pushNamed(
      context,
      config.route,
      arguments: {'listening': _listening},
    );
  }

  /// Generate a lazy step (record / key_takeaways) for an import, showing a
  /// blocking spinner. Returns true on success (path now populated on
  /// [_listening]); false if it failed (a message was shown).
  Future<bool> _generate(String step, String featureName) async {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => _GeneratingDialog(featureName: featureName),
    );
    try {
      final res =
          await _importRepo.enrich(importId: _listening.importId, step: step);
      final path = res.path ?? '';
      if (mounted) {
        setState(() {
          _listening = step == 'key_takeaways'
              ? _listening.copyWith(keyTakeawaysPath: path)
              : _listening.copyWith(recordSubtitlePath: path);
        });
      }
      return path.isNotEmpty;
    } on YoutubeImportException catch (e, st) {
      // Log the raw cause for us; show plain English to the user.
      AppLogger.instance.error(
        'YT_ENRICH $step failed: code=${e.code} message=${e.message}',
        error: e,
        stackTrace: st,
      );
      _showError(_friendlyEnrichError(e, featureName));
      return false;
    } catch (e, st) {
      AppLogger.instance.error('YT_ENRICH $step failed (unexpected): $e',
          error: e, stackTrace: st);
      _showError('Something went wrong preparing $featureName. '
          'Please check your connection and try again.');
      return false;
    } finally {
      if (mounted) Navigator.of(context, rootNavigator: true).pop();
    }
  }

  /// Maps an enrichment failure to a friendly, non-technical message. The raw
  /// cause is logged separately for debugging.
  String _friendlyEnrichError(YoutubeImportException e, String featureName) {
    if (e.needsPremium) return '$featureName is a Premium feature.';
    final raw = (e.message ?? '').toLowerCase();
    final busy = raw.contains('overload') ||
        raw.contains('high demand') ||
        raw.contains('unavailable') ||
        raw.contains('503') ||
        raw.contains('429') ||
        raw.contains('timeout');
    if (busy) {
      return "Our AI is busy right now. Please try $featureName again in a moment.";
    }
    switch (e.code) {
      case 'subtitle_unavailable':
        return "We couldn't load this video's text. Please try again.";
      case 'import_not_found':
      case 'forbidden':
        return "We couldn't find this video. Try reopening it from My Videos.";
      default:
        return "We couldn't prepare $featureName just now. Please try again.";
    }
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 5),
    ));
  }

  void _showSpeakModeSheet() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) => _SpeakModeSheet(
        onBySection: () {
          Navigator.pop(sheetContext);
          Navigator.pushNamed(context, PmpRoutes.speechPracticeSessionPage,
              arguments: {'listening': _listening});
        },
        onFullTalk: () {
          Navigator.pop(sheetContext);
          Navigator.pushNamed(context, PmpRoutes.fullTalkPage,
              arguments: {'listening': _listening});
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final steps = _visibleSteps();

    return GlassScaffold(
      title: Text(l10n.txtLesson),
      body: BlocBuilder<VideoStepProgressBloc, VideoStepProgressState>(
          builder: (context, state) {
            final stepStates = <_StepConfig, VideoStepState>{
              for (final s in steps)
                s: state.stepStateFor(_listening.youtubeId, s.step),
            };
            final doneCount =
                stepStates.values.where((s) => s == VideoStepState.done).length;
            final nextIndex =
                steps.indexWhere((s) => stepStates[s] != VideoStepState.done);
            final allDone = nextIndex == -1;
            final hasStarted =
                stepStates.values.any((s) => s != VideoStepState.notStarted);

            // No pinned bottom button: the highlighted "recommended next" step
            // card is the continue action. The all-done note rides at the end
            // of the list instead of a pinned bar.
            return SafeArea(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                children: [
                  _Header(
                    listening: _listening,
                    doneCount: doneCount,
                    totalCount: steps.length,
                    onPlay: () => _openStep(
                      steps.firstWhere(
                        (s) => s.step == VideoLessonStep.watch,
                        orElse: () => steps.first,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (!hasStarted) ...[
                    _OutcomeBanner(listening: _listening),
                    const SizedBox(height: 20),
                  ],
                  for (int i = 0; i < steps.length; i++) ...[
                    _StepCard(
                      number: i + 1,
                      config: steps[i],
                      state: stepStates[steps[i]] ?? VideoStepState.notStarted,
                      isNextRecommended: !allDone && i == nextIndex,
                      locked: _isLocked(steps[i].step),
                      onTap: () => _openStep(steps[i]),
                    ),
                    if (i < steps.length - 1) const SizedBox(height: 12),
                  ],
                  if (allDone) ...[
                    const SizedBox(height: 16),
                    GlassCard(
                      blur: false,
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 16),
                      child: Row(
                        children: [
                          const Icon(Symbols.celebration,
                              color: PmpColors.success500),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              l10n.txtAllStepsComplete,
                              style: PmpTextStyles.body2Semi.copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            );
          },
        ),
    );
  }

}

class _StepConfig {
  const _StepConfig({
    required this.step,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.route,
  });

  final VideoLessonStep step;
  final String title;
  final String subtitle;
  final IconData icon;
  final String route;
}

/// Glass video hero + title + progress.
class _Header extends StatelessWidget {
  const _Header({
    required this.listening,
    required this.doneCount,
    required this.totalCount,
    required this.onPlay,
  });

  final Listening listening;
  final int doneCount;
  final int totalCount;

  /// Tapping the poster opens the video — same destination as the Watch step.
  final VoidCallback onPlay;

  String _formatDuration(int seconds) {
    final h = seconds ~/ 3600;
    final m = (seconds % 3600) ~/ 60;
    final s = seconds % 60;
    final ss = s.toString().padLeft(2, '0');
    if (h > 0) return '$h:${m.toString().padLeft(2, '0')}:$ss';
    return '$m:$ss';
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final progress = totalCount == 0 ? 0.0 : doneCount / totalCount;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onPlay,
          child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CachedNetworkImage(
                  imageUrl: listening.thumbnail,
                  fit: BoxFit.cover,
                  // Cap decode to ~display width (2x) so a 1280px thumbnail
                  // isn't held in memory at full size on low-RAM devices.
                  memCacheWidth: 760,
                  placeholder: (context, url) => Container(
                    color: Colors.white.withValues(alpha: 0.05),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.white.withValues(alpha: 0.05),
                    child: Icon(Symbols.broken_image,
                        size: 24, color: cs.onSurfaceVariant),
                  ),
                ),
                // Scrim: darken top + bottom so the play button and duration
                // chip stay legible over any thumbnail, and add a soft radial
                // pool behind the play button so it never washes out against a
                // bright frame.
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.0, 0.5, 1.0],
                      colors: [
                        Color(0x40000000),
                        Color(0x14000000),
                        Color(0x73000000),
                      ],
                    ),
                  ),
                ),
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      radius: 0.55,
                      colors: [Color(0x4D000000), Color(0x00000000)],
                    ),
                  ),
                ),
                Center(
                  child: ClipOval(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                      child: Container(
                        width: 62,
                        height: 62,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black.withValues(alpha: 0.36),
                          border: Border.all(
                              color: Colors.white.withValues(alpha: 0.45),
                              width: 1.5),
                        ),
                        child: const Icon(Symbols.play_arrow,
                            size: 34, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                if (listening.end - listening.start > 0)
                  Positioned(
                    right: 10,
                    bottom: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.60),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _formatDuration(listening.end - listening.start),
                        style: PmpTextStyles.labelSemi
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          listening.title,
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w800,
            height: 1.3,
            color: cs.onSurface,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 7,
                  backgroundColor: cs.onSurface.withValues(alpha: 0.10),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                      PmpColors.brandOrange),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              AppLocalizations.of(context)
                  .txtProgressXofY(doneCount, totalCount),
              style: PmpTextStyles.labelSemi
                  .copyWith(color: cs.onSurfaceVariant),
            ),
          ],
        ),
      ],
    );
  }
}

/// "What you'll get" intro shown above the step list before the learner starts.
class _OutcomeBanner extends StatelessWidget {
  const _OutcomeBanner({required this.listening});

  final Listening listening;

  List<String> _bullets(AppLocalizations l10n) {
    final durationSeconds = listening.end - listening.start;
    final minutes = durationSeconds > 0 ? (durationSeconds / 60).round() : 0;
    final hasCounts = listening.vocabCount > 0 ||
        listening.patternCount > 0 ||
        listening.sentenceCount > 0;
    if (!hasCounts) {
      return [l10n.txtOutcomeBullet1, l10n.txtOutcomeBullet2, l10n.txtOutcomeBullet3];
    }
    return [
      if (minutes > 0) l10n.txtOutcomeCountMinutes(minutes),
      if (listening.vocabCount > 0) l10n.txtOutcomeCountVocab(listening.vocabCount),
      if (listening.patternCount > 0)
        l10n.txtOutcomeCountPatterns(listening.patternCount),
      if (listening.sentenceCount > 0)
        l10n.txtOutcomeCountSentences(listening.sentenceCount),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final bullets = _bullets(l10n);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            PmpColors.brandCyan.withValues(alpha: 0.12),
            PmpColors.brandOrange.withValues(alpha: 0.06),
          ],
        ),
        border: Border.all(color: PmpColors.brandCyan.withValues(alpha: 0.22)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: PmpColors.brandCyan.withValues(alpha: 0.15),
                ),
                child: const Icon(Symbols.flag,
                    size: 17, color: PmpColors.brandCyanBright),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  l10n.txtOutcomeBannerTitle,
                  style: PmpTextStyles.body1Semi
                      .copyWith(color: cs.onSurface),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          for (int i = 0; i < bullets.length; i++) ...[
            if (i > 0) const SizedBox(height: 8),
            _OutcomeBullet(text: bullets[i]),
          ],
        ],
      ),
    );
  }
}

class _OutcomeBullet extends StatelessWidget {
  const _OutcomeBullet({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 1),
          child: Icon(Symbols.check_circle,
              size: 18, color: PmpColors.success500),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style:
                PmpTextStyles.body2Regular.copyWith(color: cs.onSurface),
          ),
        ),
      ],
    );
  }
}

/// Choose-mode sheet shown when the learner taps "Speak on your own".
class _SpeakModeSheet extends StatelessWidget {
  const _SpeakModeSheet({required this.onBySection, required this.onFullTalk});

  final VoidCallback onBySection;
  final VoidCallback onFullTalk;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 4, 4, 12),
              child: Text('How do you want to speak?',
                  style: PmpTextStyles.title1SemiBold
                      .copyWith(color: cs.onSurface)),
            ),
            _option(context,
                icon: Icons.segment,
                title: 'By section',
                subtitle: 'Practice one chunk at a time — record, compare, redo.',
                onTap: onBySection),
            const SizedBox(height: 12),
            _option(context,
                icon: Icons.record_voice_over,
                title: 'Full talk',
                subtitle: 'Record the whole talk in one continuous take.',
                onTap: onFullTalk),
          ],
        ),
      ),
    );
  }

  Widget _option(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final cs = Theme.of(context).colorScheme;
    return GlassCard(
      onTap: onTap,
      borderRadius: 16,
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: PmpColors.brandCyan.withValues(alpha: 0.14),
            ),
            child: const Icon(Icons.mic_none_rounded,
                color: PmpColors.brandCyanBright, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: PmpTextStyles.body1Semi
                        .copyWith(color: cs.onSurface)),
                const SizedBox(height: 2),
                Text(subtitle,
                    style: PmpTextStyles.body2Regular
                        .copyWith(color: cs.onSurfaceVariant)),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: cs.onSurfaceVariant, size: 22),
        ],
      ),
    );
  }
}

class _StepCard extends StatelessWidget {
  const _StepCard({
    required this.number,
    required this.config,
    required this.state,
    required this.isNextRecommended,
    required this.locked,
    required this.onTap,
  });

  final int number;
  final _StepConfig config;
  final VideoStepState state;
  final bool isNextRecommended;
  final bool locked;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final dark = Theme.of(context).brightness == Brightness.dark;
    final isDone = state == VideoStepState.done;
    final isInProgress = state == VideoStepState.inProgress;

    final card = GlassCard(
      highlight: isNextRecommended,
      onTap: onTap,
      borderRadius: 16,
      padding: const EdgeInsets.all(14),
      // Several step cards render at once — skip the per-card BackdropFilter
      // (invisible over the gradient) so the screen stays light on low-end GPUs.
      blur: false,
      child: Row(
        children: [
          _NumberBadge(number: number, isDone: isDone),
          const SizedBox(width: 12),
          Container(
            width: 32,
            height: 32,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: PmpColors.brandCyan.withValues(alpha: dark ? 0.18 : 0.12),
              border: Border.all(
                color: PmpColors.brandCyanBright
                    .withValues(alpha: dark ? 0.34 : 0.30),
              ),
            ),
            child: Icon(config.icon,
                size: 17, color: PmpColors.brandCyanBright),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  config.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: PmpTextStyles.body1Semi.copyWith(color: cs.onSurface),
                ),
                const SizedBox(height: 3),
                Text(
                  config.subtitle,
                  style: PmpTextStyles.body2Regular
                      .copyWith(color: cs.onSurfaceVariant),
                ),
                const SizedBox(height: 5),
                // Locked steps show the PREMIUM chip inline (instead of a
                // "Not started" line) — no corner overlay that collides with
                // the title.
                if (locked)
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: PremiumLockBadge(),
                  )
                else
                  _StatusLine(
                    state: state,
                    isNextRecommended: isNextRecommended,
                  ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Icon(
            locked
                ? Symbols.lock
                : Symbols.chevron_right,
            size: 20,
            color: isInProgress || isNextRecommended
                ? PmpColors.brandCyanBright
                : cs.onSurfaceVariant,
          ),
        ],
      ),
    );

    return card;
  }
}

class _NumberBadge extends StatelessWidget {
  const _NumberBadge({required this.number, required this.isDone});

  final int number;
  final bool isDone;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: 34,
      height: 34,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: isDone
            ? const LinearGradient(
                colors: [PmpColors.success400, PmpColors.success600])
            : null,
        color: isDone
            ? null
            : (dark
                ? Colors.white.withValues(alpha: 0.06)
                : const Color(0xFF0D3147).withValues(alpha: 0.05)),
        border: Border.all(
          color: isDone
              ? Colors.transparent
              : (dark
                  ? Colors.white.withValues(alpha: 0.18)
                  : const Color(0xFF0D3147).withValues(alpha: 0.12)),
        ),
      ),
      child: isDone
          ? const Icon(Symbols.check, size: 19, color: Color(0xFF06140C))
          : Text(
              '$number',
              style: PmpTextStyles.body2Semi.copyWith(color: cs.onSurface),
            ),
    );
  }
}

class _StatusLine extends StatelessWidget {
  const _StatusLine({required this.state, required this.isNextRecommended});

  final VideoStepState state;
  final bool isNextRecommended;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final (String text, Color color, IconData? icon) = switch (state) {
      VideoStepState.done => (
          AppLocalizations.of(context).txtCompleted,
          PmpColors.success500,
          Symbols.check_circle,
        ),
      VideoStepState.inProgress => (
          AppLocalizations.of(context).txtInProgress,
          PmpColors.brandCyanBright,
          Symbols.timelapse,
        ),
      VideoStepState.notStarted when isNextRecommended => (
          AppLocalizations.of(context).txtRecommendedNext,
          PmpColors.brandCyanBright,
          Symbols.flag,
        ),
      VideoStepState.notStarted => (
          AppLocalizations.of(context).txtNotStarted,
          cs.onSurfaceVariant,
          null,
        ),
    };

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
        ],
        Text(text, style: PmpTextStyles.labelSemi.copyWith(color: color)),
      ],
    );
  }
}

/// Blocking dialog shown while an imported video's step is generated.
class _GeneratingDialog extends StatelessWidget {
  const _GeneratingDialog({required this.featureName});

  final String featureName;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 18),
          Text(
            'Preparing $featureName…',
            textAlign: TextAlign.center,
            style: PmpTextStyles.body1Semi.copyWith(color: cs.onSurface),
          ),
          const SizedBox(height: 6),
          Text(
            'This is generated once, then saved.',
            textAlign: TextAlign.center,
            style: PmpTextStyles.body2Regular
                .copyWith(color: cs.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}
