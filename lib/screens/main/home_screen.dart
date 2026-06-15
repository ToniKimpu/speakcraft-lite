import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speakcraft/bloc/listening/listening_bloc.dart';
import 'package:speakcraft/bloc/user_activity/user_activity_bloc.dart';
import 'package:speakcraft/bloc/user_activity/user_activity_messages.dart';
import 'package:speakcraft/bloc/video_step_progress/video_step_progress_bloc.dart';
import 'package:speakcraft/config/pmp_routes.dart';
import 'package:speakcraft/config/pmp_text_styles.dart';
import 'package:speakcraft/l10n/generated/l10n.dart';
import 'package:speakcraft/model/listening/listening.dart';
import 'package:speakcraft/screens/listening_and_shadowing/utils/lesson_steps.dart';

import '../../bloc/auth/auth_bloc.dart';
import 'widgets/module_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Timer? _sessionTimer;
  bool _sessionRecorded = false;

  /// Timestamp of the last back press, for the double-tap-to-exit guard.
  DateTime? _lastBackPressed;

  /// Android root-screen back handling: first press hints, a second press
  /// within the window exits the app.
  void _handleBackPressed() {
    final now = DateTime.now();
    if (_lastBackPressed == null ||
        now.difference(_lastBackPressed!) > const Duration(seconds: 2)) {
      _lastBackPressed = now;
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context).txtPressBackToExit),
            duration: const Duration(seconds: 2),
          ),
        );
      return;
    }
    SystemNavigator.pop();
  }

  @override
  void initState() {
    super.initState();
    context.read<UserActivityBloc>().add(const UserActivityEvent.initialize());
    // Saved step progress feeds the "Continue learning" card below the header.
    context.read<VideoStepProgressBloc>().add(
          const VideoStepProgressEvent.loadAll(),
        );
    _sessionTimer = Timer(
      const Duration(minutes: 1),
      _onSessionTimerFired,
    );
  }

  void _onSessionTimerFired() {
    if (!mounted || _sessionRecorded) return;
    _sessionRecorded = true;
    context
        .read<UserActivityBloc>()
        .add(const UserActivityEvent.recordSession());
  }

  @override
  void dispose() {
    _sessionTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _handleBackPressed();
      },
      child: Scaffold(
        appBar: AppBar(
          // Header merged into the bar: Day title + streak + profile sit on the
          // teal band, replacing the old standalone "SpeakCraft" title. Fixed
          // toolbarHeight so the bar never resizes between loading/loaded states.
          toolbarHeight: 104,
          automaticallyImplyLeading: false,
          flexibleSpace: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 4, 8, 12),
              child: BlocBuilder<UserActivityBloc, UserActivityState>(
                builder: (context, state) {
                  return state.when(
                    initial: () => _buildHeader(0, 0, ''),
                    loading: () => _buildHeader(0, 0, ''),
                    loaded: (data) => _buildHeader(
                      data.totalLearningDays,
                      data.currentStreak,
                      UserActivityMessages.get(
                        resolveMessageType(data),
                        streak: data.currentStreak,
                      ),
                    ),
                    sessionRecorded: (data) => _buildHeader(
                      data.totalLearningDays,
                      data.currentStreak,
                      UserActivityMessages.get(
                        UserActivityMessageType.activeToday,
                      ),
                    ),
                    error: (_) => _buildHeader(0, 0, ''),
                  );
                },
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _ContinueLearningSection(),
              ModuleWidget(
                title: AppLocalizations.of(context).txtModuleListeningTitle,
                label1: AppLocalizations.of(context).txtModuleListeningLabel1,
                label2: AppLocalizations.of(context).txtModuleListeningLabel2,
                iconTitle: Icons.hearing,
                iconLabel1: Icons.headphones,
                iconLabel2: Icons.surround_sound,
                onPressed: () {
                  Navigator.pushNamed(context, PmpRoutes.listeningListPage);
                },
              ),
              const SizedBox(height: 12),
              // Daily Speaking Practice — productive-skill counterpart.
              // P1 (stub-driven) on `feat/daily_speaking_practice`. See
              // lib/screens/daily_speaking/CLAUDE.md.
              ModuleWidget(
                title: 'Daily Speaking Practice',
                label1: 'နေ့စဉ် ၃ မိနစ် ပြောကြည့်ပါ',
                label2: 'AI ဆီကနေ ချက်ချင်း feedback ရယူပါ',
                iconTitle: Icons.mic,
                iconLabel1: Icons.timer_outlined,
                iconLabel2: Icons.auto_awesome,
                onPressed: () {
                  Navigator.pushNamed(context, PmpRoutes.dailySpeakingEntry);
                },
              ),
              const SizedBox(height: 12),
              // Writing Practice — grammar-foundation course. Lands on the path
              // screen (Level → Section → Unit). See WRITING_FEATURE_PLAN.md.
              ModuleWidget(
                title: 'Writing Practice',
                label1: 'သဒ္ဒါ အခြေခံကနေ စတင်လေ့လာပါ',
                label2: 'လေ့ကျင့်ခန်းတွေနဲ့ ချက်ချင်း စစ်ဆေးပါ',
                iconTitle: Icons.edit_document,
                iconLabel1: Icons.school_outlined,
                iconLabel2: Icons.fact_check_outlined,
                onPressed: () {
                  Navigator.pushNamed(context, PmpRoutes.writingPath);
                },
              ),
              const SizedBox(height: 12),
              ModuleWidget(
                title: AppLocalizations.of(context).txtModuleBookmarksTitle,
                label1: AppLocalizations.of(context).txtModuleBookmarksLabel1,
                label2: AppLocalizations.of(context).txtModuleBookmarksLabel2,
                iconTitle: Icons.bookmark,
                iconLabel1: Icons.menu_book,
                iconLabel2: Icons.school,
                onPressed: () {
                  Navigator.pushNamed(context, PmpRoutes.savedTermsPage);
                },
              ),
              // Debug-only navigation/dev tools. Comment out the single line
              // below to hide the whole block; it already no-ops in release.
              //const _DebugMenu(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(int totalDays, int streak, String message) {
    // Content lives on the teal AppBar band, so colors track the AppBar
    // foreground (white in light, light text in dark) rather than surface.
    final appBarFg = Theme.of(context).appBarTheme.foregroundColor ??
        Theme.of(context).colorScheme.onSurface;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                UserActivityMessages.getDayTitle(totalDays),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  color: appBarFg,
                  fontFamily: 'ArchivoBlack Regular',
                ),
              ),
            ),
            if (streak > 1) _StreakChip(streak: streak),
            const SizedBox(width: 10),
            // Circular translucent button so the profile target reads as a
            // tappable avatar on the teal band, not a faint bare glyph.
            Material(
              color: appBarFg.withValues(alpha: 0.15),
              shape: CircleBorder(
                side: BorderSide(color: appBarFg.withValues(alpha: 0.4)),
              ),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, PmpRoutes.profilePage);
                },
                child: Padding(
                  padding: const EdgeInsets.all(9),
                  child: Icon(Icons.person, color: appBarFg, size: 22),
                ),
              ),
            ),
          ],
        ),
        if (message.isNotEmpty)
          Text(
            message,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: PmpTextStyles.body2Regular.copyWith(
              color: appBarFg.withValues(alpha: 0.85),
            ),
          ),
      ],
    );
  }
}

