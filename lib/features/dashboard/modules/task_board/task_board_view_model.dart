import 'dart:async';

import 'package:kanban_app/app/service_locator.dart';
import 'package:kanban_app/core/view_models/core_reactive_view_model.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/enums/task_status.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/repository/models/task.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/repository/models/task_detail.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/task_board_service.dart';
import 'package:kanban_app/shared/overlays/bottom_sheets/app_bottom_sheet_service.dart';
import 'package:stacked/src/mixins/listenable_service_mixin.dart';

class TaskBoardViewModel extends CoreReactiveViewModel {
  final _taskBoardService = locator<TaskBoardService>();
  final _bottomSheetService = locator<AppBottomSheetService>();

  List<Task> get tasks => _taskBoardService.tasks;

  bool get isBusyFetchingTasks => _taskBoardService.isBusyFetchingTasks;

  TaskDetail getDetailFromTask(Task task) {
    return _taskBoardService.getDetailFromTask(task);
  }

  List<Task> getTasksFromStatus(TaskStatus status) {
    return tasks.where((task) => getDetailFromTask(task).status == status).toList();
  }

  createTask() {
    _bottomSheetService.showModifyTaskBottomSheet(context!);
  }

  updateTask(Task task) {
    _bottomSheetService.showModifyTaskBottomSheet(context!, task: task);
  }

  updateTaskStatus(Task task) async {
    await _bottomSheetService.showSelectTaskStatusBottomSheet(
      context!,
      task: task,
      status: getDetailFromTask(task).status,
    );
  }

  @override
  FutureOr<void> initialise() {
    _taskBoardService.fetchTasks();
    return super.initialise();
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_taskBoardService];
}
