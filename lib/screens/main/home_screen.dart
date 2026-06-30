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
import 'package:speakcraft/config/pmp_colors.dart';
import 'package:speakcraft/config/pmp_routes.dart';
import 'package:speakcraft/config/pmp_text_styles.dart';
import 'package:speakcraft/l10n/generated/l10n.dart';
import 'package:speakcraft/model/listening/listening.dart';
import 'package:speakcraft/screens/listening_and_shadowing/utils/lesson_steps.dart';
import 'package:speakcraft/screens/onboarding/onboarding_page.dart';
import 'package:speakcraft/services/analytics_service.dart';
import 'package:speakcraft/services/share_preference_utils.dart';
import 'package:speakcraft/shared_widgets/glass.dart';
import 'package:speakcraft/shared_widgets/premium_status.dart';

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
  DateTime? _lastBackPressed;

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
    context.read<VideoStepProgressBloc>().add(
          const VideoStepProgressEvent.loadAll(),
        );
    _sessionTimer = Timer(const Duration(minutes: 1), _onSessionTimerFired);
    _maybeOpenUpgrade();
  }

  // If the user tapped "Get Premium" during onboarding, open the payment screen
  // once they reach home (consumes the flag so it fires only once).
  void _maybeOpenUpgrade() {
    if (SharedPreferenceUtils.getBool(OnboardingPage.kPendingUpgrade) != true) {
      return;
    }
    SharedPreferenceUtils.remove(OnboardingPage.kPendingUpgrade);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        Navigator.pushNamed(context, PmpRoutes.premiumPaymentPage);
      }
    });
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
    final l10n = AppLocalizations.of(context);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _handleBackPressed();
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: glassOverlayStyle(Theme.of(context).brightness),
        child: Scaffold(
          body: GradientBackground(
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<UserActivityBloc, UserActivityState>(
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
                  const SizedBox(height: 22),
                  const HomeUpgradeBanner(),
                  const _ContinueLearningSection(),
                  const _SectionLabel('Learn'),
                  ModuleWidget(
                    title: l10n.txtModuleListeningTitle,
                    label1: l10n.txtModuleListeningLabel1,
                    label2: l10n.txtModuleListeningLabel2,
                    iconTitle: Icons.hearing,
                    iconLabel1: Icons.headphones,
                    iconLabel2: Icons.surround_sound,
                    accent: ModuleAccent.cyan,
                    onPressed: () {
                      AnalyticsService.instance.featureOpen('listening');
                      Navigator.pushNamed(
                          context, PmpRoutes.listeningListPage);
                    },
                  ),
                  ModuleWidget(
                    title: 'Writing Practice',
                    label1: 'သဒ္ဒါ အခြေခံကနေ စတင်လေ့လာပါ',
                    label2: 'လေ့ကျင့်ခန်းတွေနဲ့ ချက်ချင်း စစ်ဆေးပါ',
                    iconTitle: Icons.edit_document,
                    iconLabel1: Icons.school_outlined,
                    iconLabel2: Icons.fact_check_outlined,
                    accent: ModuleAccent.orange,
                    onPressed: () {
                      AnalyticsService.instance.featureOpen('grammar');
                      Navigator.pushNamed(context, PmpRoutes.writingPath);
                    },
                  ),
                  ModuleWidget(
                    title: 'Vocabulary',
                    label1: 'စကားလုံးတွေကို အုပ်စုဖွဲ့ လေ့လာပါ',
                    label2: 'နားထောင်ပြီး လေ့ကျင့်ခန်း လုပ်ပါ',
                    iconTitle: Icons.style,
                    iconLabel1: Icons.workspaces_outline,
                    iconLabel2: Icons.record_voice_over_outlined,
                    accent: ModuleAccent.orange,
                    onPressed: () {
                      AnalyticsService.instance.featureOpen('vocabulary');
                      Navigator.pushNamed(context, PmpRoutes.vocabularyList);
                    },
                  ),
                  ModuleWidget(
                    title: 'Speak Your Mind',
                    label1: 'topic အလိုက် အသုံးဝင်တဲ့ စကားစု toolbox',
                    label2: 'ကိုယ်ပိုင်အကြောင်း ရေး/ပြောပြီး ထုတ်သုံးပါ',
                    iconTitle: Icons.lightbulb_outline,
                    iconLabel1: Icons.handyman_outlined,
                    iconLabel2: Icons.edit_outlined,
                    accent: ModuleAccent.cyan,
                    onPressed: () {
                      AnalyticsService.instance.featureOpen('sym');
                      Navigator.pushNamed(context, PmpRoutes.speakYourMind);
                    },
                  ),
                  ModuleWidget(
                    title: l10n.txtModuleBookmarksTitle,
                    label1: l10n.txtModuleBookmarksLabel1,
                    label2: l10n.txtModuleBookmarksLabel2,
                    iconTitle: Icons.bookmark,
                    iconLabel1: Icons.menu_book,
                    iconLabel2: Icons.school,
                    accent: ModuleAccent.cyan,
                    onPressed: () =>
                        Navigator.pushNamed(context, PmpRoutes.savedTermsPage),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      ),
    );
  }

  Widget _buildHeader(int totalDays, int streak, String message) {
    final cs = Theme.of(context).colorScheme;
    return Column(
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
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: cs.onSurface,
                  letterSpacing: 0.2,
                ),
              ),
            ),
            if (streak > 1) _StreakChip(streak: streak),
            const SizedBox(width: 10),
            _ProfileAvatar(),
          ],
        ),
        if (message.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              message,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: PmpTextStyles.body2Regular
                  .copyWith(color: cs.onSurfaceVariant),
            ),
          ),
      ],
    );
  }
}

