import 'minecraft/animation_controller.dart';
import 'minecraft/item.dart';
import 'minecraft/loot_table.dart';
import 'minecraft/server_entity.dart';
import 'pack_element.dart';
import 'pack_element_type.dart';
import 'pack_image.dart';

class PackContent {
  final Map<String, dynamic> files;

  PackContent({
    required this.files,
  });

  Map<String, PackElement> get elements => Map.fromEntries(files.entries
      .where((element) => element.value is PackElement)
      .map((e) => MapEntry(e.key, e.value as PackElement)));

  Map<String, Map<String, MinecraftAnimationController>>
      get animationControllers =>
          Map.fromEntries(_elementsOfType(PackElementType.animationController)
              .entries
              .map((e) => MapEntry(e.key, e.value.animationControllers!)));

  Map<String, MinecraftServerEntity> get entities =>
      Map.fromEntries(_elementsOfType(PackElementType.entity)
          .entries
          .map((e) => MapEntry(e.key, e.value.entity!)));

  Map<String, MinecraftItem> get items =>
      Map.fromEntries(_elementsOfType(PackElementType.item)
          .entries
          .map((e) => MapEntry(e.key, e.value.item!)));

  Map<String, List<MinecraftLootTable>> get lootTables =>
      Map.fromEntries(_elementsOfType(PackElementType.lootTable)
          .entries
          .map((e) => MapEntry(e.key, e.value.lootTables!)));

  List<String> get unidentified => files.entries
      .where((element) => element.value == null)
      .map((e) => e.key)
      .toList();

  PackElement? element(String path) {
    return elements[path];
  }

  Map<String, PackElement> _elementsOfType(PackElementType type) {
    return Map.fromEntries(
        elements.entries.where((element) => element.value.type == type));
  }

  List<PackImage> get images => files.entries
      .where((element) => element.value is PackImage)
      .map((e) => e.value as PackImage)
      .toList();
}
