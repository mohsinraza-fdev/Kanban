import 'dart:async';

import 'package:kanban_app/app/service_locator.dart';
import 'package:kanban_app/core/view_models/core_reactive_view_model.dart';
import 'package:kanban_app/features/projects/projects_service.dart';
import 'package:kanban_app/features/projects/repository/models/project.dart';
import 'package:kanban_app/shared/overlays/bottom_sheets/app_bottom_sheet_service.dart';
import 'package:stacked/stacked.dart';

class ProjectsViewModel extends CoreReactiveViewModel {
  final _projectsService = locator<ProjectsService>();
  final _bottomSheetService = locator<AppBottomSheetService>();

  Project? get selectedProject => _projectsService.selectedProject;
  List<Project> get projects => _projectsService.projects;

  bool get failedFetchingProjects => _projectsService.failedFetchingProjects;
  bool get isBusyFetchingProjects => _projectsService.isBusyFetchingProjects;

  selectProject(Project project) {
    _projectsService.selectProject(project);
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

  updateProject(Project project) async {
    await _bottomSheetService.showModifyProjectBottomSheet(
      id: project.id,
      name: project.name,
      onConfirm: (text) async {
        await _projectsService.updateProject(project.id, text);
        return true;
      },
    );
  }

  deleteProject(Project project) async {
    await _bottomSheetService.showDeleteConfirmationBottomSheet(
      title: 'Delete Project',
      onDelete: () async {
        await _projectsService.deleteProject(project.id);
        return true;
      },
    );
  }

  @override
  FutureOr<void> initialise() {
    _projectsService.fetchProjects();
    return super.initialise();
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_projectsService];
}
