import 'package:flutter/material.dart';

import '../../../config/pmp_colors.dart';
import '../../../config/pmp_text_styles.dart';

class ScoreLevelWidget extends StatelessWidget {
  const ScoreLevelWidget({
    super.key,
    required this.correctCount,
    required this.inCorrectCount,
    required this.notAnswerCount,
  });
  final int correctCount, inCorrectCount, notAnswerCount;

  @override
  Widget build(BuildContext context) {
    final total = correctCount + inCorrectCount + notAnswerCount;
    final percentage = total == 0 ? 0.0 : (correctCount / total) * 100;
    debugPrint("_scorePercentate: $percentage percentage!");
    String txtLevel = calculateLevel(percentage);
    return Container(
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF203A43),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: PmpColors.white),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Your Level',
            style:
                PmpTextStyles.body1Semi.copyWith(color: PmpColors.success500),
          ),
          const SizedBox(
            height: 12,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            decoration: BoxDecoration(
              color: getColor(txtLevel),
              borderRadius: BorderRadius.circular(200),
            ),
            child: Text(
              txtLevel,
              style: PmpTextStyles.body1Semi.copyWith(color: PmpColors.white),
            ),
          )
        ],
      ),
    );
  }

  String calculateLevel(double score) {
    if (score >= 0 && score <= 40) {
      return 'E';
    } else if (score > 40 && score <= 50) {
      return 'D';
    } else if (score > 50 && score <= 60) {
      return 'C';
    } else if (score > 60 && score <= 80) {
      return 'B';
    } else if (score > 80 && score <= 100) {
      return 'A';
    } else {
      return 'Invalid score';
    }
  }

  Color getColor(String grade) {
    switch (grade) {
      case 'A':
        return PmpColors.success400;
      case 'B':
        return PmpColors.info400;
      case 'C':
        return const Color(0xFFFFC62D);
      case 'D':
        return const Color(0xFFEF7C25);
      case 'E':
        return PmpColors.destructive500;
      default:
        return Colors.transparent;
    }
  }
}
