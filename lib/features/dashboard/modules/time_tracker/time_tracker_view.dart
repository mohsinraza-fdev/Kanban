import 'package:flutter/material.dart';
import 'package:kanban_app/app/service_locator.dart';
import 'package:kanban_app/core/view_models/core_view.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/widgets/task_card.dart';
import 'package:kanban_app/features/dashboard/modules/time_tracker/time_tracker_view_model.dart';
import 'package:kanban_app/shared/theme/app_colors.dart';
import 'package:kanban_app/shared/theme/app_text_styles.dart';
import 'package:kanban_app/shared/theme/app_theme.dart';
import 'package:kanban_app/shared/utils/ui_helpers.dart';
import 'package:kanban_app/shared/widgets/app_loading_indicator.dart';
import 'package:kanban_app/shared/widgets/primary_app_bar.dart';

class TimeTrackerView extends CoreView<TimeTrackerViewModel> {
  const TimeTrackerView({super.key});

  @override
  Widget buildView(BuildContext context, TimeTrackerViewModel viewModel, Widget? child) {
    return Scaffold(
      body: Column(
        children: [
          const PrimaryAppBar(title: 'Track Time'),
          Expanded(
            child: viewModel.tasks.isEmpty && viewModel.isBusyFetchingTasks
                ? const AppLoadingIndicator()
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Task Selection Field
                          Opacity(
                            opacity: viewModel.tracking ? 0.6 : 1,
                            child: IgnorePointer(
                              ignoring: viewModel.tracking,
                              child: GestureDetector(
                                onTap: viewModel.selectTask,
                                child: Container(
                                  height: 56,
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  decoration: BoxDecoration(
                                    color: AppTheme.colors(context).surface,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      width: 1,
                                      color: AppTheme.colors(context).border,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      if (viewModel.selectedTask != null)
                                        Container(
                                          height: 20,
                                          width: 20,
                                          alignment: Alignment.center,
                                          color: Colors.transparent,
                                          child: Container(
                                            height: 12,
                                            width: 12,
                                            decoration: BoxDecoration(
                                              color: taskStatusColor(
                                                context,
                                                viewModel.getDetailFromTask(viewModel.selectedTask!).status,
                                              ),
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                          ),
                                        ),
                                      if (viewModel.selectedTask == null)
                                        Icon(
                                          Icons.library_add_check_outlined,
                                          size: 20,
                                          color: AppTheme.colors(context).tertiary,
                                        ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          viewModel.selectedTask?.content ?? 'Select Task',
                                          style: AppTextStyles.m14(viewModel.selectedTask == null
                                              ? AppTheme.colors(context).tertiary
                                              : AppTheme.colors(context).text),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Time Tracker
                          const SizedBox(height: 16),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Opacity(
                              opacity: viewModel.isUpdatingTaskDuration || viewModel.selectedTask == null ? 0.6 : 1,
                              child: IgnorePointer(
                                ignoring: viewModel.isUpdatingTaskDuration || viewModel.selectedTask == null,
                                child: Container(
                                  height: 50,
                                  padding: const EdgeInsets.symmetric(horizontal: 6),
                                  decoration: BoxDecoration(
                                    color: AppTheme.colors(context).surface,
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                      width: 1,
                                      color: AppTheme.colors(context).border,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8),
                                        width: 90,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            viewModel.totalFormattedTime,
                                            style: AppTextStyles.r14(AppTheme.colors(context).text),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () =>
                                            viewModel.tracking ? viewModel.stopTracking() : viewModel.startTracking(),
                                        child: Container(
                                          height: 40,
                                          width: 40,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: AppTheme.colors(context).success, shape: BoxShape.circle),
                                          child: Icon(
                                            viewModel.tracking ? Icons.pause_rounded : Icons.play_arrow_rounded,
                                            size: 24,
                                            color: AppColors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Recent Trackings
                          const SizedBox(height: 16),
                          if (viewModel.trackedTasks.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Recent Trackings',
                                    style: AppTextStyles.m16(AppTheme.colors(context).text),
                                  ),
                                  const SizedBox(height: 16),
                                  ...viewModel.trackedTasks.map((task) {
                                    return Container(
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TaskCard(
                                            task: task,
                                            taskDetail: viewModel.getDetailFromTask(task),
                                            showDetail: false,
                                            trailing: Text(
                                              formatDuration(viewModel.getDetailFromTask(task).durationInSeconds),
                                              style: AppTextStyles.sb14(AppTheme.colors(context).tertiary),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
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
  TimeTrackerViewModel viewModelBuilder(BuildContext context) {
    return locator<TimeTrackerViewModel>();
  }
}
