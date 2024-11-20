import 'package:flutter/material.dart';
import 'package:kanban_app/core/extensions/date_time_extension.dart';
import 'package:kanban_app/core/view_models/core_view.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/repository/models/task.dart';
import 'package:kanban_app/shared/overlays/bottom_sheets/task_board/modify_task/modify_task_view_model.dart';
import 'package:kanban_app/shared/theme/app_text_styles.dart';
import 'package:kanban_app/shared/theme/app_theme.dart';
import 'package:kanban_app/shared/utils/ui_helpers.dart';
import 'package:kanban_app/shared/widgets/app_button.dart';
import 'package:kanban_app/shared/widgets/app_input_field.dart';

class ModifyTaskBottomSheet extends CoreView<ModifyTaskViewModel> {
  final Task? task;
  const ModifyTaskBottomSheet({
    super.key,
    this.task,
  });

  @override
  Widget buildView(BuildContext context, ModifyTaskViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        task == null ? "Create Task" : "Update Task",
                        style: AppTextStyles.m18(AppTheme.colors(context).text),
                      ),
                      const SizedBox(width: 8),
                      if (task != null)
                        AppButton.outline(
                          size: AppButtonSize.small,
                          label: 'View Comments',
                          onTap: viewModel.openCommentsBottomSheet,
                        ),
                    ],
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
                    AppInputField.text(
                      controller: viewModel.contentController,
                      focusNode: viewModel.contentFocus,
                      label: 'Content',
                      hint: 'Enter task content',
                      required: true,
                    ),
                    const SizedBox(height: 12),
                    AppInputField.description(
                      controller: viewModel.descriptionController,
                      focusNode: viewModel.descriptionFocus,
                      label: 'Description',
                      hint: 'Enter task description',
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Status',
                      style: AppTextStyles.m14(AppTheme.colors(context).text),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: viewModel.selectStatus,
                      child: Container(
                        height: 48,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: AppTheme.colors(context).surfaceSecondary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                viewModel.selectedStatus.name,
                                style: AppTextStyles.m14(AppTheme.colors(context).text),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              height: 16,
                              width: 16,
                              margin: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: taskStatusColor(context, viewModel.selectedStatus),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Due Date',
                      style: AppTextStyles.m14(AppTheme.colors(context).text),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: viewModel.selectDate,
                      child: Container(
                        height: 48,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: AppTheme.colors(context).surfaceSecondary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                viewModel.selectedDueDate?.toDDMMMYYYY() ?? 'Select Date',
                                style: AppTextStyles.m14(viewModel.selectedDueDate == null
                                    ? AppTheme.colors(context).tertiary
                                    : AppTheme.colors(context).text),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              Icons.calendar_month_outlined,
                              size: 20,
                              color: AppTheme.colors(context).tertiary,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 1,
            alignment: Alignment.center,
            color: AppTheme.colors(context).border,
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                if (task != null) ...[
                  Expanded(
                    child: AppButton.danger(
                      size: AppButtonSize.large,
                      width: double.maxFinite,
                      isLoading: viewModel.isBusyDeletingTasks,
                      label: 'Delete',
                      onTap: viewModel.delete,
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
                Expanded(
                    child: AppButton.primary(
                  size: AppButtonSize.large,
                  width: double.maxFinite,
                  isLoading: viewModel.isBusyCreatingTasks || viewModel.isBusyUpdatingTask,
                  label: task == null ? 'Create' : 'Update',
                  onTap: viewModel.submit,
                ))
              ],
            ),
          ),
          SizedBox(height: isKeyboardOpen(context) ? 24 : 40),
        ],
      ),
    );
  }

  @override
  ModifyTaskViewModel viewModelBuilder(BuildContext context) {
    return ModifyTaskViewModel(task);
  }
}
