import 'package:flutter/material.dart';
import 'package:kanban_app/core/view_models/core_view.dart';
import 'package:kanban_app/features/dashboard/modules/home/home_view_model.dart';
import 'package:kanban_app/shared/theme/app_text_styles.dart';
import 'package:kanban_app/shared/theme/app_theme.dart';
import 'package:kanban_app/shared/widgets/app_button.dart';
import 'package:kanban_app/shared/widgets/app_loading_indicator.dart';
import 'package:kanban_app/shared/widgets/primary_app_bar.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeView extends CoreView<HomeViewModel> {
  const HomeView({super.key});

  @override
  Widget buildView(BuildContext context, HomeViewModel viewModel, Widget? child) {
    String title() {
      if (viewModel.isBusyFetchingProjects && viewModel.projects.isEmpty) {
        return 'Kanban';
      }
      if (viewModel.selectedProject == null) {
        'Create Project';
      }
      return viewModel.selectedProject!.name;
    }

    return Scaffold(
      body: Column(
        children: [
          Skeletonizer(
            enabled: viewModel.isBusyFetchingProjects && viewModel.projects.isEmpty,
            child: PrimaryAppBar(
              title: title(),
              actions: [
                if (viewModel.projects.isNotEmpty)
                  AppButton.outline(
                    size: AppButtonSize.small,
                    label: 'My Projects',
                    onTap: viewModel.navigateToProjectsView,
                  ),
              ],
            ),
          ),
          Expanded(
            child: viewModel.isActiveLocadingState
                ? const AppLoadingIndicator()
                : viewModel.selectedProject == null
                    ? Center(
                        child: AppButton.primary(
                          size: AppButtonSize.medium,
                          label: 'Create Project',
                          onTap: viewModel.createProject,
                        ),
                      )
                    : SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: SizedBox(
                            width: double.maxFinite,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 4),
                                Text(
                                  'Analytics',
                                  style: AppTextStyles.m16(AppTheme.colors(context).text),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
          ),
        ],
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) {
    return HomeViewModel();
  }
}
