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
    final pack = packController.pack;
    final content = packController.packContent;

    if (packController.loading) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            Text(packController.statusMessage ?? ''),
          ],
        ),
      );
    }

    if (pack == null) {
      return const Center(
        child: Text('No pack selected'),
      );
    }

    if (content == null) {
      return const Center(
        child: Text('Pack content loading failed'),
      );
    }

    return ListView(
      restorationId: 'packContentsListView',
      children: [
        if (content.animationControllers.isEmpty)
          const ListTile(
            title: Text('Animation Controllers'),
            subtitle: Text('None'),
            enabled: false,
          ),
        if (content.animationControllers.isNotEmpty)
          ExpansionTile(
            title: const Text('Animation Controllers'),
            subtitle: Text(
                '${content.animationControllers.entries.expand((e) => e.value.entries).length} controller(s)'),
            children: content.animationControllers.entries
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
        if (pack.isBehaviorPack && content.entities.isEmpty)
          const ListTile(
            title: Text('Entities'),
            subtitle: Text('None'),
            enabled: false,
          ),
        if (pack.isBehaviorPack && content.entities.isNotEmpty)
          ExpansionTile(
            title: const Text('Enitities'),
            subtitle: Text(content.entities.length
                .pluralText('entity', 'entities', '(server-side)')),
            children: content.entities.entries
                .map((e) => ListTile(
                      title: Text(e.value.description.identifier),
                      subtitle: Text(e.key),
                      onTap: () => onElementSelected?.call(
                          PackElementType.entity, e.key),
                    ))
                .toList(),
          ),
        if (pack.isBehaviorPack && content.items.isEmpty)
          const ListTile(
            title: Text('Items'),
            subtitle: Text('None'),
            enabled: false,
          ),
        if (pack.isBehaviorPack && content.items.isNotEmpty)
          ExpansionTile(
            title: const Text('Items'),
            subtitle: Text(content.items.length.pluralText('item', 'items')),
            children: content.items.entries
                .map((e) => ListTile(
                      title: Text(e.value.description.identifier),
                      subtitle: Text(e.key),
                      onTap: () =>
                          onElementSelected?.call(PackElementType.item, e.key),
                    ))
                .toList(),
          ),
        if (pack.isBehaviorPack && content.lootTables.isEmpty)
          const ListTile(
            title: Text('Loot Tables'),
            subtitle: Text('None'),
            enabled: false,
          ),
        if (pack.isBehaviorPack && content.lootTables.isNotEmpty)
          ExpansionTile(
            title: const Text('Loot Tables'),
            subtitle:
                Text(content.lootTables.length.pluralText('pool', 'pools')),
            children: content.lootTables.entries
                .map((e) => ListTile(
                      title: Text(e.key),
                      subtitle:
                          Text(e.value.length.pluralText('pool', 'pools')),
                      onTap: () =>
                          onElementSelected?.call(PackElementType.item, e.key),
                    ))
                .toList(),
          ),
        if (content.unidentified.isNotEmpty)
          ExpansionTile(
            title: const Text('Unidentified Files'),
            subtitle:
                Text(content.unidentified.length.pluralText('file', 'files')),
            children: content.unidentified
                .map((e) => ListTile(
                      title: Text(e),
                      dense: true,
                    ))
                .toList(),
          )
      ],
    );
  }
}
