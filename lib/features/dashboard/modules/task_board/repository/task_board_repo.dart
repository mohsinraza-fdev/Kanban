import 'package:dio/dio.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/repository/models/task.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/repository/models/task_comment.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/repository/models/task_detail.dart';

abstract class TaskBoardRepo {
  // Task
  Future<List<Task>> fetchTasks({
    required String projectId,
    CancelToken? cancelToken,
  });

  Future<Task> createTask({
    required String projectId,
    required String content,
    String? description,
    CancelToken? cancelToken,
  });

  Future<Task> updateTask({
    required String id,
    required String content,
    String? description,
    CancelToken? cancelToken,
  });

  Future<bool> deleteTask({
    required String taskId,
    CancelToken? cancelToken,
  });

  // Task Comments
  Future<List<TaskComment>> fetchComments({
    required String taskId,
    required String projectId,
    CancelToken? cancelToken,
  });

  Future<TaskComment> createComment({
    required String taskId,
    required String projectId,
    required String content,
    CancelToken? cancelToken,
  });

  // Task Detail
  Future<List<TaskDetail>> getAllTaskDetails();

  Future<TaskDetail> saveTaskDetails(TaskDetail taskDetail);

  Future<bool> deleteTaskDetails(String id);
}
