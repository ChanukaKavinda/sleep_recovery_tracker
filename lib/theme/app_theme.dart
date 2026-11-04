import 'package:flutter/material.dart';

import 'clay_theme.dart';

/// Font family declared in pubspec.yaml (assets/fonts/Nunito-*.ttf).
const appFontFamily = 'Nunito';

/// Builds the MaterialApp theme from a Soft Clay palette.
ThemeData buildAppTheme(ClayColors c, Brightness brightness) {
  final scheme = ColorScheme.fromSeed(
    seedColor: c.accent,
    brightness: brightness,
  ).copyWith(
    primary: c.accent,
    onPrimary: c.onAccent,
    surface: c.background,
    onSurface: c.text,
    error: c.danger,
  );

  final base = ThemeData(
    useMaterial3: true,
    brightness: brightness,
    colorScheme: scheme,
    scaffoldBackgroundColor: c.background,
    fontFamily: appFontFamily,
    extensions: <ThemeExtension<dynamic>>[c],
  );

  return base.copyWith(
    textTheme: base.textTheme.apply(
      bodyColor: c.text,
      displayColor: c.text,
      fontFamily: appFontFamily,
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: c.text,
      contentTextStyle: TextStyle(
        color: c.background,
        fontFamily: appFontFamily,
        fontWeight: FontWeight.w600,
      ),
      actionTextColor: c.lightSleep,
    ),
    textSelectionTheme: TextSelectionThemeData(cursorColor: c.accent),
  );
}
