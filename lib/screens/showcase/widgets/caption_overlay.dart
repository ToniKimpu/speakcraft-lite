import 'package:flutter/material.dart';

import '../../../config/pmp_colors.dart';
import '../showcase_director.dart';
import 'showcase_fx.dart';

/// The bilingual marketing caption pinned to the lower third of every scene.
/// English headline on top (bold, with a brand-cyan accent rule), Myanmar
/// support line below. It owns its own entrance/exit so it reads in slightly
/// after the scene settles and clears out before the cross-fade.
class CaptionOverlay extends StatelessWidget {
  const CaptionOverlay({
    super.key,
    required this.caption,
    required this.localT,
    required this.sceneDuration,
  });

  final SceneCaption caption;

  /// Seconds since this scene became active.
  final double localT;

  /// Total length of the active scene (seconds).
  final double sceneDuration;

  @override
  Widget build(BuildContext context) {
    // Reads in after a short beat, holds, then fades just before the scene ends.
    final enter = seg(localT, 0.35, 1.05);
    final exit = 1.0 - seg(localT, sceneDuration - 0.45, sceneDuration);

    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: IgnorePointer(
        child: Opacity(
          opacity: exit,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(28, 0, 28, 92),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeRise(
                  t: enter,
                  dy: 18,
                  child: Container(
                    width: 46,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          PmpColors.brandCyanBright,
                          PmpColors.brandCyan,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                FadeRise(
                  t: seg(localT, 0.45, 1.15),
                  dy: 22,
                  child: Text(
                    caption.en,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      height: 1.18,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.4,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                FadeRise(
                  t: seg(localT, 0.6, 1.3),
                  dy: 22,
                  child: Text(
                    caption.mm,
                    style: const TextStyle(
                      color: PmpColors.myanmarGlossDark,
                      fontSize: 17,
                      height: 1.55,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Noto Sans Myanmar',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
