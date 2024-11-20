import 'package:flutter/material.dart';
import 'package:kanban_app/core/extensions/date_time_extension.dart';
import 'package:kanban_app/core/view_models/core_view_model_widget.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/enums/task_status.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/task_board_view_model.dart';
import 'package:kanban_app/shared/theme/app_colors.dart';
import 'package:kanban_app/shared/theme/app_text_styles.dart';
import 'package:kanban_app/shared/theme/app_theme.dart';
import 'package:kanban_app/shared/utils/ui_helpers.dart';
import 'package:kanban_app/shared/widgets/app_button.dart';
import 'package:kanban_app/shared/widgets/app_chip.dart';

class BoardColumn extends CoreViewModelWidget<TaskBoardViewModel> {
  final TaskStatus taskStatus;
  const BoardColumn({
    required this.taskStatus,
    super.key,
  });

  @override
  Widget build(BuildContext context, TaskBoardViewModel viewModel) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: screenWidth(context, multiplier: 0.9)),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: taskStatusColor(context, taskStatus),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Container(
              decoration: BoxDecoration(boxShadow: [BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(0.1))]),
              child: Text(
                taskStatus.name.toUpperCase(),
                style: AppTextStyles.sb14(AppColors.white),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 4),
                    ...viewModel.getTasksFromStatus(taskStatus).map((task) {
                      final taskDetail = viewModel.getDetailFromTask(task);
                      return GestureDetector(
                        onTap: () => viewModel.updateTask(task),
                        child: Container(
                          padding: const EdgeInsets.only(left: 12, right: 20, top: 16, bottom: 16),
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: AppTheme.colors(context).surface,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () => viewModel.updateTaskStatus(task),
                                child: Container(
                                  height: 24,
                                  width: 24,
                                  alignment: Alignment.center,
                                  color: Colors.transparent,
                                  child: Container(
                                    height: 12,
                                    width: 12,
                                    decoration: BoxDecoration(
                                      color: taskStatusColor(context, taskStatus),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      task.content,
                                      style: AppTextStyles.r14(AppTheme.colors(context).text),
                                    ),
                                    if (taskDetail.dueAt != null || taskDetail.durationInSeconds > 0) ...[
                                      const SizedBox(height: 8),
                                      Wrap(
                                        spacing: 8,
                                        runSpacing: 8,
                                        children: [
                                          if (taskDetail.dueAt != null)
                                            AppChip(
                                              size: AppChipSize.small,
                                              label: 'Due: ${taskDetail.dueAt!.toDDMMMYYYY()}',
                                            ),
                                          if (taskDetail.durationInSeconds > 0)
                                            AppChip(
                                              size: AppChipSize.small,
                                              label: formatDuration(taskDetail.durationInSeconds),
                                              leading: Icon(
                                                Icons.timer_outlined,
                                                size: 14,
                                                color: AppTheme.colors(context).secondary,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ]
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
