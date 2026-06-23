import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../config/pmp_colors.dart';

/// Circular glass back button used in app bars (lesson hub, listening list, …).
/// Defaults to popping the current route.
class GlassBackButton extends StatelessWidget {
  const GlassBackButton({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Material(
      color: dark
          ? Colors.white.withValues(alpha: 0.08)
          : const Color(0xFF0D3147).withValues(alpha: 0.05),
      shape: CircleBorder(
        side: BorderSide(
          color: dark
              ? Colors.white.withValues(alpha: 0.20)
              : const Color(0xFF0D3147).withValues(alpha: 0.14),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap ?? () => Navigator.of(context).maybePop(),
        child: SizedBox(
          width: 40,
          height: 40,
          child: Icon(Symbols.arrow_back, size: 22, color: cs.onSurface),
        ),
      ),
    );
  }
}

/// Blur + a gentle saturation bump, applied behind every [GlassCard] — mirrors
/// the mock's `backdrop-filter: blur(18px) saturate(1.4)`. Composed once and
/// reused so we don't rebuild the (immutable) filter per card. The colour
/// matrix is a standard saturation matrix at s=1.4.
final ImageFilter _kGlassFilter = ImageFilter.compose(
  outer: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
  inner: const ColorFilter.matrix(<double>[
    1.31496, -0.28608, -0.02888, 0, 0, //
    -0.08504, 1.11392, -0.02888, 0, 0, //
    -0.08504, -0.28608, 1.37112, 0, 0, //
    0, 0, 0, 1, 0, //
  ]),
);

/// System status-bar + nav-bar overlay style that matches the glass backdrop:
/// transparent status bar with light icons on dark mode, dark icons on light.
SystemUiOverlayStyle glassOverlayStyle(Brightness brightness) {
  final dark = brightness == Brightness.dark;
  return SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: dark ? Brightness.light : Brightness.dark, // Android
    statusBarBrightness: dark ? Brightness.dark : Brightness.light, // iOS
    systemNavigationBarColor:
        dark ? PmpColors.glassDarkBg1 : PmpColors.glassLightBg1,
    systemNavigationBarIconBrightness:
        dark ? Brightness.light : Brightness.dark,
  );
}

/// Full-bleed themed backdrop: a vertical gradient with a cyan glow (top-right)
/// and a warm orange glow (bottom-left). Cheap — no blur — so wrap a whole
/// screen body in it. Glass cards placed over it read as frosted for free.
class GradientBackground extends StatelessWidget {
  const GradientBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final bg0 = dark ? PmpColors.glassDarkBg0 : PmpColors.glassLightBg0;
    final bg1 = dark ? PmpColors.glassDarkBg1 : PmpColors.glassLightBg1;
    // Two full-screen radial washes over the dark base — a teal one anchored
    // top-right and a warm orange one bottom-left — mirroring the design mock's
    // `radial-gradient(... at 82% -12%)` layers. Full-screen (not small corner
    // circles) so the colour bleeds evenly into the content area: a flat-black
    // middle band makes the translucent glass cards read as plain dark
    // rectangles instead of frosted. Cheap — plain gradients, no blur.
    const cyan = PmpColors.brandCyan;
    const orange = PmpColors.brandOrange;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: glassOverlayStyle(Theme.of(context).brightness),
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [bg0, bg1],
          ),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: const Alignment(0.9, -0.85),
                    radius: 1.35,
                    colors: [
                      cyan.withValues(alpha: dark ? 0.34 : 0.20),
                      cyan.withValues(alpha: 0),
                    ],
                    stops: const [0.0, 0.72],
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: const Alignment(-0.95, 1.0),
                    radius: 1.1,
                    colors: [
                      orange.withValues(alpha: dark ? 0.20 : 0.13),
                      orange.withValues(alpha: 0),
                    ],
                    stops: const [0.0, 0.62],
                  ),
                ),
              ),
            ),
            Positioned.fill(child: child),
          ],
        ),
      ),
    );
  }
}

/// A Scaffold whose [GradientBackground] sits behind BOTH the app bar and the
/// body, so the backdrop (and its glow) flows continuously — no dead black
/// app-bar band. The app bar is forced transparent. Content lays out below the
/// bar normally (no extend-behind collisions).
class GlassScaffold extends StatelessWidget {
  const GlassScaffold({
    super.key,
    this.title,
    this.actions,
    this.leading,
    this.automaticallyImplyLeading = true,
    required this.body,
    this.bottomNavigationBar,
  });

