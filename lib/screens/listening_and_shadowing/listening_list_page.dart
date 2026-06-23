import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speakcraft/bloc/listening/listening_bloc.dart';
import 'package:speakcraft/bloc/video_step_progress/video_step_progress_bloc.dart';
import 'package:speakcraft/config/pmp_colors.dart';
import 'package:speakcraft/config/pmp_routes.dart';
import 'package:speakcraft/config/pmp_text_styles.dart';
import 'package:speakcraft/model/listening/listening.dart';
import 'package:speakcraft/screens/listening_and_shadowing/utils/lesson_steps.dart';
import 'package:speakcraft/shared_widgets/glass.dart';
import 'package:speakcraft/shared_widgets/premium_gate.dart';

import '../../l10n/generated/l10n.dart';

class ListeningListPage extends StatefulWidget {
  const ListeningListPage({super.key});

  @override
  State<ListeningListPage> createState() => _ListeningListPageState();
}

class _ListeningListPageState extends State<ListeningListPage> {
  /// One-time module intro: shown until the learner dismisses it. `null` while
  /// the stored flag is still loading, so we don't flash the card then hide it.
  static const String _introDismissedKey = 'listening_intro_dismissed';
  bool? _introDismissed;

  @override
  void initState() {
    super.initState();
    // Pull every video's saved step progress so the list can show how far the
    // learner got and float unfinished lessons to the top.
    context.read<VideoStepProgressBloc>().add(
          const VideoStepProgressEvent.loadAll(),
        );
    _loadIntroFlag();
  }

  Future<void> _loadIntroFlag() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _introDismissed = prefs.getBool(_introDismissedKey) ?? false;
    });
  }

  Future<void> _dismissIntro() async {
    setState(() => _introDismissed = true);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_introDismissedKey, true);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BlocProvider(
      create: (context) =>
          ListeningBloc()..add(const ListeningEvent.loadListenings()),
      child: GlassScaffold(
        title: Text(AppLocalizations.of(context).txtListeningListTitle),
        body: BlocBuilder<ListeningBloc, ListeningState>(
          builder: (context, state) {
            return state.maybeWhen(
              loading: () => const Center(
                child: SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(),
                ),
              ),
              loaded: (listenings) {
                if (listenings.isEmpty) {
                  return Center(
                    child: Text(
                      AppLocalizations.of(context).txtWillUploadSoon,
                      style: PmpTextStyles.body2Semi
                          .copyWith(color: colorScheme.onSurface),
                    ),
                  );
                }
                return BlocBuilder<VideoStepProgressBloc,
                    VideoStepProgressState>(
                  builder: (context, progressState) {
                    // Catalog order is preserved so the list stays predictable;
                    // progress is shown inline per row. Resume lives on the
                    // home "Continue learning" card.
                    final anyStarted = listenings.any(
                      (l) => lessonProgressFor(progressState, l).hasStarted,
                    );
                    // Show the one-time module intro as a leading card until
                    // dismissed (and only once the stored flag has loaded).
                    final showIntro = _introDismissed == false;
                    final leading = showIntro ? 1 : 0;
                    return ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: listenings.length + leading,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 14),
                      itemBuilder: (context, index) {
                        if (showIntro && index == 0) {
                          return _ModuleIntroCard(onDismiss: _dismissIntro);
                        }
                        final li = index - leading;
                        final listening = listenings[li];
                        return _ListeningCard(
                          listening: listening,
                          progress: lessonProgressFor(progressState, listening),
                          // A brand-new learner (nothing started anywhere) gets
                          // a single "Start here" nudge on the first lesson.
                          isStartHere: !anyStarted && li == 0,
                        );
                      },
                    );
                  },
                );
              },
              orElse: () => Container(),
            );
          },
        ),
      ),
    );
  }

}

/// One-time, dismissable intro that frames what the whole Listening &
/// Shadowing module gives the learner (before → after) and names the 4-step
/// path each lesson follows. Sits at the top of the list until dismissed.
class _ModuleIntroCard extends StatelessWidget {
  const _ModuleIntroCard({required this.onDismiss});

  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    const accent = PmpColors.brandCyanBright;

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            PmpColors.brandCyan.withValues(alpha: 0.14),
            PmpColors.brandOrange.withValues(alpha: 0.07),
          ],
        ),
        border:
            Border.all(color: PmpColors.brandCyan.withValues(alpha: 0.22)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_awesome_rounded, size: 18, color: accent),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  l10n.txtListeningIntroTitle,
                  style: PmpTextStyles.body1Semi.copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _IntroLine(
            icon: Icons.volume_off_rounded,
            text: l10n.txtListeningIntroBefore,
            color: colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 6),
          _IntroLine(
            icon: Icons.graphic_eq_rounded,
            text: l10n.txtListeningIntroAfter,
            color: colorScheme.onSurface,
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: colorScheme.surface.withValues(alpha: 0.55),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Icon(Icons.timeline_rounded,
                    size: 16, color: colorScheme.onSurfaceVariant),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    l10n.txtListeningIntroPath,
                    style: PmpTextStyles.labelSemi.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: onDismiss,
              child: Text(l10n.txtGotIt),
            ),
          ),
        ],
      ),
    );
  }
}

