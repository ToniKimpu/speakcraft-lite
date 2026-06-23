import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'pmp_colors.dart';
import 'pmp_text_styles.dart';

class PmpThemes {
  static ThemeData get darkTheme => _build(_PmpPalette.dark());
  static ThemeData get lightTheme => _build(_PmpPalette.light());

  static ThemeData _build(_PmpPalette p) {
    final colorScheme = ColorScheme(
      brightness: p.brightness,
      primary: p.primary,
      onPrimary: p.onPrimary,
      primaryContainer: p.surfaceVariant,
      onPrimaryContainer: p.textPrimary,
      secondary: p.primary,
      onSecondary: p.onPrimary,
      secondaryContainer: p.surfaceVariant,
      onSecondaryContainer: p.textPrimary,
      tertiary: p.textSecondary,
      onTertiary: p.onPrimary,
      tertiaryContainer: p.surfaceVariant,
      onTertiaryContainer: p.textPrimary,
      error: PmpColors.destructive500,
      onError: PmpColors.white,
      errorContainer: PmpColors.destructive50,
      onErrorContainer: PmpColors.destructive500,
      surface: p.surface,
      onSurface: p.textPrimary,
      surfaceContainerHighest: p.cardBg,
      surfaceContainerHigh: p.cardBg,
      surfaceContainer: p.cardBg,
      surfaceContainerLow: p.surface,
      surfaceContainerLowest: p.background,
      onSurfaceVariant: p.textSecondary,
      outline: p.outline,
      outlineVariant: p.outlineVariant,
      shadow: PmpColors.black,
      scrim: PmpColors.black,
      inverseSurface: p.primary,
      onInverseSurface: p.onPrimary,
      inversePrimary: p.onPrimary,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: p.brightness,
      fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: p.background,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          TargetPlatform.android: ZoomPageTransitionsBuilder(
            allowEnterRouteSnapshotting: false,
          ),
        },
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(color: p.primary),
      appBarTheme: AppBarTheme(
        backgroundColor: p.appBarBg,
        foregroundColor: p.appBarFg,
        iconTheme: IconThemeData(color: p.appBarFg, size: 24),
        titleTextStyle:
            PmpTextStyles.body1Semi.copyWith(color: p.appBarFg),
        toolbarHeight: 56,
        centerTitle: false,
        scrolledUnderElevation: 0,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness:
              p.brightness == Brightness.dark ? Brightness.light : Brightness.dark,
          statusBarBrightness:
              p.brightness == Brightness.dark ? Brightness.dark : Brightness.light,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: p.surfaceVariant,
        filled: true,
        isDense: true,
        hintStyle:
            PmpTextStyles.body2Regular.copyWith(color: p.textSecondary),
        labelStyle:
            PmpTextStyles.body2Regular.copyWith(color: p.textSecondary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          gapPadding: 10,
          borderSide: BorderSide(color: p.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          gapPadding: 10,
          borderSide: BorderSide(color: p.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          gapPadding: 10,
          borderSide: BorderSide(color: p.primary, width: 1.5),
        ),
      ),
      textTheme: const TextTheme(
        headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        titleMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      ).apply(
        bodyColor: p.textPrimary,
        displayColor: p.textPrimary,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: p.primary,
          foregroundColor: p.onPrimary,
          textStyle: PmpTextStyles.body1Semi,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: p.primary,
          foregroundColor: p.onPrimary,
          elevation: 0,
          textStyle: PmpTextStyles.body1Semi,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: p.primary,
          textStyle: PmpTextStyles.body1Semi,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: p.primary,
          side: BorderSide(color: p.outline),
          textStyle: PmpTextStyles.body1Semi,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: p.cardBg,
        surfaceTintColor: p.cardBg,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: p.outline),
        ),
      ),
      listTileTheme: ListTileThemeData(
        tileColor: p.surface,
        iconColor: p.textPrimary,
        textColor: p.textPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: p.outlineVariant,
        thickness: 1,
      ),
      iconTheme: IconThemeData(color: p.textPrimary),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: p.surface,
        modalBackgroundColor: p.surface,
        surfaceTintColor: p.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: p.surface,
        surfaceTintColor: p.surface,
      ),
    );
  }
}

class _PmpPalette {
  final Brightness brightness;
  final Color background;
  final Color surface;
  final Color surfaceVariant;
  final Color cardBg;
  final Color outline;
  final Color outlineVariant;
  final Color textPrimary;
  final Color textSecondary;
  final Color primary;
  final Color onPrimary;
  final Color appBarBg;
  final Color appBarFg;

  const _PmpPalette({
    required this.brightness,
    required this.background,
    required this.surface,
    required this.surfaceVariant,
    required this.cardBg,
    required this.outline,
    required this.outlineVariant,
    required this.textPrimary,
    required this.textSecondary,
    required this.primary,
    required this.onPrimary,
    required this.appBarBg,
    required this.appBarFg,
  });

  factory _PmpPalette.dark() => const _PmpPalette(
        brightness: Brightness.dark,
        background: PmpColors.glassDarkBg0,
        surface: PmpColors.glassDarkSurface,
        surfaceVariant: PmpColors.glassDarkCard,
        cardBg: PmpColors.glassDarkCard,
        outline: PmpColors.glassDarkOutline,
        outlineVariant: PmpColors.darkOutlineVariant,
        textPrimary: PmpColors.darkTextPrimary,
        textSecondary: PmpColors.darkTextSecondary,
        // Cyan brand — bright on dark for buttons/progress/accents.
        primary: PmpColors.brandCyanBright,
        onPrimary: Color(0xFF04212C),
        // App bars sit over the gradient; a subtle surface tint keeps
        // not-yet-glassed screens looking intentional.
        appBarBg: PmpColors.glassDarkSurface,
        appBarFg: PmpColors.darkTextPrimary,
      );

  factory _PmpPalette.light() => const _PmpPalette(
        brightness: Brightness.light,
        background: PmpColors.glassLightBg0,
        surface: PmpColors.lightSurfaceBw,
        surfaceVariant: PmpColors.lightSurfaceVariant,
        cardBg: PmpColors.lightSurfaceBw,
        outline: PmpColors.lightOutline,
        outlineVariant: PmpColors.lightOutlineVariant,
        textPrimary: PmpColors.glassLightText,
        textSecondary: PmpColors.glassLightTextDim,
        primary: PmpColors.brandCyan,
        onPrimary: PmpColors.white,
        appBarBg: PmpColors.lightSurfaceBw,
        appBarFg: PmpColors.glassLightText,
      );
}
