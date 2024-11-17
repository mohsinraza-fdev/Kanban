import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  static Color get white => const Color(0xFFFFFFFF);
  static Color get black => const Color(0xFF000000);

  final Color primary;
  final Color secondary;
  final Color tertiary;
  final Color text;
  final Color surface;

  AppColors({
    required this.primary,
    required this.secondary,
    required this.tertiary,
    required this.text,
    required this.surface,
  });

  @override
  ThemeExtension<AppColors> copyWith({
    Color? primary,
    Color? secondary,
    Color? tertiary,
    Color? text,
    Color? surface,
  }) {
    return AppColors(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      tertiary: tertiary ?? this.tertiary,
      text: text ?? this.text,
      surface: surface ?? this.surface,
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
      surface: Color.lerp(surface, other.surface, t) ?? surface,
    );
  }
}
