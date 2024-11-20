// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskComment _$TaskCommentFromJson(Map<String, dynamic> json) => TaskComment(
      id: json['id'] as String,
      taskId: json['task_id'] as String,
      projectId: json['project_id'] as String,
      postedAt: DateTime.parse(json['posted_at'] as String),
    );

Map<String, dynamic> _$TaskCommentToJson(TaskComment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'task_id': instance.taskId,
      'project_id': instance.projectId,
      'posted_at': instance.postedAt.toIso8601String(),
    };
