import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../controller/addon_controller.dart';
import '../controller/merge_controller.dart';
import '../controller/pack_controller.dart';
import '../repository/addon_picker.dart';
import 'compare_selection_layout.dart';
import 'pack_detail_layout.dart';
import 'addon_layout.dart';

class MainLayout extends StatelessWidget {
  static const routeName = '/';

  final AddonController addonController;
  final AddonPicker addonPicker;
  final Logger logger;
  final MergeController mergeController;
  final PackController packController;

  const MainLayout({
    required this.addonController,
    required this.addonPicker,
    required this.logger,
    required this.mergeController,
    required this.packController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MCBE Addon Merger'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                child: const Text('Explore Pack'),
                onPressed: () => _explore(context),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                child: const Text('Compare Packs'),
                onPressed: () => _compare(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _compare(BuildContext context) async {
    mergeController.clear();
    Navigator.restorablePushNamed(context, CompareSelectionLayout.routeName);
  }

  _explore(BuildContext context) async {
    var pickResult = await addonPicker.pickFileAsync();

    if (pickResult == null) {
      return;
    }

    if (pickResult.isAddon) {
      await addonController.loadAddonAsync(pickResult.data);
      Navigator.restorablePushNamed(context, AddonLayout.routeName);
    } else {
      await packController.loadPackAsync(pickResult.data);
      Navigator.restorablePushNamed(context, PackDetailLayout.routeName);
    }
  }
}
