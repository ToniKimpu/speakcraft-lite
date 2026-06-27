import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../config/pmp_colors.dart';
import '../../../../shared_widgets/glass.dart';
import '../../showcase_director.dart';
import '../showcase_fx.dart';

class _Step {
  const _Step(this.label, this.icon, this.accent);
  final String label;
  final IconData icon;
  final Color accent;
}

const _steps = [
  _Step('Watch the video', Symbols.play_circle, PmpColors.brandCyan),
  _Step('Study the sentences', Symbols.menu_book, PmpColors.brandCyanBright),
  _Step('Key takeaways', Symbols.workspace_premium, PmpColors.premiumGold),
  _Step('Shadow along', Symbols.headphones, PmpColors.brandCyan),
  _Step('Record & compare', Symbols.mic, PmpColors.brandOrange),
];

/// The 5-step lesson path. Rows rise in first, then a green check pops on each
/// step in sequence — communicating "a guided, complete path per video".
class LessonHubScene extends StatelessWidget {
  const LessonHubScene({super.key, required this.t});

  final double t;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(22, 28, 22, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeRise(
              t: seg(t, 0.0, 0.5),
              child: const Text(
                'Your lesson path',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.3,
                ),
              ),
            ),
            const SizedBox(height: 18),
            for (var i = 0; i < _steps.length; i++) ...[
              FadeRise(
                t: seg(t, 0.2 + i * 0.14, 0.7 + i * 0.14),
                dy: 18,
                child: _stepRow(
                  _steps[i],
                  i + 1,
                  // Sequential "completion" pulse after all rows are in.
                  done: seg(t, 1.4 + i * 0.4, 1.7 + i * 0.4),
                ),
              ),
              const SizedBox(height: 11),
            ],
          ],
        ),
      ),
    );
  }

  Widget _stepRow(_Step s, int n, {required double done}) {
    final active = done > 0.05;
    return GlassCard(
      highlight: active,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: s.accent.withValues(alpha: 0.22),
            ),
            child: Icon(s.icon, color: s.accent, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              s.label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          // Step number → green check once "completed".
          SizedBox(
            width: 28,
            height: 28,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Opacity(
                  opacity: 1 - done.clamp(0.0, 1.0),
                  child: Text(
                    '$n',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.4),
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                FadePop(
                  t: done,
                  child: Container(
                    width: 26,
                    height: 26,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: PmpColors.green,
                    ),
                    child: const Icon(Symbols.check,
                        size: 18, color: Colors.black, weight: 700),
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
