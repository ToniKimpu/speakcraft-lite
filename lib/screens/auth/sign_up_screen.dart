import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmp_english/bloc/auth/auth_bloc.dart';
import 'package:pmp_english/config/common_extensions.dart';
import 'package:pmp_english/config/pmp_colors.dart';
import 'package:pmp_english/config/pmp_text_styles.dart';
import 'package:pmp_english/screens/auth/widgets/sign_up_data.dart';
import 'package:pmp_english/screens/auth/widgets/sign_up_profile.dart';
import 'package:pmp_english/screens/main/home_screen.dart';
import 'package:pmp_english/shared_widgets/main_scaffold.dart';

import '../../config/pmp_routes.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late final ValueNotifier<int> _currentIndexNotifier;
  late final ValueNotifier<bool> _completeNotifier;

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
    _completeNotifier = ValueNotifier<bool>(false);
  }

  @override
  void dispose() {
    _currentIndexNotifier.dispose();
    _completeNotifier.dispose();
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
      child: MainScaffold(
        // appBar: AppBar(
        //   title: Text('Create an account', style: PmpTextStyles.title1SemiBold),
        //   centerTitle: true,
        // ),
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
                          onCompleteCheck: (isComplete, name, email, password) {
                            _completeNotifier.value = isComplete;
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ValueListenableBuilder<bool>(
                  valueListenable: _completeNotifier,
                  builder: (context, isComplete, child) {
                    return ValueListenableBuilder<int>(
                      valueListenable: _currentIndexNotifier,
                      builder: (context, currentIndex, child) {
                        final buttonText =
                            currentIndex == 0 ? 'Next' : 'Create an account';
                        final isLoading =
                            context.watch<AuthBloc>().state.whenOrNull(
                                      loading: () => true,
                                    ) ??
                                false;
                        return InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: () {
                            if (_currentIndexNotifier.value == 0 &&
                                !isComplete) {
                              return;
                            }
                            if (_currentIndexNotifier.value == 0 &&
                                isComplete) {
                              FocusScope.of(context).unfocus();
                              _onNextButtonPressed();
                            } else {
                              _authBloc.add(
                                AuthEvent.signupWithEmail(
                                  _email,
                                  _password,
                                  _name,
                                  _profilePath,
                                ),
                              );
                            }
                          },
                          child: Ink(
                            width: double.infinity,
                            height: 48,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              gradient: isComplete
                                  ? const LinearGradient(
                                      colors: [
                                        Color(0xFF00C6FF),
                                        Color(0xFF0072FF)
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    )
                                  : LinearGradient(
                                      colors: [
                                        PmpColors.primary400.withOpacity(0.6),
                                        PmpColors.primary400.withOpacity(0.4),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                              boxShadow: isComplete
                                  ? [
                                      BoxShadow(
                                        color: Colors.blue.withOpacity(0.3),
                                        blurRadius: 6,
                                        spreadRadius: 1,
                                        offset: const Offset(0, 3),
                                      )
                                    ]
                                  : [],
                            ),
                            child: Center(
                              child: isLoading
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                      ),
                                    )
                                  : Text(
                                      buttonText,
                                      style:
                                          PmpTextStyles.body1Regular.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.8,
                                      ),
                                    ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
