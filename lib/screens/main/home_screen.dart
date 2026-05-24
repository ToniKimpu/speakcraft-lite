import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmp_english/bloc/user_activity/user_activity_bloc.dart';
import 'package:pmp_english/bloc/user_activity/user_activity_messages.dart';
import 'package:pmp_english/config/pmp_routes.dart';

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

  @override
  void initState() {
    super.initState();
    context.read<UserActivityBloc>().add(const UserActivityEvent.initialize());
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('PMP English'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, PmpRoutes.profilePage);
            },
            icon: const Icon(Icons.person),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
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
            const SizedBox(height: 24),
            // HIDDEN for V1 — restore for v2 once Listening feedback loop is shipped.
            // See lib/screens/listening_and_shadowing/CLAUDE.md → "Home screen scope (v1)".
            // ModuleWidget(
            //   title: 'Useful Spoken Patterns',
            //   label1: 'Spoken Patternပေါင်း (၁၀၀)ကျော်လေ့လာမယ်',
            //   label2: 'နေ့စဉ်ပုံမှန် လေ့လာမယ်',
            //   iconTitle: Icons.menu_book,
            //   iconLabel1: Icons.format_quote,
            //   iconLabel2: Icons.calendar_month,
            //   onPressed: () {
            //     Navigator.pushNamed(context, PmpRoutes.dayList);
            //   },
            // ),
            // const SizedBox(height: 12),
            ModuleWidget(
              title: 'Listening & Shadowing',
              label1: 'Listening လုပ်မယ်။',
              label2: 'Shadowing လိုက်လုပ်မယ်။',
              iconTitle: Icons.hearing,
              iconLabel1: Icons.headphones,
              iconLabel2: Icons.surround_sound,
              onPressed: () {
                Navigator.pushNamed(context, PmpRoutes.listeningListPage);
              },
            ),
            const SizedBox(height: 12),
            ModuleWidget(
              title: 'Bookmarks',
              label1: 'ကိုယ်တိုင် save ထားသော bookmarks များ',
              label2: 'Vocabulary, phrase, grammar ကို ပြန်လေ့လာမယ်',
              iconTitle: Icons.bookmark,
              iconLabel1: Icons.menu_book,
              iconLabel2: Icons.school,
              onPressed: () {
                Navigator.pushNamed(context, PmpRoutes.savedTermsPage);
              },
            ),
            const SizedBox(height: 12),
            if (kDebugMode)
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/html_list');
                },
                child: const Text('See Html List'),
              ),
            const SizedBox(height: 8),
            if (kDebugMode)
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, PmpRoutes.gritJsonList);
                },
                child: const Text('Grit JSON List'),
              ),
            const SizedBox(height: 8),
            if (kDebugMode)
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, PmpRoutes.zendayaJsonList);
                },
                child: const Text('Zendaya'),
              ),
            const SizedBox(height: 8),
            if (kDebugMode)
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                      context, PmpRoutes.importantOfSocialHealthJsonList);
                },
                child: const Text('Important of Social Health'),
              ),
            const SizedBox(height: 8),
            if (kDebugMode)
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                      context, PmpRoutes.paulRuddInterviewJsonList);
                },
                child: const Text('Paul Rudd Interview'),
              ),
            const SizedBox(height: 8),
            if (kDebugMode)
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                      context, PmpRoutes.goingViralTaughtMeJsonList);
                },
                child: const Text('Going Viral Taught Me'),
              ),
            const SizedBox(height: 8),
            if (kDebugMode)
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, PmpRoutes.grammarJsonTest);
                },
                child: const Text('Grammar JSON Test'),
              ),
            const SizedBox(height: 12),
            if (kDebugMode)
              ElevatedButton(
                onPressed: () {
                  context.read<AuthBloc>().add(const AuthEvent.logout());
                },
                child: const Text('Logout'),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(int totalDays, int streak, String message) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            UserActivityMessages.getDayTitle(totalDays),
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w400,
              color: colorScheme.onSurface,
              fontFamily: 'ArchivoBlack Regular',
            ),
            textAlign: TextAlign.center,
          ),
        ),
        if (streak > 1)
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text(
              '$streak day streak 🔥',
              style: TextStyle(
                fontSize: 13,
                color: colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        if (message.isNotEmpty)
          Align(
            alignment: Alignment.center,
            child: Text(
              message,
              style: TextStyle(
                fontSize: 16,
                color: colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ),
      ],
    );
  }
}
