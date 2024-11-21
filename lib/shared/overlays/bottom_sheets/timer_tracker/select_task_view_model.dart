import 'package:kanban_app/app/service_locator.dart';
import 'package:kanban_app/core/view_models/core_reactive_view_model.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/enums/task_status.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/repository/models/task.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/repository/models/task_detail.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/task_board_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SelectTaskViewModel extends CoreReactiveViewModel {
  final _taskBoardService = locator<TaskBoardService>();
  final _navigator = locator<NavigationService>();

  List<Task> get tasksBySelectedStatus => _taskBoardService.tasks
      .where((task) => _taskBoardService.getDetailFromTask(task).status == selectedStatus)
      .toList();

  TaskDetail getDetailFromTask(Task task) {
    return _taskBoardService.getDetailFromTask(task);
  }

  TaskStatus selectedStatus = TaskStatus.open;
  selectStatus(TaskStatus status) {
    selectedStatus = status;
    notifyListeners();
  }

  selectTask(Task task) {
    _navigator.back(result: task);
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_taskBoardService];
}