/// Debug-only tools surfaced on the home screen (JSON/HTML test lists and a
/// quick logout). Renders nothing in release builds, so the call site can be
/// commented out in one line without leaving dead UI in production.
// ignore: unused_element  // call site in HomePage.build is intentionally toggled
class _DebugMenu extends StatelessWidget {
  const _DebugMenu();

  @override
  Widget build(BuildContext context) {
    if (!kDebugMode) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, '/html_list'),
          child: const Text('See Html List'),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () =>
              Navigator.pushNamed(context, PmpRoutes.gritJsonList),
          child: const Text('Grit JSON List'),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () =>
              Navigator.pushNamed(context, PmpRoutes.zendayaJsonList),
          child: const Text('Zendaya'),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () => Navigator.pushNamed(
              context, PmpRoutes.importantOfSocialHealthJsonList),
          child: const Text('Important of Social Health'),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () =>
              Navigator.pushNamed(context, PmpRoutes.paulRuddInterviewJsonList),
          child: const Text('Paul Rudd Interview'),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () =>
              Navigator.pushNamed(context, PmpRoutes.goingViralTaughtMeJsonList),
          child: const Text('Going Viral Taught Me'),
        ),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: () =>
              context.read<AuthBloc>().add(const AuthEvent.logout()),
          child: const Text('Logout'),
        ),
      ],
    );
  }
}

