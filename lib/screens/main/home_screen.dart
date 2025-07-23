import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmp_english/config/pmp_routes.dart';
import 'package:pmp_english/shared_widgets/main_scaffold.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';

import '../../bloc/auth/auth_bloc.dart';
import 'widgets/module_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      maybeUpdateInBackground();
    });
  }

  Future<void> maybeUpdateInBackground() async {
    final updater = ShorebirdUpdater();
    if (!updater.isAvailable) {
      debugPrint('Shorebird is not available on this platform.');
      return;
    }
    try {
      final status = await updater.checkForUpdate();
      if (status == UpdateStatus.outdated) {
        debugPrint('Update available. Downloading...');
        await updater.update();
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text('App update downloaded. It will apply on next launch.'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      } else {
        debugPrint('App is already up to date.');
      }
    } on UpdateException catch (e) {
      debugPrint('Update failed: ${e.reason.name}');
    }
  }

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
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ModuleWidget(
              title: 'Spoken Pattern Tutorial',
              label1: 'Spoken Patternပေါင်း (၁၀၀)ကျော်လေ့လာမယ်',
              label2: 'နေ့စဉ်ပုံမှန် လေ့လာမယ်',
              onPressed: () {
                Navigator.pushNamed(context, PmpRoutes.dayList);
              },
            ),
            // const SizedBox(height: 24),
            // const Text(
            //   "Coming Soon",
            //   style: TextStyle(
            //     fontSize: 16,
            //     fontWeight: FontWeight.bold,
            //     color: Colors.white,
            //   ),
            // ),
            const SizedBox(height: 12),
             ModuleWidget(
              title: 'Listening & Shadowing Practice',
              label1: 'Listening လုပ်မယ်။',
              label2: 'Shadowing လိုက်လုပ်မယ်။',
              onPressed: (){
                Navigator.pushNamed(context, PmpRoutes.listeningListPage);
              },
            ),
            const SizedBox(height: 24),
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
