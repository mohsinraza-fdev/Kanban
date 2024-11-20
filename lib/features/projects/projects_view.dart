import 'package:flutter/material.dart';
import 'package:kanban_app/core/view_models/core_view.dart';
import 'package:kanban_app/features/projects/projects_view_model.dart';
import 'package:kanban_app/shared/theme/app_colors.dart';
import 'package:kanban_app/shared/theme/app_text_styles.dart';
import 'package:kanban_app/shared/theme/app_theme.dart';
import 'package:kanban_app/shared/widgets/app_loading_indicator.dart';
import 'package:kanban_app/shared/widgets/primary_app_bar.dart';

class ProjectsView extends CoreView<ProjectsViewModel> {
  const ProjectsView({super.key});

  @override
  Widget buildView(BuildContext context, ProjectsViewModel viewModel, Widget? child) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      floatingActionButton: FloatingActionButton.extended(
        label: Text(
          'Add Project',
          style: AppTextStyles.m16(AppColors.white),
        ),
        icon: Icon(
          Icons.add,
          color: AppColors.white,
        ),
        backgroundColor: AppTheme.colors(context).primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        onPressed: viewModel.createProject,
      ),
      body: Column(
        children: [
          PrimaryAppBar(
            title: 'Projects',
            leading: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Icon(
                Icons.arrow_back_ios,
                color: AppTheme.colors(context).text,
              ),
            ),
          ),
          Expanded(
            child: viewModel.isBusyFetchingProjects && viewModel.projects.isEmpty
                ? const AppLoadingIndicator()
                : Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        ...viewModel.projects.map((project) {
                          bool isSelected = viewModel.selectedProject?.id == project.id;
                          return GestureDetector(
                            onTap: () => viewModel.selectProject(project),
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                              decoration: BoxDecoration(
                                color: isSelected ? AppTheme.colors(context).primary : AppTheme.colors(context).surface,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  width: 1,
                                  color:
                                      isSelected ? AppTheme.colors(context).primary : AppTheme.colors(context).border,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      project.name,
                                      style: AppTextStyles.m16(
                                          isSelected ? AppColors.white : AppTheme.colors(context).text),
                                    ),
                                  ),
                                  if (project.name != 'Inbox') ...[
                                    const SizedBox(width: 8),
                                    GestureDetector(
                                      onTap: () => viewModel.updateProject(project),
                                      child: Icon(
                                        Icons.edit,
                                        size: 20,
                                        color: (isSelected ? AppColors.white : AppTheme.colors(context).text)
                                            .withOpacity(0.8),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    GestureDetector(
                                      onTap: () => viewModel.deleteProject(project),
                                      child: Icon(
                                        Icons.delete,
                                        size: 20,
                                        color: AppTheme.colors(context).critical,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  @override
  ProjectsViewModel viewModelBuilder(BuildContext context) {
    return ProjectsViewModel();
  }
}
