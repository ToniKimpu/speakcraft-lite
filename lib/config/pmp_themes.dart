import 'package:flutter/material.dart';
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
      surfaceContainerHighest: p.surfaceVariant,
      surfaceContainerHigh: p.surfaceVariant,
      surfaceContainer: p.surfaceVariant,
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
      fontFamily: GoogleFonts.inter().fontFamily,
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
        backgroundColor: p.background,
        foregroundColor: p.textPrimary,
        iconTheme: IconThemeData(color: p.textPrimary, size: 24),
        titleTextStyle:
            PmpTextStyles.body1Semi.copyWith(color: p.textPrimary),
        toolbarHeight: 56,
        centerTitle: false,
        scrolledUnderElevation: 0,
        elevation: 0,
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
        color: p.surface,
        surfaceTintColor: p.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: p.outlineVariant),
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
  final Color outline;
  final Color outlineVariant;
  final Color textPrimary;
  final Color textSecondary;
  final Color primary;
  final Color onPrimary;

  const _PmpPalette({
    required this.brightness,
    required this.background,
    required this.surface,
    required this.surfaceVariant,
    required this.outline,
    required this.outlineVariant,
    required this.textPrimary,
    required this.textSecondary,
    required this.primary,
    required this.onPrimary,
  });

  factory _PmpPalette.dark() => const _PmpPalette(
        brightness: Brightness.dark,
        background: PmpColors.darkBackground,
        surface: PmpColors.darkSurfaceBw,
        surfaceVariant: PmpColors.darkSurfaceVariant,
        outline: PmpColors.darkOutline,
        outlineVariant: PmpColors.darkOutlineVariant,
        textPrimary: PmpColors.darkTextPrimary,
        textSecondary: PmpColors.darkTextSecondary,
        primary: PmpColors.white,
        onPrimary: PmpColors.black,
      );

  factory _PmpPalette.light() => const _PmpPalette(
        brightness: Brightness.light,
        background: PmpColors.lightBackground,
        surface: PmpColors.lightSurfaceBw,
        surfaceVariant: PmpColors.lightSurfaceVariant,
        outline: PmpColors.lightOutline,
        outlineVariant: PmpColors.lightOutlineVariant,
        textPrimary: PmpColors.lightTextPrimary,
        textSecondary: PmpColors.lightTextSecondary,
        primary: PmpColors.black,
        onPrimary: PmpColors.white,
      );
}
