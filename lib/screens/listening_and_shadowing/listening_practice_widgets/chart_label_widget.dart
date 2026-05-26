import 'package:flutter/material.dart';
import 'package:speakcraft/config/pmp_colors.dart';
import 'package:speakcraft/config/pmp_text_styles.dart';
import 'package:speakcraft/l10n/generated/l10n.dart';

class ChartLabelWidget extends StatelessWidget {
  const ChartLabelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildPieChartExpLabel(
            context, AppLocalizations.of(context).txtCorrect, PmpColors.success400),
        const SizedBox(
          width: 12,
        ),
        _buildPieChartExpLabel(context, AppLocalizations.of(context).txtIncorrect,
            PmpColors.destructive400),
        const SizedBox(
          width: 12,
        ),
        _buildPieChartExpLabel(
            context, AppLocalizations.of(context).txtNotAnswer, PmpColors.warning400),
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
