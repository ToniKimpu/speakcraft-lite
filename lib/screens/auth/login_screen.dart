import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmp_english/bloc/auth/auth_bloc.dart';
import 'package:pmp_english/config/common_extensions.dart';
import 'package:pmp_english/config/pmp_colors.dart';
import 'package:pmp_english/config/pmp_routes.dart';
import 'package:pmp_english/config/pmp_text_styles.dart';

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

  late final AuthBloc _authBloc;

  @override
  void initState() {
    super.initState();
    _authBloc = context.read<AuthBloc>();
  }

  @override
  void dispose() {
    super.dispose();
    _obscureNotifier.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        context.watch<AuthBloc>().state.whenOrNull(loading: () => true) ??
            false;
    return Scaffold(
      appBar: AppBar(
        title: Text('Login', style: PmpTextStyles.title1SemiBold),
        centerTitle: true,
      ),
      body: BlocListener<AuthBloc, AuthState>(
        bloc: _authBloc,
        listener: (context, state) {
          state.whenOrNull(
            authenticated: () {
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
              Navigator.pushReplacementNamed(
                context,
                PmpRoutes.freeUserPage,
              );
            },
            error: (message) {
              showErrorSnackbar(message);
            },
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome to PMP English',
                style: PmpTextStyles.h2.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                'Login to practice intensively your english skill',
                style: PmpTextStyles.body1Regular.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              ValueListenableBuilder<bool>(
                valueListenable: _obscureNotifier,
                builder: (context, isObscured, child) {
                  return TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          onPressed: () => _obscureNotifier.value = !isObscured,
                          icon: Icon(
                            isObscured
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.black,
                          ),
                        )),
                    obscureText: isObscured,
                  );
                },
              ),
              const SizedBox(
                height: 12,
              ),
              InkWell(
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
                  width: double.infinity,
                  height: 42,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: PmpColors.primary400,
                  ),
                  child: Center(
                    child: isLoading
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(),
                          )
                        : Text(
                            'Login',
                            style: PmpTextStyles.body1Regular.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Don\'t have an account? ',
                  style: PmpTextStyles.body1Regular.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () =>
                      Navigator.pushNamed(context, PmpRoutes.signUpScreen),
                  child: Text(
                    'Create an account',
                    style: PmpTextStyles.body1Regular.copyWith(
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
