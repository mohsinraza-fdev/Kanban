import 'package:dio/dio.dart';
import 'package:kanban_app/features/projects/repository/models/project.dart';

abstract class ProjectsRepo {
  Future<List<Project>> fetchProjects({
    CancelToken? cancelToken,
  });

  Future<Project> createProject({
    required String name,
    CancelToken? cancelToken,
  });

  Future<Project> updateProject({
    required String id,
    required String name,
    CancelToken? cancelToken,
  });

  Future<bool> deleteProject({
    required String id,
    CancelToken? cancelToken,
  });
}
