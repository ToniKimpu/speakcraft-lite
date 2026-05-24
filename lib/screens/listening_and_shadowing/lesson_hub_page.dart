import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speakcraft/bloc/video_step_progress/video_step_progress_bloc.dart';
import 'package:speakcraft/config/pmp_routes.dart';
import 'package:speakcraft/config/pmp_text_styles.dart';
import 'package:speakcraft/model/listening/listening.dart';
import 'package:speakcraft/model/video_step_progress/video_step_progress.dart';

class LessonHubPage extends StatefulWidget {
  const LessonHubPage({super.key, required this.listening});

  final Listening listening;

  @override
  State<LessonHubPage> createState() => _LessonHubPageState();
}

class _LessonHubPageState extends State<LessonHubPage> {
  @override
  void initState() {
    super.initState();
    context
        .read<VideoStepProgressBloc>()
        .add(VideoStepProgressEvent.loadVideo(widget.listening.youtubeId));
  }

  List<_StepConfig> _visibleSteps() {
    final l = widget.listening;
    return <_StepConfig>[
      if (l.subtitlePath.trim().isNotEmpty)
        const _StepConfig(
          step: VideoLessonStep.watch,
          title: 'Watch',
          subtitle: 'Listen with subtitles to understand the content',
          icon: Icons.play_circle_outline,
          route: PmpRoutes.youtubeVideoPage,
        ),
      const _StepConfig(
        step: VideoLessonStep.explanation,
        title: 'Study the patterns',
        subtitle: 'Review grammar and vocabulary used in this video',
        icon: Icons.lightbulb_outline,
        route: PmpRoutes.sentenceExplanationList,
      ),
      if (l.shadowingPath.trim().isNotEmpty)
        const _StepConfig(
          step: VideoLessonStep.shadowing,
          title: 'Practice along (shadowing)',
          subtitle: 'Speak in sync with the audio',
          icon: Icons.headphones,
          route: PmpRoutes.shadowingPage,
        ),
      if (l.recordSubtitlePath.trim().isNotEmpty)
        const _StepConfig(
          step: VideoLessonStep.record,
          title: 'Speak on your own',
          subtitle: 'Record yourself and compare to the original',
          icon: Icons.record_voice_over,
          route: PmpRoutes.speechPracticeSessionPage,
        ),
    ];
  }

