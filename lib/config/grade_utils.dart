import 'package:flutter/material.dart';
import 'pmp_colors.dart';

String calculateGrade(double score) {
  if (score >= 0 && score <= 40) {
    return 'F';
  } else if (score > 40 && score <= 50) {
    return 'D';
  } else if (score > 50 && score <= 60) {
    return 'C';
  } else if (score > 60 && score <= 70) {
    return 'B';
  } else if (score > 70 && score <= 80) {
    return 'A-';
  } else if (score > 80 && score <= 90) {
    return 'A';
  } else if (score > 90 && score <= 100) {
    return 'A+';
  } else {
    return 'F';
  }
}

Color getGradeColor(String grade) {
  switch (grade) {
    case 'A+':
    case 'A':
    case 'A-':
      return PmpColors.success400;
    case 'B':
      return PmpColors.info400;
    case 'C':
      return const Color(0xFFFFC62D);
    case 'D':
      return const Color(0xFFEF7C25);
    case 'F':
      return PmpColors.destructive500;
    default:
      return Colors.transparent;
  }
}
