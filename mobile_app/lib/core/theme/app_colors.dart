import 'package:flutter/material.dart';

/// Coursera-standard color palette (from design spec JSON)
class AppColors {
  AppColors._();

  // Primary — Coursera Blue
  static const Color primary = Color(0xFF0056D2);
  static const Color primaryDark = Color(0xFF0048B0);
  static const Color primaryLight = Color(0xFF3587FC);

  // Dark surface — Coursera near-black
  static const Color surfaceDark = Color(0xFF0F1114);

  // Accent — DONE state
  static const Color accent = Color(0xFF32AE88);
  static const Color accentLight = Color(0xFFB0E5FB);

  // Neutrals
  static const Color neutral = Color(0xFF5B6780);
  static const Color neutralLight = Color(0xFF696969);
  static const Color border = Color(0xFFDAE1ED);
  static const Color borderLight = Color(0xFFE8EEF7);
  static const Color background = Color(0xFFF0F6FF);
  static const Color surface = Color(0xFFFFFFFF);

  // Status colors
  static const Color done = Color(0xFF32AE88);
  static const Color inProgress = Color(0xFF0056D2);
  static const Color todo = Color(0xFF5B6780);
  static const Color error = Color(0xFFD32F2F);

  // Gradient palettes for study plan cards
  static const List<List<Color>> planGradients = [
    [Color(0xFF0056D2), Color(0xFF3587FC)],
    [Color(0xFF32AE88), Color(0xFF0056D2)],
    [Color(0xFF6C63FF), Color(0xFF0056D2)],
    [Color(0xFFFF6B35), Color(0xFFFF9A3C)],
    [Color(0xFF0F1114), Color(0xFF5B6780)],
  ];
}
