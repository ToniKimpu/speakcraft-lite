import 'package:flutter/material.dart';

import '../../../../config/pmp_text_styles.dart';

class FooterWidget extends StatelessWidget {
  // final List<SpokenPattern> spokenPatterns;
  final int totalPage;
  final int currentPage;
  final Function(int page) onPageChanged;
  final bool nextEnabled;

  const FooterWidget({
    super.key,
    // required this.spokenPatterns,
    required this.totalPage,
    required this.currentPage,
    required this.onPageChanged,
    required this.nextEnabled,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      elevation: 4,
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.only(left: 12, right: 12, bottom: 12, top: 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildPreviousButton(colorScheme),
            _buildProgressIndicator(colorScheme),
            _buildNextButton(colorScheme),
          ],
        ),
      ),
    );
  }

  Widget _buildPreviousButton(ColorScheme colorScheme) {
    final disabled = currentPage == 0;
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: disabled ? null : () => onPageChanged(currentPage - 1),
      child: Ink(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: disabled
              ? colorScheme.onSurface.withValues(alpha: 0.12)
              : colorScheme.inverseSurface,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.chevron_left,
          color: disabled
              ? colorScheme.onSurface.withValues(alpha: 0.38)
              : colorScheme.onInverseSurface,
          size: 28,
        ),
      ),
    );
  }

  Widget _buildProgressIndicator(ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: colorScheme.inverseSurface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        '${currentPage + 1}/$totalPage',
        style: PmpTextStyles.body2Semi.copyWith(
          color: colorScheme.onInverseSurface,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildNextButton(ColorScheme colorScheme) {
    final totalPatterns = totalPage - 1;
    final disabled = currentPage >= totalPatterns || !nextEnabled;
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: disabled ? null : () => onPageChanged(currentPage + 1),
      child: Ink(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: disabled
              ? colorScheme.onSurface.withValues(alpha: 0.12)
              : colorScheme.inverseSurface,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.chevron_right,
          color: disabled
              ? colorScheme.onSurface.withValues(alpha: 0.38)
              : colorScheme.onInverseSurface,
          size: 28,
        ),
      ),
    );
  }
}