/// Compact streak indicator shown beside the day title.
class _StreakChip extends StatelessWidget {
  const _StreakChip({required this.streak});

  final int streak;

  @override
  Widget build(BuildContext context) {
    // Sits on the teal AppBar band: translucent foreground pill so it reads on
    // the colored bar in light mode and the dark surface bar in dark mode.
    final fg = Theme.of(context).appBarTheme.foregroundColor ??
        Theme.of(context).colorScheme.onSurface;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: fg.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: fg.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('🔥', style: TextStyle(fontSize: 13)),
          const SizedBox(width: 4),
          Text(
            '$streak day streak',
            style: PmpTextStyles.labelSemi.copyWith(color: fg),
          ),
        ],
      ),
    );
  }
}

/// Surfaces the most recently opened, not-yet-finished lesson so the learner
/// can resume in one tap. Renders nothing for brand-new users (no lesson
/// started) or once every started lesson is complete.
class _ContinueLearningSection extends StatelessWidget {
  const _ContinueLearningSection();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ListeningBloc()..add(const ListeningEvent.loadListenings()),
      child: BlocBuilder<ListeningBloc, ListeningState>(
        builder: (context, listeningState) {
          final listenings = listeningState.maybeWhen(
            loaded: (items) => items,
            orElse: () => const <Listening>[],
          );
          if (listenings.isEmpty) return const SizedBox.shrink();

          return BlocBuilder<VideoStepProgressBloc, VideoStepProgressState>(
            builder: (context, progressState) {
              final resume = _pickResume(progressState, listenings);
              if (resume == null) return const SizedBox.shrink();
              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: _ContinueCard(
                  listening: resume.$1,
                  progress: resume.$2,
                ),
              );
            },
          );
        },
      ),
    );
  }

  /// The in-progress lesson opened most recently, or null if none qualify.
  (Listening, LessonProgress)? _pickResume(
    VideoStepProgressState state,
    List<Listening> listenings,
  ) {
    (Listening, LessonProgress)? best;
    for (final l in listenings) {
      final p = lessonProgressFor(state, l);
      if (!p.isInProgress) continue;
      if (best == null) {
        best = (l, p);
        continue;
      }
      final bestTime = best.$2.lastOpenedAt;
      final t = p.lastOpenedAt;
      if (t != null && (bestTime == null || t.isAfter(bestTime))) best = (l, p);
    }
    return best;
  }
}

class _ContinueCard extends StatelessWidget {
  const _ContinueCard({required this.listening, required this.progress});

  final Listening listening;
  final LessonProgress progress;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Material(
      color: colorScheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            PmpRoutes.listeningHub,
            arguments: {'listening': listening},
          );
        },
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: colorScheme.primary, width: 2),
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.play_circle_fill,
                      size: 16, color: colorScheme.primary),
                  const SizedBox(width: 6),
                  Text(
                    AppLocalizations.of(context).txtContinueLearning,
                    style: PmpTextStyles.labelSemi
                        .copyWith(color: colorScheme.primary),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: listening.thumbnail,
                      width: 96,
                      height: 60,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        width: 96,
                        height: 60,
                        color: colorScheme.surface,
                      ),
                      errorWidget: (context, url, error) => Container(
                        width: 96,
                        height: 60,
                        color: colorScheme.surface,
                        child: Icon(Icons.broken_image,
                            size: 20, color: colorScheme.onSurfaceVariant),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
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
                        Row(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: LinearProgressIndicator(
                                  value: progress.fraction,
                                  minHeight: 5,
                                  backgroundColor: colorScheme.surface,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      colorScheme.primary),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              AppLocalizations.of(context)
                                  .txtProgressXofY(
                                      progress.doneCount, progress.totalCount),
                              style: PmpTextStyles.labelSemi.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(Icons.chevron_right, color: colorScheme.primary),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
