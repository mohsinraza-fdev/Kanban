import 'package:dio/dio.dart';
import 'package:kanban_app/database/hive_service.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/repository/task_board_repo.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/repository/task_board_repo_impl.dart';
import 'package:kanban_app/features/projects/projects_service.dart';
import 'package:kanban_app/features/projects/repository/projects_repo.dart';
import 'package:kanban_app/features/projects/repository/projects_repo_impl.dart';
import 'package:kanban_app/network/api_client_kanban.dart';
import 'package:kanban_app/services/preference_service.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/task_board_service.dart';
import 'package:kanban_app/shared/overlays/bottom_sheets/app_bottom_sheet_service.dart';
import 'package:kanban_app/shared/overlays/snackbars/app_snackbar_service.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stacked_themes/stacked_themes.dart';

final locator = StackedLocator.instance;

void setupServiceLocator() {
  locator.registerLazySingleton(() => PreferenceService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => ThemeService.getInstance());
  locator.registerLazySingleton(() => ApiClientKanban(Dio()));

  // Local Services
  locator.registerLazySingleton(() => HiveService());
  locator.registerLazySingleton(() => ProjectsService());
  locator.registerLazySingleton(() => TaskBoardService());

  // Repositories
  locator.registerLazySingleton<TaskBoardRepo>(() => TaskBoardRepoImpl());
  locator.registerLazySingleton<ProjectsRepo>(() => ProjectsRepoImpl());

  // Overlays
  locator.registerLazySingleton(() => AppBottomSheetService());
  locator.registerLazySingleton(() => AppSnackbarService());
}