  void _openStep(_StepConfig config) {
    Navigator.pushNamed(
      context,
      config.route,
      arguments: {'listening': widget.listening},
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final steps = _visibleSteps();

    return Scaffold(
      appBar: AppBar(title: const Text('Lesson')),
      body: BlocBuilder<VideoStepProgressBloc, VideoStepProgressState>(
        builder: (context, state) {
          final stepStates = <_StepConfig, VideoStepState>{
            for (final s in steps)
              s: state.stepStateFor(widget.listening.youtubeId, s.step),
          };

          final doneCount =
              stepStates.values.where((s) => s == VideoStepState.done).length;
          final nextIndex = steps.indexWhere(
              (s) => stepStates[s] != VideoStepState.done);
          final allDone = nextIndex == -1;

          return SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    children: [
                      _Header(
                        listening: widget.listening,
                        doneCount: doneCount,
                        totalCount: steps.length,
                      ),
                      const SizedBox(height: 20),
                      for (int i = 0; i < steps.length; i++) ...[
                        _StepCard(
                          number: i + 1,
                          config: steps[i],
                          state: stepStates[steps[i]] ?? VideoStepState.notStarted,
                          isNextRecommended: !allDone && i == nextIndex,
                          onTap: () => _openStep(steps[i]),
                        ),
                        if (i < steps.length - 1) const SizedBox(height: 12),
                      ],
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
                if (!allDone)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    child: SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: () => _openStep(steps[nextIndex]),
                        icon: const Icon(Icons.arrow_forward),
                        label: Text('Continue · ${steps[nextIndex].title}'),
                        style: FilledButton.styleFrom(
                          minimumSize: const Size.fromHeight(52),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  )
                else
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 16),
                      decoration: BoxDecoration(
                        color: colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.celebration,
                              color: colorScheme.onPrimaryContainer),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'All steps complete — great work!',
                              style: PmpTextStyles.body2Semi.copyWith(
                                color: colorScheme.onPrimaryContainer,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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

class _Header extends StatelessWidget {
  const _Header({
    required this.listening,
    required this.doneCount,
    required this.totalCount,
  });

  final Listening listening;
  final int doneCount;
  final int totalCount;

  String _formatDuration(int seconds) {
    final h = seconds ~/ 3600;
    final m = (seconds % 3600) ~/ 60;
    final s = seconds % 60;
    final ss = s.toString().padLeft(2, '0');
    if (h > 0) {
      final mm = m.toString().padLeft(2, '0');
      return '$h:$mm:$ss';
    }
    return '$m:$ss';
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final progress = totalCount == 0 ? 0.0 : doneCount / totalCount;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              fit: StackFit.expand,
              children: [
                CachedNetworkImage(
                  imageUrl: listening.thumbnail,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: colorScheme.surfaceContainerHighest,
                    child: const Center(
                      child: SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: colorScheme.surfaceContainerHighest,
                    child: Icon(
                      Icons.broken_image,
                      size: 24,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                if (listening.end - listening.start > 0)
                  Positioned(
                    right: 8,
                    bottom: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.75),
                        borderRadius: BorderRadius.circular(6),
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
        const SizedBox(height: 16),
        Text(
          listening.title,
          style: PmpTextStyles.title1SemiBold.copyWith(
            color: colorScheme.onSurface,
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
                  minHeight: 8,
                  backgroundColor: colorScheme.surfaceContainerHighest,
                  valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              '$doneCount of $totalCount',
              style: PmpTextStyles.labelSemi.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _StepCard extends StatelessWidget {
  const _StepCard({
    required this.number,
    required this.config,
    required this.state,
    required this.isNextRecommended,
    required this.onTap,
  });

  final int number;
  final _StepConfig config;
  final VideoStepState state;
  final bool isNextRecommended;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDone = state == VideoStepState.done;
    final isInProgress = state == VideoStepState.inProgress;

    final borderColor = isNextRecommended
        ? colorScheme.primary
        : colorScheme.outline;
    final borderWidth = isNextRecommended ? 2.0 : 1.0;
    final cardColor = isNextRecommended
        ? Color.alphaBlend(
            colorScheme.primary.withValues(alpha: 0.06),
            colorScheme.surfaceContainerHighest,
          )
        : colorScheme.surfaceContainerHighest;

    return Material(
      color: cardColor,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderColor, width: borderWidth),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _NumberBadge(number: number, isDone: isDone),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: colorScheme.primary.withValues(alpha: 0.10),
                          ),
                          alignment: Alignment.center,
                          child: Icon(
                            config.icon,
                            size: 16,
                            color: colorScheme.primary,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            config.title,
                            style: PmpTextStyles.body1Semi.copyWith(
                              color: colorScheme.onSurface,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      config.subtitle,
                      style: PmpTextStyles.body2Regular.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 6),
                    _StatusLine(
                      state: state,
                      isNextRecommended: isNextRecommended,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.chevron_right,
                size: 20,
                color: isInProgress || isNextRecommended
                    ? colorScheme.primary
                    : colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NumberBadge extends StatelessWidget {
  const _NumberBadge({required this.number, required this.isDone});

  final int number;
  final bool isDone;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isDone ? colorScheme.primary : colorScheme.surface,
        border: Border.all(
          color: isDone ? colorScheme.primary : colorScheme.outline,
        ),
      ),
      alignment: Alignment.center,
      child: isDone
          ? Icon(Icons.check, size: 18, color: colorScheme.onPrimary)
          : Text(
              '$number',
              style: PmpTextStyles.body2Semi.copyWith(
                color: colorScheme.onSurface,
              ),
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
    final colorScheme = Theme.of(context).colorScheme;
    final (String text, Color color, IconData? icon) = switch (state) {
      VideoStepState.done => (
          'Completed',
          colorScheme.primary,
          Icons.check_circle,
        ),
      VideoStepState.inProgress => (
          'In progress',
          colorScheme.tertiary,
          Icons.timelapse,
        ),
      VideoStepState.notStarted when isNextRecommended => (
          'Recommended next',
          colorScheme.primary,
          Icons.flag_outlined,
        ),
      VideoStepState.notStarted => (
          'Not started',
          colorScheme.onSurfaceVariant,
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
        Text(
          text,
          style: PmpTextStyles.labelSemi.copyWith(color: color),
        ),
      ],
    );
  }
}
