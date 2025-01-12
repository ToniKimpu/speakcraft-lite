import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmp_english/bloc/auth/auth_bloc.dart';
import 'package:pmp_english/config/pmp_routes.dart';

import 'widgets/module_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PMP English'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // ModuleWidget(
            //   title: 'Listening & Shadowing Practice',
            //   label1: 'Listening လေ့ကျင့်မယ်။',
            //   label2: 'Shadowing လိုက်လုပ်မယ်။',
            //   onPressed: () {
            //     Navigator.pushNamed(context, PmpRoutes.youtubeVideoPage);
            //   },
            // ),
            // const SizedBox(height: 24),
            ModuleWidget(
              title: 'Spoken Pattern Tutorial',
              label1: 'Spoken Patternပေါင်း (၁၀၀)ကျော်လေ့လာမယ်',
              label2: 'နေ့စဉ်ပုံမှန် လေ့လာမယ်',
              onPressed: () {
                Navigator.pushNamed(context, PmpRoutes.dayList);
              },
            ),
            const SizedBox(height: 24),
            ModuleWidget(
              title: 'Spoken Pattern Practices',
              label1:
                  'ကျွန်တော်တို့ လေ့လာထားတဲ့ စကားစုများကို ပြန်ပြီးတော့ လေ့ကျင့်ကြမယ်',
              label2: 'နေ့စဉ်ပုံမှန် လေ့ကျင့်မယ်',
              onPressed: () {
                Navigator.pushNamed(context, PmpRoutes.translationDayList);
              },
            ),
            const SizedBox(
              height: 24,
            ),
            ModuleWidget(
              title: 'Practice Yourself',
              label1:
                  'Pattern များကိုအသုံးပြုပြီး သင့်ကိုယ်ပိုင် အိုင်ဒီယာဖြင့် ဝါကျများကို တည်ဆောက်ပါ။',
              label2: 'နေ့စဉ်ပုံမှန် လေ့ကျင့်မယ်',
              onPressed: () {
                Navigator.pushNamed(context, PmpRoutes.patternList);
              },
            ),
            const SizedBox(
              height: 24,
            ),
            ElevatedButton(
              onPressed: () {
                context.read<AuthBloc>().add(const AuthEvent.logout());
              },
              child: const Center(
                child: Text('Logout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
