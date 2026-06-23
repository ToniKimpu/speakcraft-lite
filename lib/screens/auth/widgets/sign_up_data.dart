import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:speakcraft/screens/auth/widgets/auth_ui.dart';
import 'package:speakcraft/shared_widgets/glass.dart';

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
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmController;

  /// All fields filled, password long enough and both passwords matching —
  /// drives the "Next" button.
  final _isComplete = ValueNotifier<bool>(false);

  /// Mismatch message shown under the confirm field (null when fine).
  final _confirmError = ValueNotifier<String?>(null);

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    _isComplete.dispose();
    _confirmError.dispose();
    super.dispose();
  }

  void _onCompleteCheck() {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirm = _confirmController.text.trim();
    final matches = password.isNotEmpty && password == confirm;

    // Only nag about a mismatch once the user has typed in the confirm field.
    _confirmError.value =
        confirm.isNotEmpty && !matches ? "Passwords don't match" : null;

    final isComplete =
        name.isNotEmpty && email.isNotEmpty && password.length >= 6 && matches;
    _isComplete.value = isComplete;
    widget.onCompleteCheck(isComplete, name, email, password);
  }

  @override
  Widget build(BuildContext context) {
    final t = AuthTokens.of(context);
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(22, 8, 22, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: AuthBackButton(onTap: () => Navigator.of(context).pop()),
            ),
            const SizedBox(height: 14),
            Text(
              'Create your account',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: t.text,
              ),
            ),
            const SizedBox(height: 7),
            Text(
              'Start speaking with confidence',
              style: TextStyle(fontSize: 14, color: t.dim),
            ),
            const SizedBox(height: 18),
            const AuthStepIndicator(
              current: 1,
              total: 2,
              label: 'Step 1 of 2 · Details',
            ),
            const SizedBox(height: 24),
            GlassCard(
              padding: const EdgeInsets.fromLTRB(18, 20, 18, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GlassField(
                    controller: _nameController,
                    label: 'Full name',
                    icon: Symbols.person,
                    hint: 'Thet Naing',
                    textCapitalization: TextCapitalization.words,
                    textInputAction: TextInputAction.next,
                    onChanged: (_) => _onCompleteCheck(),
                    autofillHints: const [AutofillHints.name],
                  ),
                  const SizedBox(height: 16),
                  GlassField(
                    controller: _emailController,
                    label: 'Email',
                    icon: Symbols.mail,
                    hint: 'you@email.com',
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    onChanged: (_) => _onCompleteCheck(),
                    autofillHints: const [AutofillHints.email],
                  ),
                  const SizedBox(height: 16),
                  GlassField(
                    controller: _passwordController,
                    label: 'Password',
                    icon: Symbols.lock,
                    hint: 'At least 6 characters',
                    isPassword: true,
                    textInputAction: TextInputAction.next,
                    onChanged: (_) => _onCompleteCheck(),
                    autofillHints: const [AutofillHints.newPassword],
                  ),
                  const SizedBox(height: 16),
                  ValueListenableBuilder<String?>(
                    valueListenable: _confirmError,
                    builder: (context, error, _) {
                      return GlassField(
                        controller: _confirmController,
                        label: 'Confirm password',
                        icon: Symbols.lock,
                        hint: 'Re-enter password',
                        isPassword: true,
                        textInputAction: TextInputAction.done,
                        onChanged: (_) => _onCompleteCheck(),
                        autofillHints: const [AutofillHints.newPassword],
                        errorText: error,
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  ValueListenableBuilder<bool>(
                    valueListenable: _isComplete,
                    builder: (context, isComplete, _) {
                      return AuthPrimaryButton(
                        label: 'Next',
                        trailingIcon: Symbols.arrow_forward,
                        onPressed: isComplete
                            ? () {
                                FocusScope.of(context).unfocus();
                                widget.onNext();
                              }
                            : null,
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            AuthFootLink(
              prompt: 'Already have an account?',
              action: 'Sign in',
              onTap: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}
