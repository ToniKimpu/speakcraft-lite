import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedSuccessDialog extends StatefulWidget {
  const AnimatedSuccessDialog({
    super.key,
    this.seconds = 1,
    this.shouldExit = true,
  });

  final int seconds;
  final bool shouldExit;

  @override
  State<AnimatedSuccessDialog> createState() => _AnimatedSuccessDialogState();
}

class _AnimatedSuccessDialogState extends State<AnimatedSuccessDialog>
    with SingleTickerProviderStateMixin {
  double _opacity = 1.0;
  late final String _message;

  final List<String> _praiseMessages = [
    "Correct!", // Simple and clear
    "Well done!", // Polite and encouraging
    "Perfect!", // Strong, precise praise
    "Spot on!", // Confirms accuracy
    "Great job!", // Friendly, positive
    "Nicely done!", // Polished alternative to "You nailed it"
    "Excellent!", // Encouraging without being over-the-top
    "Impressive!" // Optional, for translations that are particularly good
  ];

  @override
  void initState() {
    super.initState();

    // Pick a random message
    final random = Random();
    _message = _praiseMessages[random.nextInt(_praiseMessages.length)];

    // Start fade out after specified seconds
    Future.delayed(Duration(seconds: widget.seconds), () {
      if (mounted) {
        setState(() {
          _opacity = 0.0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      onEnd: () {
        Future.delayed(const Duration(milliseconds: 1000), () {
          if (context.mounted && widget.shouldExit) {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }
          }
        });
      },
      opacity: _opacity,
      child: AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 80),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: const EdgeInsets.all(24),
        surfaceTintColor: const Color(0xFF1C3B2C),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              _message,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFF0FC638),
                borderRadius: BorderRadius.circular(9999),
              ),
              child: const Icon(
                Icons.check,
                color: Colors.white,
                size: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
