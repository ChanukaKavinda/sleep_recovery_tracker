import 'package:flutter/material.dart';

/// Soft Clay palette. Change a colour here and it updates across the app.
class AppColors {
  AppColors._();

  // Surface + the two shadow colours that create the "clay" look.
  static const Color background = Color(0xFFE9EAF4);
  static const Color shadowDark = Color(0xFFC5C7DA);
  static const Color shadowLight = Color(0xFFFFFFFF);

  // Text.
  static const Color text = Color(0xFF2B2D42);
  static const Color textMuted = Color(0xFF5C5F7A);

  // Accent (selected mood, switch, active tab).
  static const Color accent = Color(0xFF6B5BD2);
  static const Color trackOff = Color(0xFFD5D7E6);

  // Recovery bar + heart icon.
  static const Color vitals = Color(0xFFD9683A);

  // Sleep stages: three blues, darkest = deepest sleep.
  static const Color deepSleep = Color(0xFF152F7A);
  static const Color remSleep = Color(0xFF2E67D9);
  static const Color lightSleep = Color(0xFF6FA8F5);
}
