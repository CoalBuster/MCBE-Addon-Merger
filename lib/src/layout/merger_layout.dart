import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:mcbe_addon_merger_core/mcbe_addon_merger_core.dart';

import '../controller/merge_controller.dart';
import '../controller/pack_controller.dart';
import 'compare_selection_layout.dart';
import 'pack_detail_layout.dart';
import 'pack_picker_layout.dart';

/// Displays detailed information about a SampleItem.
class MergerLayout extends StatelessWidget {
  static const routeName = '/';

  final Logger logger;
  final MergeController mergeController;
  final PackController packController;

  const MergerLayout({
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
    final _pack =
        await Navigator.pushNamed<Pack>(context, PackPickerLayout.routeName);

    if (_pack != null) {
      packController.loadAsync(_pack);
      Navigator.restorablePushNamed(context, PackDetailLayout.routeName);
    }
  }
}
