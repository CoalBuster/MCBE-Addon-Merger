import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mcbe_addon_merger/src/controller/addon_controller.dart';
import 'package:path/path.dart' as path;

import '../model/manifest.dart';

class PackListView extends StatelessWidget {
  final AddonController addonController;
  final Function(Manifest pack)? onPackTapped;
  // final List<Manifest> packs;
  // final List<Manifest> selected;

  const PackListView({
    required this.addonController,
    Key? key,
    this.onPackTapped,
    // this.packs = const [],
    // this.selected = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (addonController.packs.isEmpty) {
      return const Center(child: Text('No packs'));
    }

    return ListView.builder(
      restorationId: 'packListView',
      itemCount: addonController.packs.length,
      itemBuilder: (BuildContext context, int index) {
        final pack = addonController.packs[index];

        return ListTile(
          title: Text(pack.header.name),
          leading: FutureBuilder<Uint8List?>(
            future: addonController.getPackIconAsync(pack.header.uuid),
            builder: (context, snapshot) => snapshot.hasData
                ? CircleAvatar(
                    backgroundImage: MemoryImage(snapshot.data!),
                  )
                : const CircleAvatar(),
          ),
          selected: addonController.selected.contains(pack),
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
