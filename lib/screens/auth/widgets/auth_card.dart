import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../config/pmp_colors.dart';

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
    return Container(
      decoration: BoxDecoration(
        color: PmpColors.darkSurface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: PmpColors.outline.withOpacity(0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: PmpColors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: child,
    ).animate().fadeIn(duration: 600.ms).slideY(
          begin: 0.3,
          delay: Duration(milliseconds: delayMilliseconds),
        );
  }
}
