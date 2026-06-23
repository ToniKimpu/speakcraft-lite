import 'package:flutter/material.dart' show Brightness, Color, Colors;

class PmpColors {
  static const Color primary300 = Color(0xFF3593B2);
  static const Color primary400 = Color(0xFF0496C7);
  static const Color primary50 = Color(0xFFEDFAFF);
  static const Color primary100 = Color(0xFF9BD5E9);
  static const Color primary500 = Color(0xFF03789F);
  static const Color primary900 = Color(0xFF081A20);
  static const Color secondary400 = Color(0xFFC93357);
  static const Color secondary500 = Color(0xFFBC002D);
  // Warm accent for "tip / explanation / learn more" CTAs. AA-contrast with
  // white text (~4.6:1). Used by the subtitle card's View Explanation button.
  static const Color accentOrange = Color(0xFFEA580C);
  static const Color red = Colors.red;
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color neutral00 = Color(0xFF8B8B8B);
  static const Color neutral10 = Color(0xFF404040);
  static const Color neutral20 = Color(0xFFDFDFDF);
  static const Color neutral50 = Color(0xFFF8F8F8);
  static const Color neutral100 = Color(0xFFE6E6E6);
  static const Color neutral200 = Color(0xFFCCCCCC);
  static const Color neutral300 = Color(0xFFB3B3B3);
  static const Color neutral400 = Color(0xFF999999);
  static const Color neutral500 = Color(0xFFF5F5F5);
  static const Color neutral600 = Color(0xFF666666);
  static const Color neutral700 = Color(0xFF4D4D4D);
  static const Color neutral800 = Color(0xFF333333);
  static const Color neutral900 = Color(0xFF1A1A1A);
  static const Color neutral950 = Color(0xFF181818);
  static const Color transparent = Colors.transparent;
  static const Color green = Color(0xFF4FD05C);
  static const Color info50 = Color(0xFFF5FAFD);
  static const Color info400 = Color(0xFF5DADE2);
  static const Color info500 = Color(0xFF3498DB);
  static const Color info600 = Color(0xFF2A7AAF);
  static const Color success50 = Color(0xFFF2FAF6);
  static const Color success300 = Color(0xFF66CA97);
  static const Color success400 = Color(0xFF33B874);
  static const Color success500 = Color(0xFF00A651);
  static const Color success600 = Color(0xFF008541);
  static const Color warning50 = Color(0xFFFEF8EC);
  static const Color warning300 = Color(0xFFFFC62D);
  static const Color warning400 = Color(0xFFF4C468);
  static const Color warning500 = Color(0xFFF1B542);
  static const Color warning600 = Color(0xFFC19135);
  static const Color destructive500 = Color(0xFFEC2020);
  static const Color destructive400 = Color(0xFFF04D4D);
  static const Color destructive300 = Color(0xFFEC5553);
  static const Color destructive50 = Color(0xFFFEF4F4);
  static const Color darkSurface = Color(0xFF1F2532);
  static const Color outline = Color(0xFFE2E8F0);

  // Pure black theme palette
  static const Color darkBackground = Color(0xFF000000);
  static const Color darkSurfaceBw = Color(0xFF0A0A0A);
  static const Color darkSurfaceVariant = Color(0xFF1A1A1A);
  static const Color darkOutline = Color(0xFF2A2A2A);
  static const Color darkOutlineVariant = Color(0xFF242424);
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFB3B3B3);
  static const Color darkTextDisabled = Color(0xFF6B6B6B);

  // Scholar Teal light theme (warm paper background, teal primary)
  static const Color lightBackground = Color(0xFFFAF8F5);
  static const Color lightSurfaceBw = Color(0xFFFFFFFF);
  static const Color lightSurfaceVariant = Color(0xFFF4F1EB);
  // Teal-leaning border for cards, inputs, outlined buttons (brand chrome).
  static const Color lightOutline = Color(0xFFCFE0E6);
  static const Color lightOutlineVariant = Color(0xFFE8E2D6);
  static const Color lightTextPrimary = Color(0xFF1A1A1A);
  static const Color lightTextSecondary = Color(0xFF5C5C5C);
  static const Color lightTextDisabled = Color(0xFF999999);

  // Burmese (Myanmar) translation text — a calm teal that marks the "support
  // language" sitting beside English. Distinct from primary text (white/near
  // black) and from the muted grey used for side-notes/hints, so a learner can
  // tell "this is the meaning" from "this is a footnote" at a glance. Mode-aware
  // so it stays legible on both the near-black dark card and the warm-white
  // light card. Pick via [myanmarGloss].
  static const Color myanmarGlossDark = Color(0xFFA9C7D6);
  static const Color myanmarGlossLight = Color(0xFF2E6072);
  static Color myanmarGloss(Brightness brightness) =>
      brightness == Brightness.dark ? myanmarGlossDark : myanmarGlossLight;

  // ── Glass theme (cyan + orange identity) ────────────────────────────────
  // Brand accents (shared across modes).
  static const Color brandCyan = Color(0xFF0496C7);
  static const Color brandCyanBright = Color(0xFF28BBE6);
  static const Color brandCyanDeep = Color(0xFF03789F);
  static const Color brandOrange = Color(0xFFEA580C);
  static const Color brandOrangeBright = Color(0xFFF97316);

  // Premium accent — warm gold reads "premium" on a thumbnail/chip far better
  // than the flat grey `tertiary`. Pair with [onPremium] dark text for contrast.
  static const Color premiumGold = Color(0xFFF6B23C);
  static const Color premiumGoldDeep = Color(0xFFE08A1E);
  static const Color onPremium = Color(0xFF3A2400);

  // Dark gradient backdrop stops.
  static const Color glassDarkBg0 = Color(0xFF080D13);
  static const Color glassDarkBg1 = Color(0xFF0B141D);
  static const Color glassDarkSurface = Color(0xFF0E1722);
  static const Color glassDarkCard = Color(0xFF131E29);
  static const Color glassDarkOutline = Color(0xFF243441);

  // Light gradient backdrop stops.
  static const Color glassLightBg0 = Color(0xFFEFF5F9);
  static const Color glassLightBg1 = Color(0xFFE2ECF2);
  static const Color glassLightText = Color(0xFF0F2C3A);
  static const Color glassLightTextDim = Color(0xFF5C7585);
}
