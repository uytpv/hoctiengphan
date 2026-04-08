import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Typography scale based on Coursera design standard (Source Sans Pro → Source Sans 3)
class AppTextStyles {
  AppTextStyles._();

  static TextStyle get _base => GoogleFonts.sourceSans3(
        color: AppColors.surfaceDark,
      );

  // Display font (Nunito) — used for hero titles
  static TextStyle get _display => GoogleFonts.nunito(
        color: AppColors.surfaceDark,
      );

  // --- Headings
  static TextStyle get displayLarge => _display.copyWith(
        fontSize: 48,
        fontWeight: FontWeight.w700,
        height: 1.17,
        letterSpacing: -0.48,
      );

  static TextStyle get headingXl => _base.copyWith(
        fontSize: 30,
        fontWeight: FontWeight.w600,
        height: 1.20,
        letterSpacing: -0.15,
      );

  static TextStyle get headingLg => _base.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        height: 1.17,
        letterSpacing: -0.12,
      );

  static TextStyle get headingMd => _base.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 1.20,
        letterSpacing: -0.06,
      );

  static TextStyle get headingSm => _base.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 1.25,
        letterSpacing: -0.048,
      );

  // --- Body
  static TextStyle get bodyLg => _base.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.50,
      );

  static TextStyle get bodyMd => _base.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.43,
      );

  static TextStyle get bodySm => _base.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.50,
      );

  // --- Labels / Captions
  static TextStyle get labelLg => _base.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: 1.43,
        letterSpacing: 0.14,
      );

  static TextStyle get labelMd => _base.copyWith(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        height: 1.29,
        letterSpacing: 0.13,
      );

  static TextStyle get caption => _base.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.50,
        color: AppColors.neutral,
      );

  // --- Bilingual secondary text (secondary language in parentheses)
  static TextStyle get bilingualPrimary => _base.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 1.25,
        color: AppColors.surfaceDark,
      );

  static TextStyle get bilingualSecondary => _base.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.43,
        color: AppColors.neutral,
      );

  // --- Buttons
  static TextStyle get buttonLg => _base.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        height: 1.50,
      );

  static TextStyle get buttonMd => _base.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        height: 1.43,
        letterSpacing: 0.14,
      );
}
