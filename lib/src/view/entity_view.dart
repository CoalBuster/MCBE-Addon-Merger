import 'package:flutter/material.dart';
import 'package:mcbe_addon_merger_core/mcbe_addon_merger_core.dart';

import '../model/patch.dart';
import 'tile/interact_tile.dart';
import 'tile/patched_tile.dart';

class EntityDetailView extends StatelessWidget {
  final ServerEntity entity;
  final Version? formatVersion;
  final List<Patch>? patches;
  final ScrollController scrollController;

  EntityDetailView({
    required this.entity,
    this.formatVersion,
    Key? key,
    this.patches,
    ScrollController? scrollController,
  })  : scrollController = scrollController ?? ScrollController(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      restorationId: 'entityListView',
      controller: scrollController,
      children: [
        PatchedTile(
          title: entity.description.identifier,
          subtitle: formatVersion == null
              ? null
              : Row(
                  children: [
                    const Text('Format Version: '),
                    PatchedText(
                      original: formatVersion.toString(),
                      patches: _diff('/format_version'),
                    ),
                  ],
                ),
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
        final interact = EntityComponentInteract.fromJson(componentContent);
        return InteractTile(interact: interact);
      default:
        return PatchedTile(
          title: componentName,
          value: componentContent,
          patches: _diff('/minecraft:entity/components/$componentName'),
        );
    }
  }

  List<Patch>? _diff(String path) {
    return patches
        ?.where((p) => p.path.startsWith(path))
        .map((p) => Patch(
              operation: p.operation,
              path: p.path.replaceFirst(path, ''),
              value: p.value,
            ))
        .toList();
  }
}
