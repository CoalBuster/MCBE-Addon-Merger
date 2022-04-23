import 'package:flutter/material.dart';

import '../model/pack.dart';

class PackListView extends StatelessWidget {
  final Function(Pack pack)? onPackTapped;
  final List<Pack> packs;

  const PackListView({
    Key? key,
    this.onPackTapped,
    this.packs = const [],
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
          leading: const CircleAvatar(
            foregroundImage: AssetImage('assets/images/flutter_logo.png'),
          ),
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
