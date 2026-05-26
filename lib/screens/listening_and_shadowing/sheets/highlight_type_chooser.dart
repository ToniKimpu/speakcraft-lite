import 'package:flutter/material.dart';
import 'package:speakcraft/screens/listening_and_shadowing/model/highlight_types.dart';

import '../../../config/pmp_text_styles.dart';
import 'package:speakcraft/l10n/generated/l10n.dart';

class HighlightTypeChooser extends StatelessWidget {
  const HighlightTypeChooser({
    super.key,
    required this.onHighlightTypeSelected,
  });

  final Function(HighlightType type) onHighlightTypeSelected;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final highlightOptions = [
      {
        'type': HighlightType.readAlong,
        'label': AppLocalizations.of(context).txtHighlightReadAlong,
        'icon': Icons.format_color_fill,
      },
      {
        'type': HighlightType.line,
        'label': AppLocalizations.of(context).txtHighlightLine,
        'icon': Icons.highlight,
      },
      {
        'type': HighlightType.none,
        'label': AppLocalizations.of(context).txtHighlightNone,
        'icon': Icons.not_interested,
      },
    ];

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 4,
              width: 32,
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: colorScheme.onSurfaceVariant,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Text(
                AppLocalizations.of(context).txtChooseHighlightType,
                style: PmpTextStyles.body1Semi
                    .copyWith(color: colorScheme.onSurface),
              ),
            ),
            Divider(color: colorScheme.outlineVariant, height: 1),
            ...highlightOptions.map((option) => _HighlightOptionItem(
                  icon: option['icon'] as IconData,
                  label: option['label'] as String,
                  onTap: () {
                    onHighlightTypeSelected(option['type'] as HighlightType);
                    Navigator.of(context).pop();
                  },
                )),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class _HighlightOptionItem extends StatelessWidget {
  const _HighlightOptionItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 50,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Icon(icon, color: colorScheme.onSurface, size: 20),
                const SizedBox(width: 12),
                Text(
                  label,
                  style: PmpTextStyles.body2Semi
                      .copyWith(color: colorScheme.onSurface),
                ),
                const Spacer(),
                Icon(
                  Icons.chevron_right,
                  color: colorScheme.onSurfaceVariant,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
