import 'package:flutter/material.dart';

import '../model/component.dart';
import '../model/item.dart';
import '../model/version.dart';
import 'tile/patched_tile.dart';

class ItemDetailView extends StatelessWidget {
  final Item item;
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
          title: formatVersion == null
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

  Widget _buildComponent(String componentName, Component component) {
    switch (component.runtimeType) {
      case FoodComponent:
        return PatchedTile(
          title: 'Food',
          subtitle: Text(component.toString()),
        );
      case SeedComponent:
        return PatchedTile(
          title: 'Seed',
          subtitle: Text(component.toString()),
        );
      // case UseDurationComponent:
      //   return PatchedTile(
      //     title: 'Use Duration',
      //     subtitle: Text('$componentContent tick(s)'),
      //   );
      default:
        return ListTile(
          title: Text(componentName),
          subtitle: Text(component.toString()),
        );
    }
  }
}
