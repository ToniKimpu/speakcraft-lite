import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmp_english/config/pmp_routes.dart';
import 'package:pmp_english/config/pmp_text_styles.dart';
import 'package:pmp_english/shared_widgets/main_scaffold.dart';

import '../../bloc/auth/auth_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2)).then(
      (value) {
        if (context.mounted) {
          context.read<AuthBloc>().add(const AuthEvent.authCheck());
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          state.maybeWhen(
            authenticated: () {
              Navigator.pushReplacementNamed(context, PmpRoutes.home);
            },
            unauthenticated: () {
              Navigator.pushReplacementNamed(
                context,
                PmpRoutes.loginScreen,
                // (route) => false,
              );
            },
            onFreeUser: () {
              Navigator.pushReplacementNamed(
                context,
                PmpRoutes.freeUserPage,
              );
            },
            onNewVersion: (appVersion) {
              Navigator.pushReplacementNamed(
                context,
                PmpRoutes.newVersionScreen,
                arguments: {
                  'appVersion': appVersion,
                },
              );
            },
            deviceIdFailed: () {
              Navigator.pushReplacementNamed(
                context,
                PmpRoutes.deviceFailedScreen,
              );
            },
            error: (message) {},
            orElse: () => Container(),
          );
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  'assets/images/app_logo.png',
                  height: 150,
                  width: 150,
                ),
              ).animate().fadeIn(duration: 600.ms).scale(delay: 200.ms),
              const SizedBox(height: 24),
              Text(
                "PMP English App",
                style: PmpTextStyles.body1Semi.copyWith(color: Colors.white),
              ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.3, end: 0),
            ],
          ),
        ),
      ),
    );
  }
}
