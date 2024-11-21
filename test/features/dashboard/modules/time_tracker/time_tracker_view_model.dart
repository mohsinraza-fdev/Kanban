// test/features/dashboard/modules/time_tracker/time_tracker_view_model_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/enums/task_status.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/repository/models/task.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/repository/models/task_detail.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/task_board_service.dart';
import 'package:kanban_app/features/dashboard/modules/time_tracker/time_tracker_view_model.dart';
import 'package:kanban_app/shared/overlays/bottom_sheets/app_bottom_sheet_service.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter/material.dart';

import '../../../../test_helpers.dart';
import '../../../../test_helpers.mocks.dart';

void main() {
  late TimeTrackerViewModel viewModel;
  late TaskBoardService mockTaskBoardService;
  late AppBottomSheetService mockBottomSheetService;
  late BuildContext mockContext;

  setUp(() {
    registerServices();
    mockTaskBoardService = getAndRegisterTaskBoardService();
    mockBottomSheetService = getAndRegisterBottomSheetService();
    viewModel = TimeTrackerViewModel();
    mockContext = MockBuildContext();
    viewModel.setViewModelContext(mockContext);
  });

  tearDown(() {
    unregisterServices();
  });

  group('TimeTrackerViewModel -', () {
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

      test('should return tracked tasks correctly', () {
        final mockTasks = [
          Task(id: '1', projectId: '1', content: 'Task 1', description: ''),
          Task(id: '2', projectId: '1', content: 'Task 2', description: '')
        ];

        final mockDetails = [
          TaskDetail(
              id: '1', projectId: '1', status: TaskStatus.open, durationInSeconds: 100, updatedAt: DateTime.now()),
          TaskDetail(id: '2', projectId: '1', status: TaskStatus.open, durationInSeconds: 0, updatedAt: DateTime.now())
        ];

        when(mockTaskBoardService.tasks).thenReturn(mockTasks);
        when(mockTaskBoardService.getDetailFromTask(mockTasks[0])).thenReturn(mockDetails[0]);
        when(mockTaskBoardService.getDetailFromTask(mockTasks[1])).thenReturn(mockDetails[1]);

        final trackedTasks = viewModel.trackedTasks;
        expect(trackedTasks.length, 1);
        expect(trackedTasks.first.id, '1');
      });

      test('should get task detail from TaskBoardService', () {
        final mockTask = Task(id: '1', projectId: '1', content: 'Task 1', description: '');
        final mockDetail = TaskDetail(
            id: '1', projectId: '1', status: TaskStatus.open, durationInSeconds: 0, updatedAt: DateTime.now());

        when(mockTaskBoardService.getDetailFromTask(mockTask)).thenReturn(mockDetail);

        expect(viewModel.getDetailFromTask(mockTask), equals(mockDetail));
      });
    });

    group('Task Selection -', () {
      test('should show task selection bottom sheet', () async {
        final selectedTask = Task(id: '1', projectId: '1', content: 'Task 1', description: '');
        when(mockBottomSheetService.showSelectTaskBottomSheet(mockContext)).thenAnswer((_) async => selectedTask);

        await viewModel.selectTask();

        verify(mockBottomSheetService.showSelectTaskBottomSheet(mockContext)).called(1);
        expect(viewModel.selectedTask, equals(selectedTask));
      });
    });

    group('Time Tracking -', () {
      test('should initialize with zero seconds recorded', () {
        expect(viewModel.secondsRecorded, equals(0));
        expect(viewModel.tracking, isFalse);
      });

      test('should format total time correctly for new task', () {
        expect(viewModel.totalFormattedTime, equals('00:00:00'));
      });

      test('should format total time correctly with existing duration', () {
        final mockTask = Task(id: '1', projectId: '1', content: 'Task 1', description: '');
        final mockDetail = TaskDetail(
            id: '1',
            projectId: '1',
            status: TaskStatus.open,
            durationInSeconds: 3665, // 1 hour, 1 minute, 5 seconds
            updatedAt: DateTime.now());

        viewModel.selectedTask = mockTask;
        when(mockTaskBoardService.getDetailFromTask(mockTask)).thenReturn(mockDetail);

        expect(viewModel.totalFormattedTime, equals('01:01:05'));
      });

      test('should not start tracking without selected task', () {
        viewModel.selectedTask = null;
        viewModel.startTracking();

        expect(viewModel.tracking, isFalse);
        expect(viewModel.secondsRecorded, equals(0));
      });

      test('should not start tracking with existing seconds recorded', () {
        final mockTask = Task(id: '1', projectId: '1', content: 'Task 1', description: '');
        viewModel.selectedTask = mockTask;
        viewModel.secondsRecorded = 10;

        viewModel.startTracking();

        expect(viewModel.tracking, isFalse);
      });

      test('should update duration on stop tracking', () async {
        final mockTask = Task(id: '1', projectId: '1', content: 'Task 1', description: '');
        final mockDetail = TaskDetail(
            id: '1', projectId: '1', status: TaskStatus.open, durationInSeconds: 100, updatedAt: DateTime.now());

        viewModel.selectedTask = mockTask;
        viewModel.secondsRecorded = 50;
        when(mockTaskBoardService.getDetailFromTask(mockTask)).thenReturn(mockDetail);
        when(mockTaskBoardService.updateTaskDuration(task: mockTask, duration: 150)).thenAnswer((_) async {});

        await viewModel.stopTracking();

        verify(mockTaskBoardService.updateTaskDuration(task: mockTask, duration: 150)).called(1);
        expect(viewModel.secondsRecorded, equals(0));
        expect(viewModel.tracking, isFalse);
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
