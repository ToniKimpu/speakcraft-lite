import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmp_english/config/pmp_routes.dart';
import 'package:pmp_english/shared_widgets/main_scaffold.dart';

import '../../bloc/auth/auth_bloc.dart';
import 'widgets/module_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> _welcomeMessages = [
    "Let’s practice a little today 😊📘",
    "Small steps every day! 👣✨",
    "You’re improving day by day! 📈🌟",
    "Keep going, you’re doing great! 💪🎉",
    "Practice makes progress! 📝🚀",
    "Speak more, fear less! 🗣️🔥",
    "Consistency is your superpower 💪⚡",
    "One lesson at a time! 📖⏳",
    "Believe in your English! 🌈🧠",
    "Today is a good day to learn! ☀️📚",
  ];

  String getDayTitle(int day) {
    if (day == 1) return "Day 1 – 🚀";
    if (day <= 7) return "Day $day – 💪";
    if (day <= 30) return "Day $day – 🔥";
    if (day <= 60) return "Day $day – 🌟";
    if (day < 100) return "Day $day – 🚀";
    if (day == 100) return "Day 100 – 🏆";

    return "Day $day – Keep Shining! ✨";
  }

  late String _randomMessage;

  @override
  void initState() {
    super.initState();
    _randomMessage =
        _welcomeMessages[Random().nextInt(_welcomeMessages.length)];
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   maybeUpdateInBackground();
    // });
  }

  // Future<void> maybeUpdateInBackground() async {
  //   final updater = ShorebirdUpdater();
  //   if (!updater.isAvailable) {
  //     debugPrint('Shorebird is not available on this platform.');
  //     return;
  //   }
  //   try {
  //     final status = await updater.checkForUpdate();
  //     if (status == UpdateStatus.outdated) {
  //       debugPrint('Update available. Downloading...');
  //       await updater.update();
  //       if (!mounted) return;
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content:
  //               Text('App update downloaded. It will apply on next launch.'),
  //           behavior: SnackBarBehavior.floating,
  //         ),
  //       );
  //     } else {
  //       debugPrint('App is already up to date.');
  //     }
  //   } on UpdateException catch (e) {
  //     debugPrint('Update failed: ${e.reason.name}');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
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
            const SizedBox(
              height: 8,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "“ Day 1 ”",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withValues(alpha: 0.9),
                  fontFamily: "ArchivoBlack Regular",
                  shadows: const [
                    Shadow(
                      offset: Offset(1, 1),
                      blurRadius: 1,
                      color: Colors.deepOrange,
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                _randomMessage,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            ModuleWidget(
              title: 'Useful Spoken Patterns',
              label1: 'Spoken Patternပေါင်း (၁၀၀)ကျော်လေ့လာမယ်',
              label2: 'နေ့စဉ်ပုံမှန် လေ့လာမယ်',
              iconTitle: Icons.menu_book,
              iconLabel1: Icons.format_quote,
              iconLabel2: Icons.calendar_month,
              onPressed: () {
                Navigator.pushNamed(context, PmpRoutes.dayList);
              },
            ),
            const SizedBox(height: 12),
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
            // ModuleWidget(
            //   title: 'Practice with AI',
            //   label1: 'sentence တွေကို ကိုယ်တိုင်လေ့ကျင့်မယ်။',
            //   label2: 'AI ကိုမှန်မမှန်ပြန်စစ်ခိုင်းမယ်။',
            //   iconTitle: Icons.smart_toy,
            //   iconLabel1: Icons.psychology,
            //   iconLabel2: Icons.auto_awesome,
            //   onPressed: () {
            //     Navigator.pushNamed(
            //         context, PmpRoutes.aiSentencePracticeListScreen);
            //   },
            // ),
            // const SizedBox(height: 24),

            if (kDebugMode)
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/html_list');
                },
                child: const Text('See Html List'),
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
}
