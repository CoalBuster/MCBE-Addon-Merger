enum PackElementType {
  animationController,
  entity,
  item,
  lootTable;

  String asString() {
    switch (this) {
      case PackElementType.animationController:
        return 'Animation Controller';
      case PackElementType.entity:
        return 'Entity';
      case PackElementType.item:
        return 'Item';
      case PackElementType.lootTable:
        return 'Loot Table';
    }
  }

  String jsonKey() {
    switch (this) {
      case PackElementType.animationController:
        return 'animation_controllers';
      case PackElementType.entity:
        return 'minecraft:entity';
      case PackElementType.item:
        return 'minecraft:item';
      case PackElementType.lootTable:
        return 'pools';
    }
  }
}
