import 'package:flutter/material.dart';
import 'package:kanban_app/shared/assets_gen/fonts.gen.dart';

class AppTextStyles {
  static String get _primaryFontFamily => FontFamily.poppins;

  static TextStyle m18(Color color) => TextStyle(
        fontFamily: _primaryFontFamily,
        fontWeight: FontWeight.w500,
        fontSize: 18,
        color: color,
      );
}
