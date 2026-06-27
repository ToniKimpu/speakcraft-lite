import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../config/pmp_colors.dart';
import '../../../../shared_widgets/glass.dart';
import '../../showcase_director.dart';
import '../showcase_fx.dart';

/// Record & compare: a pulsing record button captures a take, the timer ticks,
/// then a saved "Take 1" row slides in — the "practice speaking" payoff.
class RecordScene extends StatelessWidget {
  const RecordScene({super.key, required this.t});

  final double t;

  static const _recordEnd = 3.0;

  @override
  Widget build(BuildContext context) {
    final recording = t < _recordEnd;
    final elapsed = t.clamp(0.0, _recordEnd);
    final pulse = (t / 0.9) % 1.0;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 36, 24, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Timer.
            Center(
              child: Text(
                _fmt(elapsed),
                style: TextStyle(
                  color: recording ? Colors.white : Colors.white70,
                  fontSize: 44,
                  fontWeight: FontWeight.w300,
                  fontFeatures: const [FontFeature.tabularFigures()],
                  letterSpacing: 1,
                ),
              ),
            ),
            const SizedBox(height: 22),
            _waveform(recording),
            const SizedBox(height: 34),
            Center(child: _recordButton(recording, pulse)),
            const SizedBox(height: 14),
            Center(
              child: Text(
                recording ? 'Recording…' : 'Tap to record',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 30),
            FadeRise(
              t: seg(t, _recordEnd + 0.15, _recordEnd + 0.8),
              dy: 26,
              child: _takeRow(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _recordButton(bool recording, double pulse) {
    return SizedBox(
      width: 110,
      height: 110,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (recording)
            Transform.scale(
              scale: 1 + pulse * 0.5,
              child: Opacity(
                opacity: (1 - pulse) * 0.5,
                child: Container(
                  width: 90,
                  height: 90,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: PmpColors.red,
                  ),
                ),
              ),
            ),
          Container(
            width: 84,
            height: 84,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: recording
                  ? PmpColors.red
                  : PmpColors.brandCyan.withValues(alpha: 0.18),
              border: Border.all(
                color: recording
                    ? PmpColors.red
                    : PmpColors.brandCyanBright.withValues(alpha: 0.7),
                width: 2.5,
              ),
              boxShadow: recording
                  ? [
                      BoxShadow(
                        color: PmpColors.red.withValues(alpha: 0.5),
                        blurRadius: 30,
                        spreadRadius: 2,
                      ),
                    ]
                  : null,
            ),
            child: recording
                ? const Icon(Symbols.stop, color: Colors.white, size: 34,
                    fill: 1)
                : const Icon(Symbols.mic, color: PmpColors.brandCyanBright,
                    size: 38),
          ),
        ],
      ),
    );
  }

  Widget _waveform(bool active) {
    return SizedBox(
      height: 56,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(28, (i) {
          final base = active
              ? 6 + 44 * (0.5 + 0.5 * math.sin(t * 7 + i * 0.55)).abs()
              : 6.0 + (i.isEven ? 5 : 2);
          return Container(
            width: 4,
            height: base,
            decoration: BoxDecoration(
              color: active
                  ? PmpColors.red.withValues(alpha: 0.85)
                  : Colors.white.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(2),
            ),
          );
        }),
      ),
    );
  }

  Widget _takeRow() {
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: PmpColors.brandCyan.withValues(alpha: 0.20),
            ),
            child: const Icon(Symbols.play_arrow,
                color: PmpColors.brandCyanBright, size: 24, fill: 1),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Take 1',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Just now · 0:08',
                  style: TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: PmpColors.green.withValues(alpha: 0.18),
            ),
            child: const Text(
              'Saved',
              style: TextStyle(
                color: PmpColors.green,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _fmt(double s) {
    final total = s.floor();
    final mm = (total ~/ 60).toString().padLeft(1, '0');
    final ss = (total % 60).toString().padLeft(2, '0');
    return '$mm:$ss';
  }
}
