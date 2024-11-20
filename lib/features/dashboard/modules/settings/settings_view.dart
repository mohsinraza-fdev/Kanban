import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kanban_app/app/service_locator.dart';
import 'package:kanban_app/core/view_models/core_view.dart';
import 'package:kanban_app/features/dashboard/modules/settings/settings_view_model.dart';
import 'package:kanban_app/features/dashboard/modules/settings/widgets/radio_button_tile.dart';
import 'package:kanban_app/shared/theme/app_text_styles.dart';
import 'package:kanban_app/shared/theme/app_theme.dart';
import 'package:kanban_app/shared/widgets/card_shell.dart';
import 'package:kanban_app/shared/widgets/primary_app_bar.dart';
import 'package:stacked_themes/stacked_themes.dart';

class SettingsView extends CoreView<SettingsViewModel> {
  const SettingsView({super.key});

  @override
  Widget buildView(BuildContext context, SettingsViewModel viewModel, Widget? child) {
    return Scaffold(
      body: Column(
        children: [
          const PrimaryAppBar(title: 'Settings'),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Theme
                    CardShell(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Theme',
                            style: AppTextStyles.m18(
                              AppTheme.colors(context).text,
                            ),
                          ),
                          const SizedBox(height: 12),
                          RadioButtonTile(
                            title: 'Light',
                            isSelected: viewModel.currentTheme == ThemeManagerMode.light,
                            onTap: () => viewModel.setThemeMode(ThemeManagerMode.light),
                          ),
                          const SizedBox(height: 12),
                          RadioButtonTile(
                            title: 'Dark',
                            isSelected: viewModel.currentTheme == ThemeManagerMode.dark,
                            onTap: () => viewModel.setThemeMode(ThemeManagerMode.dark),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Language
                    CardShell(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Language',
                            style: AppTextStyles.m18(
                              AppTheme.colors(context).text,
                            ),
                          ),
                          const SizedBox(height: 12),
                          RadioButtonTile(
                            title: 'English',
                            isSelected: context.locale.languageCode == 'en',
                            onTap: () => viewModel.updateLanguage('en'),
                          ),
                          const SizedBox(height: 12),
                          RadioButtonTile(
                            title: 'German',
                            isSelected: context.locale.languageCode == 'de',
                            onTap: () => viewModel.updateLanguage('de'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get disposeViewModel => false;

  @override
  bool get fireOnViewModelReadyOnce => true;

  @override
  SettingsViewModel viewModelBuilder(BuildContext context) {
    return locator<SettingsViewModel>();
  }
}
