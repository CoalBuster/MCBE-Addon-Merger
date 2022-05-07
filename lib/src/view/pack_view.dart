import 'package:flutter/material.dart';

import '../controller/pack_controller.dart';
import '../model/pack_element_type.dart';
import '../util/pluralizer.dart';

class PackView extends StatelessWidget {
  final Function(PackElementType type, String path, [String? name])?
      onElementSelected;
  final PackController packController;

  const PackView({
    required this.packController,
    Key? key,
    this.onElementSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = packController;
    final pack = packController.pack;

    if (controller.loading) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            Text(controller.statusMessage ?? ''),
          ],
        ),
      );
    }

    if (pack == null) {
      return const Center(
        child: Text('No pack selected'),
      );
    }

    return ListView(
      restorationId: 'packContentsListView',
      children: [
        if (controller.animationControllers.isEmpty)
          const ListTile(
            title: Text('Animation Controllers'),
            subtitle: Text('None'),
            enabled: false,
          ),
        if (controller.animationControllers.isNotEmpty)
          ExpansionTile(
            title: const Text('Animation Controllers'),
            subtitle: Text(
                '${controller.animationControllers.entries.expand((e) => e.value.entries).length} controller(s)'),
            children: controller.animationControllers.entries
                .expand((element) => element.value.entries.map((e) => ListTile(
                      title: Text(e.key),
                      subtitle: Text(element.key),
                      onTap: () => onElementSelected?.call(
                          PackElementType.animationController,
                          element.key,
                          e.key),
                    )))
                .toList(),
          ),
        if (pack.isBehaviorPack && controller.entities.isEmpty)
          const ListTile(
            title: Text('Entities'),
            subtitle: Text('None'),
            enabled: false,
          ),
        if (pack.isBehaviorPack && controller.entities.isNotEmpty)
          ExpansionTile(
            title: const Text('Enitities'),
            subtitle: Text(controller.entities.length
                .pluralText('entity', 'entities', '(server-side)')),
            children: controller.entities.entries
                .map((e) => ListTile(
                      title: Text(e.value.description.identifier),
                      subtitle: Text(e.key),
                      onTap: () => onElementSelected?.call(
                          PackElementType.entity, e.key),
                    ))
                .toList(),
          ),
        if (pack.isBehaviorPack && controller.items.isEmpty)
          const ListTile(
            title: Text('Items'),
            subtitle: Text('None'),
            enabled: false,
          ),
        if (pack.isBehaviorPack && controller.items.isNotEmpty)
          ExpansionTile(
            title: const Text('Items'),
            subtitle: Text(controller.items.length.pluralText('item', 'items')),
            children: controller.items.entries
                .map((e) => ListTile(
                      title: Text(e.value.description.identifier),
                      subtitle: Text(e.key),
                      onTap: () =>
                          onElementSelected?.call(PackElementType.item, e.key),
                    ))
                .toList(),
          ),
        if (pack.isBehaviorPack && controller.lootTables.isEmpty)
          const ListTile(
            title: Text('Loot Tables'),
            subtitle: Text('None'),
            enabled: false,
          ),
        if (pack.isBehaviorPack && controller.lootTables.isNotEmpty)
          ExpansionTile(
            title: const Text('Loot Tables'),
            subtitle:
                Text(controller.lootTables.length.pluralText('pool', 'pools')),
            children: controller.lootTables.entries
                .map((e) => ListTile(
                      title: Text(e.key),
                      subtitle:
                          Text(e.value.length.pluralText('pool', 'pools')),
                      onTap: () =>
                          onElementSelected?.call(PackElementType.item, e.key),
                    ))
                .toList(),
          ),
      ],
    );
  }
}
