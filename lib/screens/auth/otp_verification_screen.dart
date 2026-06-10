import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speakcraft/bloc/auth/auth_bloc.dart';
import 'package:speakcraft/config/common_extensions.dart';
import 'package:speakcraft/config/pmp_routes.dart';
import 'package:speakcraft/config/pmp_text_styles.dart';
import 'package:speakcraft/screens/auth/widgets/auth_card.dart';
import 'package:speakcraft/screens/main/device_failed_screen.dart';
import 'package:speakcraft/screens/main/home_screen.dart';

import '../../l10n/generated/l10n.dart';

const _resendCooldownSeconds = 60;

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key, required this.email});

  final String email;

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final _codeController = TextEditingController();
  final _loadingNotifier = ValueNotifier<bool>(false);
  final _secondsNotifier = ValueNotifier<int>(_resendCooldownSeconds);
  Timer? _cooldownTimer;

  late final AuthBloc _authBloc;

  @override
  void initState() {
    super.initState();
    _authBloc = context.read<AuthBloc>();
    // A code was just sent during signup — start the cooldown immediately.
    _startCooldown();
  }

  @override
  void dispose() {
    _cooldownTimer?.cancel();
    _codeController.dispose();
    _loadingNotifier.dispose();
    _secondsNotifier.dispose();
    super.dispose();
  }

  void _startCooldown() {
    _cooldownTimer?.cancel();
    _secondsNotifier.value = _resendCooldownSeconds;
    _cooldownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsNotifier.value <= 1) {
        _secondsNotifier.value = 0;
        timer.cancel();
      } else {
        _secondsNotifier.value -= 1;
      }
    });
  }

  void _onVerify() {
    FocusScope.of(context).unfocus();
    _authBloc.add(
      AuthEvent.verifyOtp(widget.email, _codeController.text.trim()),
    );
  }

  void _onResend() {
    FocusScope.of(context).unfocus();
    _authBloc.add(AuthEvent.resendOtp(widget.email));
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
            authenticated: () {
              _loadingNotifier.value = false;
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
                ModalRoute.withName(PmpRoutes.home),
              );
            },
            deviceIdFailed: () {
              _loadingNotifier.value = false;
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => const DeviceFailedScreen()),
                ModalRoute.withName(PmpRoutes.deviceFailedScreen),
              );
            },
            otpResent: () {
              _loadingNotifier.value = false;
              showSuccessSnackbar(l10n.txtCodeResent);
              _startCooldown();
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
              Icon(Icons.mark_email_read_outlined,
                  size: 72, color: colorScheme.primary),
              const SizedBox(height: 24),
              Text(
                l10n.txtVerifyEmailTitle,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                l10n.txtOtpSentTo(widget.email),
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              AuthCard(
                child: Column(
                  children: [
                    TextField(
                      controller: _codeController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      autofocus: true,
                      maxLength: 6,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(6),
                      ],
                      style: PmpTextStyles.h2.copyWith(
                        color: colorScheme.onSurface,
                        letterSpacing: 12,
                        fontWeight: FontWeight.w600,
                      ),
                      onSubmitted: (_) => _onVerify(),
                      decoration: InputDecoration(
                        counterText: '',
                        labelText: l10n.txtOtpFieldLabel,
                        filled: true,
                        fillColor: colorScheme.surfaceContainerHighest,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: colorScheme.outline.withValues(alpha: 0.5),
                          ),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ValueListenableBuilder<bool>(
                      valueListenable: _loadingNotifier,
                      builder: (context, isLoading, _) {
                        return SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: FilledButton(
                            onPressed: isLoading ? null : _onVerify,
                            child: isLoading
                                ? const SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(
                                        strokeWidth: 2),
                                  )
                                : Text(l10n.txtVerify),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    l10n.txtDidntGetCode,
                    style: TextStyle(color: colorScheme.onSurfaceVariant),
                  ),
                  ValueListenableBuilder<int>(
                    valueListenable: _secondsNotifier,
                    builder: (context, seconds, _) {
                      final canResend = seconds == 0;
                      return TextButton(
                        onPressed: canResend ? _onResend : null,
                        child: Text(
                          canResend
                              ? l10n.txtResendCode
                              : l10n.txtResendInSeconds(seconds),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
