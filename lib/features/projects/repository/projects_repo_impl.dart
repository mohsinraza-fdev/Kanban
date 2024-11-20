import 'package:dio/src/cancel_token.dart';
import 'package:kanban_app/app/service_locator.dart';
import 'package:kanban_app/features/projects/repository/models/project.dart';
import 'package:kanban_app/features/projects/repository/projects_repo.dart';
import 'package:kanban_app/network/api_client_kanban.dart';
import 'package:kanban_app/network/client/client_utils.dart';
import 'package:kanban_app/network/endpoints_kanban.dart';

class ProjectsRepoImpl implements ProjectsRepo {
  final _client = locator<ApiClientKanban>();

  @override
  Future<List<Project>> fetchProjects({CancelToken? cancelToken}) async {
    try {
      List resp = await _client.get<List>(
        EndpointsKanban.projects,
        cancelToken: cancelToken,
      );
      return parseModel<List<Project>>(() => resp.map((e) => Project.fromJson(e)).toList());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Project> createProject({required String name, CancelToken? cancelToken}) async {
    try {
      Map<String, dynamic> resp = await _client.post<Map<String, dynamic>>(
        EndpointsKanban.projects,
        data: {
          "name": name,
        },
        cancelToken: cancelToken,
      );
      return parseModel<Project>(() => Project.fromJson(resp));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Project> updateProject({
    required String id,
    required String name,
    CancelToken? cancelToken,
  }) async {
    try {
      Map<String, dynamic> resp = await _client.post<Map<String, dynamic>>(
        '${EndpointsKanban.projects}/$id',
        data: {
          "name": name,
        },
        cancelToken: cancelToken,
      );
      return parseModel<Project>(() => Project.fromJson(resp));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> deleteProject({required String id, CancelToken? cancelToken}) async {
    try {
      await _client.delete<String>(
        '${EndpointsKanban.projects}/$id',
        cancelToken: cancelToken,
      );
      return true;
    } catch (e) {
      rethrow;
    }
  }
}
