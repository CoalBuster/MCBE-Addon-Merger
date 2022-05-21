import 'package:flutter/material.dart';

import '../controller/merge_controller.dart';
import '../view/compare_selection_view.dart';
import 'comparer_layout.dart';

class CompareSelectionLayout extends AnimatedWidget {
  static const routeName = '/compare-picker';

  final MergeController mergeController;

  const CompareSelectionLayout({
    required this.mergeController,
    Key? key,
  }) : super(key: key, listenable: mergeController);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Packs to Compare'),
      ),
      body: CompareSelectionView(
        mergeController: mergeController,
      ),
      floatingActionButton:
          !mergeController.packsSelected || mergeController.packsLoading
              ? null
              : FloatingActionButton(
                  child: const Icon(Icons.arrow_forward),
                  onPressed: () => _compare(context),
                ),
    );
  }

  _compare(BuildContext context) {
    mergeController.compare();
    Navigator.restorablePushNamed(context, ComparerLayout.routeName);
  }
}