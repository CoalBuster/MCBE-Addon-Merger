import 'package:flutter/material.dart';
import 'package:json_patch/json_patch.dart';

import '../model/parameter.dart';
import '../model/range.dart';
import '../util/json_pointer_ext.dart';

class _ParameterItem {
  final String title;
  final String? subtitle;
  final JsonPointer path;

  _ParameterItem({
    required this.title,
    this.subtitle,
    required this.path,
  });
}

class ParametersView extends StatelessWidget {
  final dynamic object;
  final JsonPointer? path;
  final Function(JsonPointer path)? onItemSelected;
  final JsonPointer? selected;

  const ParametersView({
    required this.object,
    Key? key,
    this.path,
    this.onItemSelected,
    this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (object == null) {
      return const Center(
        child: Text('Nothing to show'),
      );
    }

    if (path == null) {
      return const Center(
        child: Text('Nothing to show'),
      );
    }

    var parameters = _buildItems(
      name: 'ROOT',
      json: object,
      path: path ?? JsonPointer.fromString(''),
    ).toList();

    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              var param = parameters[index];
              var objct = _traverse(object, param.path);

              return _ParameterItemView(
                name: param.title,
                object: objct,
                path: param.path,
                selected: param.path.toString() == selected.toString(),
                onTap: (path) => onItemSelected?.call(path),
              );
            },
            childCount: parameters.length,
          ),
        ),
      ],
    );
  }

  dynamic _traverse(dynamic object, JsonPointer pointer) {
    var value = object;

    for (var seg in pointer.segments) {
      value = value is SingleOrList
          ? value.items[int.parse(seg)]
          : value is List
              ? value[int.parse(seg)]
              : value is Map
                  ? value[seg]
                  : value.toJson()[seg];
    }

    return value;
  }

  Iterable<_ParameterItem> _buildItems({
    required String name,
    dynamic json,
    required JsonPointer path,
  }) {
    var title = name;
    var value = _traverse(json, path);

    if (value is Named) {
      title = value.name ?? title;
      value = value.value;
    }

    if (value is Parameterized) {
      var params = value.parameters;

      return params.map((e) => _ParameterItem(
            title: e.name,
            path: path.append(e.path),
          ));
    }

    if (value is Map) {
      return value.entries.map(
        (e) => _ParameterItem(
          title: e.key,
          path: path.append(e.key),
        ),
      );
    }

    if (value is List) {
      return value.asMap().entries.map(
            (e) => _ParameterItem(
              title: 'Index ${e.key + 1}',
              path: path.append(e.key.toString()),
            ),
          );
    }

    return [
      _ParameterItem(
        title: title,
        subtitle: value.toString(),
        path: path,
      )
    ];
  }
}

class _ParameterItemView extends StatelessWidget {
  final String name;
  final dynamic object;
  final JsonPointer path;
  final void Function(JsonPointer subPath)? onTap;
  final bool selected;

  const _ParameterItemView({
    required this.name,
    required this.object,
    required this.path,
    this.onTap,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    final value = object;
    var entries = value is Map
        ? value.keys
        : value is List
            ? value
            : value is Parameterized
                ? value.parameters
                : value is SingleOrList
                    ? value.items
                    : null;

    if (entries != null) {
      if (entries.isEmpty) {
        return ListTile(
          title: Text(name),
          selected: selected,
        );
      }

      return ListTile(
        title: Text(name),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () => onTap?.call(path),
        selected: selected,
      );
    }

    if (value is bool) {
      return SwitchListTile(
        title: Text(name),
        value: value,
        onChanged: (i) {},
      );
    }

    if (value is Named) {
      return ListTile(
        title: Text(name),
        subtitle: Text(value.value.toString()),
      );
    }

    return ListTile(
      title: Text(name),
      subtitle: value == null ? null : Text(value.toString()),
    );
  }
}
