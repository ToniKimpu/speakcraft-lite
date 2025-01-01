import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmp_english/config/pmp_colors.dart';
import 'package:pmp_english/config/pmp_routes.dart';

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
    Future.delayed(const Duration(seconds: 1)).then(
      (value) {
        if (context.mounted) {
          context.read<AuthBloc>().add(const AuthEvent.authCheck());
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          state.maybeWhen(
            authenticated: () {
              Navigator.pushReplacementNamed(context, PmpRoutes.home
                  // (route) => false,
                  );
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
            onNewVersion: (filePath) {},
            deviceIdFailed: () {},
            error: (message) {},
            orElse: () => Container(),
          );
        },
        child: const Center(
          child: SizedBox(
            height: 24,
            width: 24,
            child: CircularProgressIndicator(
              color: PmpColors.primary400,
            ),
          ),
        ),
      ),
    );
  }
}
