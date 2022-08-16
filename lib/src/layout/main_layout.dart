import 'dart:math';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:mcbe_addon_merger/src/model/manifest.dart';
import 'package:mcbe_addon_merger/src/repository/addon_repository.dart';
import 'package:mcbe_addon_merger/src/view/pack_list_view.dart';

import '../controller/addon_controller.dart';
import '../controller/merge_controller.dart';
import '../controller/pack_controller.dart';
import '../repository/addon_picker.dart';
import 'compare_selection_layout.dart';
import 'comparer_layout.dart';
import 'pack_detail_layout.dart';

class MainLayout extends StatelessWidget {
  static const routeName = '/';

  final AddonController addonController;
  final AddonPicker addonPicker;
  // final AddonRepository addonRepository;
  final Logger logger;
  final MergeController mergeController;
  final PackController packController;

  const MainLayout({
    required this.addonController,
    required this.addonPicker,
    // required this.addonRepository,
    required this.logger,
    required this.mergeController,
    required this.packController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: addonController,
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          title: const Text('MCBE Addon Merger'),
        ),
        // body: Center(
        //   child: Padding(
        //     padding: const EdgeInsets.all(16),
        //     child: Column(
        //       mainAxisSize: MainAxisSize.min,
        //       crossAxisAlignment: CrossAxisAlignment.stretch,
        //       children: [
        //         ElevatedButton(
        //           child: const Text('Explore Pack'),
        //           onPressed: () => _explore(context),
        //         ),
        //         const SizedBox(height: 8),
        //         ElevatedButton(
        //           child: const Text('Compare Packs'),
        //           onPressed: () => _compare(context),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        body: PackListView(
          addonController: addonController,
          onPackTapped: (pack) => _explorePack(context, pack),
        ),
        floatingActionButton: addonController.anySelected
            ? FloatingActionButton(
                child: const Icon(Icons.compare),
                onPressed: addonController.loading
                    ? null
                    : () => _comparePacks(context),
              )
            : FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: addonController.loading
                    ? null
                    : () => _pickAndUpload(context),
              ),
      ),
    );
  }

  _comparePacks(BuildContext context) async {
    await mergeController.loadBasePack(addonController.selectedIds[0]);
    await mergeController.loadComparePack(addonController.selectedIds[1]);
    mergeController.compare();
    // Navigator.restorablePushNamed(context, ComparerLayout.routeName);
  }

  _explorePack(BuildContext context, Manifest pack) async {
    Navigator.restorablePushNamed(context, PackDetailLayout.routeName);
    packController.loadPackByIdAsync(pack.header.uuid);
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

  // _compare(BuildContext context) async {
  //   mergeController.clear();
  //   Navigator.restorablePushNamed(context, CompareSelectionLayout.routeName);
  // }

  // _explore(BuildContext context) async {
  //   var pickResult = await addonPicker.pickFileAsync();

  //   if (pickResult == null) {
  //     return;
  //   }

  //   if (pickResult.isAddon) {
  //     Navigator.restorablePushNamed(context, AddonLayout.routeName);
  //     await addonController.loadAddonAsync(pickResult.data);
  //   } else {
  //     Navigator.restorablePushNamed(context, PackDetailLayout.routeName);
  //     packController.loadPackAsync(pickResult.data);
  //   }
  // }
}
