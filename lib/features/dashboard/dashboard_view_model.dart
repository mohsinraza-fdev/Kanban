import 'package:kanban_app/app/service_locator.dart';
import 'package:kanban_app/core/view_models/core_reactive_view_model.dart';
import 'package:kanban_app/features/projects/projects_service.dart';
import 'package:kanban_app/features/projects/repository/models/project.dart';
import 'package:stacked/stacked.dart';

class DashboardViewModel extends CoreReactiveViewModel {
  final _projectsService = locator<ProjectsService>();

  int selectedIndex = 0;
  setIndex(int value) {
    if (value == selectedIndex) return;
    selectedIndex = value;
    notifyListeners();
  }

  Project? get selectedProject => _projectsService.selectedProject;

  @override
  List<ListenableServiceMixin> get listenableServices => [_projectsService];
}
