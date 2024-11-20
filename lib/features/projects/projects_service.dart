import 'package:kanban_app/app/service_locator.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/task_board_service.dart';
import 'package:kanban_app/features/projects/repository/models/project.dart';
import 'package:kanban_app/features/projects/repository/projects_repo.dart';
import 'package:kanban_app/network/exceptions/cancelled_request_exception.dart';
import 'package:kanban_app/services/preference_service.dart';
import 'package:stacked/stacked.dart';

class ProjectsService with ListenableServiceMixin {
  final _projectsRepo = locator<ProjectsRepo>();
  final _preferenceService = locator<PreferenceService>();
  TaskBoardService get _taskBoardService => locator<TaskBoardService>();

  Project? _selectedProject;
  Project? get selectedProject => _selectedProject;
  selectProject(Project project) {
    if (_selectedProject?.id == project.id) return;
    _selectedProject = project;
    _taskBoardService.clean();
    _preferenceService.setActiveProjectId(project.id);
    notifyListeners();
  }

  List<Project> _projects = [];
  List<Project> get projects => _projects;

  // Fetch
  bool failedFetchingProjects = false;
  bool _isBusyFetchingProjects = false;
  bool get isBusyFetchingProjects => _isBusyFetchingProjects;
  setBusyFetchingProjects(bool value) {
    _isBusyFetchingProjects = value;
    notifyListeners();
  }

  fetchProjects() async {
    if (isBusyFetchingProjects) return;
    failedFetchingProjects = false;
    setBusyFetchingProjects(true);
    try {
      _projects = await _projectsRepo.fetchProjects();
      final selection = _projects.where((project) => project.id == _preferenceService.activeProjectId).firstOrNull ??
          _projects.firstOrNull;
      if (selection != null) {
        selectProject(selection);
      }
    } catch (e) {
      if (e is! CancelledRequestException) {
        if (_projects.isEmpty) {
          failedFetchingProjects = true;
        }
        setBusyFetchingProjects(false);
        rethrow;
      }
    }
    setBusyFetchingProjects(false);
  }

  // Create
  bool _isBusyCreatingProjects = false;
  bool get isBusyCreatingProjects => _isBusyCreatingProjects;
  setBusyCreatingProjects(bool value) {
    _isBusyCreatingProjects = value;
    notifyListeners();
  }

  createProject(String name) async {
    if (isBusyCreatingProjects) return;
    setBusyCreatingProjects(true);
    try {
      final project = await _projectsRepo.createProject(name: name);
      _projects.add(project);
    } catch (e) {
      if (e is! CancelledRequestException) {
        setBusyCreatingProjects(false);
        rethrow;
      }
    }
    setBusyCreatingProjects(false);
  }

  // Update
  bool _isBusyUpdatingProjects = false;
  bool get isBusyUpdatingProjects => _isBusyUpdatingProjects;
  setBusyUpdatingProjects(bool value) {
    _isBusyUpdatingProjects = value;
    notifyListeners();
  }

  updateProject(String id, String name) async {
    if (isBusyUpdatingProjects) return;
    setBusyUpdatingProjects(true);
    try {
      final project = await _projectsRepo.updateProject(id: id, name: name);
      final index = _projects.indexWhere((p) => p.id == id);
      _projects.removeAt(index);
      _projects.insert(index, project);
      if (selectedProject?.id == project.id) {
        _selectedProject = project;
      }
    } catch (e) {
      if (e is! CancelledRequestException) {
        setBusyUpdatingProjects(false);
        rethrow;
      }
    }
    setBusyUpdatingProjects(false);
  }

  // Delete
  bool _isBusyDeletingProjects = false;
  bool get isBusyDeletingProjects => _isBusyDeletingProjects;
  setBusyDeletingProjects(bool value) {
    _isBusyDeletingProjects = value;
    notifyListeners();
  }

  deleteProject(String id) async {
    if (isBusyDeletingProjects) return;
    setBusyDeletingProjects(true);
    try {
      final res = await _projectsRepo.deleteProject(id: id);
      if (res == true) {
        _projects.removeWhere((project) => project.id == id);
        if (_selectedProject?.id == id) {
          clean();
          _taskBoardService.clean();
          fetchProjects();
        }
      }
    } catch (e) {
      if (e is! CancelledRequestException) {
        setBusyDeletingProjects(false);
        rethrow;
      }
    }
    setBusyDeletingProjects(false);
  }

  clean() {
    _projects.clear();
    _selectedProject = null;
    notifyListeners();
  }
}
