import 'package:flutter/material.dart';
import 'package:mcbe_addon_merger/src/model/server_entity.dart';

import '../model/animation_controller.dart' as mc;
import '../model/item.dart';
import '../model/loot_table.dart';
import '../model/manifest.dart';
import '../model/pack_element.dart';
import '../model/patch.dart';
import '../repository/addon_repository.dart';
import 'animation_controller_view.dart';
import 'entity_view.dart';
import 'item_view.dart';
import 'loot_table_view.dart';

class PackElementDetailView extends StatelessWidget {
  final AddonRepository addonRepository;
  final PackElementInfo? element;
  final String? name;
  final Manifest? pack;
  final List<Patch>? patches;
  final ScrollController scrollController;

  PackElementDetailView({
    required this.addonRepository,
    required this.element,
    required this.name,
    required this.pack,
    Key? key,
    this.patches,
    ScrollController? scrollController,
  })  : scrollController = scrollController ?? ScrollController(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (pack == null || element == null) {
      return const Center(
        child: Text('No element selected'),
      );
    }

    return FutureBuilder<PackElement?>(
      future: addonRepository.getElementByPathAsync(
          pack!.header.uuid, element!.path),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return const Center(
              child: Text('None'),
            );
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.active:
          case ConnectionState.done:
            if (!snapshot.hasData) {
              return Center(
                child: Text('Element not found: ${element!.path}'),
              );
            }

            switch (element!.type) {
              case PackElementType.animationControllers:
                return AnimationControllerDetailView(
                  animationControllers:
                      snapshot.data as mc.AnimationControllers,
                  formatVersion: element!.formatVersion,
                  name: name,
                );
              case PackElementType.entity:
                return EntityDetailView(
                  entity: snapshot.data as ServerEntity,
                  formatVersion: element!.formatVersion,
                  patches: patches,
                );
              case PackElementType.item:
                return ItemDetailView(
                  item: snapshot.data as Item,
                  formatVersion: element!.formatVersion,
                );
              case PackElementType.lootTable:
                return LootTableDetailView(
                  lootTables: snapshot.data as LootTables,
                  formatVersion: element!.formatVersion,
                );
              default:
                return Center(
                  child: Text('Unhandled type: ${element!.type.name}'),
                );
            }
        }
      },
    );
  }
}
