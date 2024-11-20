import 'package:kanban_app/app/service_locator.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/enums/task_status.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/repository/models/task.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/repository/models/task_detail.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/repository/task_board_repo.dart';
import 'package:kanban_app/features/projects/projects_service.dart';
import 'package:kanban_app/features/projects/repository/models/project.dart';
import 'package:kanban_app/network/exceptions/cancelled_request_exception.dart';
import 'package:stacked/stacked.dart';

class TaskBoardService with ListenableServiceMixin {
  final _taskBoardRepo = locator<TaskBoardRepo>();
  ProjectsService get _projectsService => locator<ProjectsService>();

  Project? get selectedProject => _projectsService.selectedProject;

  List<Task> _tasks = [];
  List<TaskDetail> _taskDetails = [];

  List<Task> get tasks => _tasks;
  List<TaskDetail> get taskDetails => _taskDetails;

  TaskDetail getDetailFromTask(Task task) {
    return _taskDetails.where((detail) => detail.id == task.id).firstOrNull ??
        TaskDetail(
          id: task.id,
          projectId: task.projectId,
          status: TaskStatus.open,
          durationInSeconds: 0,
          updatedAt: DateTime.now(),
        );
  }

  // Fetch
  bool failedFetchingTasks = false;
  bool _isBusyFetchingTasks = false;
  bool get isBusyFetchingTasks => _isBusyFetchingTasks;
  setBusyFetchingTasks(bool value) {
    _isBusyFetchingTasks = value;
    notifyListeners();
  }

  fetchTasks() async {
    if (isBusyFetchingTasks || selectedProject == null) return;
    failedFetchingTasks = false;
    setBusyFetchingTasks(true);
    try {
      final [tasks, taskDetails] = await Future.wait([
        _taskBoardRepo.fetchTasks(projectId: selectedProject!.id),
        _taskBoardRepo.getAllTaskDetails(),
      ]);

      _tasks = tasks as List<Task>;
      _taskDetails =
          (taskDetails as List<TaskDetail>).where((detail) => detail.projectId == selectedProject?.id).toList();
    } catch (e) {
      if (e is! CancelledRequestException) {
        if (_tasks.isEmpty) {
          failedFetchingTasks = true;
        }
        setBusyFetchingTasks(false);
        rethrow;
      }
    }
    setBusyFetchingTasks(false);
  }

  // Create
  bool _isBusyCreatingTasks = false;
  bool get isBusyCreatingTasks => _isBusyCreatingTasks;
  setBusyCreatingTasks(bool value) {
    _isBusyCreatingTasks = value;
    notifyListeners();
  }

  createTask({
    required String content,
    String description = '',
    required TaskStatus status,
    DateTime? dueDate,
    DateTime? completionDate,
  }) async {
    if (isBusyCreatingTasks || selectedProject == null) return;
    setBusyCreatingTasks(true);
    try {
      final task =
          await _taskBoardRepo.createTask(projectId: selectedProject!.id, content: content, description: description);
      final taskDetail = await _taskBoardRepo.saveTaskDetails(
        TaskDetail(
          id: task.id,
          projectId: task.projectId,
          status: status,
          durationInSeconds: 0,
          updatedAt: DateTime.now(),
          dueAt: dueDate,
          completedAt: completionDate,
        ),
      );
      _tasks.add(task);
      _taskDetails.add(taskDetail);
    } catch (e) {
      if (e is! CancelledRequestException) {
        setBusyCreatingTasks(false);
        rethrow;
      }
    }
    setBusyCreatingTasks(false);
  }

  // Update
  bool _isBusyUpdatingTasks = false;
  bool get isBusyUpdatingTasks => _isBusyUpdatingTasks;
  setBusyUpdatingTasks(bool value) {
    _isBusyUpdatingTasks = value;
    notifyListeners();
  }

  updateTask({
    required String id,
    required String content,
    String description = '',
    required TaskStatus status,
    required int duration,
    DateTime? dueDate,
    DateTime? completionDate,
  }) async {
    if (isBusyUpdatingTasks || selectedProject == null) return;
    setBusyUpdatingTasks(true);
    try {
      final task = await _taskBoardRepo.updateTask(id: id, content: content, description: description);
      final taskDetail = await _taskBoardRepo.saveTaskDetails(
        TaskDetail(
          id: task.id,
          projectId: task.projectId,
          status: status,
          durationInSeconds: duration,
          updatedAt: DateTime.now(),
          dueAt: dueDate,
          completedAt: completionDate,
        ),
      );
      _tasks.removeWhere((t) => t.id == task.id);
      _taskDetails.removeWhere((td) => td.id == taskDetail.id);

      _tasks.add(task);
      _taskDetails.add(taskDetail);
    } catch (e) {
      if (e is! CancelledRequestException) {
        setBusyUpdatingTasks(false);
        rethrow;
      }
    }
    setBusyUpdatingTasks(false);
  }

  // Delete
  bool _isBusyDeletingTasks = false;
  bool get isBusyDeletingTasks => _isBusyDeletingTasks;
  setBusyDeletingTasks(bool value) {
    _isBusyDeletingTasks = value;
    notifyListeners();
  }

  deleteTask(String id) async {
    if (isBusyDeletingTasks || selectedProject == null) return;
    setBusyDeletingTasks(true);
    try {
      await _taskBoardRepo.deleteTask(taskId: id);
      await _taskBoardRepo.deleteTaskDetails(id);

      _tasks.removeWhere((t) => t.id == id);
      _taskDetails.removeWhere((td) => td.id == id);
    } catch (e) {
      if (e is! CancelledRequestException) {
        setBusyDeletingTasks(false);
        rethrow;
      }
    }
    setBusyDeletingTasks(false);
  }

  clean() {
    _tasks.clear();
    _taskDetails.clear();
    notifyListeners();
  }
}
