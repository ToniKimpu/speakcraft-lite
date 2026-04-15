import 'package:flutter/material.dart';
import 'package:pmp_english/config/pmp_colors.dart';
import 'package:pmp_english/config/pmp_text_styles.dart';

class ChartLabelWidget extends StatelessWidget {
  const ChartLabelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildPieChartExpLabel(context, 'Correct', PmpColors.success400),
        const SizedBox(
          width: 12,
        ),
        _buildPieChartExpLabel(context, 'Incorrect', PmpColors.destructive400),
        const SizedBox(
          width: 12,
        ),
        _buildPieChartExpLabel(context, 'Not Answer', PmpColors.warning400),
      ],
    );
  }

  Widget _buildPieChartExpLabel(
      BuildContext context, String label, Color bgColor) {
    return Wrap(
      spacing: 8,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
              color: bgColor, borderRadius: BorderRadius.circular(100)),
        ),
        Text(
          label,
          style: PmpTextStyles.label2Regular
              .copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
      ],
    );
  }
}
