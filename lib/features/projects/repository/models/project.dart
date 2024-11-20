import 'package:json_annotation/json_annotation.dart';
part 'project.g.dart';

@JsonSerializable(explicitToJson: true)
class Project {
  final String id;
  final String name;

  Project({
    required this.id,
    required this.name,
  });

  factory Project.fromJson(Map<String, dynamic> json) => _$ProjectFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectToJson(this);
}
