import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:kanban_app/app/service_locator.dart';
import 'package:kanban_app/core/view_models/core_view.dart';
import 'package:kanban_app/features/dashboard/modules/home/home_view_model.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/enums/task_status.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/widgets/task_card.dart';
import 'package:kanban_app/shared/constants/app_strings.dart';
import 'package:kanban_app/shared/theme/app_colors.dart';
import 'package:kanban_app/shared/theme/app_text_styles.dart';
import 'package:kanban_app/shared/theme/app_theme.dart';
import 'package:kanban_app/shared/utils/ui_helpers.dart';
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
        return AppStrings.appName;
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
                          padding: const EdgeInsets.all(24),
                          child: SizedBox(
                            width: double.maxFinite,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Welcome Mohsin 👋',
                                  style: AppTextStyles.m24(AppTheme.colors(context).text),
                                ),
                                const SizedBox(height: 16),
                                Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: AppTheme.colors(context).surface.withOpacity(0.6),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(width: 1, color: AppTheme.colors(context).border),
                                    boxShadow: [
                                      BoxShadow(
                                        offset: const Offset(1, 5),
                                        blurRadius: 40,
                                        color: Colors.black.withOpacity(0.1),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Total Tasks',
                                          style: AppTextStyles.m20(AppTheme.colors(context).text),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Text(
                                        viewModel.tasks.length.toString(),
                                        style: AppTextStyles.m20(AppTheme.colors(context).text),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 32),

                                // Tasks Summary
                                Text(
                                  'Task Board Summary',
                                  style: AppTextStyles.m16(AppTheme.colors(context).text),
                                ),
                                const SizedBox(height: 16),
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: AppTheme.colors(context).surface.withOpacity(0.6),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(width: 1, color: AppTheme.colors(context).border),
                                      boxShadow: [
                                        BoxShadow(
                                          offset: const Offset(1, 5),
                                          blurRadius: 40,
                                          color: Colors.black.withOpacity(0.1),
                                        ),
                                      ],
                                    ),
                                    child: viewModel.tasks.isEmpty
                                        ? Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: AppButton.primary(
                                              size: AppButtonSize.medium,
                                              label: 'Add Task',
                                              leading: const Icon(
                                                Icons.add,
                                                size: 20,
                                                color: Colors.white,
                                              ),
                                              onTap: viewModel.createTask,
                                            ),
                                          )
                                        : Row(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SizedBox(
                                                height: screenWidth(context, multiplier: 0.45),
                                                width: screenWidth(context, multiplier: 0.45),
                                                child: PieChart(
                                                  PieChartData(
                                                    sections: TaskStatus.values
                                                        .map(
                                                          (status) => PieChartSectionData(
                                                            value: viewModel.getTasksByStatus(status).length.toDouble(),
                                                            title:
                                                                '%${((viewModel.getTasksByStatus(status).length / viewModel.tasks.length) * 100).toStringAsFixed(0)}',
                                                            titleStyle: AppTextStyles.sb14(AppColors.white),
                                                            color: taskStatusColor(context, status),
                                                          ),
                                                        )
                                                        .toList(),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 24),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    ...TaskStatus.values.map((status) {
                                                      return Row(
                                                        children: [
                                                          Container(
                                                            height: 12,
                                                            width: 12,
                                                            decoration: BoxDecoration(
                                                              color: taskStatusColor(context, status),
                                                              borderRadius: BorderRadius.circular(4),
                                                            ),
                                                          ),
                                                          const SizedBox(width: 8),
                                                          Expanded(
                                                            child: Text(
                                                              status.name.toUpperCase(),
                                                              style:
                                                                  AppTextStyles.m12(AppTheme.colors(context).secondary),
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    }),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                  ),
                                ),

                                // Recent Completed Tasks
                                const SizedBox(height: 32),
                                Text(
                                  'Completed Tasks',
                                  style: AppTextStyles.m16(AppTheme.colors(context).text),
                                ),
                                const SizedBox(height: 16),
                                if (viewModel.getTasksByStatus(TaskStatus.done).isEmpty)
                                  Align(
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: const EdgeInsets.all(24),
                                      child: Text(
                                        'No Completed Tasks',
                                        style: AppTextStyles.m14(AppTheme.colors(context).secondary),
                                      ),
                                    ),
                                  ),
                                if (viewModel.getTasksByStatus(TaskStatus.done).isNotEmpty)
                                  ...viewModel.getTasksByStatus(TaskStatus.done).map(
                                        (task) => TaskCard(
                                          task: task,
                                          taskDetail: viewModel.getDetailFromTask(task),
                                          onTap: () => viewModel.updateTask(task),
                                        ),
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
  bool get disposeViewModel => false;

  @override
  HomeViewModel viewModelBuilder(BuildContext context) {
    return locator<HomeViewModel>();
  }
}