class _IntroLine extends StatelessWidget {
  const _IntroLine({
    required this.icon,
    required this.text,
    required this.color,
  });

  final IconData icon;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 1),
          child: Icon(icon, size: 16, color: color),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: PmpTextStyles.body2Regular.copyWith(color: color),
          ),
        ),
      ],
    );
  }
}

class _ListeningCard extends StatelessWidget {
  const _ListeningCard({
    required this.listening,
    required this.progress,
    required this.isStartHere,
  });

  final Listening listening;
  final LessonProgress progress;
  final bool isStartHere;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final highlight = isStartHere;
    return GlassCard(
      highlight: highlight,
      borderRadius: 16,
      padding: const EdgeInsets.all(12),
      // List rows render many-at-once while scrolling; skip the costly
      // BackdropFilter (invisible over the smooth gradient anyway) to keep
      // scrolling smooth on low-end devices.
      blur: false,
      onTap: () {
        Navigator.pushNamed(
          context,
          PmpRoutes.listeningHub,
          arguments: {'listening': listening},
        );
      },
      child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _Thumbnail(
                imageUrl: listening.thumbnail,
                durationSeconds: listening.end - listening.start,
                isFree: listening.isFree,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      listening.title,
                      style: PmpTextStyles.body1Semi
                          .copyWith(color: colorScheme.onSurface),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    _StatusSection(
                      progress: progress,
                      isStartHere: isStartHere,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.chevron_right,
                color: colorScheme.onSurfaceVariant,
              ),
            ],
          ),
    );
  }
}

/// Per-row learning state: completed, in-progress (with a thin progress bar),
/// or not-yet-started (with an optional "Start here" nudge).
class _StatusSection extends StatelessWidget {
  const _StatusSection({required this.progress, required this.isStartHere});

  final LessonProgress progress;
  final bool isStartHere;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    if (progress.isComplete) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check_circle,
              size: 14, color: PmpColors.success500),
          const SizedBox(width: 4),
          Text(
            AppLocalizations.of(context).txtCompleted,
            style:
                PmpTextStyles.labelSemi.copyWith(color: PmpColors.success500),
          ),
        ],
      );
    }

    if (progress.isInProgress) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)
                .txtStepsProgress(progress.doneCount, progress.totalCount),
            style: PmpTextStyles.labelMedium
                .copyWith(color: colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 5),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress.fraction,
              minHeight: 5,
              backgroundColor: colorScheme.onSurface.withValues(alpha: 0.10),
              valueColor: const AlwaysStoppedAnimation<Color>(
                  PmpColors.brandOrange),
            ),
          ),
        ],
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.school_outlined,
          size: 14,
          color: colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            AppLocalizations.of(context).txtStepLesson(progress.totalCount),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: PmpTextStyles.labelMedium.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        if (isStartHere) ...[
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: colorScheme.primary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              AppLocalizations.of(context).txtStartHere,
              style:
                  PmpTextStyles.subBold.copyWith(color: colorScheme.onPrimary),
            ),
          ),
        ],
      ],
    );
  }
}

class _Thumbnail extends StatelessWidget {
  const _Thumbnail({
    required this.imageUrl,
    required this.durationSeconds,
    required this.isFree,
  });

  final String imageUrl;
  final int durationSeconds;
  final bool isFree;

  static const double _width = 112;
  static const double _height = 72; // 16:9

  String _formatDuration(int seconds) {
    if (seconds <= 0) return '';
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
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        alignment: Alignment.center,
        children: [
          CachedNetworkImage(
            imageUrl: imageUrl,
            width: _width,
            height: _height,
            fit: BoxFit.cover,
            // Decode to roughly the on-screen size (~2x for crispness) instead
            // of the full 720p thumbnail — much less memory/decode work per row.
            memCacheWidth: (_width * 2).round(),
            placeholder: (context, url) => Container(
              width: _width,
              height: _height,
              color: colorScheme.surface,
              child: const Center(
                child: SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            ),
            errorWidget: (context, url, error) => Container(
              width: _width,
              height: _height,
              color: colorScheme.surface,
              child: Icon(
                Icons.broken_image,
                size: 20,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          // Subtle dark scrim so the play icon stays legible over any thumbnail.
          Container(
            width: _width,
            height: _height,
            color: Colors.black.withValues(alpha: 0.25),
          ),
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.95),
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.play_arrow_rounded,
              size: 20,
              color: Colors.black,
            ),
          ),
          Positioned(
            top: 4,
            left: 4,
            child: FreePremiumBadge(isFree: isFree),
          ),
          if (durationSeconds > 0)
            Positioned(
              right: 4,
              bottom: 4,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.75),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  _formatDuration(durationSeconds),
                  style: PmpTextStyles.subBold.copyWith(color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
