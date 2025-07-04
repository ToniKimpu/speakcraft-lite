import 'package:flutter/material.dart';

import '../../../config/pmp_colors.dart';
import '../../../config/pmp_text_styles.dart';

class ModuleWidget extends StatelessWidget {
  const ModuleWidget({
    super.key,
    required this.title,
    required this.label1,
    required this.label2,
    this.onPressed,
  });

  final String title;
  final String label1, label2;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color:
            Colors.white.withValues(alpha: 0.08), // Dark card with transparency
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color: Colors.white.withValues(alpha: 0.2)), // Subtle border
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            title,
            style: PmpTextStyles.body1Regular.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 1,
            width: double.infinity,
            color: Colors.white.withValues(alpha: 0.2), // Light separator
            margin: const EdgeInsets.symmetric(vertical: 8),
          ),
          const SizedBox(height: 10),

          // Bullet Points
          _buildBulletPoint(label1),
          const SizedBox(height: 10),
          _buildBulletPoint(label2),

          const SizedBox(height: 12),

          // Button
          Align(
            alignment: Alignment.bottomRight,
            child: TextButton(
              onPressed: () => onPressed?.call(),
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                textStyle: PmpTextStyles.body2Regular,
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Start'),
                  SizedBox(width: 4),
                  Icon(Icons.chevron_right, size: 20, color: Colors.white),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: PmpColors.white, // Use theme color for contrast
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: PmpTextStyles.body2Regular.copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
