import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kanban_app/app/service_locator.dart';
import 'package:kanban_app/database/hive_service.dart';
import 'package:kanban_app/features/dashboard/modules/home/home_view_model.dart';
import 'package:kanban_app/features/dashboard/modules/settings/settings_view_model.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/repository/task_board_repo.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/task_board_service.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/task_board_view_model.dart';
import 'package:kanban_app/features/dashboard/modules/time_tracker/time_tracker_view_model.dart';
import 'package:kanban_app/features/projects/projects_service.dart';
import 'package:kanban_app/features/projects/repository/projects_repo.dart';
import 'package:kanban_app/network/api_client_kanban.dart';
import 'package:kanban_app/services/preference_service.dart';
import 'package:kanban_app/shared/overlays/bottom_sheets/app_bottom_sheet_service.dart';
import 'package:kanban_app/shared/overlays/snackbars/app_snackbar_service.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stacked_themes/stacked_themes.dart';

import 'test_helpers.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<BuildContext>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<SharedPreferences>(onMissingStub: OnMissingStub.returnDefault),

  // Services
  MockSpec<ApiClientKanban>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<PreferenceService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<NavigationService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<ThemeService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<HiveService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<ProjectsService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<TaskBoardService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<AppBottomSheetService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<AppSnackbarService>(onMissingStub: OnMissingStub.returnDefault),

  // ViewModels
  MockSpec<HomeViewModel>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<TaskBoardViewModel>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<TimeTrackerViewModel>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<SettingsViewModel>(onMissingStub: OnMissingStub.returnDefault),

  // Repositories
  MockSpec<TaskBoardRepo>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<ProjectsRepo>(onMissingStub: OnMissingStub.returnDefault),

  // Core
  MockSpec<Dio>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<Box>(onMissingStub: OnMissingStub.returnDefault),

  // Controllers
  MockSpec<TextEditingController>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<FocusNode>(onMissingStub: OnMissingStub.returnDefault),
])
class TestMockGenerateables {}

// Service registration helpers
ApiClientKanban getAndRegisterApiClientKanban() {
  _removeRegistrationIfExists<ApiClientKanban>();
  final service = MockApiClientKanban();
  locator.registerSingleton<ApiClientKanban>(service);
  return service;
}

PreferenceService getAndRegisterPreferenceService() {
  _removeRegistrationIfExists<PreferenceService>();
  final service = MockPreferenceService();
  locator.registerSingleton<PreferenceService>(service);
  return service;
}

NavigationService getAndRegisterNavigationService() {
  _removeRegistrationIfExists<NavigationService>();
  final service = MockNavigationService();
  locator.registerSingleton<NavigationService>(service);
  return service;
}

ThemeService getAndRegisterThemeService() {
  _removeRegistrationIfExists<ThemeService>();
  final service = MockThemeService();
  locator.registerSingleton<ThemeService>(service);
  return service;
}

HiveService getAndRegisterHiveService() {
  _removeRegistrationIfExists<HiveService>();
  final service = MockHiveService();
  locator.registerSingleton<HiveService>(service);
  return service;
}

ProjectsService getAndRegisterProjectsService() {
  _removeRegistrationIfExists<ProjectsService>();
  final service = MockProjectsService();
  locator.registerSingleton<ProjectsService>(service);
  return service;
}

TaskBoardService getAndRegisterTaskBoardService() {
  _removeRegistrationIfExists<TaskBoardService>();
  final service = MockTaskBoardService();
  locator.registerSingleton<TaskBoardService>(service);
  return service;
}

AppBottomSheetService getAndRegisterBottomSheetService() {
  _removeRegistrationIfExists<AppBottomSheetService>();
  final service = MockAppBottomSheetService();
  locator.registerSingleton<AppBottomSheetService>(service);
  return service;
}

AppSnackbarService getAndRegisterSnackbarService() {
  _removeRegistrationIfExists<AppSnackbarService>();
  final service = MockAppSnackbarService();
  locator.registerSingleton<AppSnackbarService>(service);
  return service;
}

HomeViewModel getAndRegisterHomeViewModel() {
  _removeRegistrationIfExists<HomeViewModel>();
  final viewModel = MockHomeViewModel();
  locator.registerSingleton<HomeViewModel>(viewModel);
  return viewModel;
}

TaskBoardViewModel getAndRegisterTaskBoardViewModel() {
  _removeRegistrationIfExists<TaskBoardViewModel>();
  final viewModel = MockTaskBoardViewModel();
  locator.registerSingleton<TaskBoardViewModel>(viewModel);
  return viewModel;
}

TimeTrackerViewModel getAndRegisterTimeTrackerViewModel() {
  _removeRegistrationIfExists<TimeTrackerViewModel>();
  final viewModel = MockTimeTrackerViewModel();
  locator.registerSingleton<TimeTrackerViewModel>(viewModel);
  return viewModel;
}

SettingsViewModel getAndRegisterSettingsViewModel() {
  _removeRegistrationIfExists<SettingsViewModel>();
  final viewModel = MockSettingsViewModel();
  locator.registerSingleton<SettingsViewModel>(viewModel);
  return viewModel;
}

void registerServices() {
  getAndRegisterApiClientKanban();
  getAndRegisterPreferenceService();
  getAndRegisterNavigationService();
  getAndRegisterThemeService();
  getAndRegisterHiveService();
  getAndRegisterProjectsService();
  getAndRegisterTaskBoardService();
  getAndRegisterBottomSheetService();
  getAndRegisterSnackbarService();
  getAndRegisterHomeViewModel();
  getAndRegisterTaskBoardViewModel();
  getAndRegisterTimeTrackerViewModel();
  getAndRegisterSettingsViewModel();
}

void unregisterServices() {
  locator.unregister<ApiClientKanban>();
  locator.unregister<PreferenceService>();
  locator.unregister<NavigationService>();
  locator.unregister<ThemeService>();
  locator.unregister<HiveService>();
  locator.unregister<ProjectsService>();
  locator.unregister<TaskBoardService>();
  locator.unregister<AppBottomSheetService>();
  locator.unregister<AppSnackbarService>();
  locator.unregister<HomeViewModel>();
  locator.unregister<TaskBoardViewModel>();
  locator.unregister<TimeTrackerViewModel>();
  locator.unregister<SettingsViewModel>();
}

void _removeRegistrationIfExists<T extends Object>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}
