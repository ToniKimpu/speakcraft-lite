import 'package:flutter/material.dart';
import 'package:pmp_english/config/pmp_colors.dart';
import 'package:pmp_english/config/pmp_text_styles.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({
    super.key,
    this.msg,
  });
  final String? msg;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      contentPadding: const EdgeInsets.all(16),
      surfaceTintColor: PmpColors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 12,
          ),
          const SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(),
          ),
          const SizedBox(
            height: 12,
          ),
          if (msg != null)
            Text(
              msg ?? '',
              style: PmpTextStyles.body1Regular.copyWith(color: Colors.black),
            ),
        ],
      ),
    );
  }
}
