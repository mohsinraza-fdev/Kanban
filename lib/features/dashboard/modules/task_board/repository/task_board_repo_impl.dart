import 'package:dio/src/cancel_token.dart';
import 'package:kanban_app/app/service_locator.dart';
import 'package:kanban_app/database/hive_service.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/repository/models/task.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/repository/models/task_comment.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/repository/models/task_detail.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/repository/task_board_repo.dart';
import 'package:kanban_app/network/api_client_kanban.dart';
import 'package:kanban_app/network/client/client_utils.dart';
import 'package:kanban_app/network/endpoints_kanban.dart';

class TaskBoardRepoImpl implements TaskBoardRepo {
  final _client = locator<ApiClientKanban>();
  final _hiveService = locator<HiveService>();

  // Tasks
  @override
  Future<List<Task>> fetchTasks({
    required String projectId,
    CancelToken? cancelToken,
  }) async {
    try {
      List resp = await _client.get<List>(
        '${EndpointsKanban.tasks}?project_id=$projectId',
        cancelToken: cancelToken,
      );
      return parseModel<List<Task>>(() => resp.map((e) => Task.fromJson(e)).toList());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Task> createTask({
    required String projectId,
    required String content,
    String? description,
    CancelToken? cancelToken,
  }) async {
    try {
      Map<String, dynamic> resp = await _client.post<Map<String, dynamic>>(
        EndpointsKanban.tasks,
        data: {
          "project_id": projectId,
          "content": content,
          "description": description ?? '',
        },
        cancelToken: cancelToken,
      );
      return parseModel<Task>(() => Task.fromJson(resp));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Task> updateTask({
    required String id,
    required String content,
    String? description,
    CancelToken? cancelToken,
  }) async {
    try {
      Map<String, dynamic> resp = await _client.post<Map<String, dynamic>>(
        '${EndpointsKanban.tasks}/$id',
        data: {
          "content": content,
          "description": description ?? '',
        },
        cancelToken: cancelToken,
      );
      return parseModel<Task>(() => Task.fromJson(resp));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> deleteTask({
    required String taskId,
    CancelToken? cancelToken,
  }) async {
    try {
      await _client.delete<String>(
        '${EndpointsKanban.tasks}/$taskId',
        cancelToken: cancelToken,
      );
      return true;
    } catch (e) {
      rethrow;
    }
  }

  // Task Comments
  @override
  Future<List<TaskComment>> fetchComments({
    required String taskId,
    required String projectId,
    CancelToken? cancelToken,
  }) async {
    try {
      List resp = await _client.get<List>(
        '${EndpointsKanban.comments}?task_id=$taskId&project_id=$projectId',
        cancelToken: cancelToken,
      );
      return parseModel<List<TaskComment>>(() => resp.map((e) => TaskComment.fromJson(e)).toList());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<TaskComment> createComment({
    required String taskId,
    required String projectId,
    required String content,
    CancelToken? cancelToken,
  }) async {
    try {
      Map<String, dynamic> resp = await _client.post<Map<String, dynamic>>(
        EndpointsKanban.comments,
        data: {
          "task_id": taskId,
          "project_id": projectId,
          "content": content,
        },
        cancelToken: cancelToken,
      );
      return parseModel<TaskComment>(() => TaskComment.fromJson(resp));
    } catch (e) {
      rethrow;
    }
  }

  // Task Detail
  @override
  Future<List<TaskDetail>> getAllTaskDetails() async {
    try {
      return await _hiveService.getAll(TaskDetail.fromJson);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<TaskDetail> saveTaskDetails(TaskDetail taskDetail) async {
    try {
      return await _hiveService.save(taskDetail);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> deleteTaskDetails(String id) async {
    try {
      return await _hiveService.delete<TaskDetail>(id);
    } catch (e) {
      rethrow;
    }
  }
}
