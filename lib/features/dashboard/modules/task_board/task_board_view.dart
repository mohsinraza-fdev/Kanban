import 'package:flutter/material.dart';
import 'package:kanban_app/core/view_models/core_view.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/task_board_view_model.dart';
import 'package:kanban_app/shared/theme/app_colors.dart';
import 'package:kanban_app/shared/theme/app_text_styles.dart';
import 'package:kanban_app/shared/theme/app_theme.dart';
import 'package:kanban_app/shared/utils/ui_helpers.dart';
import 'package:kanban_app/shared/widgets/primary_app_bar.dart';

class TaskBoardView extends CoreView<TaskBoardViewModel> {
  const TaskBoardView({super.key});

  @override
  Widget buildView(BuildContext context, TaskBoardViewModel viewModel, Widget? child) {
    return Scaffold(
      body: Column(
        children: [
          const PrimaryAppBar(title: 'Task Board'),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  BoardColumn(
                    title: 'OPEN',
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: screenWidth(context, multiplier: 0.9)),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppTheme.colors(context).primary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            "OPEN",
                            style: AppTextStyles.m12(AppColors.white),
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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

class BoardColumn extends StatelessWidget {
  final String title;
  const BoardColumn({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: screenWidth(context, multiplier: 0.9)),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppTheme.colors(context).primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              title.toUpperCase(),
              style: AppTextStyles.m12(AppColors.white),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
