import 'package:kanban_app/app/service_locator.dart';
import 'package:kanban_app/core/view_models/core_view_model.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/enums/task_status.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/repository/models/task.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/task_board_service.dart';
import 'package:stacked_services/stacked_services.dart';

class SelectTaskStatusViewModel extends CoreViewModel {
  Task? selectedTask;
  TaskStatus selectedStatus;

  SelectTaskStatusViewModel({
    this.selectedTask,
    required this.selectedStatus,
  });

  final _taskBoardService = locator<TaskBoardService>();
  final _navigator = locator<NavigationService>();

  bool get isBusyUpdatingTaskStatus => _taskBoardService.isBusyUpdatingTaskStatus;

  selectStatus(TaskStatus status) async {
    if (selectedTask == null) {
      return _navigator.back(result: status);
    }
    final taskDetail = _taskBoardService.getDetailFromTask(selectedTask!);
    if (status == taskDetail.status) return;
    await _taskBoardService.updateTaskStatus(task: selectedTask!, status: status);
    selectedStatus = status;
    notifyListeners();
  }
}
