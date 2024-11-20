import 'package:flutter/material.dart';
import 'package:kanban_app/core/view_models/core_view_model_widget.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/enums/task_status.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/task_board_view_model.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/widgets/task_card.dart';
import 'package:kanban_app/shared/theme/app_colors.dart';
import 'package:kanban_app/shared/theme/app_text_styles.dart';
import 'package:kanban_app/shared/utils/ui_helpers.dart';

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
                      return TaskCard(
                        task: task,
                        taskDetail: taskDetail,
                        onTap: () => viewModel.updateTask(task),
                        onTapStatusIndicator: () => viewModel.updateTaskStatus(task),
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
