import 'package:flutter/material.dart';

import '../model/module_type.dart';
import '../model/pack_element.dart';
import '../util/pluralizer.dart';

class PackContentSliver extends StatelessWidget {
  final List<PackElementInfo> content;
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
    final animControllers =
        content.where((e) => e.type == PackElementType.animationControllers);
    final entities = content.where((e) => e.type == PackElementType.entity);
    final items = content.where((e) => e.type == PackElementType.item);
    final lootTables =
        content.where((e) => e.type == PackElementType.lootTable);
    final unidentified =
        content.where((e) => e.type == PackElementType.unknown);

    return SliverList(
      delegate: SliverChildListDelegate(
        [
          if (animControllers.isEmpty)
            const ListTile(
              title: Text('Animation Controllers'),
              subtitle: Text('None'),
              enabled: false,
            ),
          if (animControllers.isNotEmpty)
            ExpansionTile(
              title: const Text('Animation Controllers'),
              subtitle: Text(animControllers.length
                  .pluralText('controller', 'controllers')),
              children: animControllers
                  .expand((e) => (e.name ?? e.path)
                      .split(',')
                      .map((n) => n.trim())
                      .map((n) => ListTile(
                            title: Text(n),
                            subtitle: Text(e.path),
                            onTap: () => onElementSelected?.call(
                                PackElementType.animationControllers,
                                e.path,
                                n),
                          )))
                  .toList(),
            ),
          if (moduleTypes.contains(ModuleType.data) && entities.isEmpty)
            const ListTile(
              title: Text('Entities'),
              subtitle: Text('None'),
              enabled: false,
            ),
          if (moduleTypes.contains(ModuleType.data) && entities.isNotEmpty)
            ExpansionTile(
              title: const Text('Enitities'),
              subtitle: Text(entities.length
                  .pluralText('entity', 'entities', '(server-side)')),
              children: entities
                  .map((e) => ListTile(
                        title: Text(e.name ?? e.path),
                        subtitle: Text(e.path),
                        onTap: () => onElementSelected?.call(
                            PackElementType.entity, e.path),
                      ))
                  .toList(),
            ),
          if (moduleTypes.contains(ModuleType.data) && items.isEmpty)
            const ListTile(
              title: Text('Items'),
              subtitle: Text('None'),
              enabled: false,
            ),
          if (moduleTypes.contains(ModuleType.data) && items.isNotEmpty)
            ExpansionTile(
              title: const Text('Items'),
              subtitle: Text(items.length.pluralText('item', 'items')),
              children: items
                  .map((e) => ListTile(
                        title: Text(e.name ?? e.path),
                        subtitle: Text(e.path),
                        onTap: () => onElementSelected?.call(
                            PackElementType.item, e.path),
                      ))
                  .toList(),
            ),
          if (moduleTypes.contains(ModuleType.data) && lootTables.isEmpty)
            const ListTile(
              title: Text('Loot Tables'),
              subtitle: Text('None'),
              enabled: false,
            ),
          if (moduleTypes.contains(ModuleType.data) && lootTables.isNotEmpty)
            ExpansionTile(
              title: const Text('Loot Tables'),
              subtitle: Text(lootTables.length.pluralText('pool', 'pools')),
              children: lootTables
                  .map((e) => ListTile(
                        title: Text(e.path),
                        onTap: () => onElementSelected?.call(
                            PackElementType.item, e.path),
                      ))
                  .toList(),
            ),
          if (unidentified.isNotEmpty)
            ExpansionTile(
              title: const Text('Unidentified Files'),
              subtitle: Text(unidentified.length.pluralText('file', 'files')),
              children: unidentified
                  .map((e) => ListTile(
                        title: Text(e.path),
                        dense: true,
                      ))
                  .toList(),
            )
        ],
      ),
    );
  }
}
