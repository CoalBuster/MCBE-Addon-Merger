import 'package:flutter/material.dart';

import '../model/minecraft/component/food.dart';
import '../model/minecraft/component/seed.dart';
import '../model/minecraft/item.dart';
import '../model/version.dart';
import 'tile/simple_tile.dart';

class ItemDetailView extends StatelessWidget {
  final MinecraftItem item;
  final Version? formatVersion;

  const ItemDetailView({
    required this.item,
    this.formatVersion,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      restorationId: 'itemListView',
      children: [
        ListTile(
          title: Text(item.description.identifier),
          subtitle: formatVersion == null
              ? null
              : Text('Format Version: $formatVersion' +
                  (item.description.category == null
                      ? ''
                      : '\nCategory: ${item.description.category}')),
        ),
        if (item.components?.isEmpty ?? true)
          const ListTile(
            title: Text('Components'),
            subtitle: Text('None'),
            enabled: false,
          ),
        if (item.components?.isNotEmpty ?? false)
          ExpansionTile(
            initiallyExpanded: true,
            title: const Text('Components'),
            subtitle: Text('${item.components!.length} component(s)'),
            children: item.components!.entries
                .map((e) => _buildComponent(e.key, e.value))
                .toList(),
          ),
      ],
    );
  }

  Widget _buildComponent(String componentName, dynamic componentContent) {
    switch (componentName) {
      case 'minecraft:food':
        final food = MinecraftComponentFood.fromJson(componentContent);
        return SimpleTile(
          title: 'Food',
          subtitle: food.toString(),
        );
      case 'minecraft:seed':
        final seed = MinecraftComponentSeed.fromJson(componentContent);
        return SimpleTile(
          title: 'Seed',
          subtitle: seed.toString(),
        );
      case 'minecraft:use_duration':
        return SimpleTile(
          title: 'Use Duration',
          subtitle: '$componentContent tick(s)',
        );
      default:
        return ListTile(
          title: Text(componentName),
          subtitle: Text(componentContent.toString()),
        );
    }
  }
}
