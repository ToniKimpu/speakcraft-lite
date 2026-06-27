import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../config/pmp_colors.dart';
import '../../../../shared_widgets/glass.dart';
import '../../showcase_director.dart';
import '../showcase_fx.dart';

/// Key Takeaways: vocabulary cards popping in one-by-one — the "you keep what
/// you learn" beat.
class TakeawaysScene extends StatelessWidget {
  const TakeawaysScene({super.key, required this.t});

  final double t;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(22, 30, 22, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeRise(
              t: seg(t, 0.0, 0.5),
              child: Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      color: PmpColors.premiumGold.withValues(alpha: 0.22),
                    ),
                    child: const Icon(Symbols.workspace_premium,
                        color: PmpColors.premiumGold, size: 22),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Key Takeaways',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.3,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            for (var i = 0; i < kTakeawayChips.length; i++) ...[
              FadePop(
                t: seg(t, 0.3 + i * 0.4, 0.9 + i * 0.4),
                child: _chipCard(kTakeawayChips[i]),
              ),
              const SizedBox(height: 12),
            ],
          ],
        ),
      ),
    );
  }

  Widget _chipCard(TakeawayChip c) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          const Icon(Symbols.bookmark,
              color: PmpColors.brandCyanBright, size: 20, fill: 1),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  c.word,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  c.gloss,
                  style: const TextStyle(
                    color: PmpColors.myanmarGlossDark,
                    fontSize: 14,
                    height: 1.5,
                    fontFamily: 'Noto Sans Myanmar',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
