import 'package:kanban_app/features/dashboard/dashboard_view.dart';
import 'package:kanban_app/features/projects/projects_view.dart';
import 'package:kanban_app/features/splash/splash_view.dart';
import 'package:stacked/stacked_annotations.dart';

@StackedApp(routes: [
  AdaptiveRoute(initial: true, page: SplashView),
  AdaptiveRoute(page: DashboardView),
  AdaptiveRoute(page: ProjectsView),
])
class RouterConfig {}
