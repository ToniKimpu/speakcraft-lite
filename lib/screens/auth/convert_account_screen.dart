import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:speakcraft/bloc/auth/auth_bloc.dart';
import 'package:speakcraft/config/common_extensions.dart';
import 'package:speakcraft/config/pmp_routes.dart';
import 'package:speakcraft/screens/auth/otp_verification_screen.dart';
import 'package:speakcraft/screens/auth/widgets/auth_ui.dart';
import 'package:speakcraft/screens/main/device_failed_screen.dart';
import 'package:speakcraft/screens/main/home_screen.dart';
import 'package:speakcraft/shared_widgets/glass.dart';

/// Converts the current guest into a permanent account — Google (instant) or
/// email/password (with OTP). Both LINK to the same anonymous user, so the
/// learner keeps their account_id and all progress. Reached from the guest AI
/// prompt and the profile guest note.
class ConvertAccountScreen extends StatefulWidget {
  const ConvertAccountScreen({super.key});

  @override
  State<ConvertAccountScreen> createState() => _ConvertAccountScreenState();
}

class _ConvertAccountScreenState extends State<ConvertAccountScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  /// null = idle; 'email' | 'google' — which action is in flight.
  final _loadingAction = ValueNotifier<String?>(null);

  late final AuthBloc _authBloc;

  @override
  void initState() {
    super.initState();
    _authBloc = context.read<AuthBloc>();
  }

  @override
  void dispose() {
    _loadingAction.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onGoogle() {
    FocusScope.of(context).unfocus();
    _loadingAction.value = 'google';
    _authBloc.add(const AuthEvent.convertGuestWithGoogle());
  }

  void _onEmail() {
    FocusScope.of(context).unfocus();
    _loadingAction.value = 'email';
    _authBloc.add(
      AuthEvent.convertGuestWithEmail(
        _emailController.text.trim(),
        _passwordController.text.trim(),
        _nameController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AuthTokens.of(context);

    return Scaffold(
      body: GradientBackground(
        child: BlocListener<AuthBloc, AuthState>(
          bloc: _authBloc,
          listener: (context, state) {
            state.maybeWhen(
              unauthenticated: () => _loadingAction.value = null,
              otpRequired: (email) {
                _loadingAction.value = null;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OtpVerificationScreen(
                      email: email,
                      convertName: _nameController.text.trim(),
                    ),
                  ),
                );
              },
              authenticated: () {
                _loadingAction.value = null;
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                  ModalRoute.withName(PmpRoutes.home),
                );
              },
              deviceIdFailed: () {
                _loadingAction.value = null;
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DeviceFailedScreen()),
                  ModalRoute.withName(PmpRoutes.deviceFailedScreen),
                );
              },
              socketError: (message) {
                _loadingAction.value = null;
                showErrorSnackbar(message);
              },
              error: (message) {
                _loadingAction.value = null;
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
                    child:
                        AuthBackButton(onTap: () => Navigator.of(context).pop()),
                  ),
                  const SizedBox(height: 10),
                  const Center(child: AuthGlyph(icon: Symbols.person_add)),
                  const SizedBox(height: 20),
                  Text(
                    'Create your account',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 26, fontWeight: FontWeight.w800, color: t.text),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    'Keep your progress and unlock AI feedback & premium.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: t.dim),
                  ),
                  const SizedBox(height: 5),
                  burmeseText(
                    'သင့်တိုးတက်မှုကို သိမ်းထားပြီး AI feedback တွေ သုံးလို့ရပါမယ်။',
                    color: t.mm,
                  ),
                  const SizedBox(height: 22),
                  GlassCard(
                    padding: const EdgeInsets.fromLTRB(18, 20, 18, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ValueListenableBuilder<String?>(
                          valueListenable: _loadingAction,
                          builder: (context, action, _) {
                            return AuthGhostButton(
                              label: 'Continue with Google',
                              loading: action == 'google',
                              onPressed: action == null ? _onGoogle : null,
                              leading: SvgPicture.asset(
                                'assets/images/google_logo.svg',
                                width: 20,
                                height: 20,
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 18),
                        const AuthOrDivider(),
                        const SizedBox(height: 18),
                        GlassField(
                          controller: _nameController,
                          label: 'Name',
                          icon: Symbols.person,
                          hint: 'Your name',
                          textCapitalization: TextCapitalization.words,
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 16),
                        GlassField(
                          controller: _emailController,
                          label: 'Email',
                          icon: Symbols.mail,
                          hint: 'you@email.com',
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          autofillHints: const [AutofillHints.email],
                        ),
                        const SizedBox(height: 16),
                        GlassField(
                          controller: _passwordController,
                          label: 'Password',
                          icon: Symbols.lock,
                          hint: 'At least 6 characters',
                          isPassword: true,
                          textInputAction: TextInputAction.done,
                          onSubmitted: (_) => _onEmail(),
                          autofillHints: const [AutofillHints.newPassword],
                        ),
                        const SizedBox(height: 18),
                        ValueListenableBuilder<String?>(
                          valueListenable: _loadingAction,
                          builder: (context, action, _) {
                            return AuthPrimaryButton(
                              label: 'Sign up with email',
                              leadingIcon: Symbols.mark_email_read,
                              loading: action == 'email',
                              onPressed: action == null ? _onEmail : null,
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
        ),
      ),
    );
  }
}
