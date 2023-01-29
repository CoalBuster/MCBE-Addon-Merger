import 'package:flutter/material.dart';
import 'package:json_patch/json_patch.dart';
import 'package:mcbe_addon_merger/src/model/range.dart';

import '../model/parameter.dart';
import '../util/pluralizer.dart';

class _ParameterItem {
  final String title;
  final String? subtitle;
  final Iterable<_ParameterItem>? children;
  final String? path;

  _ParameterItem({
    required this.title,
    this.subtitle,
    this.children,
    this.path,
  });
}

class ParametersView extends StatefulWidget {
  final dynamic object;
  final String? name;

  const ParametersView({
    required this.object,
    Key? key,
    this.name,
  }) : super(key: key);

  @override
  State<ParametersView> createState() => _ParametersViewState();
}

class _ParametersViewState extends State<ParametersView> {
  String path = '';

  @override
  Widget build(BuildContext context) {
    if (widget.object == null) {
      return const Center(
        child: Text('Nothing to show'),
      );
    }

    var root = _buildItem(
      name: 'ROOT',
      json: widget.object,
      path: path, //widget.name == null ? path : '/${widget.name}$path',
    );
    var parameters = root.children!
        .map((e) => _buildItem(
              name: e.title,
              json: widget.object,
              path: e.path!,
            ))
        .toList();

    return CustomScrollView(
      slivers: [
        if (path.isNotEmpty)
          SliverToBoxAdapter(
            child: ListTile(
              title: Text('Path: $path'),
              leading: const Icon(Icons.arrow_upward),
              dense: true,
              onTap: () => setState(() {
                var pointer = JsonPointer.fromString(path);
                path = pointer.hasParent ? pointer.parent.toString() : '';
              }),
            ),
          ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              var param = parameters[index];
              var objct = _traverse(widget.object, param.path!);

              return _ParameterItemView(
                name: param.title,
                object: objct,
                path: param.path,
                onTap: (p) => setState(() {
                  path = p!;
                  print('GOTO $path');
                }),
              );
            },
            childCount: parameters.length,
          ),
        ),
      ],
    );
  }

  dynamic _traverse(dynamic object, String path) {
    var value = object;
    var pointer = JsonPointer.fromString(path);

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

  _ParameterItem _buildItem({
    required String name,
    dynamic json,
    String path = '',
  }) {
    var value = json;
    var title = name;

    if (path.isNotEmpty) {
      value = _traverse(value, path);
    }

    if (value is Named) {
      title = value.name ?? title;
      value = value.value;
    }

    if (value is Parameterized) {
      var params = value.parameters;

      return _ParameterItem(
        title: title,
        path: path,
        children: params.map((e) => _ParameterItem(
              title: e.name,
              path: path + e.path,
            )),
      );
    }

    if (value is Map) {
      return _ParameterItem(
        title: title,
        path: path,
        children: value.entries.map((e) => _ParameterItem(
              title: e.key,
              path: '$path/${e.key}',
            )),
      );
    }

    if (value is List) {
      return _ParameterItem(
        title: title,
        subtitle: value.length.pluralText('Entry', 'Entries'),
        path: path,
        children: value.asMap().entries.map((e) => _ParameterItem(
              title: 'Index ${e.key + 1}',
              path: '$path/${e.key}',
            )),
      );
    }

    return _ParameterItem(
      title: title,
      subtitle: value.toString(),
      path: path,
    );
  }
}

class _ParameterItemView extends StatelessWidget {
  final String name;
  final dynamic object;
  final String? path;
  final void Function(String? subPath)? onTap;

  const _ParameterItemView({
    required this.name,
    required this.object,
    this.path,
    this.onTap,
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
        );
      }

      return ListTile(
        title: Text(name),
        // subtitle: Text(entries.length.pluralText('Entry', 'Entries')),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () => onTap?.call(path),
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



// class ParametersView extends StatelessWidget {
//   final dynamic object;
//   final List<Parameter> parameters;
//   // final PackElement? element;
//   // final String? name;
//   // final Version? formatVersion;
//   // final List<Patch>? patches;
//   // final ScrollController scrollController;

//   const ParametersView({
//     required this.object,
//     required this.parameters,
//     // this.formatVersion,
//     Key? key,
//     // this.name,
//     // this.patches,
//     // ScrollController? scrollController,
//   }) : // scrollController = scrollController ?? ScrollController(),
//         super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     if (parameters.isEmpty) {
//       return const Center(
//         child: Text('None'),
//       );
//     }

//     return CustomScrollView(
//       slivers: [
//         SliverList(
//           delegate: SliverChildBuilderDelegate(
//             (context, index) {
//               var param = parameters[index];

//               return _ParameterItemView(
//                 name: param.name,
//                 json: object,
//                 path: JsonPointer.fromString(param.path),
//                 expand: true,
//               );
//             },
//             childCount: parameters.length,
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _ParameterItemView extends StatelessWidget {
//   final bool expand;
//   final String name;
//   final JsonPointer? path;
//   final dynamic json;

//   const _ParameterItemView({
//     required this.name,
//     this.expand = false,
//     this.json,
//     this.path,
//   });

//   @override
//   Widget build(BuildContext context) {
//     var value = json;
//     var title = name;

//     if (path != null) {
//       for (var seg in path!.segments) {
//         value = value is List
//             ? value[int.parse(seg)]
//             : value is Map
//                 ? value[seg]
//                 : value.toJson()[seg];
//       }
//     }

//     if (value is Named) {
//       title = value.name ?? title;
//       value = value.value;
//     }

//     if (value is Parameterized) {
//       var params = value.parameters();

//       return ExpansionTile(
//         title: Text(title),
//         initiallyExpanded: expand,
//         children: params
//             .map((f) => _ParameterItemView(
//                   name: f.name,
//                   json: value,
//                   path: JsonPointer.fromString(f.path),
//                 ))
//             .toList(),
//       );
//     }

//     if (value is Map) {
//       return ExpansionTile(
//         title: Text(title),
//         initiallyExpanded: expand,
//         children: value.entries
//             .map((f) => Padding(
//                   padding: const EdgeInsets.only(left: 8),
//                   child: _ParameterItemView(
//                     name: f.key,
//                     json: f.value,
//                   ),
//                 ))
//             .toList(),
//       );
//     }

//     if (value is List) {
//       return ExpansionTile(
//         title: Text(title),
//         initiallyExpanded: expand,
//         subtitle: Text(value.length.pluralText('Entry', 'Entries')),
//         children: value
//             .asMap()
//             .entries
//             .map((f) => Padding(
//                   padding: const EdgeInsets.only(left: 8),
//                   child: f.value is String
//                       ? _ParameterItemView(
//                           name: f.value,
//                         )
//                       : _ParameterItemView(
//                           name: 'Index ${f.key + 1}',
//                           json: f.value,
//                         ),
//                 ))
//             .toList(),
//       );
//     }

//     if (value is bool) {
//       return SwitchListTile(
//         title: Text(title),
//         value: value,
//         onChanged: (i) {},
//       );
//     }

//     return ListTile(
//       title: Text(title),
//       subtitle: value == null ? null : Text(value.toString()),
//     );
//   }
// }
