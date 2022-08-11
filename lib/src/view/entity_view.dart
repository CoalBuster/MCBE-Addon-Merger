import 'package:flutter/material.dart';

import '../model/component.dart';
import '../model/pack_element.dart';
import '../model/patch.dart';
import '../model/version.dart';
import 'tile/interact_tile.dart';
import 'tile/patched_tile.dart';

class EntityDetailView extends StatelessWidget {
  final ServerEntityElement entity;
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
        ListTile(
          title: const Text('Entity (server-side)'),
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
        if (entity.components?.isEmpty ?? true)
          const ListTile(
            title: Text('Components'),
            subtitle: Text('None'),
            enabled: false,
          ),
        if (entity.components?.isNotEmpty ?? false)
          ExpansionTile(
            title: const Text('Components'),
            subtitle: Text('${entity.components!.length} component(s)'),
            children: entity.components!.entries
                .map((e) => _buildComponent(e.key, e.value))
                .toList(),
          ),
      ],
    );
  }

  Widget _buildComponent(String componentName, Component component) {
    switch (component.runtimeType) {
      case InteractComponent:
        return InteractTile(interact: component as InteractComponent);
      default:
        return PatchedTile(
          title: componentName,
          value: component.toJson(),
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
