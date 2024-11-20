import 'package:flutter/material.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/enums/task_status.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/repository/models/task.dart';
import 'package:kanban_app/shared/overlays/bottom_sheets/common/deletion_confirmation_bottom_sheet.dart';
import 'package:kanban_app/shared/overlays/bottom_sheets/projects/modify_project_bottom_sheet.dart';
import 'package:kanban_app/shared/overlays/bottom_sheets/task_board/modify_task/modify_task_bottom_sheet.dart';
import 'package:kanban_app/shared/overlays/bottom_sheets/task_board/select_task_status/select_task_status_bottom_sheet.dart';
import 'package:kanban_app/shared/overlays/bottom_sheets/timer_tracker/select_task_bottom_sheet.dart';
import 'package:kanban_app/shared/theme/app_theme.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:stacked_services/stacked_services.dart';

class AppBottomSheetService {
  showModifyProjectBottomSheet({
    String? id,
    required String name,
    required Future<bool> Function(String name) onConfirm,
  }) async {
    final context = StackedService.navigatorKey?.currentContext;
    if (context == null) return;
    return await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: ModifyProjectBottomSheet(
          id: id,
          name: name,
          onConfirm: onConfirm,
        ),
      ),
    );
  }

  showDeleteConfirmationBottomSheet({
    required String title,
    required Future<bool> Function() onDelete,
  }) async {
    final context = StackedService.navigatorKey?.currentContext;
    if (context == null) return;
    return await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: DeletionConfirmationBottomSheet(
          title: title,
          onDelete: onDelete,
        ),
      ),
    );
  }

  showModifyTaskBottomSheet(
    BuildContext context, {
    Task? task,
  }) async {
    return await showCupertinoModalBottomSheet<List<String>?>(
      expand: true,
      context: context,
      backgroundColor: AppTheme.colors(context).surface,
      builder: (context) => ModifyTaskBottomSheet(
        task: task,
      ),
    );
  }

  Future<TaskStatus?> showSelectTaskStatusBottomSheet(
    BuildContext context, {
    Task? task,
    required TaskStatus status,
  }) async {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SelectTaskStatusBottomSheet(
          task: task,
          selectedStatus: status,
        ),
      ),
    );
  }

  Future<Task?> showSelectTaskBottomSheet(BuildContext context) async {
    return await showCupertinoModalBottomSheet<Task?>(
      expand: true,
      context: context,
      backgroundColor: AppTheme.colors(context).surface,
      builder: (context) => const SelectTaskBottomSheet(),
    );
  }
}
