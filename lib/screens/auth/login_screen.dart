import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:speakcraft/core/logger/app_logger.dart';
import 'package:speakcraft/bloc/auth/auth_bloc.dart';
import 'package:speakcraft/config/common_extensions.dart';
import 'package:speakcraft/config/pmp_routes.dart';
import 'package:speakcraft/screens/auth/forgot_password_screen.dart';
import 'package:speakcraft/screens/auth/widgets/auth_ui.dart';
import 'package:speakcraft/screens/main/device_failed_screen.dart';
import 'package:speakcraft/shared_widgets/glass.dart';

import '../main/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  /// Which auth action is in flight, so only the tapped button shows a spinner
  /// (null = idle). Values: 'email' | 'google'.
  final _loadingAction = ValueNotifier<String?>(null);

  late final AuthBloc _authBloc;

  @override
  void initState() {
    super.initState();
    _authBloc = context.read<AuthBloc>();
  }

  @override
  void dispose() {
    _loadingAction.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSignIn() {
    FocusScope.of(context).unfocus();
    _loadingAction.value = 'email';
    _authBloc.add(
      AuthEvent.loginWithEmail(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      ),
    );
  }

  void _onGoogle() {
    FocusScope.of(context).unfocus();
    _loadingAction.value = 'google';
    _authBloc.add(const AuthEvent.loginWithGoogle());
  }

  @override
  Widget build(BuildContext context) {
    final t = AuthTokens.of(context);

    return Scaffold(
      body: GradientBackground(
        child: BlocListener<AuthBloc, AuthState>(
          bloc: _authBloc,
          listener: (context, state) {
            state.maybeWhen(
              // The tapped button sets _loadingAction optimistically on press,
              // so we only need to clear it on the terminal states below.
              unauthenticated: () {
                // Reached when the user dismisses the Google account picker.
                _loadingAction.value = null;
              },
              authenticated: () {
                _loadingAction.value = null;
                AppLogger.instance.debug("_loginScreen: Authenticated");
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                  ModalRoute.withName(PmpRoutes.home),
                );
              },
              deviceIdFailed: () {
                _loadingAction.value = null;
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DeviceFailedScreen()),
                  ModalRoute.withName(PmpRoutes.deviceFailedScreen),
                );
              },
              socketError: (message) {
                _loadingAction.value = null;
                showErrorSnackbar(message);
              },
              error: (message) {
                _loadingAction.value = null;
                showErrorSnackbar(message);
              },
              orElse: () {},
            );
          },
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(22, 8, 22, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 18),
                  const Center(
                    child: AuthGlyph(icon: Symbols.graphic_eq),
                  ),
                  const SizedBox(height: 22),
                  Text(
                    'Welcome back',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: t.text,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    'Sign in to continue learning',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: t.dim),
                  ),
                  const SizedBox(height: 5),
                  burmeseText(
                    'ဆက်လက်လေ့လာရန် အကောင့်ဝင်ပါ',
                    color: t.mm,
                  ),
                  const SizedBox(height: 24),
                  GlassCard(
                    padding: const EdgeInsets.fromLTRB(18, 20, 18, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        GlassField(
                          controller: _emailController,
                          label: 'Email',
                          icon: Symbols.mail,
                          hint: 'you@email.com',
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          autofillHints: const [AutofillHints.email],
                        ),
                        const SizedBox(height: 16),
                        GlassField(
                          controller: _passwordController,
                          label: 'Password',
                          icon: Symbols.lock,
                          hint: 'Your password',
                          isPassword: true,
                          textInputAction: TextInputAction.done,
                          onSubmitted: (_) => _onSignIn(),
                          autofillHints: const [AutofillHints.password],
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: AuthTextLink(
                              label: 'Forgot password?',
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgotPasswordScreen(),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        ValueListenableBuilder<String?>(
                          valueListenable: _loadingAction,
                          builder: (context, action, _) {
                            return AuthPrimaryButton(
                              label: 'Sign In',
                              leadingIcon: Symbols.login,
                              loading: action == 'email',
                              onPressed: action == null ? _onSignIn : null,
                            );
                          },
                        ),
                        const SizedBox(height: 18),
                        const AuthOrDivider(),
                        const SizedBox(height: 18),
                        ValueListenableBuilder<String?>(
                          valueListenable: _loadingAction,
                          builder: (context, action, _) {
                            return AuthGhostButton(
                              label: 'Continue with Google',
                              loading: action == 'google',
                              onPressed: action == null ? _onGoogle : null,
                              leading: SvgPicture.asset(
                                'assets/images/google_logo.svg',
                                width: 20,
                                height: 20,
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 18),
                        AuthFootLink(
                          prompt: "Don't have an account?",
                          action: 'Sign up',
                          onTap: () => Navigator.pushNamed(
                              context, PmpRoutes.signUpScreen),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
