import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:pinput/pinput.dart';
import 'package:speakcraft/bloc/auth/auth_bloc.dart';
import 'package:speakcraft/config/common_extensions.dart';
import 'package:speakcraft/config/pmp_colors.dart';
import 'package:speakcraft/config/pmp_routes.dart';
import 'package:speakcraft/screens/auth/widgets/auth_ui.dart';
import 'package:speakcraft/screens/main/device_failed_screen.dart';
import 'package:speakcraft/screens/main/home_screen.dart';
import 'package:speakcraft/shared_widgets/glass.dart';

const _resendCooldownSeconds = 60;

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({
    super.key,
    required this.email,
    this.convertName,
  });

  final String email;

  /// When non-null, this screen verifies a GUEST → account conversion (the
  /// email-change OTP) and carries the name to write into the profile, rather
  /// than a normal signup OTP.
  final String? convertName;

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
    final code = _codeController.text.trim();
    final convertName = widget.convertName;
    _authBloc.add(
      convertName != null
          ? AuthEvent.verifyGuestConvertOtp(widget.email, code, convertName)
          : AuthEvent.verifyOtp(widget.email, code),
    );
  }

  void _onResend() {
    FocusScope.of(context).unfocus();
    _authBloc.add(
      widget.convertName != null
          ? AuthEvent.resendGuestConvertOtp(widget.email)
          : AuthEvent.resendOtp(widget.email),
    );
  }

  String _formatCooldown(int seconds) {
    final m = seconds ~/ 60;
    final s = (seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final t = AuthTokens.of(context);
    final dark = Theme.of(context).brightness == Brightness.dark;

    final defaultPinTheme = PinTheme(
      width: 44,
      height: 56,
      textStyle: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w800,
        color: t.text,
      ),
      decoration: BoxDecoration(
        color: t.field,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: t.fieldBd, width: 1.5),
      ),
    );
    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: t.cyanBright, width: 1.5),
        boxShadow: [
          BoxShadow(color: t.focusGlow, blurRadius: 0, spreadRadius: 3),
        ],
      ),
    );
    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: PmpColors.brandCyanBright.withValues(alpha: dark ? 0.10 : 0.08),
        border: Border.all(color: PmpColors.brandCyan, width: 1.5),
      ),
    );

    return Scaffold(
      body: GradientBackground(
        child: BlocListener<AuthBloc, AuthState>(
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
                showSuccessSnackbar('A new code is on its way');
                _startCooldown();
              },
              error: (message) {
                _loadingNotifier.value = false;
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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: AuthBackButton(
                        onTap: () => Navigator.of(context).pop()),
                  ),
                  const SizedBox(height: 14),
                  const Center(
                    child: AuthGlyph(
                      icon: Symbols.mark_email_read,
                      circle: true,
                      size: 88,
                      iconSize: 44,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Verify your email',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: t.text,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    'We sent a 6-digit code to',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: t.dim),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    widget.email,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: t.text,
                    ),
                  ),
                  const SizedBox(height: 5),
                  burmeseText(
                    'အီးမေးလ်ထဲက ၆ လုံးကုဒ်ကို ထည့်ပါ',
                    color: t.mm,
                  ),
                  const SizedBox(height: 24),
                  GlassCard(
                    padding: const EdgeInsets.fromLTRB(18, 22, 18, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Pinput(
                          length: 6,
                          controller: _codeController,
                          autofocus: true,
                          keyboardType: TextInputType.number,
                          showCursor: true,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          defaultPinTheme: defaultPinTheme,
                          focusedPinTheme: focusedPinTheme,
                          submittedPinTheme: submittedPinTheme,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          onCompleted: (_) => _onVerify(),
                        ),
                        const SizedBox(height: 20),
                        ValueListenableBuilder<bool>(
                          valueListenable: _loadingNotifier,
                          builder: (context, isLoading, _) {
                            return AuthPrimaryButton(
                              label: 'Verify',
                              leadingIcon: Symbols.check_circle,
                              loading: isLoading,
                              onPressed: _onVerify,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  ValueListenableBuilder<int>(
                    valueListenable: _secondsNotifier,
                    builder: (context, seconds, _) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Didn't get the code? ",
                            style: TextStyle(fontSize: 13.5, color: t.dim),
                          ),
                          if (seconds == 0)
                            AuthTextLink(
                              label: 'Resend code',
                              onTap: _onResend,
                            )
                          else
                            Text(
                              'Resend in ${_formatCooldown(seconds)}',
                              style: TextStyle(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w700,
                                color: t.dim,
                              ),
                            ),
                        ],
                      );
                    },
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
