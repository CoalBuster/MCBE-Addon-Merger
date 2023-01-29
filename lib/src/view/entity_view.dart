import 'package:flutter/material.dart';

import '../model/component.dart';
import '../model/pack_element_json.dart';
import '../model/patch.dart';
import '../model/version.dart';
import 'tile/patched_tile.dart';

class EntityDetailView extends StatefulWidget {
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
  State<EntityDetailView> createState() => _EntityDetailViewState();
}

class _EntityDetailViewState extends State<EntityDetailView> {
  String? _selectedGroup;

  @override
  Widget build(BuildContext context) {
    final entity = widget.entity;
    final components = entity.components;
    final groupComponents = entity.groups?[_selectedGroup];

    if (groupComponents == null) {
      _selectedGroup = null;
    }

    return ListView(
        restorationId: 'entityListView',
        controller: widget.scrollController,
        children: [
          ListTile(
            title: const Text('Entity (server-side)'),
            subtitle: widget.formatVersion == null
                ? null
                : Row(
                    children: [
                      const Text('Format Version: '),
                      PatchedText(
                        original: widget.formatVersion.toString(),
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
          if (entity.groups?.isNotEmpty ?? false)
            ListTile(
              title: const Text('Component Group'),
              trailing: DropdownButton<String>(
                items: entity.groups?.keys
                    .map((e) => DropdownMenuItem(
                          child: Text(e),
                          value: e,
                        ))
                    .toList(),
                value: _selectedGroup,
                onChanged: (e) => setState(() => _selectedGroup = e),
              ),
              dense: true,
            ),
          if (components?.isEmpty ?? true)
            const ListTile(
              title: Text('Components'),
              subtitle: Text('None'),
              enabled: false,
            ),
          if (components?.isNotEmpty ?? false)
            ExpansionTile(
              title: const Text('Components'),
              subtitle: Text(
                  '${components!.length + (groupComponents?.length ?? 0)} component(s)'),
              children: components.entries
                      .map((e) => _buildComponent(e.key, e.value))
                      .toList() +
                  (groupComponents?.entries
                          .map((e) =>
                              _buildComponent(e.key, e.value, _selectedGroup))
                          .toList() ??
                      []),
            ),
        ]);
  }

  Widget _buildComponent(String componentName, Component component,
      [String? groupName]) {
    // if (component.parameters.isEmpty) {
    return ListTile(
      title: Text(component.name ?? componentName),
      subtitle: component.summary == null ? null : Text(component.summary!),
    );
    // }

    // return ExpansionTile(
    //   expandedAlignment: Alignment.centerLeft,
    //   expandedCrossAxisAlignment: CrossAxisAlignment.start,
    //   childrenPadding: const EdgeInsets.symmetric(horizontal: 24),
    //   title: Text(component.name ?? componentName),
    //   subtitle: component.summary == null ? null : Text(component.summary!),
    //   children: component.parameters.map((e) {
    //     if (e.value is bool) {
    //       return SwitchListTile(
    //         title: Text(e.name),
    //         value: e.value,
    //         onChanged: (i) {},
    //       );
    //     }
    //     return ListTile(
    //       title: Text(e.name),
    //       subtitle: Text(e.value.toString()),
    //     );
    //   }).toList(),
    // );
  }

  List<Patch>? _diff(String path) {
    return widget.patches
        ?.where((p) => p.path.startsWith(path))
        .map((p) => Patch(
              operation: p.operation,
              path: p.path.replaceFirst(path, ''),
              value: p.value,
            ))
        .toList();
  }
}
