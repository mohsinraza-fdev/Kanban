import 'package:json_annotation/json_annotation.dart';
import 'package:kanban_app/database/hive_model.dart';
import 'package:kanban_app/features/dashboard/modules/task_board/enums/task_status.dart';
part 'task_detail.g.dart';

@JsonSerializable(explicitToJson: true)
class TaskDetail extends HiveModel<String> {
  final String id;
  final String projectId;
  final TaskStatus status;
  final int durationInSeconds;
  final DateTime updatedAt;
  final DateTime? dueAt;
  final DateTime? completedAt;

  TaskDetail({
    required this.id,
    required this.projectId,
    required this.status,
    required this.durationInSeconds,
    required this.updatedAt,
    this.dueAt,
    this.completedAt,
  });

  @override
  String get primaryKey => id;

  factory TaskDetail.fromJson(Map<String, dynamic> json) => _$TaskDetailFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TaskDetailToJson(this);
}
