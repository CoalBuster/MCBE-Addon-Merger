import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../controller/addon_controller.dart';
import '../controller/element_controller.dart';
import '../controller/pack_controller.dart';
import '../model/manifest.dart';
import '../repository/addon_picker.dart';
import '../view/pack_list_view.dart';
import 'pack_layout.dart';

class MainLayout extends AnimatedWidget {
  static const routeName = '/';

  final AddonController addonController;
  final AddonPicker addonPicker;
  final PackElementController elementController;
  final Logger logger;
  final PackController packController;

  const MainLayout({
    required this.addonController,
    required this.addonPicker,
    required this.elementController,
    required this.logger,
    required this.packController,
    Key? key,
  }) : super(key: key, listenable: addonController);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(addonController.multiSelectMode
            ? '${addonController.selectedIds.length}'
            : 'MCBE Addon Merger'),
        leading: addonController.multiSelectMode
            ? BackButton(
                onPressed: () => addonController.unselectAll(),
              )
            : null,
        actions: [
          if (addonController.multiSelectMode)
            IconButton(
              icon: const Icon(Icons.compare),
              tooltip: addonController.selectedIds.length != 2
                  ? 'Select 2 for comparing'
                  : 'Compare selected packs',
              onPressed: addonController.selectedIds.length != 2
                  ? null
                  : () => _comparePacks(context),
            ),
        ],
      ),
      body: PackListView(
        addonController: addonController,
        onPackTapped: (pack) => _explorePack(context, pack),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Pick Pack',
        child: const Icon(Icons.add),
        onPressed:
            addonController.loading ? null : () => _pickAndUpload(context),
      ),
    );
  }

  _comparePacks(BuildContext context) async {
    // elementController.clear();
    // packController.clear();
    // await mergeController.loadBasePack(addonController.selectedIds[0]);
    // await mergeController.loadComparePack(addonController.selectedIds[1]);
    // mergeController.compare();
    // Navigator.restorablePushNamed(context, ComparerLayout.routeName);
  }

  _explorePack(BuildContext context, Manifest pack) async {
    elementController.clear();
    packController.loadPackByIdAsync(pack.header.uuid);
    Navigator.restorablePushNamed(context, PackLayout.routeName);
  }

  _pickAndUpload(BuildContext context) async {
    var pickResult = await addonPicker.pickFileAsync();

    if (pickResult == null) {
      return;
    }

    if (pickResult.isAddon) {
      await addonController.loadAddonAsync(pickResult.data);
    } else {
      await addonController.loadPackAsync(pickResult.data);
    }
  }
}
