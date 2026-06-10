import 'package:flutter/material.dart';
import 'package:speakcraft/screens/auth/widgets/auth_card.dart';
import 'package:speakcraft/screens/auth/widgets/auth_text_field.dart';

import '../../../config/pmp_text_styles.dart';
import '../../../l10n/generated/l10n.dart';

class SignUpData extends StatefulWidget {
  const SignUpData({
    super.key,
    required this.onCompleteCheck,
    required this.onNext,
  });

  final Function(bool isComplete, String name, String email, String password)
      onCompleteCheck;

  /// Advance to the next sign-up step — wired to the in-card "Next" button.
  final VoidCallback onNext;

  @override
  State<SignUpData> createState() => _SignUpDataState();
}

class _SignUpDataState extends State<SignUpData> {
  late final ValueNotifier<bool> _passwordObscureNotifier;
  late final ValueNotifier<bool> _confirmObscureNotifier;

  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmController;

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  /// All fields filled and passwords match — drives the in-card "Next" button.
  final _isComplete = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _passwordObscureNotifier = ValueNotifier<bool>(true);
    _confirmObscureNotifier = ValueNotifier<bool>(true);
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _passwordObscureNotifier.dispose();
    _confirmObscureNotifier.dispose();
    _isComplete.dispose();
  }

  void _onCompleteCheck() {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirm = _confirmController.text.trim();
    final isComplete = name.isNotEmpty &&
        email.isNotEmpty &&
        password.isNotEmpty &&
        confirm.isNotEmpty &&
        password == confirm;
    _isComplete.value = isComplete;
    widget.onCompleteCheck(isComplete, name, email, password);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
          Text(
            'Welcome to SpeakCraft',
            style: PmpTextStyles.h2.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          )
              ,
          const SizedBox(
            height: 12,
          ),
          Text(
            'Sign up and boost your english speaking skill',
            style: PmpTextStyles.body1Regular.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          )
              ,
          const SizedBox(height: 40),
          AuthCard(
            child: Column(
              children: [
                AuthTextField(
                  controller: _nameController,
                  labelText: 'Full Name',
                  prefixIcon: const Icon(Icons.person_outline),
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                  onChanged: (value) => _onCompleteCheck(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name is required';
                    }
                    if (value.length < 2) {
                      return 'Name must be at least 2 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                AuthTextField(
                  controller: _emailController,
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.email_outlined),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  onChanged: (value) => _onCompleteCheck(),
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
                  textInputAction: TextInputAction.next,
                  onChanged: (value) => _onCompleteCheck(),
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
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                AuthTextField(
                  controller: _confirmController,
                  labelText: 'Confirm Password',
                  prefixIcon: const Icon(Icons.lock_outline),
                  obscureText: !_isConfirmPasswordVisible,
                  textInputAction: TextInputAction.done,
                  onChanged: (value) => _onCompleteCheck(),
                  onSubmitted: (_) {},
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isConfirmPasswordVisible
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                    onPressed: () {
                      setState(() {
                        _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                ValueListenableBuilder<bool>(
                  valueListenable: _isComplete,
                  builder: (context, isComplete, child) {
                    return SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: FilledButton(
                        onPressed: isComplete
                            ? () {
                                FocusScope.of(context).unfocus();
                                widget.onNext();
                              }
                            : null,
                        child: Text(AppLocalizations.of(context).txtNext),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context).txtAlreadyHaveAccount,
                style: PmpTextStyles.body2Regular.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(AppLocalizations.of(context).txtLogin),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
