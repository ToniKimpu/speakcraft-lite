import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../config/pmp_colors.dart';
import '../../showcase_director.dart';
import '../showcase_fx.dart';

/// Opening brand beat: a glowing mic badge with an expanding pulse ring and the
/// SpeakCraft wordmark resolving in over the gradient backdrop.
class HookScene extends StatelessWidget {
  const HookScene({super.key, required this.t});

  /// Seconds since this scene became active.
  final double t;

  @override
  Widget build(BuildContext context) {
    final ringFrac = (t / 1.6) % 1.0;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 200,
            height: 200,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Expanding pulse ring.
                Transform.scale(
                  scale: 1 + ringFrac * 0.7,
                  child: Opacity(
                    opacity: (1 - ringFrac) * 0.5,
                    child: Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: PmpColors.brandCyanBright,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                // Mic badge.
                FadePop(
                  t: seg(t, 0.1, 0.9),
                  from: 0.7,
                  child: Container(
                    width: 124,
                    height: 124,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          PmpColors.brandCyanBright,
                          PmpColors.brandCyanDeep,
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: PmpColors.brandCyan.withValues(alpha: 0.55),
                          blurRadius: 44,
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                    child: const Icon(Symbols.mic,
                        size: 62, color: Colors.white, weight: 600),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          FadeRise(
            t: seg(t, 0.55, 1.3),
            child: const Text(
              'SpeakCraft',
              style: TextStyle(
                color: Colors.white,
                fontSize: 38,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
