import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speakcraft/core/logger/app_logger.dart';
import 'package:speakcraft/config/common_extensions.dart';
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
                error: (message) {},
                socketError: (message) {
                  _socketError = true;
                  showErrorSnackbar(
                    message,
                  );
                },
                orElse: () => Container(),
              );
            },
          ),
          BlocListener<InternetCheckerBloc, InternetCheckerState>(
            listener: (context, state) {
              state.maybeWhen(
                accessInternet: () {
                  AppLogger.instance.debug("_internetCheckerBloc: Accessing internet");
                  if (_socketError) {
                    showSuccessSnackbar("You have access to the internet.");
                    context.read<AuthBloc>().add(const AuthEvent.authCheck());
                    _socketError = false;
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
            ],
          ),
        ),
      ),
      ),
    );
  }
}
