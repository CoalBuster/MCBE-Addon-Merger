import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

import '../model/manifest.dart';

class PackListView extends StatelessWidget {
  final Function(Manifest pack)? onPackTapped;
  final List<Manifest> packs;
  final List<Manifest> selected;

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
          title: Text(pack.header.name),
          leading: CircleAvatar(
              // backgroundImage: MemoryImage(),
              // backgroundImage: FileImage(
              //   File(path.absolute(pack.directory.path, 'pack_icon.png')),
              // ),
              ),
          selected: selected.contains(pack),
          subtitle: Text('v${pack.header.version} | ' +
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
