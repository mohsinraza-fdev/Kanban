import 'package:json_annotation/json_annotation.dart';
part 'task_comment.g.dart';

@JsonSerializable(explicitToJson: true)
class TaskComment {
  final String id;

  @JsonKey(name: 'task_id')
  final String taskId;

  @JsonKey(name: 'project_id')
  final String projectId;

  @JsonKey(name: 'posted_at')
  final DateTime postedAt;

  TaskComment({
    required this.id,
    required this.taskId,
    required this.projectId,
    required this.postedAt,
  });

  factory TaskComment.fromJson(Map<String, dynamic> json) => _$TaskCommentFromJson(json);

  Map<String, dynamic> toJson() => _$TaskCommentToJson(this);
}
