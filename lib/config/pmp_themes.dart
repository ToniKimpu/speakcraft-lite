import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'pmp_colors.dart';
import 'pmp_text_styles.dart';

class PmpThemes {
  static ThemeData get lightTechLearnTheme => _getThemeData(Brightness.light);
  static ThemeData get darkTechLearnTheme => _getThemeData(Brightness.dark);

  static ThemeData _getThemeData(Brightness brightness) {
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      fontFamily: GoogleFonts.inter().fontFamily,
      colorScheme: ColorScheme.fromSeed(
        seedColor: PmpColors.primary300,
        brightness: brightness,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: PmpColors.white,
      ),
      scaffoldBackgroundColor: PmpColors.transparent,
      appBarTheme: AppBarTheme(
        backgroundColor: PmpColors.transparent,
        iconTheme: const IconThemeData(
          color: PmpColors.white,
          size: 24,
        ),
        titleTextStyle: PmpTextStyles.body1Semi.copyWith(
          color: PmpColors.white,
        ),
        toolbarHeight: 56,
        centerTitle: false,
        scrolledUnderElevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: PmpColors.white,
        filled: true,
        isDense: true,
        hintStyle: PmpTextStyles.body2Regular.copyWith(
          color: PmpColors.neutral300,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          gapPadding: 10,
          borderSide: const BorderSide(color: PmpColors.neutral200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          gapPadding: 10,
          borderSide: const BorderSide(color: PmpColors.neutral200),
        ),
      ),
      textTheme: const TextTheme(
          headlineMedium: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          titleMedium: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          )).apply(
        bodyColor: PmpColors.neutral600,
        displayColor: PmpColors.neutral900,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: PmpColors.primary400,
          textStyle: PmpTextStyles.body1Semi,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        ),
      ),
      cardTheme: ThemeData.light().cardTheme.copyWith(
            surfaceTintColor: PmpColors.white,
          ),
      listTileTheme: ListTileThemeData(
        tileColor: PmpColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
