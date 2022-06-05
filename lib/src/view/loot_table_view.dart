import 'package:flutter/material.dart';
import 'package:mcbe_addon_merger_core/mcbe_addon_merger_core.dart';
import 'package:path/path.dart' as path;

class LootTableDetailView extends StatelessWidget {
  final List<LootTable> pools;
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
              .map((e) => e.isEmpty
                  ? const ListTile(
                      title: Text('Empty Pool'),
                      enabled: false,
                    )
                  : ExpansionTile(
                      title: Text(
                          e.isTiered ? 'Tiered roll' : '${e.rolls} roll(s)'),
                      subtitle: Text(
                          e.conditions?.map((c) => c.toString()).join(' | ') ??
                              '${e.entries!.length} entries'),
                      children: <Widget>[
                            if (e.isTiered)
                              ListTile(
                                title: const Text('Tier system'),
                                subtitle: Text(
                                    'Start Index: ${e.tiers!.start}\n'
                                    'Max Incrementals: +${e.tiers!.bonusRolls}\n'
                                    'Index Incremental Chance: ${e.tiers!.bonusChance * 100}%'),
                              )
                          ] +
                          e.entries!
                              .map((entry) => LootTablePoolEntryView(
                                    entry: entry,
                                    parentPool: e,
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
  final LootPoolEntry entry;
  final LootTable parentPool;

  const LootTablePoolEntryView({
    required this.entry,
    required this.parentPool,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final index = parentPool.entries!.indexOf(entry);
    final chance = parentPool.isTiered
        ? ''
        : ' (${(entry.weight / parentPool.totalWeight * 100).toStringAsFixed(2)}%)';

    switch (entry.type) {
      case LootType.empty:
        return ListTile(
          title: Text('Nothing$chance'),
        );
      case LootType.item:
        final functions = entry.functions?.map((e) => e.toString()).join(' | ');
        return ListTile(
          title: Text('${entry.name}$chance'),
          subtitle: functions == null ? null : Text(functions),
        );
      case LootType.lootTable:
        final table = path.basenameWithoutExtension(entry.name!);
        return ListTile(
          leading: parentPool.isTiered
              ? CircleAvatar(
                  child: Text('${index + 1}'),
                )
              : null,
          title: Text('From "$table" Table$chance'),
          subtitle: Text(entry.name!),
          trailing: const Icon(Icons.arrow_forward),
          onTap: () {},
        );
    }
  }
}
