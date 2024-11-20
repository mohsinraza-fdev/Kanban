// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskComment _$TaskCommentFromJson(Map<String, dynamic> json) => TaskComment(
      id: json['id'] as String,
      taskId: json['task_id'] as String,
      content: json['content'] as String,
      postedAt: DateTime.parse(json['posted_at'] as String),
    );

Map<String, dynamic> _$TaskCommentToJson(TaskComment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'task_id': instance.taskId,
      'content': instance.content,
      'posted_at': instance.postedAt.toIso8601String(),
    };