/// Small all-caps section divider label.
class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 2, 4, 12),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.7,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Material(
      color: dark
          ? Colors.white.withValues(alpha: 0.10)
          : Colors.white.withValues(alpha: 0.70),
      shape: CircleBorder(
        side: BorderSide(
          color: dark
              ? Colors.white.withValues(alpha: 0.20)
              : PmpColors.brandCyan.withValues(alpha: 0.25),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, PmpRoutes.profilePage),
        child: Padding(
          padding: const EdgeInsets.all(9),
          child: Icon(Icons.person, color: cs.onSurface, size: 22),
        ),
      ),
    );
  }
}

class _StreakChip extends StatelessWidget {
  const _StreakChip({required this.streak});

  final int streak;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final tx = dark ? const Color(0xFFFFD9B8) : const Color(0xFFB4470F);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            PmpColors.brandOrange.withValues(alpha: dark ? 0.22 : 0.16),
            PmpColors.brandOrange.withValues(alpha: dark ? 0.10 : 0.08),
          ],
        ),
        borderRadius: BorderRadius.circular(30),
        border:
            Border.all(color: PmpColors.brandOrange.withValues(alpha: 0.40)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('🔥', style: TextStyle(fontSize: 13)),
          const SizedBox(width: 5),
          Text(
            '$streak day streak',
            style: PmpTextStyles.labelSemi.copyWith(color: tx),
          ),
        ],
      ),
    );
  }
}

/// Debug-only tools surfaced on the home screen. Renders nothing in release.
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
          onPressed: () =>
              context.read<AuthBloc>().add(const AuthEvent.logout()),
          child: const Text('Logout'),
        ),
      ],
    );
  }
}

/// Surfaces the most recently opened, not-yet-finished lesson so the learner
/// can resume in one tap. Renders nothing for brand-new users or once every
/// started lesson is complete.
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
                padding: const EdgeInsets.only(bottom: 22),
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
    final cs = Theme.of(context).colorScheme;
    return GlassCard(
      padding: const EdgeInsets.all(14),
      borderRadius: 22,
      onTap: () => Navigator.pushNamed(
        context,
        PmpRoutes.listeningHub,
        arguments: {'listening': listening},
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.play_circle,
                  size: 16, color: PmpColors.brandCyanBright),
              const SizedBox(width: 6),
              Text(
                AppLocalizations.of(context).txtContinueLearning,
                style: PmpTextStyles.labelSemi.copyWith(
                  color: PmpColors.brandCyanBright,
                  letterSpacing: 0.4,
                ),
              ),
            ],
          ),
          const SizedBox(height: 11),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: listening.thumbnail,
                  width: 100,
                  height: 62,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    width: 100,
                    height: 62,
                    color: Colors.white.withValues(alpha: 0.05),
                  ),
                  errorWidget: (context, url, error) => Container(
                    width: 100,
                    height: 62,
                    color: Colors.white.withValues(alpha: 0.05),
                    child: Icon(Icons.broken_image,
                        size: 20, color: cs.onSurfaceVariant),
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
                          .copyWith(color: cs.onSurface),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: LinearProgressIndicator(
                              value: progress.fraction,
                              minHeight: 6,
                              backgroundColor:
                                  cs.onSurface.withValues(alpha: 0.10),
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                  PmpColors.brandOrange),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          AppLocalizations.of(context).txtProgressXofY(
                              progress.doneCount, progress.totalCount),
                          style: PmpTextStyles.labelSemi
                              .copyWith(color: cs.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.chevron_right,
                  color: PmpColors.brandCyanBright),
            ],
          ),
        ],
      ),
    );
  }
}
