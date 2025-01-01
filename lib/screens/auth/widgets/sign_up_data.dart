import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../config/pmp_text_styles.dart';

class SignUpData extends StatefulWidget {
  const SignUpData({
    super.key,
    required this.onCompleteCheck,
  });

  final Function(bool isComplete, String name, String email, String password)
      onCompleteCheck;

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
  }

  _onCompleteCheck() {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmController.text.isEmpty) {
      widget.onCompleteCheck(false, '', '', '');
      return;
    }
    if (_passwordController.text != _confirmController.text) {
      widget.onCompleteCheck(false, '', '', '');
      return;
    }
    widget.onCompleteCheck(
      true,
      _nameController.text.trim(),
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            'Sign up and boost your english speaking skill',
            style: PmpTextStyles.body1Regular.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          TextField(
            controller: _nameController,
            onChanged: (value) => _onCompleteCheck(),
            decoration: const InputDecoration(
              hintText: 'Name',
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          TextField(
            controller: _emailController,
            onChanged: (value) => _onCompleteCheck(),
            decoration: const InputDecoration(
              hintText: 'example@gmail.com',
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          ValueListenableBuilder<bool>(
            valueListenable: _passwordObscureNotifier,
            builder: (context, isObscured, child) {
              return TextField(
                controller: _passwordController,
                onChanged: (value) => _onCompleteCheck(),
                decoration: InputDecoration(
                    hintText: 'Password',
                    suffixIcon: IconButton(
                      onPressed: () =>
                          _passwordObscureNotifier.value = !isObscured,
                      icon: Icon(
                        isObscured ? Icons.visibility : Icons.visibility_off,
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
          ValueListenableBuilder<bool>(
            valueListenable: _confirmObscureNotifier,
            builder: (context, isObscured, child) {
              return TextField(
                controller: _confirmController,
                onChanged: (value) => _onCompleteCheck(),
                decoration: InputDecoration(
                    hintText: 'Confirm your password',
                    suffixIcon: IconButton(
                      onPressed: () =>
                          _confirmObscureNotifier.value = !isObscured,
                      icon: Icon(
                        isObscured ? Icons.visibility : Icons.visibility_off,
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
          Align(
            alignment: Alignment.center,
            child: Text.rich(
              TextSpan(
                text: 'Already have an account? ',
                style: PmpTextStyles.body1Regular.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
                children: [
                  TextSpan(
                    text: 'Login',
                    style: PmpTextStyles.body1Regular.copyWith(
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
