import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_patch/json_patch.dart';

import '../model/component.dart';

class ComponentsView extends StatelessWidget {
  final Map<String, Component> components;
  // final Version? formatVersion;
  // final List<Patch>? patches;
  // final ScrollController scrollController;

  const ComponentsView({
    required this.components,
    // this.formatVersion,
    Key? key,
    // this.patches,
    // ScrollController? scrollController,
  }) : // scrollController = scrollController ?? ScrollController(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverFixedExtentList(
      itemExtent: 64,
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          var component = components.entries.elementAt(index);
          return _ComponentItemView(component.key, component.value);
        },
        childCount: components.length,
      ),
    );
  }
}

class _ComponentItemView extends StatelessWidget {
  final String componentName;
  final Component component;

  const _ComponentItemView(
    this.componentName,
    this.component,
  );

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(component.name ?? componentName, maxLines: 1),
      subtitle: Text(component.summary ?? 'Component'),
      onTap: () => showDialog(
        context: context,
        builder: (context) {
          var json = jsonDecode(jsonEncode(component));

          return SimpleDialog(
            title: Text(component.name ?? componentName),
            children: component.parameters
                .map((e) => _ComponentParamView(
                    e.name, JsonPointer.fromString(e.path).traverse(json)))
                .toList(),
          );
        },
      ),
    );
  }
}

class _ComponentParamView extends StatelessWidget {
  final String name;
  final dynamic value;

  const _ComponentParamView(this.name, this.value);

  @override
  Widget build(BuildContext context) {
    if (value is Map) {
      return ExpansionTile(
        title: Text(name),
        subtitle: const Text('Object'),
        children: (value as Map)
            .entries
            .map((f) => Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: _ComponentParamView(
                    f.key,
                    f.value,
                  ),
                ))
            .toList(),
      );
    }

    if (value is List) {
      return ExpansionTile(
        title: Text(name),
        subtitle: const Text('Array'),
        children: List.generate((value as List).length, (index) {
          final v = (value as List)[index];

          return Padding(
            padding: const EdgeInsets.only(left: 8),
            child: v is List || v is Map
                ? _ComponentParamView(
                    'Index ${index + 1}',
                    v,
                  )
                : _ComponentParamView(
                    v.toString(),
                    null,
                  ),
          );
        }).toList(),
      );
    }

    if (value is bool) {
      return SwitchListTile(
        title: Text(name),
        value: value,
        onChanged: (i) {},
      );
    }

    return ListTile(
      title: Text(name),
      subtitle: value == null ? null : Text(value.toString()),
    );
  }
}
