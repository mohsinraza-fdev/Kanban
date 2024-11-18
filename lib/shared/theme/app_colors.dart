import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  static Color get white => const Color(0xFFFFFFFF);
  static Color get black => const Color(0xFF000000);

  final Color primary;
  final Color secondary;
  final Color tertiary;
  final Color text;
  final Color textTertiary;
  final Color surface;
  final Color border;
  final Color inProgress;
  final Color done;

  AppColors({
    required this.primary,
    required this.secondary,
    required this.tertiary,
    required this.text,
    required this.textTertiary,
    required this.surface,
    required this.border,
    required this.inProgress,
    required this.done,
  });

  @override
  ThemeExtension<AppColors> copyWith({
    Color? primary,
    Color? secondary,
    Color? tertiary,
    Color? text,
    Color? textTertiary,
    Color? surface,
    Color? border,
    Color? inProgress,
    Color? done,
  }) {
    return AppColors(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      tertiary: tertiary ?? this.tertiary,
      text: text ?? this.text,
      textTertiary: textTertiary ?? this.textTertiary,
      surface: surface ?? this.surface,
      border: border ?? this.border,
      inProgress: inProgress ?? this.inProgress,
      done: done ?? this.done,
    );
  }

  @override
  ThemeExtension<AppColors> lerp(covariant ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      primary: Color.lerp(primary, other.primary, t) ?? primary,
      secondary: Color.lerp(secondary, other.secondary, t) ?? secondary,
      tertiary: Color.lerp(tertiary, other.tertiary, t) ?? tertiary,
      text: Color.lerp(text, other.text, t) ?? text,
      textTertiary: Color.lerp(textTertiary, other.textTertiary, t) ?? textTertiary,
      surface: Color.lerp(surface, other.surface, t) ?? surface,
      border: Color.lerp(border, other.border, t) ?? border,
      inProgress: Color.lerp(inProgress, other.inProgress, t) ?? inProgress,
      done: Color.lerp(done, other.done, t) ?? done,
    );
  }
}
