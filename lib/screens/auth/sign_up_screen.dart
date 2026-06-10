import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speakcraft/bloc/auth/auth_bloc.dart';
import 'package:speakcraft/config/common_extensions.dart';
import 'package:speakcraft/screens/auth/otp_verification_screen.dart';
import 'package:speakcraft/screens/auth/widgets/sign_up_data.dart';
import 'package:speakcraft/screens/auth/widgets/sign_up_profile.dart';
import 'package:speakcraft/screens/main/home_screen.dart';

import '../../config/pmp_routes.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late final ValueNotifier<int> _currentIndexNotifier;

  String _name = '';
  String _email = '';
  String _password = '';
  String _profilePath = '';

  late final AuthBloc _authBloc;

  @override
  void initState() {
    super.initState();
    _authBloc = context.read<AuthBloc>();
    _currentIndexNotifier = ValueNotifier<int>(0);
  }

  @override
  void dispose() {
    _currentIndexNotifier.dispose();
    super.dispose();
  }

  void _onNextButtonPressed() {
    if (_currentIndexNotifier.value == 0) {
      _currentIndexNotifier.value = 1;
      FocusScope.of(context).unfocus();
    } else {
      // Handle account creation here
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        if (_currentIndexNotifier.value == 0) {
          return Navigator.of(context).pop();
        }
        _currentIndexNotifier.value = 0;
      },
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text('Create an account', style: PmpTextStyles.title1SemiBold),
        //   centerTitle: true,
        // ),
        body: BlocListener<AuthBloc, AuthState>(
          bloc: _authBloc,
          listener: (context, state) {
            state.whenOrNull(
              otpRequired: (email) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OtpVerificationScreen(email: email),
                  ),
                );
              },
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
              error: (message) {
                showErrorSnackbar(message);
              },
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ValueListenableBuilder<int>(
                  valueListenable: _currentIndexNotifier,
                  builder: (context, currentIndex, child) {
                    return IndexedStack(
                      index: currentIndex,
                      children: [
                        SignUpData(
                          onNext: _onNextButtonPressed,
                          onCompleteCheck: (isComplete, name, email, password) {
                            _name = name;
                            _email = email;
                            _password = password;
                          },
                        ),
                        SignUpProfile(
                          onProfileSelected: (profile) =>
                              _profilePath = profile,
                        ),
                      ],
                    );
                  },
                ),
              ),
              ValueListenableBuilder<int>(
                valueListenable: _currentIndexNotifier,
                builder: (context, currentIndex, child) {
                  // Step 0's "Next" lives inside the card; only the final
                  // "Create an account" action is pinned at the bottom.
                  if (currentIndex == 0) return const SizedBox.shrink();
                  final isLoading = context.watch<AuthBloc>().state.whenOrNull(
                            loading: () => true,
                          ) ??
                      false;
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                    child: SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: FilledButton(
                        onPressed: isLoading
                            ? null
                            : () {
                                _authBloc.add(
                                  AuthEvent.signupWithEmail(
                                    _email,
                                    _password,
                                    _name,
                                    _profilePath,
                                  ),
                                );
                              },
                        child: isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Text('Create an account'),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
