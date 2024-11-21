// test/features/dashboard/modules/home/home_view_model_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_app/app/router/router_config.router.dart';
import 'package:kanban_app/features/dashboard/modules/home/home_view_model.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/enums/task_status.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/repository/models/task.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/repository/models/task_detail.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/task_board_service.dart';
import 'package:kanban_app/features/projects/projects_service.dart';
import 'package:kanban_app/features/projects/repository/models/project.dart';
import 'package:mockito/mockito.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../test_helpers.dart';

void main() {
  late HomeViewModel viewModel;
  late TaskBoardService mockTaskBoardService;
  late ProjectsService mockProjectsService;
  late NavigationService mockNavigationService;

  setUp(() {
    registerServices();
    mockTaskBoardService = getAndRegisterTaskBoardService();
    mockProjectsService = getAndRegisterProjectsService();
    mockNavigationService = getAndRegisterNavigationService();
    viewModel = HomeViewModel();
  });

  tearDown(() {
    unregisterServices();
  });

  group('HomeViewModel -', () {
    group('Tasks -', () {
      test('should return tasks from TaskBoardService', () {
        final mockTasks = [
          Task(id: '1', projectId: '1', content: 'Task 1', description: ''),
          Task(id: '2', projectId: '1', content: 'Task 2', description: '')
        ];
        when(mockTaskBoardService.tasks).thenReturn(mockTasks);

        expect(viewModel.tasks, equals(mockTasks));
        verify(mockTaskBoardService.tasks).called(1);
      });

      test('should fetch task detail from TaskBoardService', () {
        final mockTask = Task(id: '1', projectId: '1', content: 'Task 1', description: '');
        final mockDetail = TaskDetail(
          id: '1',
          projectId: '1',
          status: TaskStatus.open,
          durationInSeconds: 0,
          updatedAt: DateTime.now(),
        );

        when(mockTaskBoardService.getDetailFromTask(mockTask)).thenReturn(mockDetail);

        expect(viewModel.getDetailFromTask(mockTask), equals(mockDetail));
        verify(mockTaskBoardService.getDetailFromTask(mockTask)).called(1);
      });
    });

    group('Projects -', () {
      test('should return projects from ProjectsService', () {
        final mockProjects = [Project(id: '1', name: 'Project 1'), Project(id: '2', name: 'Project 2')];
        when(mockProjectsService.projects).thenReturn(mockProjects);

        expect(viewModel.projects, equals(mockProjects));
        verify(mockProjectsService.projects).called(1);
      });

      test('should return selected project from ProjectsService', () {
        final mockProject = Project(id: '1', name: 'Project 1');
        when(mockProjectsService.selectedProject).thenReturn(mockProject);

        expect(viewModel.selectedProject, equals(mockProject));
        verify(mockProjectsService.selectedProject).called(1);
      });
    });

    group('Loading States -', () {
      test('should reflect task loading state from TaskBoardService', () {
        when(mockTaskBoardService.isBusyFetchingTasks).thenReturn(true);
        expect(viewModel.isBusyFetchingTasks, isTrue);
      });

      test('should reflect project loading state from ProjectsService', () {
        when(mockProjectsService.isBusyFetchingProjects).thenReturn(true);
        expect(viewModel.isBusyFetchingProjects, isTrue);
      });
    });

    group('Navigation -', () {
      test('should navigate to projects view', () async {
        when(mockNavigationService.navigateTo(Routes.projectsView)).thenAnswer((_) async => null);
        when(mockProjectsService.selectedProject).thenReturn(null);

        await viewModel.navigateToProjectsView();

        verify(mockNavigationService.navigateTo(Routes.projectsView)).called(1);
      });
    });

    group('Task Operations -', () {
      test('should filter tasks by status', () {
        final mockTasks = [
          Task(id: '1', projectId: '1', content: 'Task 1', description: ''),
          Task(id: '2', projectId: '1', content: 'Task 2', description: '')
        ];

        final mockDetails = [
          TaskDetail(
            id: '1',
            projectId: '1',
            status: TaskStatus.done,
            durationInSeconds: 0,
            updatedAt: DateTime.now(),
          ),
          TaskDetail(
            id: '2',
            projectId: '1',
            status: TaskStatus.open,
            durationInSeconds: 0,
            updatedAt: DateTime.now(),
          )
        ];

        when(mockTaskBoardService.tasks).thenReturn(mockTasks);
        when(mockTaskBoardService.getDetailFromTask(mockTasks[0])).thenReturn(mockDetails[0]);
        when(mockTaskBoardService.getDetailFromTask(mockTasks[1])).thenReturn(mockDetails[1]);

        final doneTasks = viewModel.getTasksByStatus(TaskStatus.done);
        expect(doneTasks.length, 1);
        expect(doneTasks.first.id, '1');
      });
    });

    group('Initialization -', () {
      test('should fetch projects and tasks on init', () async {
        when(mockProjectsService.fetchProjects()).thenAnswer((_) async {});
        when(mockTaskBoardService.fetchTasks()).thenAnswer((_) async {});
        when(mockProjectsService.projects).thenReturn([]);

        await viewModel.initialise();

        verify(mockProjectsService.fetchProjects()).called(1);
        verify(mockTaskBoardService.fetchTasks()).called(1);
      });
    });

    group('Listenable Services -', () {
      test('should listen to both TaskBoard and Projects services', () {
        expect(viewModel.listenableServices, contains(mockTaskBoardService));
        expect(viewModel.listenableServices, contains(mockProjectsService));
      });
    });
  });
}
