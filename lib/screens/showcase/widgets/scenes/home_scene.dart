import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../config/pmp_colors.dart';
import '../../../../shared_widgets/glass.dart';
import '../../showcase_director.dart';
import '../showcase_fx.dart';

class _Module {
  const _Module(this.title, this.subtitle, this.icon, this.accent);
  final String title;
  final String subtitle;
  final IconData icon;
  final Color accent;
}

const _modules = [
  _Module('Listening & Shadowing', 'Watch, shadow & record',
      Symbols.headphones, PmpColors.brandCyan),
  _Module('Grammar Practice', 'Foundation to advanced',
      Symbols.edit_square, PmpColors.brandOrange),
  _Module('Saved Words', 'Collect & quiz key vocab',
      Symbols.bookmark, PmpColors.brandCyanBright),
];

/// The home overview: streak header, a "continue learning" highlight card, and
/// the module cards staggering in — the breadth-and-habit shot.
class HomeScene extends StatelessWidget {
  const HomeScene({super.key, required this.t});

  final double t;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeRise(t: seg(t, 0.0, 0.6), child: _header()),
            const SizedBox(height: 20),
            FadeRise(t: seg(t, 0.25, 0.9), child: _continueCard()),
            const SizedBox(height: 14),
            for (var i = 0; i < _modules.length; i++) ...[
              FadeRise(
                t: seg(t, 0.5 + i * 0.22, 1.1 + i * 0.22),
                child: _moduleCard(_modules[i]),
              ),
              const SizedBox(height: 12),
            ],
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Day 12 of Learning',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.4,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(colors: [
                    PmpColors.brandOrange.withValues(alpha: 0.30),
                    PmpColors.brandOrange.withValues(alpha: 0.12),
                  ]),
                  border: Border.all(
                    color: PmpColors.brandOrange.withValues(alpha: 0.45),
                  ),
                ),
                child: const Text(
                  '🔥  7 day streak',
                  style: TextStyle(
                    color: PmpColors.brandOrangeBright,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withValues(alpha: 0.10),
            border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
          ),
          child: const Icon(Symbols.person, color: Colors.white, size: 24),
        ),
      ],
    );
  }

  Widget _continueCard() {
    return GlassCard(
      highlight: true,
      child: Row(
        children: [
          Container(
            width: 96,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [PmpColors.brandCyanDeep, Color(0xFF0B141D)],
              ),
            ),
            child: const Icon(Symbols.play_circle,
                color: Colors.white, size: 30),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'CONTINUE LEARNING',
                  style: TextStyle(
                    color: PmpColors.brandCyanBright,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'How to sound more natural',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: 0.6,
                    minHeight: 5,
                    backgroundColor: Colors.white.withValues(alpha: 0.12),
                    valueColor: const AlwaysStoppedAnimation(
                        PmpColors.brandOrange),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _moduleCard(_Module m) {
    return GlassCard(
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: m.accent.withValues(alpha: 0.22),
            ),
            child: Icon(m.icon, color: m.accent, size: 26),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  m.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  m.subtitle,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.62),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Icon(Symbols.chevron_right,
              color: Colors.white.withValues(alpha: 0.4), size: 24),
        ],
      ),
    );
  }
}
