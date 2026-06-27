import 'package:flutter/material.dart';

/// Small, dependency-free animation primitives shared by every scene. They all
/// take a plain 0..1 [t] (already computed from the master clock via `seg`),
/// so scenes stay declarative: "at this progress, this is how I look."

/// Fade + rise. [t] 0 → fully hidden and pushed down by [dy]; 1 → settled.
class FadeRise extends StatelessWidget {
  const FadeRise({
    super.key,
    required this.t,
    required this.child,
    this.dy = 24,
    this.curve = Curves.easeOutCubic,
  });

  final double t;
  final double dy;
  final Curve curve;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final e = curve.transform(t.clamp(0.0, 1.0));
    return Opacity(
      opacity: e,
      child: Transform.translate(
        offset: Offset(0, (1 - e) * dy),
        child: child,
      ),
    );
  }
}

/// Fade + scale "pop". Good for badges, chips and the CTA logo.
class FadePop extends StatelessWidget {
  const FadePop({
    super.key,
    required this.t,
    required this.child,
    this.from = 0.86,
    this.curve = Curves.easeOutBack,
  });

  final double t;
  final double from;
  final Curve curve;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final tc = t.clamp(0.0, 1.0);
    final e = curve.transform(tc);
    return Opacity(
      // Opacity uses a plain ease so the easeOutBack overshoot doesn't flicker.
      opacity: Curves.easeOut.transform(tc),
      child: Transform.scale(scale: from + (1 - from) * e, child: child),
    );
  }
}

/// A soft bottom-anchored scrim so light caption text stays legible over busy
/// scene content without hiding the focal area (which sits higher up).
class BottomScrim extends StatelessWidget {
  const BottomScrim({super.key, this.height = 360});
  final double height;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withValues(alpha: 0.0),
                Colors.black.withValues(alpha: 0.55),
                Colors.black.withValues(alpha: 0.82),
              ],
              stops: const [0.0, 0.55, 1.0],
            ),
          ),
        ),
      ),
    );
  }
}
