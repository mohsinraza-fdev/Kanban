import 'package:flutter/material.dart';
import 'package:kanban_app/core/view_models/core_view.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/enums/task_status.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/task_board_view_model.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/widgets/board_column.dart';
import 'package:kanban_app/shared/theme/app_colors.dart';
import 'package:kanban_app/shared/theme/app_text_styles.dart';
import 'package:kanban_app/shared/theme/app_theme.dart';
import 'package:kanban_app/shared/widgets/app_loading_indicator.dart';
import 'package:kanban_app/shared/widgets/primary_app_bar.dart';

class TaskBoardView extends CoreView<TaskBoardViewModel> {
  const TaskBoardView({super.key});

  @override
  Widget buildView(BuildContext context, TaskBoardViewModel viewModel, Widget? child) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        label: Text(
          'Add Task',
          style: AppTextStyles.m16(AppColors.white),
        ),
        icon: Icon(
          Icons.add,
          color: AppColors.white,
        ),
        backgroundColor: AppTheme.colors(context).primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        onPressed: viewModel.createTask,
      ),
      body: Column(
        children: [
          const PrimaryAppBar(title: 'Task Board'),
          Expanded(
            child: viewModel.isBusyFetchingTasks && viewModel.tasks.isEmpty
                ? const AppLoadingIndicator()
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ...TaskStatus.values.map((status) {
                          return BoardColumn(taskStatus: status);
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
  TaskBoardViewModel viewModelBuilder(BuildContext context) {
    return TaskBoardViewModel();
  }
}
