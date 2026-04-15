import 'package:flutter/material.dart';

import '../../../config/pmp_colors.dart';
import '../../../config/pmp_text_styles.dart';

class ExerciseResultLabel extends StatelessWidget {
  const ExerciseResultLabel({super.key, this.pass});
  final bool? pass;

  @override
  Widget build(BuildContext context) {
    final labelData = _getLabelData(context, pass);

    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: labelData.color,
        ),
        child: Text(
          labelData.text,
          style: PmpTextStyles.h1.copyWith(
            color: labelData.textColor,
            fontWeight: labelData.fontWeight,
            fontFamily: "ArchivoBlack Regular",
          ),
        ),
      ),
    );
  }

  _LabelData _getLabelData(BuildContext context, bool? pass) {
    final colorScheme = Theme.of(context).colorScheme;
    if (pass == true) {
      return _LabelData(
        text: 'Pass ✓',
        color: PmpColors.success400.withValues(alpha: 0.15),
        textColor: PmpColors.success400,
      );
    } else if (pass == false) {
      return _LabelData(
        text: 'Fail ✘',
        color: PmpColors.destructive400.withValues(alpha: 0.15),
        textColor: PmpColors.destructive400,
      );
    } else {
      return _LabelData(
        text: 'Result',
        color: colorScheme.surfaceContainerHighest,
        textColor: colorScheme.onSurface,
        fontWeight: FontWeight.w400,
      );
    }
  }
}

class _LabelData {
  final String text;
  final Color color;
  final Color textColor;
  final FontWeight fontWeight;

  _LabelData({
    required this.text,
    required this.color,
    required this.textColor,
    this.fontWeight = FontWeight.bold,
  });
}
