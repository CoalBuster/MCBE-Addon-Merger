import 'package:json_annotation/json_annotation.dart';

import 'component/component.dart';
import 'component/components.dart';

part 'server_entity.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ServerEntity {
  final Map<String, dynamic>? componentGroups;
  @JsonKey(fromJson: Components.fromJson, toJson: Components.toJson)
  final Map<String, Component> components;
  final ServerEntityDescription description;

  ServerEntity({
    required this.componentGroups,
    required this.components,
    required this.description,
  });

  factory ServerEntity.fromJson(Map<String, dynamic> json) =>
      _$ServerEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ServerEntityToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ServerEntityDescription {
  Map<String, String>? animations;
  String identifier;
  bool? isSpawnable;
  bool? isSummonable;
  bool? isExperimental;
  ServerEntityScripts? scripts;

  ServerEntityDescription({
    required this.identifier,
    this.animations,
    this.isExperimental,
    this.isSpawnable,
    this.isSummonable,
    this.scripts,
  });

  factory ServerEntityDescription.fromJson(Map<String, dynamic> json) =>
      _$ServerEntityDescriptionFromJson(json);

  Map<String, dynamic> toJson() => _$ServerEntityDescriptionToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ServerEntityScripts {
  final List<String>? animate;

  ServerEntityScripts({
    this.animate,
  });

  factory ServerEntityScripts.fromJson(Map<String, dynamic> json) =>
      _$ServerEntityScriptsFromJson(json);

  Map<String, dynamic> toJson() => _$ServerEntityScriptsToJson(this);
}
