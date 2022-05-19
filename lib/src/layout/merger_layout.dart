import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:mcbe_addon_merger/src/layout/comparer_layout.dart';
import 'package:mcbe_addon_merger/src/layout/pack_picker_layout.dart';

import '../controller/addon_controller.dart';
import '../model/pack.dart';
import 'pack_explorer_layout.dart';

/// Displays detailed information about a SampleItem.
class MergerLayout extends StatelessWidget {
  static const routeName = '/';

  final AddonController addonController;
  final Logger logger;

  const MergerLayout({
    required this.addonController,
    required this.logger,
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
                onPressed: () => _pick(context),
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
    final _packs = await Navigator.pushNamed<List<Pack>>(
      context,
      PackPickerLayout.routeName,
      arguments: 2,
    );

    if (_packs != null) {
      Navigator.restorablePushNamed(
        context,
        ComparerLayout.routeName,
        arguments: _packs.map((e) => e.directory.path).toList(),
      );
    }
  }

  _pick(BuildContext context) {
    Navigator.restorablePushNamed(
      context,
      PackExplorerLayout.routeName,
    );
    addonController.loadAsync();
  }
}