  final Widget? title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final Widget body;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    // Default the back affordance to the circular GlassBackButton on any screen
    // that can pop, unless the caller supplied its own leading or opted out.
    final effectiveLeading = leading ??
        (automaticallyImplyLeading && Navigator.of(context).canPop()
            ? const Padding(
                padding: EdgeInsets.only(left: 8),
                child: GlassBackButton(),
              )
            : null);
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          automaticallyImplyLeading: false,
          leading: effectiveLeading,
          title: title,
          actions: actions,
        ),
        body: body,
        bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }
}

/// Frosted glass card. Uses a real [BackdropFilter] (blur + light saturation)
/// bounded by a [ClipRRect], a translucent fill that's brighter at the top so
/// the card reads as a lit pane, a brightened top-edge border and a soft drop
/// shadow — a close match to the CSS `.glass` in the design mock. Set
/// [highlight] for the cyan emphasis used by "recommended next" elements.
///
/// Set [blur] to `false` for cards rendered many-at-once in a scrolling list:
/// the real [BackdropFilter] is the only expensive part, and over the smooth
/// gradient background the blur is barely visible, so list rows get the same
/// look at a fraction of the GPU cost by skipping it.
class GlassCard extends StatelessWidget {
  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.onTap,
    this.borderRadius = 20,
    this.highlight = false,
    this.blur = true,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final double borderRadius;
  final bool highlight;
  final bool blur;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;

    // Translucent fill, brighter at the top, so the blurred backdrop shows
    // through and the pane looks lit from above.
    // Highlight = the mock's "recommended next" card: a light, airy cyan tint.
    // Must use brandCyanBright (#28BBE6 = the mock's rgba(40,187,230)), NOT the
    // deeper brandCyan (#0496C7) which renders as a dark saturated blue.
    // Highlight = the mock's "recommended next" card. The look comes from a
    // bright, crisp border + soft glow (which read the same on any background),
    // with only a LIGHT cyan tint inside (lit at the top). A heavy translucent
    // fill turns muddy over the near-black background, so keep the fill subtle.
    final List<Color> fillColors = highlight
        ? (dark
            // Near-flat, faint tint so the interior stays dark like the mock —
            // the bright border + glow (below) carry the "selected" look, not a
            // filled teal panel.
            ? [
                PmpColors.brandCyanBright.withValues(alpha: 0.07),
                PmpColors.brandCyanBright.withValues(alpha: 0.05),
              ]
            // Light mode: a clean, opaque pale cyan so the background glows
            // don't bleed through and muddy the card.
            : [
                const Color(0xFFE7F4FA),
                const Color(0xFFDBEEF7),
              ])
        : (dark
            ? [
                Colors.white.withValues(alpha: 0.11),
                Colors.white.withValues(alpha: 0.045),
              ]
            : [
                Colors.white.withValues(alpha: 0.70),
                Colors.white.withValues(alpha: 0.55),
              ]);
    final border = highlight
        ? (dark
            ? PmpColors.brandCyanBright.withValues(alpha: 0.80)
            : PmpColors.brandCyan.withValues(alpha: 0.50))
        : (dark
            ? Colors.white.withValues(alpha: 0.16)
            : const Color(0xFF0D3147).withValues(alpha: 0.10));
    final r = BorderRadius.circular(borderRadius);

    // Shadow on the OUTER box (outside the clip, never cut). The blur is bounded
    // by the ClipRRect so it only frosts this card's footprint; the translucent
    // gradient fill + border are painted over the blurred backdrop.
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: r,
        boxShadow: [
          BoxShadow(
            color: dark
                ? Colors.black.withValues(alpha: 0.30)
                : const Color(0xFF1E3A4C).withValues(alpha: 0.10),
            blurRadius: dark ? 22 : 18,
            offset: const Offset(0, 8),
          ),
          if (highlight)
            BoxShadow(
              color: PmpColors.brandCyan.withValues(alpha: dark ? 0.28 : 0.14),
              blurRadius: 28,
              offset: const Offset(0, 8),
            ),
        ],
      ),
      child: ClipRRect(
        borderRadius: r,
        child: _maybeBlur(
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: r,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: fillColors,
              ),
              border: Border.all(color: border, width: highlight ? 1.6 : 1),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                child: Padding(padding: padding, child: child),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _maybeBlur(Widget child) =>
      blur ? BackdropFilter(filter: _kGlassFilter, child: child) : child;
}
