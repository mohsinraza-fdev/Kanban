import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kanban_app/shared/theme/app_colors.dart';
import 'package:kanban_app/shared/theme/app_shadows.dart';

class AppTheme {
  static AppColors colors(BuildContext context) => Theme.of(context).extension<AppColors>() ?? _lightThemeColors;
  static AppShadows shadows(BuildContext context) => Theme.of(context).extension<AppShadows>() ?? _lightThemeShadows;

  static ThemeData get light {
    return ThemeData.light().copyWith(
      extensions: <ThemeExtension<dynamic>>[_lightThemeColors, _lightThemeShadows],
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFF0F2F5),
    );
  }

  static ThemeData get dark {
    return ThemeData.dark().copyWith(
      extensions: <ThemeExtension<dynamic>>[_darkThemeColors, _darkThemeShadows],
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF0F181F),
    );
  }

  static void setStatusBarColor(Color color) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: color,
      ),
    );
  }

  static void brightenStatusBar() => SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
        ),
      );

  static void darkenStatusBar() => SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
          statusBarColor: Colors.transparent,
        ),
      );

  // Light Theme
  static AppColors get _lightThemeColors {
    return AppColors(
      primary: const Color(0xFF1755E7),
      secondary: const Color(0xFF02C94F),
      tertiary: const Color(0xFFFFCD1C),
      text: const Color(0xFF000000),
      surface: const Color(0xFFFFFFFF),
    );
  }

  static AppShadows get _lightThemeShadows {
    return AppShadows(
      primary: const BoxShadow(
        color: Color(0xFFC3CDD9),
        offset: Offset(0, 40),
        blurRadius: 100,
      ),
    );
  }

  // Dark Theme
  static AppColors get _darkThemeColors {
    return AppColors(
      primary: const Color(0xFF8113F6),
      secondary: const Color(0xFF00F85F),
      tertiary: const Color(0xFFFFC904),
      text: const Color(0xFFFFFFFF),
      surface: const Color(0xFF202F49),
    );
  }

  static AppShadows get _darkThemeShadows {
    return AppShadows(
      primary: BoxShadow(
        color: const Color(0xFF000000).withOpacity(0.25),
        offset: const Offset(0, 4),
        blurRadius: 4,
      ),
    );
  }
}
