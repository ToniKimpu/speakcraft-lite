import 'package:flutter/material.dart';

import '../../../../config/pmp_colors.dart';
import 'sej_highlight.dart';

class SejMainCard extends StatelessWidget {
  const SejMainCard({super.key, required this.main});
  final Map<String, dynamic> main;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final english = main['english'] as String? ?? '';
    final burmese = main['burmese'] as String? ?? '';
    final highlights = (main['highlights'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ??
        [];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: PmpColors.warning400.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
        border:
            Border.all(color: PmpColors.warning400.withValues(alpha: 0.35)),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildHighlightedText(
            english,
            highlights,
            TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: colorScheme.onSurface,
              fontFamily: 'ArchivoBlack Regular',
              height: 1.4,
            ),
          ),
          if (burmese.isNotEmpty) ...[
            const SizedBox(height: 10),
            Container(
              height: 1,
              color: PmpColors.warning400.withValues(alpha: 0.25),
            ),
            const SizedBox(height: 8),
            Text(
              burmese,
              style: TextStyle(
                fontSize: 14,
                color: colorScheme.onSurfaceVariant,
                height: 1.5,
              ),
            ),
          ],
        ],
      ),
    );
  }

}
