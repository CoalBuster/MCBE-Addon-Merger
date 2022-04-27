import 'package:json_annotation/json_annotation.dart';

import 'minecraft/animation_controller.dart';
import 'minecraft/item.dart';
import 'minecraft/server_entity.dart';
import 'pack_element_type.dart';
import 'version.dart';

part 'pack_element.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PackElement {
  final Map<String, MinecraftAnimationController>? animationControllers;
  @JsonKey(fromJson: Version.fromText, toJson: Version.toText)
  final Version formatVersion;
  @JsonKey(name: 'minecraft:entity')
  final MinecraftServerEntity? entity;
  @JsonKey(name: 'minecraft:item')
  final MinecraftItem? item;

  PackElement({
    required this.formatVersion,
    this.animationControllers,
    this.entity,
    this.item,
  });

  factory PackElement.fromJson(Map<String, dynamic> json) =>
      _$PackElementFromJson(json);

  Map<String, dynamic> toJson() => _$PackElementToJson(this);

  PackElementType? get type {
    if (animationControllers != null) {
      return PackElementType.animationController;
    }

    if (entity != null) {
      return PackElementType.entity;
    }

    if (item != null) {
      return PackElementType.item;
    }

    return null;
  }
}
