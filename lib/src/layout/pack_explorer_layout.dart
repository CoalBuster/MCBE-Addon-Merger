import 'package:flutter/material.dart';

import '../controller/addon_controller.dart';
import '../controller/pack_controller.dart';
import '../model/pack.dart';
import '../view/pack_list_view.dart';
import 'pack_detail_layout.dart';

class PackExplorerLayout extends AnimatedWidget {
  static const routeName = '/packs';

  final AddonController addonController;
  final PackController packController;

  const PackExplorerLayout({
    required this.addonController,
    required this.packController,
    Key? key,
  }) : super(listenable: addonController, key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Packs'),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.settings),
        //     onPressed: () {
        //       Navigator.restorablePushNamed(context, SettingsView.routeName);
        //     },
        //   ),
        // ],
      ),
      body: addonController.loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : PackListView(
              onPackTapped: (pack) => _onPackSelected(context, pack),
              packs: addonController.packs,
            ),
    );
  }

  void _onPackSelected(BuildContext context, Pack pack) {
    packController.loadAsync(pack);
    Navigator.restorablePushNamed(
      context,
      PackDetailLayout.routeName,
    );
  }
}
