import 'package:flutter/material.dart';
import 'package:kanban_app/core/view_models/core_view.dart';
import 'package:kanban_app/shared/overlays/bottom_sheets/task_board/task_comments/task_comments_view_model.dart';
import 'package:kanban_app/shared/theme/app_colors.dart';
import 'package:kanban_app/shared/theme/app_text_styles.dart';
import 'package:kanban_app/shared/theme/app_theme.dart';
import 'package:kanban_app/shared/utils/ui_helpers.dart';
import 'package:kanban_app/shared/widgets/app_input_field.dart';
import 'package:kanban_app/shared/widgets/app_loading_indicator.dart';

class TaskCommentsBottomSheet extends CoreView<TaskCommentsViewModel> {
  final String taskId;
  final String projectId;
  const TaskCommentsBottomSheet({
    super.key,
    required this.taskId,
    required this.projectId,
  });

  @override
  Widget buildView(BuildContext context, TaskCommentsViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Comments',
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
          Container(
            height: 1,
            alignment: Alignment.center,
            color: AppTheme.colors(context).border,
          ),
          Expanded(
            child: viewModel.isBusyFetchingComments
                ? const AppLoadingIndicator()
                : ListView(
                    reverse: true,
                    children: [
                      const SizedBox(height: 16),
                      ...viewModel.comments.map((comment) {
                        return Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            margin: EdgeInsets.only(left: screenWidth(context, multiplier: 0.2), right: 16, bottom: 12),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppTheme.colors(context).primary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              comment.content,
                              style: AppTextStyles.r14(AppColors.white),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.colors(context).tertiary,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              border: Border.all(
                width: 1,
                color: AppTheme.colors(context).border,
              ),
            ),
            child: AppInputField.text(
              controller: viewModel.controller,
              focusNode: viewModel.focusNode,
              backgroundColor: AppTheme.colors(context).surface,
              hint: 'Type Comment',
              onChanged: (p0) => viewModel.notifyListeners(),
              suffix: viewModel.isBusyCreatingComment
                  ? const SizedBox(
                      height: 25,
                      width: 25,
                      child: AppLoadingIndicator(),
                    )
                  : GestureDetector(
                      onTap: viewModel.createComment,
                      child: Icon(
                        Icons.send,
                        size: 30,
                        color: viewModel.controller.text.isEmpty
                            ? AppTheme.colors(context).tertiary
                            : AppTheme.colors(context).primary,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  TaskCommentsViewModel viewModelBuilder(BuildContext context) {
    return TaskCommentsViewModel(taskId: taskId, projectId: projectId);
  }
}
