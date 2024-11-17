import 'package:kanban_app/services/preference_service.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

final locator = StackedLocator.instance;

void setupServiceLocator() {
  locator.registerLazySingleton(() => PreferenceService());
  locator.registerLazySingleton(() => NavigationService());
}
