import 'package:flutter/material.dart';

import '../model/minecraft/component/interact.dart';
import '../model/minecraft/server_entity.dart';
import '../model/version.dart';
import 'tile/interact_tile.dart';

class EntityDetailView extends StatelessWidget {
  final MinecraftServerEntity entity;
  final Version? formatVersion;

  const EntityDetailView({
    required this.entity,
    this.formatVersion,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      restorationId: 'entityListView',
      children: [
        ListTile(
          title: Text(entity.description.identifier),
          subtitle: formatVersion == null
              ? null
              : Text('Format Version: $formatVersion'),
        ),
        ListTile(
          title: const Text('Description'),
          subtitle: Text('''
${entity.description.isSpawnable ?? false ? 'Spawnable' : 'Not Spawnable'}
${entity.description.isSummonable ?? false ? 'Summonable' : 'Not Summonable'}
${entity.description.isExperimental ?? false ? 'Experimental' : 'Normal (not experimental)'}
Animations: ${entity.description.animations?.entries.map((e) => '${e.key} (${e.value})').join(', ')}
Animate: ${entity.description.scripts?.animate?.join(', ')}
          '''),
        ),
        ExpansionTile(
          title: const Text('Components'),
          subtitle: Text('${entity.components.length} component(s)'),
          children: entity.components.entries
              .map((e) => _buildComponent(e.key, e.value))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildComponent(String componentName, dynamic componentContent) {
    switch (componentName) {
      case 'minecraft:interact':
        final interact = MinecraftComponentInteract.fromJson(componentContent);
        return InteractTile(interact: interact);
      default:
        return ListTile(
          title: Text(componentName),
          subtitle: Text(componentContent.toString()),
        );
    }
  }
}
