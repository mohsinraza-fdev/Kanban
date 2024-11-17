import 'package:kanban_app/services/preference_service.dart';
import 'package:stacked/stacked_annotations.dart';

final locator = StackedLocator.instance;

void setupServiceLocator() {
  locator.registerLazySingleton(() => PreferenceService());
}
