import 'package:json_annotation/json_annotation.dart';

import 'animation_controller.dart';
import 'item.dart';
import 'loot_table.dart';
import 'server_entity.dart';
import 'version.dart';

enum PackElementType {
  animationControllers,
  entity,
  image,
  item,
  lootTable,
  unknown;

  String asString() {
    switch (this) {
      case PackElementType.animationControllers:
        return 'Animation Controller';
      case PackElementType.entity:
        return 'Entity';
      case PackElementType.image:
        return 'Image';
      case PackElementType.item:
        return 'Item';
      case PackElementType.lootTable:
        return 'Loot Table';
      case PackElementType.unknown:
        return 'Unknown';
    }
  }

  static PackElementType? fromJson(Map<String, dynamic> json) {
    if (json['animation_controllers'] is Map<String, dynamic>) {
      return PackElementType.animationControllers;
    }

    if (json['minecraft:entity'] is Map<String, dynamic>) {
      return PackElementType.entity;
    }

    if (json['minecraft:item'] is Map<String, dynamic>) {
      return PackElementType.item;
    }

    if (json['pools'] is List<dynamic>) {
      return PackElementType.lootTable;
    }

    return null;
  }

  String jsonKey() {
    switch (this) {
      case PackElementType.animationControllers:
        return 'animation_controllers';
      case PackElementType.entity:
        return 'minecraft:entity';
      case PackElementType.item:
        return 'minecraft:item';
      case PackElementType.lootTable:
        return 'pools';
      default:
        throw 'Non json';
    }
  }

  String? nameFromJson(Map<String, dynamic> json) {
    switch (this) {
      case PackElementType.animationControllers:
        return json['animation_controllers'].keys.join(', ');
      case PackElementType.entity:
        return json['minecraft:entity']['description']['identifier'];
      case PackElementType.item:
        return json['minecraft:item']['description']['identifier'];
      default:
        return null;
    }
  }
}

class PackElementInfo {
  final Version? formatVersion;
  final String? name;
  final String path;
  final PackElementType type;

  PackElementInfo({
    required this.path,
    required this.type,
    this.formatVersion,
    this.name,
  });
}

abstract class PackElement {
  PackElement();

  Map<String, dynamic> toJson();
}

class PackElements implements JsonConverter<PackElement, Map<String, dynamic>> {
  static const _elements = {
    PackElementType.animationControllers: AnimationControllers.fromJson,
    PackElementType.entity: ServerEntity.fromJson,
    PackElementType.item: Item.fromJson,
    PackElementType.lootTable: LootTables.fromJson,
  };

  const PackElements();

  @override
  PackElement fromJson(Map<String, dynamic> json) {
    final type = PackElementType.fromJson(json);
    return _elements[type]?.call(json[type!.jsonKey()]) ??
        PackElementUnknown(
          json: json,
        );
  }

  @override
  Map<String, dynamic> toJson(PackElement element) => element.toJson();
}

class PackElementUnknown extends PackElement {
  final Map<String, dynamic> json;

  PackElementUnknown({
    required this.json,
  });

  factory PackElementUnknown.fromJson(Map<String, dynamic> json) =>
      PackElementUnknown(json: json);

  @override
  Map<String, dynamic> toJson() => json;
}
