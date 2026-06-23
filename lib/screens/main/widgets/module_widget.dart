import 'package:flutter/material.dart';

import '../../../config/pmp_colors.dart';
import '../../../shared_widgets/glass.dart';

enum ModuleAccent { cyan, orange }

/// Home "module" entry as a frosted glass card: a colored icon tile, a title,
/// two support sub-labels, and a chevron. The whole card is tappable.
class ModuleWidget extends StatelessWidget {
  const ModuleWidget({
    super.key,
    required this.title,
    required this.label1,
    required this.label2,
    required this.iconTitle,
    required this.iconLabel1,
    required this.iconLabel2,
    this.onPressed,
    this.accent = ModuleAccent.cyan,
  });

  final String title;
  final String label1, label2;
  final IconData iconTitle, iconLabel1, iconLabel2;
  final VoidCallback? onPressed;
  final ModuleAccent accent;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final mm = PmpColors.myanmarGloss(Theme.of(context).brightness);
    final isCyan = accent == ModuleAccent.cyan;
    final accentBase = isCyan ? PmpColors.brandCyan : PmpColors.brandOrange;
    final accentBright =
        isCyan ? PmpColors.brandCyanBright : PmpColors.brandOrangeBright;

    return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: GlassCard(
        onTap: onPressed,
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    accentBase.withValues(alpha: 0.22),
                    accentBase.withValues(alpha: 0.05),
                  ],
                ),
                border:
                    Border.all(color: accentBase.withValues(alpha: 0.30)),
              ),
              child: Icon(iconTitle, size: 26, color: accentBright),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: cs.onSurface,
                    ),
                  ),
                  const SizedBox(height: 5),
                  _sub(cs, mm, iconLabel1, label1),
                  _sub(cs, mm, iconLabel2, label2),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(Icons.chevron_right, color: cs.onSurfaceVariant, size: 24),
          ],
        ),
      ),
    );
  }

  Widget _sub(ColorScheme cs, Color mm, IconData icon, String text) => Padding(
        padding: const EdgeInsets.only(top: 3),
        child: Row(
          children: [
            Icon(icon, size: 14, color: cs.onSurfaceVariant),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                text,
                style: TextStyle(fontSize: 12.5, color: mm, height: 1.3),
              ),
            ),
          ],
        ),
      );
}
