import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../controller/addon_controller.dart';
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
        // child: Text('More Information Here'),
        child: ElevatedButton(
          onPressed: () => _pick(context),
          child: const Text('Pick!'),
        ),
      ),
    );
  }

  _pick(BuildContext context) {
    Navigator.restorablePushNamed(
      context,
      PackExplorerLayout.routeName,
    );
    addonController.loadAsync();
  }
}
