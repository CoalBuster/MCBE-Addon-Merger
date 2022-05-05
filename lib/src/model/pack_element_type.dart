enum PackElementType {
  animationController,
  entity,
  item,
  lootTable,
}

extension PackElementTypeString on PackElementType {
  String? asString() {
    switch (this) {
      case PackElementType.animationController:
        return 'Animation Controller';
      case PackElementType.entity:
        return 'Entity';
      case PackElementType.item:
        return 'Item';
      case PackElementType.lootTable:
        return 'Loot Table';
      default:
        return null;
    }
  }
}
