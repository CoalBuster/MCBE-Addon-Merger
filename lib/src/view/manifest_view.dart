import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mcbe_addon_merger_core/mcbe_addon_merger_core.dart';
import 'package:path/path.dart' as path;

class ManifestView extends StatelessWidget {
  final Manifest manifest;

  const ManifestView({
    required this.manifest,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          // child: Image.file(
          //   File(path.absolute(pack.directory.path, 'pack_icon.png')),
          //   cacheHeight: 512,
          //   cacheWidth: 512,
          //   height: 64,
          //   width: 64,
          // ),
        ),
        Expanded(
          child: Column(
            children: [
              Text((manifest.isBehaviorPack
                      ? 'Behavior Pack'
                      : manifest.isResourcePack
                          ? 'Resource Pack'
                          : 'Unknown Pack') +
                  ' (${manifest.modules.map((e) => e.type.name).join('+')})'),
              Text(
                manifest.header.name,
                style: textTheme.titleLarge,
              ),
              Text(
                'v${manifest.header.version} | ${manifest.header.uuid}',
                style: textTheme.bodyText1,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
