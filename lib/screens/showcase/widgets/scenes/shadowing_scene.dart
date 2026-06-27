import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../config/pmp_colors.dart';
import '../../../../shared_widgets/glass.dart';
import '../../../listening_and_shadowing/shadowing_widgets/highlight_types/highlight_background.dart';
import '../../showcase_director.dart';
import '../showcase_fx.dart';

/// The hero shot. A faux video frame sits on top, and below it the REAL
/// production karaoke painter ([HighlightBackground]) sweeps its highlight
/// across the canned sentence, driven by an animated position derived from the
/// master clock. Identical look to the live shadowing screen, zero network.
class ShadowingScene extends StatelessWidget {
  const ShadowingScene({super.key, required this.t});

  final double t;

  @override
  Widget build(BuildContext context) {
    final line = cannedShadowLine();
    final posSeconds = (t - kShadowKaraokeStart).clamp(0.0, line.end + 1);
    final position = Duration(milliseconds: (posSeconds * 1000).round());

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 22, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FadeRise(t: seg(t, 0.0, 0.6), child: _videoFrame()),
            const SizedBox(height: 14),
            FadeRise(t: seg(t, 0.2, 0.8), child: _speedRow()),
            const SizedBox(height: 16),
            FadeRise(
              t: seg(t, 0.35, 0.95),
              child: GlassCard(
                padding: const EdgeInsets.fromLTRB(18, 20, 18, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    HighlightBackground(
                      subtitleLine: line,
                      position: position,
                      onSeek: (_) {},
                    ),
                    const SizedBox(height: 14),
                    Text(
                      line.burmese ?? '',
                      style: const TextStyle(
                        color: PmpColors.myanmarGlossDark,
                        fontSize: 16,
                        height: 1.6,
                        fontFamily: 'Noto Sans Myanmar',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _videoFrame() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0E2230), Color(0xFF06121C)],
          ),
          border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Animated equalizer to make the frame feel "playing".
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: List.generate(11, (i) {
                    final h = 14 +
                        18 * (0.5 + 0.5 * math.sin(t * 5 + i * 0.7)).abs();
                    return Container(
                      width: 5,
                      height: h,
                      decoration: BoxDecoration(
                        color: PmpColors.brandCyanBright
                            .withValues(alpha: 0.35),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    );
                  }),
                ),
              ),
            ),
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.16),
                border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
              ),
              child: const Icon(Symbols.play_arrow,
                  color: Colors.white, size: 34, fill: 1),
            ),
          ],
        ),
      ),
    );
  }

  Widget _speedRow() {
    return Row(
      children: [
        _chip(Symbols.speed, '1.0x'),
        const SizedBox(width: 10),
        _chip(Symbols.subtitles, 'Karaoke'),
        const Spacer(),
        _chip(Symbols.replay, 'Repeat'),
      ],
    );
  }

  Widget _chip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white.withValues(alpha: 0.08),
        border: Border.all(color: Colors.white.withValues(alpha: 0.16)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: PmpColors.brandCyanBright),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
