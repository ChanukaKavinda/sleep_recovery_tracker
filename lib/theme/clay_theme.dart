import 'package:flutter/material.dart';

/// All Soft Clay colours, stored on the Theme so every widget can read them
/// with `context.clay` and rebuild automatically when the theme changes.
@immutable
class ClayColors extends ThemeExtension<ClayColors> {
  const ClayColors({
    required this.background,
    required this.shadowDark,
    required this.shadowLight,
    required this.text,
    required this.textMuted,
    required this.accent,
    required this.onAccent,
    required this.trackOff,
    required this.vitals,
    required this.deepSleep,
    required this.remSleep,
    required this.lightSleep,
    required this.awake,
    required this.danger,
    required this.success,
  });

  /// Surface colour + the two shadows that create the clay look.
  final Color background;
  final Color shadowDark;
  final Color shadowLight;

  final Color text;
  final Color textMuted;

  /// Selected mood, switch, active tab, main buttons.
  final Color accent;

  /// Text / icons on top of [accent].
  final Color onAccent;

  /// Switch track when off, empty chart bars.
  final Color trackOff;

  /// Recovery bar, heart icon.
  final Color vitals;

  /// Sleep stages: three blues, darkest = deepest sleep.
  final Color deepSleep;
  final Color remSleep;
  final Color lightSleep;

  /// Awake time inside a sleep session.
  final Color awake;

  final Color danger;
  final Color success;

  static const light = ClayColors(
    background: Color(0xFFE9EAF4),
    shadowDark: Color(0xFFC5C7DA),
    shadowLight: Color(0xFFFFFFFF),
    text: Color(0xFF2B2D42),
    textMuted: Color(0xFF5C5F7A),
    accent: Color(0xFF6B5BD2),
    onAccent: Color(0xFFFFFFFF),
    trackOff: Color(0xFFD5D7E6),
    vitals: Color(0xFFD9683A),
    deepSleep: Color(0xFF152F7A),
    remSleep: Color(0xFF2E67D9),
    lightSleep: Color(0xFF6FA8F5),
    awake: Color(0xFFE3A44B),
    danger: Color(0xFFB83A3A),
    success: Color(0xFF2F7D5B),
  );

  /// Raised surface: dark shadow bottom-right, light shadow top-left.
  List<BoxShadow> raised(double depth) {
    return [
      BoxShadow(
        color: shadowDark,
        offset: Offset(depth, depth),
        blurRadius: depth * 2,
      ),
      BoxShadow(
        color: shadowLight,
        offset: Offset(-depth, -depth),
        blurRadius: depth * 2,
      ),
    ];
  }

  @override
  ClayColors copyWith({
    Color? background,
    Color? shadowDark,
    Color? shadowLight,
    Color? text,
    Color? textMuted,
    Color? accent,
    Color? onAccent,
    Color? trackOff,
    Color? vitals,
    Color? deepSleep,
    Color? remSleep,
    Color? lightSleep,
    Color? awake,
    Color? danger,
    Color? success,
  }) {
    return ClayColors(
      background: background ?? this.background,
      shadowDark: shadowDark ?? this.shadowDark,
      shadowLight: shadowLight ?? this.shadowLight,
      text: text ?? this.text,
      textMuted: textMuted ?? this.textMuted,
      accent: accent ?? this.accent,
      onAccent: onAccent ?? this.onAccent,
      trackOff: trackOff ?? this.trackOff,
      vitals: vitals ?? this.vitals,
      deepSleep: deepSleep ?? this.deepSleep,
      remSleep: remSleep ?? this.remSleep,
      lightSleep: lightSleep ?? this.lightSleep,
      awake: awake ?? this.awake,
      danger: danger ?? this.danger,
      success: success ?? this.success,
    );
  }

  @override
  ClayColors lerp(ThemeExtension<ClayColors>? other, double t) {
    if (other is! ClayColors) return this;
    Color mix(Color a, Color b) => Color.lerp(a, b, t) ?? b;
    return ClayColors(
      background: mix(background, other.background),
      shadowDark: mix(shadowDark, other.shadowDark),
      shadowLight: mix(shadowLight, other.shadowLight),
      text: mix(text, other.text),
      textMuted: mix(textMuted, other.textMuted),
      accent: mix(accent, other.accent),
      onAccent: mix(onAccent, other.onAccent),
      trackOff: mix(trackOff, other.trackOff),
      vitals: mix(vitals, other.vitals),
      deepSleep: mix(deepSleep, other.deepSleep),
      remSleep: mix(remSleep, other.remSleep),
      lightSleep: mix(lightSleep, other.lightSleep),
      awake: mix(awake, other.awake),
      danger: mix(danger, other.danger),
      success: mix(success, other.success),
    );
  }
}

extension ClayContext on BuildContext {
  /// The current Soft Clay colours. Widgets that read this rebuild when the
  /// theme changes (light / dark).
  ClayColors get clay =>
      Theme.of(this).extension<ClayColors>() ?? ClayColors.light;
}
