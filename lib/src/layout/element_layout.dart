import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_patch/json_patch.dart';

import '../controller/element_controller.dart';
import '../model/pack_element.dart';
import '../view/components_view.dart';

class ElementLayout extends StatefulWidget {
  static const routeName = '/pack/element';

  final PackElementController elementController;

  const ElementLayout({
    required this.elementController,
    Key? key,
  }) : super(key: key);

  @override
  State<ElementLayout> createState() => _ElementLayoutState();
}

class _ElementLayoutState extends State<ElementLayout> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final mobile = constraints.maxWidth < 850;

        return Scaffold(
          appBar: AppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.elementController.name ?? 'Element Detail'),
                Text(
                  widget.elementController.type!.asString(),
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          drawer: mobile
              ? Drawer(
                  child: _EDL(
                    elementController: widget.elementController,
                  ),
                )
              : null,
          body: Row(
            children: [
              Expanded(
                child: _ElementDetailView(
                  element: widget.elementController.element,
                  name: widget.elementController.name,
                ),
              ),
              SizedBox(
                width: 300,
                child: _EDL(
                  elementController: widget.elementController,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _EDL extends StatelessWidget {
  final PackElementController elementController;

  _EDL({
    required this.elementController,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        ComponentsView(
            components: (elementController.element as ServerEntityElement?)
                    ?.components ??
                {})
      ],
    );
  }
}

class _ElementDetailView extends StatelessWidget {
  final PackElement? element;
  final String? name;
  // final Version? formatVersion;
  // final List<Patch>? patches;
  // final ScrollController scrollController;

  const _ElementDetailView({
    required this.element,
    // this.formatVersion,
    Key? key,
    this.name,
    // this.patches,
    // ScrollController? scrollController,
  }) : // scrollController = scrollController ?? ScrollController(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (element == null) {
      return const Text('None');
    }

    bool usesName = element!.parameters.any((p) => p.path == '/$name');

    return CustomScrollView(
      slivers: [
        SliverList(
          // itemExtent: 64,
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              var component = element!.parameters[index];
              String paramName = usesName ? name! : component.name;
              var json = jsonDecode(jsonEncode(element));
              dynamic value;

              try {
                value = JsonPointer.fromString(component.path).traverse(json);
              } catch (err) {
                value = JsonPointer.fromString('/$name').traverse(json);
              }

              return _ElementParamView(paramName, value ?? 'Not set');
            },
            childCount: usesName ? 1 : element!.parameters.length,
          ),
        ),
      ],
    );
  }
}

class _ElementParamView extends StatelessWidget {
  final String name;
  final dynamic value;

  const _ElementParamView(this.name, this.value);

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
                  child: _ElementParamView(
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
                ? _ElementParamView(
                    'Index ${index + 1}',
                    v,
                  )
                : _ElementParamView(
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
