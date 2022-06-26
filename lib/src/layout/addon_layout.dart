import 'package:flutter/material.dart';

import '../controller/addon_controller.dart';
import '../controller/pack_controller.dart';
import '../model/manifest.dart';
import '../view/pack_list_view.dart';
import 'pack_detail_layout.dart';

class AddonLayout extends AnimatedWidget {
  static const routeName = '/addon';

  final AddonController addonController;
  final PackController packController;

  const AddonLayout({
    required this.addonController,
    required this.packController,
    Key? key,
  }) : super(key: key, listenable: addonController);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Addon'),
        // actions: [
        //   IconButton(
        //       icon: const Icon(Icons.folder),
        //       onPressed: () => packPickerController.loadAsync())
        // ],
      ),
      body: addonController.loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : PackListView(
              onPackTapped: (pack) => _onPacksSelected(context, pack),
              packs: addonController.packs,
              // selected: _packs,
            ),
    );
  }

  void _onPacksSelected(BuildContext context, Manifest pack) async {
    await packController.loadPackByIdAsync(pack);
    Navigator.restorablePushNamed(context, PackDetailLayout.routeName);
  }
}
