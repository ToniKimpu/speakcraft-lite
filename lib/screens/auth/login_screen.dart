import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmp_english/core/logger/app_logger.dart';
import 'package:pmp_english/bloc/auth/auth_bloc.dart';
import 'package:pmp_english/config/common_extensions.dart';
import 'package:pmp_english/config/pmp_colors.dart';
import 'package:pmp_english/config/pmp_routes.dart';
import 'package:pmp_english/screens/auth/widgets/auth_card.dart';
import 'package:pmp_english/screens/auth/widgets/auth_text_field.dart';
import 'package:pmp_english/screens/main/device_failed_screen.dart';
import 'package:pmp_english/shared_widgets/main_scaffold.dart';

import '../../config/pmp_text_styles.dart';
import '../main/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _obscureNotifier = ValueNotifier<bool>(true);
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  final _loadingNotifier = ValueNotifier<bool>(false);

  late final AuthBloc _authBloc;

  @override
  void initState() {
    super.initState();
    _authBloc = context.read<AuthBloc>();
  }

  @override
  void dispose() {
    super.dispose();
    _loadingNotifier.dispose();
    _obscureNotifier.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: BlocListener<AuthBloc, AuthState>(
        bloc: _authBloc,
        listener: (context, state) {
          state.maybeWhen(
            loading: () {
              _loadingNotifier.value = true;
            },
            authenticated: () {
              _loadingNotifier.value = false;
              AppLogger.instance.debug("_loginScreen: Authenticated");
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
                ModalRoute.withName(
                  PmpRoutes.home,
                ),
              );
            },
            deviceIdFailed: () {
              _loadingNotifier.value = false;
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const DeviceFailedScreen(),
                ),
                ModalRoute.withName(
                  PmpRoutes.deviceFailedScreen,
                ),
              );
            },
            onFreeUser: () {
              _loadingNotifier.value = false;
              Navigator.pushReplacementNamed(
                context,
                PmpRoutes.freeUserPage,
              );
            },
            error: (message) {
              _loadingNotifier.value = false;
              showErrorSnackbar(message);
            },
            orElse: () {},
          );
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 80),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(9999),
                  child: Image.asset(
                    "logo/app_logo.png",
                    width: 100,
                    height: 100,
                    colorBlendMode: BlendMode.srcIn,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Welcome Back',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontFamily: "ArchivoBlack Regular",
                      fontWeight: FontWeight.bold,
                      color: PmpColors.white,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Sign in to continue learning',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: PmpColors.white,
                      fontFamily: "ArchivoBlack Regular",
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              AuthCard(
                child: Column(
                  children: [
                    AuthTextField(
                      controller: _emailController,
                      labelText: 'Email',
                      prefixIcon: const Icon(Icons.email_outlined),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email is required';
                        }
                        if (!value.contains('@') || !value.contains('.')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    AuthTextField(
                      controller: _passwordController,
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock_outline),
                      obscureText: !_isPasswordVisible,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) {},
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable: _loadingNotifier,
                      builder: (context, isLoading, child) {
                        return Material(
                          borderRadius: BorderRadius.circular(12),
                          color: PmpColors.info500,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              _authBloc.add(
                                AuthEvent.loginWithEmail(
                                  _emailController.text.trim(),
                                  _passwordController.text.trim(),
                                ),
                              );
                            },
                            child: Ink(
                              height: 42,
                              width: double.infinity,
                              child: Center(
                                child: isLoading
                                    ? const SizedBox(
                                        width: 18,
                                        height: 18,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      )
                                    : Text(
                                        "Sign In",
                                        style: PmpTextStyles.body1Semi.copyWith(
                                          color: Colors.white,
                                          fontFamily: "ArchivoBlack Regular",
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     const Text(
              //       'Don\'t have an account?',
              //       style: TextStyle(
              //         color: PmpColors.white,
              //       ),
              //     ),
              //     AuthButton(
              //       text: 'Sign Up',
              //       onPressed: () {
              //         Navigator.pushNamed(context, PmpRoutes.signUpScreen);
              //       },
              //       variant: AuthButtonVariant.text,
              //       fullWidth: false,
              //       textColor: PmpColors.white,
              //     ),
              //   ],
              // )
              //     .animate()
              //     .fadeIn(duration: 600.ms)
              //     .slideY(begin: 0.3, delay: 1000.ms),
            ],
          ),
        ),
      ),
    );
  }
}
