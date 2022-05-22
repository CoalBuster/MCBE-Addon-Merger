import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

import '../model/pack.dart';

class PackListView extends StatelessWidget {
  final Function(Pack pack)? onPackTapped;
  final List<Pack> packs;
  final List<Pack> selected;

  const PackListView({
    Key? key,
    this.onPackTapped,
    this.packs = const [],
    this.selected = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      restorationId: 'packListView',
      itemCount: packs.length,
      itemBuilder: (BuildContext context, int index) {
        final pack = packs[index];

        return ListTile(
          title: Text(pack.manifest.header.name),
          leading: CircleAvatar(
            backgroundImage: FileImage(
              File(path.absolute(pack.directory.path, 'pack_icon.png')),
            ),
          ),
          selected: selected.contains(pack),
          subtitle: Text('v${pack.manifest.header.version} | ' +
              (pack.isBehaviorPack
                  ? 'Behavior Pack'
                  : pack.isResourcePack
                      ? 'Resource Pack'
                      : 'Unknown Pack')),
          onTap: () => onPackTapped?.call(pack),
        );
      },
    );
  }
}
