import 'package:json_annotation/json_annotation.dart';

part 'server_entity.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MinecraftServerEntity {
  final MinecraftServerEntityDescription description;

  MinecraftServerEntity({
    required this.description,
  });

  factory MinecraftServerEntity.fromJson(Map<String, dynamic> json) =>
      _$MinecraftServerEntityFromJson(json);

  Map<String, dynamic> toJson() => _$MinecraftServerEntityToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class MinecraftServerEntityDescription {
  Map<String, String>? animations;
  String identifier;
  bool? isSpawnable;
  bool? isSummonable;
  bool? isExperimental;
  MinecraftServerEntityScripts? scripts;

  MinecraftServerEntityDescription({
    required this.identifier,
    this.animations,
    this.isExperimental,
    this.isSpawnable,
    this.isSummonable,
    this.scripts,
  });

  factory MinecraftServerEntityDescription.fromJson(
          Map<String, dynamic> json) =>
      _$MinecraftServerEntityDescriptionFromJson(json);

  Map<String, dynamic> toJson() =>
      _$MinecraftServerEntityDescriptionToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class MinecraftServerEntityScripts {
  final List<String>? animate;

  MinecraftServerEntityScripts({
    this.animate,
  });

  factory MinecraftServerEntityScripts.fromJson(Map<String, dynamic> json) =>
      _$MinecraftServerEntityScriptsFromJson(json);

  Map<String, dynamic> toJson() => _$MinecraftServerEntityScriptsToJson(this);
}
