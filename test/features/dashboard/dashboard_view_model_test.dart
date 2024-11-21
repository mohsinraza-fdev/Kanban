// test/features/dashboard/dashboard_view_model_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_app/features/dashboard/dashboard_view_model.dart';
import 'package:kanban_app/features/projects/projects_service.dart';
import 'package:kanban_app/features/projects/repository/models/project.dart';
import 'package:mockito/mockito.dart';

import '../../test_helpers.dart';

void main() {
  late DashboardViewModel viewModel;
  late ProjectsService mockProjectsService;

  setUp(() {
    registerServices();
    mockProjectsService = getAndRegisterProjectsService();
    viewModel = DashboardViewModel();
  });

  tearDown(() {
    unregisterServices();
  });

  group('DashboardViewModel -', () {
    group('selectedProject -', () {
      test('should return project from ProjectsService', () {
        final mockProject = Project(id: '1', name: 'Test Project');
        when(mockProjectsService.selectedProject).thenReturn(mockProject);

        expect(viewModel.selectedProject, equals(mockProject));
        verify(mockProjectsService.selectedProject).called(1);
      });

      test('should return null when no project is selected', () {
        when(mockProjectsService.selectedProject).thenReturn(null);

        expect(viewModel.selectedProject, isNull);
        verify(mockProjectsService.selectedProject).called(1);
      });
    });

    group('Navigation Index -', () {
      test('should initialize with index 0', () {
        expect(viewModel.selectedIndex, equals(0));
      });

      test('should update selected index', () {
        viewModel.setIndex(2);

        expect(viewModel.selectedIndex, equals(2));
      });

      test('should notify listeners when index changes', () {
        var notified = false;
        viewModel.addListener(() => notified = true);

        viewModel.setIndex(1);

        expect(notified, isTrue);
        expect(viewModel.selectedIndex, equals(1));
      });

      test('should not notify listeners when same index is set', () {
        viewModel.setIndex(0);

        var notified = false;
        viewModel.addListener(() => notified = true);

        viewModel.setIndex(0);

        expect(notified, isFalse);
        expect(viewModel.selectedIndex, equals(0));
      });
    });

    group('Reactive Services -', () {
      test('should include ProjectsService in listenable services', () {
        expect(viewModel.listenableServices, contains(mockProjectsService));
      });
    });
  });
}
