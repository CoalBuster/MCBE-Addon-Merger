import 'package:flutter/material.dart';

import '../model/manifest.dart';

class ManifestView extends StatelessWidget {
  final Manifest manifest;

  const ManifestView({
    required this.manifest,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
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
    );
  }
}
