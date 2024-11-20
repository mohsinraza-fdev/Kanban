import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kanban_app/app/service_locator.dart';
import 'package:kanban_app/core/view_models/core_view_model.dart';
import 'package:stacked_themes/stacked_themes.dart';

class SettingsViewModel extends CoreViewModel {
  final themeService = locator<ThemeService>();

  ThemeManagerMode get currentTheme => themeService.selectedThemeMode;
  setThemeMode(ThemeManagerMode mode) {
    themeService.setThemeMode(mode);
  }

  Map<String, String> languages = {
    "en": 'English',
    "de": 'German',
  };

  updateLanguage(String languageCode) {
    context!.setLocale(Locale(languageCode));
    notifyListeners();
  }
}
