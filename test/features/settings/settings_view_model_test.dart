import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_app/features/dashboard/modules/settings/settings_view_model.dart';
import 'package:mockito/mockito.dart';
import 'package:stacked_themes/stacked_themes.dart';

import '../../test_helpers.dart';

void main() {
  group('SettingsViewModel', () {
    late SettingsViewModel viewModel;
    late ThemeService mockThemeService;

    setUp(() {
      registerServices();
      mockThemeService = getAndRegisterThemeService();
      viewModel = SettingsViewModel();
    });

    tearDown(() => unregisterServices());

    test('currentTheme returns the selected theme mode from ThemeService', () {
      when(mockThemeService.selectedThemeMode).thenReturn(ThemeManagerMode.light);
      final result = viewModel.currentTheme;

      expect(result, equals(ThemeManagerMode.light));
    });

    test('setThemeMode sets the theme mode using ThemeService', () {
      viewModel.setThemeMode(ThemeManagerMode.dark);
      verify(mockThemeService.setThemeMode(ThemeManagerMode.dark));
    });
  });
}
