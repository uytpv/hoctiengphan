import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          secondary: AppColors.accent,
          surface: AppColors.surface,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: AppColors.surfaceDark,
          error: AppColors.error,
          outline: AppColors.border,
        ),
        scaffoldBackgroundColor: AppColors.background,
        textTheme: GoogleFonts.sourceSans3TextTheme().copyWith(
          displayLarge: GoogleFonts.nunito(
            fontSize: 48,
            fontWeight: FontWeight.w700,
            color: AppColors.surfaceDark,
          ),
          displayMedium: GoogleFonts.nunito(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: AppColors.surfaceDark,
          ),
          headlineLarge: GoogleFonts.sourceSans3(
            fontSize: 30,
            fontWeight: FontWeight.w600,
            color: AppColors.surfaceDark,
          ),
          headlineMedium: GoogleFonts.sourceSans3(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.surfaceDark,
          ),
          headlineSmall: GoogleFonts.sourceSans3(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.surfaceDark,
          ),
          titleLarge: GoogleFonts.sourceSans3(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.surfaceDark,
          ),
          bodyLarge: GoogleFonts.sourceSans3(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.surfaceDark,
          ),
          bodyMedium: GoogleFonts.sourceSans3(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.surfaceDark,
          ),
          labelLarge: GoogleFonts.sourceSans3(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.surfaceDark,
          ),
          labelSmall: GoogleFonts.sourceSans3(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: AppColors.neutral,
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.surface,
          elevation: 0,
          scrolledUnderElevation: 1,
          shadowColor: AppColors.border,
          centerTitle: false,
          titleTextStyle: GoogleFonts.nunito(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.surfaceDark,
          ),
          iconTheme: const IconThemeData(color: AppColors.surfaceDark),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.surface,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.neutral,
          type: BottomNavigationBarType.fixed,
          elevation: 8,
          selectedLabelStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        cardTheme: CardThemeData(
          color: AppColors.surface,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: AppColors.border, width: 1),
          ),
          margin: EdgeInsets.zero,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            textStyle: GoogleFonts.sourceSans3(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
            elevation: 0,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primary,
            padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            side: const BorderSide(color: AppColors.primary, width: 1),
            textStyle: GoogleFonts.sourceSans3(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        chipTheme: ChipThemeData(
          backgroundColor: AppColors.background,
          labelStyle: GoogleFonts.sourceSans3(
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
          padding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          side: const BorderSide(color: AppColors.border),
        ),
        dividerTheme: const DividerThemeData(
          color: AppColors.borderLight,
          thickness: 1,
          space: 0,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.surface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide:
                const BorderSide(color: AppColors.primary, width: 1),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      );
}
