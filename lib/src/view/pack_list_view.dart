import 'package:flutter/material.dart';

import '../controller/addon_controller.dart';
import '../model/manifest.dart';
import 'pack_view.dart';

class PackListView extends AnimatedWidget {
  final AddonController addonController;
  final Function(Manifest pack)? onPackTapped;

  const PackListView({
    required this.addonController,
    Key? key,
    this.onPackTapped,
  }) : super(key: key, listenable: addonController);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 600,
        child: ListView.builder(
          shrinkWrap: true,
          restorationId: 'packListView',
          itemCount: addonController.packs.length,
          itemBuilder: (BuildContext context, int index) {
            final pack = addonController.packs[index];
            return PackView(
              addonController: addonController,
              pack: pack,
              onTap: () => onPackTapped?.call(pack),
            );
          },
        ),
      ),
    );
  }
}
