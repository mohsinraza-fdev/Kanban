// test/features/projects/projects_view_model_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_app/features/projects/projects_service.dart';
import 'package:kanban_app/features/projects/projects_view_model.dart';
import 'package:kanban_app/features/projects/repository/models/project.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter/material.dart';

import '../../test_helpers.dart';
import '../../test_helpers.mocks.dart';

void main() {
  late ProjectsViewModel viewModel;
  late ProjectsService mockProjectsService;
  late BuildContext mockContext;

  setUp(() {
    registerServices();
    mockProjectsService = getAndRegisterProjectsService();
    viewModel = ProjectsViewModel();
    mockContext = MockBuildContext();
    viewModel.setViewModelContext(mockContext);
  });

  tearDown(() {
    unregisterServices();
  });

  group('ProjectsViewModel -', () {
    group('Projects -', () {
      test('should return projects from ProjectsService', () {
        final mockProjects = [
          Project(id: '1', name: 'Project 1'),
          Project(id: '2', name: 'Project 2'),
        ];
        when(mockProjectsService.projects).thenReturn(mockProjects);

        expect(viewModel.projects, equals(mockProjects));
        verify(mockProjectsService.projects).called(1);
      });

      test('should return selectedProject from ProjectsService', () {
        final mockProject = Project(id: '1', name: 'Project 1');
        when(mockProjectsService.selectedProject).thenReturn(mockProject);

        expect(viewModel.selectedProject, equals(mockProject));
        verify(mockProjectsService.selectedProject).called(1);
      });
    });

    group('Loading States -', () {
      test('should reflect project loading state from ProjectsService', () {
        when(mockProjectsService.isBusyFetchingProjects).thenReturn(true);
        expect(viewModel.isBusyFetchingProjects, isTrue);
      });

      test('should reflect failed projects state from ProjectsService', () {
        when(mockProjectsService.failedFetchingProjects).thenReturn(true);
        expect(viewModel.failedFetchingProjects, isTrue);
      });
    });

    group('Project Operations -', () {
      test('should select project through ProjectsService', () {
        final mockProject = Project(id: '1', name: 'Project 1');
        viewModel.selectProject(mockProject);
        verify(mockProjectsService.selectProject(mockProject)).called(1);
      });
    });

    group('Initialization -', () {
      test('should fetch projects on init', () async {
        when(mockProjectsService.fetchProjects()).thenAnswer((_) async {});

        await viewModel.initialise();

        verify(mockProjectsService.fetchProjects()).called(1);
      });
    });

    group('Listenable Services -', () {
      test('should listen to Projects service', () {
        expect(viewModel.listenableServices, contains(mockProjectsService));
      });
    });
  });
}
