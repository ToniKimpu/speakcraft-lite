import 'package:flutter/material.dart';
import 'package:pmp_english/screens/listening_and_shadowing/model/hightlight_types.dart';

import '../../../config/pmp_text_styles.dart';

class HightlightTypeChooser extends StatelessWidget {
  const HightlightTypeChooser({
    super.key,
    required this.onHighlightTypeSelected,
  });

  final Function(HightlightTypes type) onHighlightTypeSelected;

  @override
  Widget build(BuildContext context) {
    final highlightOptions = [
      {
        'type': HightlightTypes.sentence,
        'label': 'Sentence',
        'icon': Icons.highlight
      },
      {
        'type': HightlightTypes.background,
        'label': 'Background',
        'icon': Icons.format_color_fill
      },
      {
        'type': HightlightTypes.underline,
        'label': 'Underline',
        'icon': Icons.format_underline
      },
      {
        'type': HightlightTypes.textColor,
        'label': 'Text Color',
        'icon': Icons.color_lens
      },
      {
        'type': HightlightTypes.none,
        'label': 'None',
        'icon': Icons.not_interested
      },
    ];

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 30, 71, 86),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // drag handle
            Container(
              height: 4,
              width: 32,
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            // title
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Text(
                "Choose Highlight Type",
                style: PmpTextStyles.body1Semi.copyWith(color: Colors.white),
              ),
            ),
            const Divider(color: Colors.white24),
            // highlight options
            ...highlightOptions.map((option) => _HighlightOptionItem(
                  icon: option['icon'] as IconData,
                  label: option['label'] as String,
                  onTap: () {
                    onHighlightTypeSelected(option['type'] as HightlightTypes);
                    Navigator.of(context).pop();
                  },
                )),
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
                Icon(icon, color: Colors.white, size: 20),
                const SizedBox(width: 12),
                Text(label,
                    style:
                        PmpTextStyles.body2Semi.copyWith(color: Colors.white)),
                const Spacer(),
                const Icon(Icons.chevron_right, color: Colors.white, size: 18),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
