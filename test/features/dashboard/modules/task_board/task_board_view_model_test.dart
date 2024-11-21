// test/features/dashboard/modules/task_board/task_board_view_model_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/enums/task_status.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/repository/models/task.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/repository/models/task_detail.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/task_board_service.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/task_board_view_model.dart';
import 'package:kanban_app/shared/overlays/bottom_sheets/app_bottom_sheet_service.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter/material.dart';

import '../../../../test_helpers.dart';
import '../../../../test_helpers.mocks.dart';

void main() {
  late TaskBoardViewModel viewModel;
  late TaskBoardService mockTaskBoardService;
  late AppBottomSheetService mockBottomSheetService;
  late BuildContext mockContext;

  setUp(() {
    registerServices();
    mockTaskBoardService = getAndRegisterTaskBoardService();
    mockBottomSheetService = getAndRegisterBottomSheetService();
    viewModel = TaskBoardViewModel();
    mockContext = MockBuildContext();
    viewModel.setViewModelContext(mockContext);
  });

  tearDown(() {
    unregisterServices();
  });

  group('TaskBoardViewModel -', () {
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

      test('should get task detail from TaskBoardService', () {
        final mockTask = Task(id: '1', projectId: '1', content: 'Task 1', description: '');
        final mockDetail = TaskDetail(
            id: '1', projectId: '1', status: TaskStatus.open, durationInSeconds: 0, updatedAt: DateTime.now());

        when(mockTaskBoardService.getDetailFromTask(mockTask)).thenReturn(mockDetail);

        expect(viewModel.getDetailFromTask(mockTask), equals(mockDetail));
        verify(mockTaskBoardService.getDetailFromTask(mockTask)).called(1);
      });

      test('should filter tasks by status', () {
        final mockTasks = [
          Task(id: '1', projectId: '1', content: 'Task 1', description: ''),
          Task(id: '2', projectId: '1', content: 'Task 2', description: '')
        ];

        final mockDetails = [
          TaskDetail(id: '1', projectId: '1', status: TaskStatus.done, durationInSeconds: 0, updatedAt: DateTime.now()),
          TaskDetail(id: '2', projectId: '1', status: TaskStatus.open, durationInSeconds: 0, updatedAt: DateTime.now())
        ];

        when(mockTaskBoardService.tasks).thenReturn(mockTasks);
        when(mockTaskBoardService.getDetailFromTask(mockTasks[0])).thenReturn(mockDetails[0]);
        when(mockTaskBoardService.getDetailFromTask(mockTasks[1])).thenReturn(mockDetails[1]);

        final openTasks = viewModel.getTasksFromStatus(TaskStatus.open);
        expect(openTasks.length, 1);
        expect(openTasks.first.id, '2');
      });
    });

    group('Loading States -', () {
      test('should reflect task loading state from TaskBoardService', () {
        when(mockTaskBoardService.isBusyFetchingTasks).thenReturn(true);
        expect(viewModel.isBusyFetchingTasks, isTrue);
      });
    });

    group('Task Operations -', () {
      test('should show create task bottom sheet', () {
        viewModel.createTask();
        verify(mockBottomSheetService.showModifyTaskBottomSheet(mockContext)).called(1);
      });

      test('should show update task bottom sheet', () {
        final mockTask = Task(id: '1', projectId: '1', content: 'Task 1', description: '');

        viewModel.updateTask(mockTask);
        verify(mockBottomSheetService.showModifyTaskBottomSheet(mockContext, task: mockTask)).called(1);
      });

      test('should show status selection bottom sheet', () async {
        final mockTask = Task(id: '1', projectId: '1', content: 'Task 1', description: '');
        final mockDetail = TaskDetail(
            id: '1', projectId: '1', status: TaskStatus.open, durationInSeconds: 0, updatedAt: DateTime.now());

        when(mockTaskBoardService.getDetailFromTask(mockTask)).thenReturn(mockDetail);
        when(mockBottomSheetService.showSelectTaskStatusBottomSheet(mockContext,
                task: mockTask, status: TaskStatus.open))
            .thenAnswer((_) async => null);

        await viewModel.updateTaskStatus(mockTask);

        verify(mockBottomSheetService.showSelectTaskStatusBottomSheet(mockContext,
                task: mockTask, status: TaskStatus.open))
            .called(1);
      });
    });

    group('Initialization -', () {
      test('should fetch tasks on init', () async {
        when(mockTaskBoardService.fetchTasks()).thenAnswer((_) async {});

        await viewModel.initialise();

        verify(mockTaskBoardService.fetchTasks()).called(1);
      });
    });

    group('Listenable Services -', () {
      test('should listen to TaskBoard service', () {
        expect(viewModel.listenableServices, contains(mockTaskBoardService));
      });
    });
  });
}
