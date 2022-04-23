import 'package:json_annotation/json_annotation.dart';

import 'minecraft/animation_controller.dart';
import 'minecraft/server_entity.dart';
import 'version.dart';

part 'pack_element.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PackElement {
  final Map<String, MinecraftAnimationController>? animationControllers;
  @JsonKey(fromJson: Version.fromText, toJson: Version.toText)
  final Version formatVersion;
  @JsonKey(name: 'minecraft:entity')
  final MinecraftServerEntity? entity;

  PackElement({
    required this.formatVersion,
    this.animationControllers,
    this.entity,
  });

  factory PackElement.fromJson(Map<String, dynamic> json) =>
      _$PackElementFromJson(json);

  Map<String, dynamic> toJson() => _$PackElementToJson(this);
}
