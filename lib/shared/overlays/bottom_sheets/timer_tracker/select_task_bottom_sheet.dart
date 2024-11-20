import 'package:flutter/material.dart';
import 'package:kanban_app/core/view_models/core_view.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/enums/task_status.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/widgets/task_card.dart';
import 'package:kanban_app/shared/overlays/bottom_sheets/timer_tracker/select_task_view_model.dart';
import 'package:kanban_app/shared/theme/app_text_styles.dart';
import 'package:kanban_app/shared/theme/app_theme.dart';
import 'package:kanban_app/shared/widgets/app_chip.dart';

class SelectTaskBottomSheet extends CoreView<SelectTaskViewModel> {
  const SelectTaskBottomSheet({
    super.key,
  });

  @override
  Widget buildView(BuildContext context, SelectTaskViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Select Task",
                    style: AppTextStyles.m18(AppTheme.colors(context).text),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: Navigator.of(context).pop,
                  child: Icon(
                    Icons.close,
                    size: 24,
                    color: AppTheme.colors(context).text,
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  ...TaskStatus.values.map(
                    (status) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: AppChip(
                        size: AppChipSize.medium,
                        label: status.name,
                        labelStyle: AppTextStyles.m12(viewModel.selectedStatus == status
                            ? AppTheme.colors(context).primary
                            : AppTheme.colors(context).secondary),
                        borderWidth: 1.5,
                        borderColor: viewModel.selectedStatus == status ? AppTheme.colors(context).primary : null,
                        onTap: () => viewModel.selectStatus(status),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: 1,
            alignment: Alignment.center,
            color: AppTheme.colors(context).border,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...viewModel.tasksBySelectedStatus.map((task) {
                      return TaskCard(
                        task: task,
                        taskDetail: viewModel.getDetailFromTask(task),
                        showDetail: false,
                        onTap: () => viewModel.selectTask(task),
                      );
                    }),
                    const SizedBox(height: 20),
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
  SelectTaskViewModel viewModelBuilder(BuildContext context) {
    return SelectTaskViewModel();
  }
}
