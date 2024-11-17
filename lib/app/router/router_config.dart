import 'package:kanban_app/features/splash/splash_view.dart';
import 'package:stacked/stacked_annotations.dart';

@StackedApp(routes: [
  AdaptiveRoute(initial: true, page: SplashView),
])
class RouterConfig {}
