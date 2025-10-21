import 'package:flutter/material.dart';

import '../../../config/pmp_colors.dart';
import '../../../config/pmp_text_styles.dart';

class ExerciseResultLabel extends StatelessWidget {
  const ExerciseResultLabel({super.key, this.pass});
  final bool? pass;

  @override
  Widget build(BuildContext context) {
    final labelData = _getLabelData(pass);

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

  _LabelData _getLabelData(bool? pass) {
    if (pass == true) {
      return _LabelData(
        text: 'Pass ✓',
        color: Colors.lightGreenAccent.withValues(alpha: 0.3),
        textColor: PmpColors.white,
      );
    } else if (pass == false) {
      return _LabelData(
        text: 'Fail ✘',
        color: Colors.deepOrangeAccent.withValues(alpha: 0.3),
        textColor: PmpColors.red,
      );
    } else {
      return _LabelData(
        text: 'Result',
        color: Colors.lightGreenAccent.withValues(alpha: 0.3),
        textColor: PmpColors.white,
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
