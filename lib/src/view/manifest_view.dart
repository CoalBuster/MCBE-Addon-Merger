import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mcbe_addon_merger_core/mcbe_addon_merger_core.dart';
import 'package:path/path.dart' as path;

class ManifestView extends StatelessWidget {
  final Pack pack;

  const ManifestView({
    required this.pack,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Image.file(
            File(path.absolute(pack.directory.path, 'pack_icon.png')),
            cacheHeight: 512,
            cacheWidth: 512,
            height: 64,
            width: 64,
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Text((pack.manifest.isBehaviorPack
                      ? 'Behavior Pack'
                      : pack.manifest.isResourcePack
                          ? 'Resource Pack'
                          : 'Unknown Pack') +
                  ' (${pack.manifest.modules.map((e) => e.type.name).join('+')})'),
              Text(
                pack.manifest.header.name,
                style: textTheme.titleLarge,
              ),
              Text(
                'v${pack.manifest.header.version} | ${pack.manifest.header.uuid}',
                style: textTheme.bodyText1,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
