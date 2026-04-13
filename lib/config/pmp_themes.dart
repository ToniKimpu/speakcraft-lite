import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'pmp_colors.dart';
import 'pmp_text_styles.dart';

class PmpThemes {
  static ThemeData get darkTheme {
    const background = PmpColors.darkBackground;
    const surface = PmpColors.darkSurfaceBw;
    const surfaceVariant = PmpColors.darkSurfaceVariant;
    const outline = PmpColors.darkOutline;
    const outlineVariant = PmpColors.darkOutlineVariant;
    const textPrimary = PmpColors.darkTextPrimary;
    const textSecondary = PmpColors.darkTextSecondary;
    const primary = PmpColors.white;
    const onPrimary = PmpColors.black;

    const colorScheme = ColorScheme(
      brightness: Brightness.dark,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: surfaceVariant,
      onPrimaryContainer: textPrimary,
      secondary: primary,
      onSecondary: onPrimary,
      secondaryContainer: surfaceVariant,
      onSecondaryContainer: textPrimary,
      tertiary: textSecondary,
      onTertiary: onPrimary,
      tertiaryContainer: surfaceVariant,
      onTertiaryContainer: textPrimary,
      error: PmpColors.destructive500,
      onError: PmpColors.white,
      errorContainer: PmpColors.destructive50,
      onErrorContainer: PmpColors.destructive500,
      surface: surface,
      onSurface: textPrimary,
      surfaceContainerHighest: surfaceVariant,
      surfaceContainerHigh: surfaceVariant,
      surfaceContainer: surfaceVariant,
      surfaceContainerLow: surface,
      surfaceContainerLowest: background,
      onSurfaceVariant: textSecondary,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: PmpColors.black,
      scrim: PmpColors.black,
      inverseSurface: PmpColors.white,
      onInverseSurface: PmpColors.black,
      inversePrimary: onPrimary,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: GoogleFonts.inter().fontFamily,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: background,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          TargetPlatform.android: ZoomPageTransitionsBuilder(
            allowEnterRouteSnapshotting: false,
          ),
        },
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(color: primary),
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        foregroundColor: textPrimary,
        iconTheme: const IconThemeData(color: textPrimary, size: 24),
        titleTextStyle:
            PmpTextStyles.body1Semi.copyWith(color: textPrimary),
        toolbarHeight: 56,
        centerTitle: false,
        scrolledUnderElevation: 0,
        elevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: surfaceVariant,
        filled: true,
        isDense: true,
        hintStyle:
            PmpTextStyles.body2Regular.copyWith(color: textSecondary),
        labelStyle:
            PmpTextStyles.body2Regular.copyWith(color: textSecondary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          gapPadding: 10,
          borderSide: const BorderSide(color: outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          gapPadding: 10,
          borderSide: const BorderSide(color: outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          gapPadding: 10,
          borderSide: const BorderSide(color: primary, width: 1.5),
        ),
      ),
      textTheme: const TextTheme(
        headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        titleMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      ).apply(
        bodyColor: textPrimary,
        displayColor: textPrimary,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: onPrimary,
          textStyle: PmpTextStyles.body1Semi,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: onPrimary,
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
          foregroundColor: primary,
          textStyle: PmpTextStyles.body1Semi,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primary,
          side: const BorderSide(color: outline),
          textStyle: PmpTextStyles.body1Semi,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: surface,
        surfaceTintColor: surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: outlineVariant),
        ),
      ),
      listTileTheme: ListTileThemeData(
        tileColor: surface,
        iconColor: textPrimary,
        textColor: textPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: outlineVariant,
        thickness: 1,
      ),
      iconTheme: const IconThemeData(color: textPrimary),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: surface,
        modalBackgroundColor: surface,
        surfaceTintColor: surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      ),
      dialogTheme: const DialogThemeData(
        backgroundColor: surface,
        surfaceTintColor: surface,
      ),
    );
  }
}
