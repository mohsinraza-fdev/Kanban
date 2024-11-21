import 'dart:async';

import 'package:kanban_app/app/service_locator.dart';
import 'package:kanban_app/core/view_models/core_reactive_view_model.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/repository/models/task.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/repository/models/task_detail.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/task_board_service.dart';
import 'package:kanban_app/shared/overlays/bottom_sheets/app_bottom_sheet_service.dart';

class TimeTrackerViewModel extends CoreReactiveViewModel {
  final _taskBoardService = locator<TaskBoardService>();
  final _bottomSheetService = locator<AppBottomSheetService>();

  List<Task> get tasks => _taskBoardService.tasks;
  List<Task> get trackedTasks => tasks.where((task) => getDetailFromTask(task).durationInSeconds > 0).toList();

  bool get isBusyFetchingTasks => _taskBoardService.isBusyFetchingTasks;

  TaskDetail getDetailFromTask(Task task) {
    return _taskBoardService.getDetailFromTask(task);
  }

  Task? selectedTask;
  selectTask() async {
    final task = await _bottomSheetService.showSelectTaskBottomSheet(context!);
    if (task != null) {
      selectedTask = task;
      notifyListeners();
    }
  }

  String get totalFormattedTime {
    if (selectedTask == null) return '00:00:00';
    final seconds = getDetailFromTask(selectedTask!).durationInSeconds + secondsRecorded;
    final hours = (seconds ~/ 3600).toString().padLeft(2, '0');
    final minutes = ((seconds % 3600) ~/ 60).toString().padLeft(2, '0');
    final remainingSeconds = (seconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$remainingSeconds';
  }

  int secondsRecorded = 0;
  Timer? timer;
  bool tracking = false;
  startTracking() {
    if (secondsRecorded != 0 || selectedTask == null) return;
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      ++secondsRecorded;
      notifyListeners();
    });
    tracking = true;
    notifyListeners();
  }

  bool isUpdatingTaskDuration = false;
  stopTracking() async {
    timer?.cancel();
    isUpdatingTaskDuration = true;
    notifyListeners();
    await _taskBoardService.updateTaskDuration(
      task: selectedTask!,
      duration: getDetailFromTask(selectedTask!).durationInSeconds + secondsRecorded,
    );
    tracking = false;
    timer = null;
    secondsRecorded = 0;
    isUpdatingTaskDuration = false;
    notifyListeners();
  }

  @override
  FutureOr<void> initialise() {
    _taskBoardService.fetchTasks();
    return super.initialise();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
