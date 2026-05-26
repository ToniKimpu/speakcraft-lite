import 'package:flutter/material.dart';

import '../../../config/grade_utils.dart';
import '../../../config/pmp_colors.dart';
import '../../../config/pmp_text_styles.dart';
import 'package:speakcraft/l10n/generated/l10n.dart';

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
    String txtLevel = calculateGrade(percentage);
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
            AppLocalizations.of(context).txtYourLevel,
            style:
                PmpTextStyles.body1Semi.copyWith(color: PmpColors.success500),
          ),
          const SizedBox(
            height: 12,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            decoration: BoxDecoration(
              color: getGradeColor(txtLevel),
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
}
