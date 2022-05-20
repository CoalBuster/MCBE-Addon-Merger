import 'package:flutter/material.dart';

import '../model/pack_element.dart';
import '../model/pack_element_type.dart';
import '../model/patch.dart';
import 'animation_controller_view.dart';
import 'entity_view.dart';
import 'item_view.dart';
import 'loot_table_view.dart';

class PackElementDetailView extends StatelessWidget {
  final PackElement? element;
  final String? name;
  final List<Patch>? patches;
  final ScrollController scrollController;

  PackElementDetailView({
    required this.element,
    required this.name,
    Key? key,
    this.patches,
    ScrollController? scrollController,
  })  : scrollController = scrollController ?? ScrollController(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (element == null) {
      return const Center(
        child: Text('No element selected'),
      );
    }

    switch (element!.type) {
      case PackElementType.animationController:
        return AnimationControllerDetailView(
          animationControllers: element!.animationControllers!,
          formatVersion: element!.formatVersion,
          name: name,
        );
      case PackElementType.entity:
        return EntityDetailView(
          entity: element!.entity!,
          formatVersion: element!.formatVersion,
          patches: patches ?? [],
        );
      case PackElementType.item:
        return ItemDetailView(
          item: element!.item!,
          formatVersion: element!.formatVersion,
        );
      case PackElementType.lootTable:
        return LootTableDetailView(
          pools: element!.lootTables!,
          formatVersion: element!.formatVersion,
        );
      default:
        return Center(
          child: Text('Unhandled type: ${element!.type?.name}'),
        );
    }
  }
}
