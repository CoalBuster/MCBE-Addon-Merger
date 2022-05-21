import 'package:flutter/material.dart';

import '../model/module_type.dart';
import '../model/pack_content.dart';
import '../model/pack_element_type.dart';
import '../util/pluralizer.dart';

class PackContentSliver extends StatelessWidget {
  final PackContent content;
  final Iterable<ModuleType> moduleTypes;
  final Function(PackElementType type, String path, [String? name])?
      onElementSelected;

  const PackContentSliver({
    required this.content,
    required this.moduleTypes,
    Key? key,
    this.onElementSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
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
                  .expand(
                      (element) => element.value.entries.map((e) => ListTile(
                            title: Text(e.key),
                            subtitle: Text(element.key),
                            onTap: () => onElementSelected?.call(
                                PackElementType.animationController,
                                element.key,
                                e.key),
                          )))
                  .toList(),
            ),
          if (moduleTypes.contains(ModuleType.data) && content.entities.isEmpty)
            const ListTile(
              title: Text('Entities'),
              subtitle: Text('None'),
              enabled: false,
            ),
          if (moduleTypes.contains(ModuleType.data) &&
              content.entities.isNotEmpty)
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
          if (moduleTypes.contains(ModuleType.data) && content.items.isEmpty)
            const ListTile(
              title: Text('Items'),
              subtitle: Text('None'),
              enabled: false,
            ),
          if (moduleTypes.contains(ModuleType.data) && content.items.isNotEmpty)
            ExpansionTile(
              title: const Text('Items'),
              subtitle: Text(content.items.length.pluralText('item', 'items')),
              children: content.items.entries
                  .map((e) => ListTile(
                        title: Text(e.value.description.identifier),
                        subtitle: Text(e.key),
                        onTap: () => onElementSelected?.call(
                            PackElementType.item, e.key),
                      ))
                  .toList(),
            ),
          if (moduleTypes.contains(ModuleType.data) &&
              content.lootTables.isEmpty)
            const ListTile(
              title: Text('Loot Tables'),
              subtitle: Text('None'),
              enabled: false,
            ),
          if (moduleTypes.contains(ModuleType.data) &&
              content.lootTables.isNotEmpty)
            ExpansionTile(
              title: const Text('Loot Tables'),
              subtitle:
                  Text(content.lootTables.length.pluralText('pool', 'pools')),
              children: content.lootTables.entries
                  .map((e) => ListTile(
                        title: Text(e.key),
                        subtitle:
                            Text(e.value.length.pluralText('pool', 'pools')),
                        onTap: () => onElementSelected?.call(
                            PackElementType.item, e.key),
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
      ),
    );
  }
}
