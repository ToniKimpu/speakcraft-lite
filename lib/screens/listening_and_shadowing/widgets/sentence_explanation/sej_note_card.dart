import 'package:flutter/material.dart';

import '../../../../config/pmp_colors.dart';

class SejNoteCard extends StatelessWidget {
  const SejNoteCard({super.key, required this.note});
  final Map<String, dynamic> note;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final titleMy = note['title_my'] as String? ?? '';
    final bodyMy = note['body_my'] as String? ?? '';

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: PmpColors.warning400.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: const Border(
          left: BorderSide(color: PmpColors.warning600, width: 4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (titleMy.isNotEmpty)
            Text(
              titleMy,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
          if (titleMy.isNotEmpty && bodyMy.isNotEmpty)
            const SizedBox(height: 6),
          if (bodyMy.isNotEmpty)
            Text(
              bodyMy,
              style: TextStyle(
                fontSize: 13,
                color: colorScheme.onSurfaceVariant,
                height: 1.5,
              ),
            ),
        ],
      ),
    );
  }
}
