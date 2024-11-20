import 'package:json_annotation/json_annotation.dart';

enum TaskStatus {
  @JsonValue('OPEN')
  open('Open'),

  @JsonValue('IN_PROGRESS')
  inProgress('In Progress'),

  @JsonValue('DONE')
  done('Done');

  final String name;
  const TaskStatus(this.name);
}
