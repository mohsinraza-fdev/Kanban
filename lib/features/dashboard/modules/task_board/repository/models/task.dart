import 'package:json_annotation/json_annotation.dart';
part 'task.g.dart';

@JsonSerializable(explicitToJson: true)
class Task {
  final String id;
  final String projectId;
  final String content;
  final String description;

  Task({
    required this.id,
    required this.projectId,
    required this.content,
    required this.description,
  });

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);
}
