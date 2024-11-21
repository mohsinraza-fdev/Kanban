// test/features/dashboard/modules/settings/settings_view_model_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_app/features/dashboard/modules/settings/settings_view_model.dart';
import 'package:mockito/mockito.dart';
import 'package:stacked_themes/stacked_themes.dart';

import '../../../../test_helpers.dart';

void main() {
  late SettingsViewModel viewModel;
  late ThemeService mockThemeService;

  setUp(() {
    registerServices();
    mockThemeService = getAndRegisterThemeService();
    viewModel = SettingsViewModel();
  });

  tearDown(() {
    unregisterServices();
  });

  group('SettingsViewModel -', () {
    group('Theme Management -', () {
      test('should return current theme from ThemeService', () {
        when(mockThemeService.selectedThemeMode).thenReturn(ThemeManagerMode.dark);

        expect(viewModel.currentTheme, equals(ThemeManagerMode.dark));
        verify(mockThemeService.selectedThemeMode).called(1);
      });

      test('should set theme mode through ThemeService', () {
        viewModel.setThemeMode(ThemeManagerMode.light);

        verify(mockThemeService.setThemeMode(ThemeManagerMode.light)).called(1);
      });

      test('should set dark theme mode through ThemeService', () {
        viewModel.setThemeMode(ThemeManagerMode.dark);

        verify(mockThemeService.setThemeMode(ThemeManagerMode.dark)).called(1);
      });
    });

    test('themeService should be initialized', () {
      expect(viewModel.themeService, isNotNull);
      expect(viewModel.themeService, mockThemeService);
    });
  });
}
