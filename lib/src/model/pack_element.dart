import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mcbe_addon_merger/src/model/parameter.dart';

enum PackElementCategory {
  animationControllers,
  animations,
  entity,
  image,
  item,
  lootTable,
  manifest,
  recipe,
  unknown;

  static const _displayNames = {
    PackElementCategory.animationControllers: 'Animation Controller',
    PackElementCategory.animations: 'Animation',
    PackElementCategory.entity: 'Entity',
    PackElementCategory.image: 'Image',
    PackElementCategory.item: 'Item',
    PackElementCategory.lootTable: 'Loot Table',
    PackElementCategory.manifest: 'Manifest',
    PackElementCategory.recipe: 'Recipe',
  };

  IconData asIcon() {
    switch (this) {
      default:
        return Icons.ac_unit;
    }
  }

  String asString() => _displayNames[this] ?? 'Unknown';

  bool get isJson =>
      this != PackElementCategory.image && this != PackElementCategory.unknown;
}

class PackElementInfo {
  final PackElementCategory category;
  final String displayName;
  final String path;

  PackElementInfo({
    required this.category,
    required this.displayName,
    required this.path,
  });
}

abstract class PackElement implements Parameterized {
  @JsonKey(includeToJson: true)
  PackElementCategory get category;
}
