import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../config/pmp_colors.dart';
import '../../showcase_director.dart';
import '../showcase_fx.dart';

/// Closing call-to-action: confetti burst, the SpeakCraft logo + wordmark, and
/// a store badge. Stateful so the confetti controller fires fresh each time the
/// scene mounts (i.e. once per loop).
class CtaScene extends StatefulWidget {
  const CtaScene({super.key, required this.t});

  final double t;

  @override
  State<CtaScene> createState() => _CtaSceneState();
}

class _CtaSceneState extends State<CtaScene> {
  late final ConfettiController _confetti =
      ConfettiController(duration: const Duration(seconds: 1));

  @override
  void initState() {
    super.initState();
    _confetti.play();
  }

  @override
  void dispose() {
    _confetti.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = widget.t;
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: _confetti,
            blastDirectionality: BlastDirectionality.explosive,
            emissionFrequency: 0.04,
            numberOfParticles: 18,
            gravity: 0.25,
            maxBlastForce: 22,
            minBlastForce: 8,
            colors: const [
              PmpColors.brandCyanBright,
              PmpColors.brandCyan,
              PmpColors.brandOrange,
              PmpColors.premiumGold,
              Colors.white,
            ],
          ),
        ),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FadePop(
                t: seg(t, 0.1, 0.9),
                from: 0.7,
                child: Container(
                  width: 104,
                  height: 104,
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
                        color: PmpColors.brandCyan.withValues(alpha: 0.5),
                        blurRadius: 40,
                        spreadRadius: 3,
                      ),
                    ],
                  ),
                  child: const Icon(Symbols.mic,
                      size: 54, color: Colors.white, weight: 600),
                ),
              ),
              const SizedBox(height: 22),
              FadeRise(
                t: seg(t, 0.35, 1.0),
                child: const Text(
                  'SpeakCraft',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              FadeRise(
                t: seg(t, 0.5, 1.15),
                child: Text(
                  'Listen · Shadow · Speak',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.65),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
              const SizedBox(height: 28),
              FadePop(t: seg(t, 0.7, 1.3), child: _storeBadge()),
            ],
          ),
        ),
      ],
    );
  }

  Widget _storeBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: const LinearGradient(
          colors: [PmpColors.brandCyanBright, PmpColors.brandCyan],
        ),
        boxShadow: [
          BoxShadow(
            color: PmpColors.brandCyan.withValues(alpha: 0.4),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Symbols.android, color: Colors.white, size: 22, fill: 1),
          SizedBox(width: 10),
          Text(
            'Get it on Google Play',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
