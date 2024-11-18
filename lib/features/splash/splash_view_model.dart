import 'dart:async';

import 'package:kanban_app/app/router/router_config.router.dart';
import 'package:kanban_app/app/service_locator.dart';
import 'package:kanban_app/core/view_models/core_view_model.dart';
import 'package:stacked_services/stacked_services.dart';

class SplashViewModel extends CoreViewModel {
  final _navigator = locator<NavigationService>();

  @override
  FutureOr<void> initialise() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    _navigator.clearStackAndShow(Routes.dashboardView);
    return super.initialise();
  }
}
