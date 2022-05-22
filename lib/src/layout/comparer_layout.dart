import 'package:flutter/material.dart';

import '../controller/merge_controller.dart';
import '../controller/pack_controller.dart';
import '../model/pack_difference.dart';
import '../view/comparer_view.dart';
import 'pack_element_layout.dart';

class ComparerLayout extends AnimatedWidget {
  static const routeName = '/compare';

  final MergeController mergeController;
  final PackController packController;

  const ComparerLayout({
    required this.mergeController,
    required this.packController,
    Key? key,
  }) : super(key: key, listenable: mergeController);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pack Comparison'),
      ),
      body: ComparerView(
        basePack: mergeController.basePack!,
        comparePack: mergeController.comparePack!,
        diff: mergeController.diff,
        onDiffSelected: (diff) => _onDiffSelected(context, diff),
      ),
    );
  }

  void _onDiffSelected(BuildContext context, PackDifference difference) {
    packController.packContent = mergeController.basePackContent;
    packController.patches = difference.patches;
    packController.selectElement(difference.filename);
    Navigator.restorablePushNamed(context, PackElementLayout.routeName);
  }
}
