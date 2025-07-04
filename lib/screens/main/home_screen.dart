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
            const SizedBox(height: 24),
            const Text(
              "Coming Soon",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            const ModuleWidget(
              title: 'Listening & Shadowing Practice',
              label1: 'Listening လုပ်မယ်။',
              label2: 'Shadowing လိုက်လုပ်မယ်။',
              onPressed: null,
              // onPressed: () {
              //   Navigator.pushNamed(context, PmpRoutes.listeningListPage);
              // },
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
