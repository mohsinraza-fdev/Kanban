import 'package:flutter/material.dart';
import 'package:kanban_app/core/view_models/core_view.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/enums/task_status.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/repository/models/task.dart';
import 'package:kanban_app/shared/assets_gen/assets.gen.dart';
import 'package:kanban_app/shared/overlays/bottom_sheets/task_board/select_task_status/select_task_status_view_model.dart';
import 'package:kanban_app/shared/theme/app_text_styles.dart';
import 'package:kanban_app/shared/theme/app_theme.dart';
import 'package:kanban_app/shared/utils/ui_helpers.dart';

class SelectTaskStatusBottomSheet extends CoreView<SelectTaskStatusViewModel> {
  final Task? task;
  final TaskStatus selectedStatus;
  const SelectTaskStatusBottomSheet({
    super.key,
    this.task,
    required this.selectedStatus,
  });

  @override
  Widget buildView(BuildContext context, SelectTaskStatusViewModel viewModel, Widget? child) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.colors(context).surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            width: 1,
            color: AppTheme.colors(context).border,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Select Status',
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
              const SizedBox(height: 20),
              ...TaskStatus.values.map((status) {
                return Opacity(
                  opacity: viewModel.isBusyUpdatingTaskStatus ? 0.6 : 1,
                  child: IgnorePointer(
                    ignoring: viewModel.isBusyUpdatingTaskStatus,
                    child: GestureDetector(
                      onTap: () => viewModel.selectStatus(status),
                      child: Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                        child: Row(
                          children: [
                            Container(
                              height: 16,
                              width: 16,
                              margin: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: taskStatusColor(context, status),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                status.name,
                                style: (viewModel.selectedStatus == status
                                    ? AppTextStyles.sb16
                                    : AppTextStyles.r16)(AppTheme.colors(context).text),
                              ),
                            ),
                            if (status == viewModel.selectedStatus) ...[
                              const SizedBox(width: 8),
                              Assets.icons.check.image(
                                width: 20,
                                height: 20,
                                color: AppTheme.colors(context).primary,
                              ),
                            ],
                            const SizedBox(width: 8),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  @override
  SelectTaskStatusViewModel viewModelBuilder(BuildContext context) {
    return SelectTaskStatusViewModel(
      selectedTask: task,
      selectedStatus: selectedStatus,
    );
  }
}
