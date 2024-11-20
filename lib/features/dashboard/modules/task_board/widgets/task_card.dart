import 'package:flutter/material.dart';
import 'package:kanban_app/core/extensions/date_time_extension.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/repository/models/task.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/repository/models/task_detail.dart';
import 'package:kanban_app/shared/theme/app_text_styles.dart';
import 'package:kanban_app/shared/theme/app_theme.dart';
import 'package:kanban_app/shared/utils/ui_helpers.dart';
import 'package:kanban_app/shared/widgets/app_chip.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final TaskDetail taskDetail;
  final bool showDetail;
  final Widget? trailing;
  final VoidCallback? onTap;
  final VoidCallback? onTapStatusIndicator;
  const TaskCard({
    super.key,
    required this.task,
    required this.taskDetail,
    this.showDetail = true,
    this.trailing,
    this.onTap,
    this.onTapStatusIndicator,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(left: 12, right: 20, top: 16, bottom: 16),
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: AppTheme.colors(context).surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            width: 1,
            color: AppTheme.colors(context).border,
          ),
          boxShadow: [
            BoxShadow(
              offset: const Offset(1, 5),
              blurRadius: 25,
              color: Colors.black.withOpacity(0.05),
            ),
          ],
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: onTapStatusIndicator,
              child: Container(
                height: 24,
                width: 24,
                alignment: Alignment.center,
                color: Colors.transparent,
                child: Container(
                  height: 12,
                  width: 12,
                  decoration: BoxDecoration(
                    color: taskStatusColor(context, taskDetail.status),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.content,
                    style: AppTextStyles.r14(AppTheme.colors(context).text),
                  ),
                  if ((taskDetail.dueAt != null || taskDetail.durationInSeconds > 0) && showDetail) ...[
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
            if (trailing != null) ...[
              const SizedBox(width: 8),
              trailing!,
            ],
          ],
        ),
      ),
    );
  }
}
