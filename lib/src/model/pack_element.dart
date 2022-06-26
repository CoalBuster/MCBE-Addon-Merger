import 'package:json_annotation/json_annotation.dart';

import 'animation_controller.dart';
import 'item.dart';
import 'loot_table.dart';
import 'pack_element_type.dart';
import 'server_entity.dart';
import 'version.dart';

part 'pack_element.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PackElement {
  final Map<String, AnimationController>? animationControllers;
  @JsonKey(fromJson: Version.fromText, toJson: Version.toText)
  final Version? formatVersion;
  @JsonKey(name: 'minecraft:entity')
  final ServerEntity? entity;
  @JsonKey(name: 'minecraft:item')
  final Item? item;
  @JsonKey(name: 'pools')
  final List<LootTable>? lootTables;

  PackElement({
    required this.formatVersion,
    this.animationControllers,
    this.entity,
    this.item,
    this.lootTables,
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

    if (lootTables != null) {
      return PackElementType.lootTable;
    }

    return null;
  }
}
