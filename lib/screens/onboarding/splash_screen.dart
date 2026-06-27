import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speakcraft/core/logger/app_logger.dart';
import 'package:speakcraft/core/network/network_error.dart';
import 'package:speakcraft/config/pmp_routes.dart';
import 'package:speakcraft/config/pmp_text_styles.dart';
import 'package:speakcraft/screens/onboarding/onboarding_page.dart';
import 'package:speakcraft/services/share_preference_utils.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/internet_checker/internet_checker_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _socketError = false;
  // The startup auth check failed (offline or otherwise) — show a retry gate
  // instead of stranding the user on the logo.
  bool _failed = false;
  bool _offlineFail = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2)).then(
      (value) {
        if (!mounted) return;
        context.read<AuthBloc>().add(const AuthEvent.authCheck());
      },
    );
  }

  void _retry() {
    setState(() => _failed = false);
    context.read<AuthBloc>().add(const AuthEvent.authCheck());
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scaffoldColor = Theme.of(context).scaffoldBackgroundColor;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: scaffoldColor,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        systemNavigationBarColor: scaffoldColor,
        systemNavigationBarIconBrightness:
            isDark ? Brightness.light : Brightness.dark,
      ),
      child: Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              state.maybeWhen(
                authenticated: () {
                  Navigator.pushReplacementNamed(context, PmpRoutes.home);
                },
                unauthenticated: () {
                  // First launch → onboarding once; afterwards → login.
                  final onboarded = SharedPreferenceUtils.getBool(
                          OnboardingPage.kDone) ==
                      true;
                  Navigator.pushReplacementNamed(
                    context,
                    onboarded ? PmpRoutes.loginScreen : PmpRoutes.onboarding,
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
                error: (message) {
                  setState(() {
                    _failed = true;
                    _offlineFail = isOfflineError(message);
                  });
                },
                socketError: (message) {
                  _socketError = true;
                  setState(() {
                    _failed = true;
                    _offlineFail = true;
                  });
                },
                orElse: () => Container(),
              );
            },
          ),
          BlocListener<InternetCheckerBloc, InternetCheckerState>(
            listener: (context, state) {
              state.maybeWhen(
                accessInternet: () {
                  AppLogger.instance
                      .debug("_internetCheckerBloc: Accessing internet");
                  // Auto-retry the moment connectivity returns.
                  if (_socketError || _failed) {
                    _socketError = false;
                    _retry();
                  }
                },
                orElse: () => -1,
              );
            },
          ),
        ],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  "logo/app_logo.png",
                  height: 150,
                  width: 150,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                "SpeakCraft",
                style: PmpTextStyles.body1Semi.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 32),
              if (_failed)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: [
                      Text(
                        _offlineFail
                            ? "No internet connection.\nCheck your connection and try again."
                            : "Something went wrong while starting up.",
                        textAlign: TextAlign.center,
                        style: PmpTextStyles.body2Regular.copyWith(
                          color:
                              Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 16),
                      FilledButton.icon(
                        onPressed: _retry,
                        icon: const Icon(Icons.refresh),
                        label: const Text("Try again"),
                      ),
                    ],
                  ),
                )
              else
                const SizedBox(
                  height: 22,
                  width: 22,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}
