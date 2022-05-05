import 'package:flutter/material.dart';

import '../model/minecraft/loot_table.dart';
import '../model/version.dart';

class LootTableDetailView extends StatelessWidget {
  final List<MinecraftLootTable> pools;
  final Version? formatVersion;

  const LootTableDetailView({
    required this.pools,
    this.formatVersion,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      restorationId: 'lootTableListView',
      children: [
        ExpansionTile(
          initiallyExpanded: true,
          title: const Text('Pools'),
          subtitle: Text('${pools.length} pool(s)'),
          children: pools
              .map((e) => ExpansionTile(
                    title: Text('${e.rolls} roll(s)'),
                    subtitle: Text('${e.entries.length} entries'),
                    children: e.entries
                        .map((entry) => LootTablePoolEntryView(
                              entry: entry,
                              totalWeight: e.totalWeight,
                            ))
                        .toList(),
                  ))
              .toList(),
        ),
      ],
    );
  }
}

class LootTablePoolEntryView extends StatelessWidget {
  final MinecraftLootPoolEntry entry;
  final int totalWeight;

  const LootTablePoolEntryView({
    required this.entry,
    required this.totalWeight,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final chance = (entry.weight / totalWeight * 100).toStringAsFixed(2);
    final functions = entry.functions?.map((e) => e.toString()).join(' | ');

    return ListTile(
      title: Text('${entry.name ?? 'Nothing'} ($chance%)'),
      subtitle: (entry.isEmpty || functions == null) ? null : Text(functions),
    );
  }
}
