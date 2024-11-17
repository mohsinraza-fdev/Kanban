import 'package:flutter/material.dart';

class AppShadows extends ThemeExtension<AppShadows> {
  final BoxShadow primary;

  AppShadows({
    required this.primary,
  });

  @override
  ThemeExtension<AppShadows> copyWith({
    BoxShadow? primary,
  }) {
    return AppShadows(
      primary: primary ?? this.primary,
    );
  }

  @override
  ThemeExtension<AppShadows> lerp(covariant ThemeExtension<AppShadows>? other, double t) {
    if (other is! AppShadows) {
      return this;
    }
    return AppShadows(
      primary: BoxShadow.lerp(primary, other.primary, t) ?? primary,
    );
  }
}
