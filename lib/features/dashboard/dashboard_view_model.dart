import 'package:kanban_app/app/service_locator.dart';
import 'package:kanban_app/core/view_models/core_view_model.dart';
import 'package:kanban_app/features/projects/projects_service.dart';
import 'package:kanban_app/features/projects/repository/models/project.dart';

class DashboardViewModel extends CoreViewModel {
  final _projectsService = locator<ProjectsService>();

  int selectedIndex = 0;
  setIndex(int value) {
    selectedIndex = value;
    notifyListeners();
  }

  Project? get selectedProject => _projectsService.selectedProject;
}
