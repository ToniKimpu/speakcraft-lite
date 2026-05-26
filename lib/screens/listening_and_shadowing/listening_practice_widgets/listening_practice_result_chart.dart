import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../config/pmp_colors.dart';
import '../../../config/pmp_text_styles.dart';
import 'package:speakcraft/l10n/generated/l10n.dart';

class ListeningPracticeResultChart extends StatelessWidget {
  const ListeningPracticeResultChart({
    super.key,
    required this.correctCount,
    required this.inCorrectCount,
    required this.notAnswerCount,
  });
  final int correctCount, inCorrectCount, notAnswerCount;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      height: 200,
      width: 200,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
              borderData: FlBorderData(show: false),
              sectionsSpace: 0,
              centerSpaceRadius: 51.5,
              sections: getSections(
                correctCount,
                inCorrectCount,
                notAnswerCount,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "$correctCount",
                  style: PmpTextStyles.inter
                      .copyWith(color: colorScheme.onSurface),
                ),
                Text(
                  AppLocalizations.of(context)
                      .txtOutOf(correctCount + inCorrectCount + notAnswerCount),
                  style: PmpTextStyles.labelMedium
                      .copyWith(color: colorScheme.onSurfaceVariant),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> getSections(
      int correctCount, int inCorrectCount, int notAnswerCount) {
    List<ScoreData> scoreData = [
      ScoreData(
        name: '$correctCount',
        bgColor: PmpColors.success400,
        percent: correctCount * 10,
      ),
      ScoreData(
        name: "$inCorrectCount",
        bgColor: PmpColors.destructive400,
        percent: inCorrectCount * 10,
      ),
      ScoreData(
        name: "$notAnswerCount",
        bgColor: PmpColors.warning400,
        percent: notAnswerCount * 10,
      ),
    ];
    return scoreData
        .asMap()
        .map<int, PieChartSectionData>((key, scoreData) {
          final value = PieChartSectionData(
            color: scoreData.bgColor,
            value: scoreData.percent,
            title: scoreData.name,
            radius: 48,
            titleStyle: PmpTextStyles.sub.copyWith(color: PmpColors.white),
          );
          return MapEntry(key, value);
        })
        .values
        .toList();
  }
}

class ScoreData {
  final String name;
  final Color bgColor;

  final double percent;

  ScoreData({required this.name, required this.bgColor, required this.percent});
}
