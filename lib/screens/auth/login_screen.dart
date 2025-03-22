import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pmp_english/bloc/auth/auth_bloc.dart';
import 'package:pmp_english/config/common_extensions.dart';
import 'package:pmp_english/config/pmp_colors.dart';
import 'package:pmp_english/config/pmp_routes.dart';
import 'package:pmp_english/screens/auth/widgets/auth_button.dart';
import 'package:pmp_english/screens/auth/widgets/auth_card.dart';
import 'package:pmp_english/screens/auth/widgets/auth_text_field.dart';
import 'package:pmp_english/shared_widgets/main_scaffold.dart';

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
              const SizedBox(height: 40),
              Center(
                child: SvgPicture.asset(
                  "assets/images/splash_logo.svg",
                  height: 100,
                  width: 100,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ).animate().fadeIn(duration: 600.ms).scale(delay: 200.ms),
              const SizedBox(height: 32),
              Text(
                'Welcome Back',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: PmpColors.white,
                    ),
                textAlign: TextAlign.center,
              )
                  .animate()
                  .fadeIn(duration: 600.ms)
                  .slideY(begin: 0.3, delay: 200.ms),
              const SizedBox(height: 8),
              Text(
                'Sign in to continue learning',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: PmpColors.white,
                    ),
                textAlign: TextAlign.center,
              )
                  .animate()
                  .fadeIn(duration: 600.ms)
                  .slideY(begin: 0.3, delay: 400.ms),
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
                          return AuthButton(
                            text: 'Sign In',
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              _authBloc.add(
                                AuthEvent.loginWithEmail(
                                  _emailController.text.trim(),
                                  _passwordController.text.trim(),
                                ),
                              );
                            },
                            isLoading: isLoading,
                          );
                        }),
                  ],
                ).animate().fadeIn(duration: 600.ms).slideY(
                      begin: 0.3,
                      delay: const Duration(milliseconds: 600),
                    ),
              ),
              // const SizedBox(height: 24),

              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Don\'t have an account?',
                    style: TextStyle(
                      color: PmpColors.white,
                    ),
                  ),
                  AuthButton(
                    text: 'Sign Up',
                    onPressed: () {
                      Navigator.pushNamed(context, PmpRoutes.signUpScreen);
                    },
                    variant: AuthButtonVariant.text,
                    fullWidth: false,
                    textColor: PmpColors.white,
                  ),
                ],
              )
                  .animate()
                  .fadeIn(duration: 600.ms)
                  .slideY(begin: 0.3, delay: 1000.ms),

              // TextField(
              //   controller: _emailController,
              //   decoration: const InputDecoration(
              //     labelText: 'Email',
              //   ),
              // ),
              // const SizedBox(
              //   height: 12,
              // ),
              // ValueListenableBuilder<bool>(
              //   valueListenable: _obscureNotifier,
              //   builder: (context, isObscured, child) {
              //     return TextField(
              //       controller: _passwordController,
              //       decoration: InputDecoration(
              //           labelText: 'Password',
              //           suffixIcon: IconButton(
              //             onPressed: () => _obscureNotifier.value = !isObscured,
              //             icon: Icon(
              //               isObscured
              //                   ? Icons.visibility
              //                   : Icons.visibility_off,
              //               color: Colors.black,
              //             ),
              //           )),
              //       obscureText: isObscured,
              //     );
              //   },
              // ),
              // const SizedBox(
              //   height: 12,
              // ),
              // InkWell(
              //   onTap: () {
              //     FocusScope.of(context).unfocus();
              //     _authBloc.add(
              //       AuthEvent.loginWithEmail(
              //         _emailController.text.trim(),
              //         _passwordController.text.trim(),
              //       ),
              //     );
              //   },
              //   child: Ink(
              //     width: double.infinity,
              //     height: 42,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(6),
              //       color: PmpColors.primary400,
              //     ),
              //     child: Center(
              //       child: isLoading
              //           ? const SizedBox(
              //               width: 18,
              //               height: 18,
              //               child: CircularProgressIndicator(),
              //             )
              //           : Text(
              //               'Login',
              //               style: PmpTextStyles.body1Regular.copyWith(
              //                 color: Colors.white,
              //                 fontWeight: FontWeight.w600,
              //               ),
              //             ),
              //     ),
              //   ),
              // ),
              // const Spacer(),
              // Align(
              //   alignment: Alignment.center,
              //   child: Text(
              //     'Don\'t have an account? ',
              //     style: PmpTextStyles.body1Regular.copyWith(
              //       color: Colors.black,
              //       fontWeight: FontWeight.w600,
              //     ),
              //     textAlign: TextAlign.center,
              //   ),
              // ),
              // Align(
              //   alignment: Alignment.center,
              //   child: InkWell(
              //     onTap: () =>
              //         Navigator.pushNamed(context, PmpRoutes.signUpScreen),
              //     child: Text(
              //       'Create an account',
              //       style: PmpTextStyles.body1Regular.copyWith(
              //         color: Colors.blue,
              //         fontWeight: FontWeight.w600,
              //         decoration: TextDecoration.underline,
              //       ),
              //       textAlign: TextAlign.center,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
