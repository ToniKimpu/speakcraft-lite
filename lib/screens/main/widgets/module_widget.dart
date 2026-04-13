import 'package:flutter/material.dart';

import '../../../config/pmp_text_styles.dart';

class ModuleWidget extends StatelessWidget {
  const ModuleWidget({
    super.key,
    required this.title,
    required this.label1,
    required this.label2,
    required this.iconTitle,
    required this.iconLabel1,
    required this.iconLabel2,
    this.onPressed,
  });

  final String title;
  final String label1, label2;
  final IconData iconTitle, iconLabel1, iconLabel2;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                iconTitle,
                size: 20,
                color: colorScheme.onSurface,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: PmpTextStyles.body1Regular.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            height: 1,
            width: double.infinity,
            color: colorScheme.outlineVariant,
            margin: const EdgeInsets.symmetric(vertical: 8),
          ),
          const SizedBox(height: 10),
          _buildBulletPoint(context, label1, iconLabel1),
          const SizedBox(height: 10),
          _buildBulletPoint(context, label2, iconLabel2),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.bottomRight,
            child: TextButton(
              onPressed: () => onPressed?.call(),
              style: TextButton.styleFrom(
                foregroundColor: colorScheme.primary,
                textStyle: PmpTextStyles.body2Regular,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Start'),
                  const SizedBox(width: 4),
                  Icon(Icons.chevron_right, size: 20, color: colorScheme.primary),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(BuildContext context, String text, IconData icon) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Icon(icon, size: 16, color: colorScheme.onSurfaceVariant),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: PmpTextStyles.body2Regular.copyWith(
              color: colorScheme.onSurface,
            ),
          ),
        ),
      ],
    );
  }
}
