import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kanban_app/app/service_locator.dart';
import 'package:kanban_app/core/view_models/core_reactive_view_model.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/enums/task_status.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/repository/models/task.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/task_board_service.dart';
import 'package:kanban_app/shared/overlays/bottom_sheets/app_bottom_sheet_service.dart';
import 'package:kanban_app/shared/overlays/snackbars/app_snackbar_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ModifyTaskViewModel extends CoreReactiveViewModel {
  Task? selectedTask;
  ModifyTaskViewModel([this.selectedTask]);

  final _taskBoardService = locator<TaskBoardService>();
  final _bottomSheetService = locator<AppBottomSheetService>();
  final _snackbarService = locator<AppSnackbarService>();
  final _navigator = locator<NavigationService>();

  bool get isBusyCreatingTasks => _taskBoardService.isBusyCreatingTasks;
  bool get isBusyUpdatingTask => _taskBoardService.isBusyUpdatingTask;
  bool get isBusyDeletingTasks => _taskBoardService.isBusyDeletingTasks;

  late final contentController = getTextEditingController();
  late final descriptionController = getTextEditingController();

  late final contentFocus = getFocusNode();
  late final descriptionFocus = getFocusNode();

  TaskStatus selectedStatus = TaskStatus.open;
  selectStatus() async {
    final status = await _bottomSheetService.showSelectTaskStatusBottomSheet(
      context!,
      status: selectedStatus,
    );
    if (status != null) {
      selectedStatus = status;
      notifyListeners();
    }
  }

  DateTime? selectedDueDate;
  selectDate() async {
    final date = await showDatePicker(
      context: context!,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 1000)),
    );
    if (date != null) {
      selectedDueDate = date;
      notifyListeners();
    }
  }

  submit() async {
    try {
      if (selectedTask == null) {
        await _taskBoardService.createTask(
          content: contentController.text,
          description: descriptionController.text,
          status: selectedStatus,
          dueDate: selectedDueDate,
        );
        _navigator.back();
        return;
      }
      final taskDetail = _taskBoardService.getDetailFromTask(selectedTask!);
      await _taskBoardService.updateTask(
        id: selectedTask!.id,
        content: contentController.text,
        description: descriptionController.text,
        status: selectedStatus,
        dueDate: selectedDueDate,
        duration: taskDetail.durationInSeconds,
      );
      _navigator.back();
    } catch (e) {
      _snackbarService.showErrorSnackbar(message: 'Please check your internet connection');
    }
  }

  delete() async {
    if (selectedTask == null) return;
    try {
      await _taskBoardService.deleteTask(selectedTask!.id);
      _navigator.back();
    } catch (e) {
      _snackbarService.showErrorSnackbar(message: 'Please check your internet connection');
    }
  }

  @override
  FutureOr<void> initialise() {
    if (selectedTask != null) {
      final taskDetail = _taskBoardService.getDetailFromTask(selectedTask!);
      contentController.text = selectedTask!.content;
      descriptionController.text = selectedTask!.description;
      selectedStatus = taskDetail.status;
      selectedDueDate = taskDetail.dueAt;
      if (context?.mounted ?? false) {
        notifyListeners();
      }
    }
    return super.initialise();
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_taskBoardService];
}
