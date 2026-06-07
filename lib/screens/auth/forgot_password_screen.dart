import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speakcraft/bloc/auth/auth_bloc.dart';
import 'package:speakcraft/config/common_extensions.dart';
import 'package:speakcraft/screens/auth/reset_password_screen.dart';
import 'package:speakcraft/screens/auth/widgets/auth_card.dart';
import 'package:speakcraft/screens/auth/widgets/auth_text_field.dart';

import '../../l10n/generated/l10n.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  final _loadingNotifier = ValueNotifier<bool>(false);
  late final AuthBloc _authBloc;

  @override
  void initState() {
    super.initState();
    _authBloc = context.read<AuthBloc>();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _loadingNotifier.dispose();
    super.dispose();
  }

  void _onSendCode() {
    FocusScope.of(context).unfocus();
    _authBloc.add(AuthEvent.forgotPassword(_emailController.text.trim()));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<AuthBloc, AuthState>(
        bloc: _authBloc,
        listener: (context, state) {
          state.maybeWhen(
            loading: () => _loadingNotifier.value = true,
            passwordResetOtpSent: (email) {
              _loadingNotifier.value = false;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResetPasswordScreen(email: email),
                ),
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
              Icon(Icons.lock_reset_outlined,
                  size: 72, color: colorScheme.primary),
              const SizedBox(height: 24),
              Text(
                l10n.txtForgotPasswordTitle,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                l10n.txtForgotPasswordSubtitle,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              AuthCard(
                child: Column(
                  children: [
                    AuthTextField(
                      controller: _emailController,
                      labelText: 'Email',
                      prefixIcon: const Icon(Icons.email_outlined),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      autofocus: true,
                      onSubmitted: (_) => _onSendCode(),
                    ),
                    const SizedBox(height: 16),
                    ValueListenableBuilder<bool>(
                      valueListenable: _loadingNotifier,
                      builder: (context, isLoading, _) {
                        return SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: FilledButton(
                            onPressed: isLoading ? null : _onSendCode,
                            child: isLoading
                                ? const SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(
                                        strokeWidth: 2),
                                  )
                                : Text(l10n.txtSendCode),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
