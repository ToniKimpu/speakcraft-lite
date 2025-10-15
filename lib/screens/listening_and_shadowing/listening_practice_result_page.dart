import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pmp_english/config/pmp_colors.dart';
import 'package:pmp_english/config/pmp_text_styles.dart';
import 'package:pmp_english/screens/listening_and_shadowing/sentence_practice_widgets/chart_label_widget.dart';
import 'package:pmp_english/screens/listening_and_shadowing/sentence_practice_widgets/score_level_widget.dart';
import 'package:pmp_english/screens/listening_and_shadowing/sheets/correct_answer_sheet.dart';

import '../../model/listening_question/listening_question.dart';

class ListeningPracticeResultPage extends StatefulWidget {
  const ListeningPracticeResultPage({super.key});

  @override
  State<ListeningPracticeResultPage> createState() =>
      _ListeningPracticeResultPageState();
}

class _ListeningPracticeResultPageState
    extends State<ListeningPracticeResultPage> {
  int correctCount = 5;
  int inCorrectCount = 2;
  int notAnswerCount = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                  left: 24, top: 16, right: 24, bottom: 60),
              child: Column(
                children: [
                  const SizedBox(
                    height: 12,
                  ),
                  Center(
                    child: Text(
                      'Test Result',
                      style: PmpTextStyles.h1.copyWith(
                        color: PmpColors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  SizedBox(
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
                                correctCount, inCorrectCount, notAnswerCount),
                          ),
                        ),
                        Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "$correctCount",
                                style: PmpTextStyles.inter
                                    .copyWith(color: Colors.blue),
                              ),
                              Text(
                                'out of ${correctCount + inCorrectCount + notAnswerCount}',
                                style: PmpTextStyles.labelMedium
                                    .copyWith(color: PmpColors.white),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  const ChartLabelWidget(),
                  const SizedBox(
                    height: 32,
                  ),
                  const ScoreLevelWidget(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    child: Container(
                      height: 1,
                      width: double.infinity,
                      color: PmpColors.neutral300,
                    ),
                  ),
                  Center(
                    child: Text(
                      'Correct Answer',
                      style: PmpTextStyles.body1Regular.copyWith(
                        color: PmpColors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.red,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.3),
                          blurRadius: 8,
                          spreadRadius: 2,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Question 1',
                              style: PmpTextStyles.label2Regular
                                  .copyWith(color: PmpColors.white),
                            ),
                            InkWell(
                              borderRadius: BorderRadius.circular(16),
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (BuildContext context) {
                                    return const CorrectAnswerSheet();
                                  },
                                );
                              },
                              child: Ink(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white.withValues(alpha: 0.15),
                                ),
                                child: const Icon(
                                  Icons.expand_more,
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Does the speaker know how to build grit?",
                          style: PmpTextStyles.body1Regular.copyWith(
                            color: PmpColors.white,
                            fontFamily: "ArchivoBlack Regular",
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        _buildOption(
                          const AnswerOption(
                              answer: "No, she does not know.", correct: true),
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOption(AnswerOption answerOption) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration:
              const BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
          child: const Center(
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 13,
            ),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.blue,
              border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      answerOption.answer,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<PieChartSectionData> getSections(
      int correctCount, int inCorrectCount, int notAnswerCount) {
    List<ScoreData> scoreData = [
      ScoreData(
          name: '$correctCount',
          bgColor: PmpColors.success400,
          percent: correctCount * 10),
      ScoreData(
          name: "$inCorrectCount",
          bgColor: PmpColors.destructive400,
          percent: inCorrectCount * 10),
      ScoreData(
          name: "$notAnswerCount",
          bgColor: PmpColors.warning400,
          percent: notAnswerCount * 10),
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
