// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskDetail _$TaskDetailFromJson(Map<String, dynamic> json) => TaskDetail(
      id: json['id'] as String,
      projectId: json['projectId'] as String,
      status: $enumDecode(_$TaskStatusEnumMap, json['status']),
      durationInSeconds: (json['durationInSeconds'] as num).toInt(),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      dueAt: json['dueAt'] == null
          ? null
          : DateTime.parse(json['dueAt'] as String),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
    );

Map<String, dynamic> _$TaskDetailToJson(TaskDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'projectId': instance.projectId,
      'status': _$TaskStatusEnumMap[instance.status]!,
      'durationInSeconds': instance.durationInSeconds,
      'updatedAt': instance.updatedAt.toIso8601String(),
      'dueAt': instance.dueAt?.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
    };

const _$TaskStatusEnumMap = {
  TaskStatus.open: 'OPEN',
  TaskStatus.inProgress: 'IN_PROGRESS',
  TaskStatus.done: 'DONE',
};
