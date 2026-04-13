import 'package:flutter/material.dart';

class AuthCard extends StatelessWidget {
  final Widget child;
  final int delayMilliseconds;

  const AuthCard({
    super.key,
    required this.child,
    this.delayMilliseconds = 600,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: colorScheme.outlineVariant,
        ),
      ),
      padding: const EdgeInsets.all(24),
      child: child,
    );
  }
}
