import 'dart:async';

import 'package:kanban_app/app/router/router_config.router.dart';
import 'package:kanban_app/app/service_locator.dart';
import 'package:kanban_app/core/view_models/core_reactive_view_model.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/enums/task_status.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/repository/models/task.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/repository/models/task_detail.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/task_board_service.dart';
import 'package:kanban_app/features/projects/projects_service.dart';
import 'package:kanban_app/features/projects/repository/models/project.dart';
import 'package:kanban_app/shared/overlays/bottom_sheets/app_bottom_sheet_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends CoreReactiveViewModel {
  TaskBoardService get _taskBoardService => locator<TaskBoardService>();
  ProjectsService get _projectsService => locator<ProjectsService>();
  final _bottomSheetService = locator<AppBottomSheetService>();
  final _navigator = locator<NavigationService>();

  List<Task> get tasks => _taskBoardService.tasks;
  List<Project> get projects => _projectsService.projects;

  Project? get selectedProject => _projectsService.selectedProject;

  bool get isBusyFetchingProjects => _projectsService.isBusyFetchingProjects;
  bool get isBusyFetchingTasks => _taskBoardService.isBusyFetchingTasks;

  bool get isActiveLocadingState {
    return (tasks.isEmpty && isBusyFetchingTasks) || (projects.isEmpty && isBusyFetchingProjects);
  }

  TaskDetail getDetailFromTask(Task task) {
    return _taskBoardService.getDetailFromTask(task);
  }

  List<Task> getTasksByStatus(TaskStatus status) {
    return _taskBoardService.tasks.where((task) => getDetailFromTask(task).status == status).toList();
  }

  createTask() {
    _bottomSheetService.showModifyTaskBottomSheet(context!);
  }

  updateTask(Task task) {
    _bottomSheetService.showModifyTaskBottomSheet(context!, task: task);
  }

  createProject() async {
    await _bottomSheetService.showModifyProjectBottomSheet(
      name: '',
      onConfirm: (text) async {
        await _projectsService.createProject(text);
        return true;
      },
    );
  }

  navigateToProjectsView() async {
    final selectedProject = this.selectedProject;
    await _navigator.navigateTo(Routes.projectsView);
    if (this.selectedProject != null && selectedProject?.id != this.selectedProject?.id) {
      initialise();
    }
  }

  @override
  FutureOr<void> initialise() async {
    if (projects.isEmpty) await _projectsService.fetchProjects();
    if (tasks.isEmpty) await _taskBoardService.fetchTasks();
    return super.initialise();
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_taskBoardService, _projectsService];
}
