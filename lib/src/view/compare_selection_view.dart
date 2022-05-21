import 'package:flutter/material.dart';

import '../controller/merge_controller.dart';
import '../layout/pack_picker_layout.dart';
import '../model/pack.dart';

class CompareSelectionView extends AnimatedWidget {
  final MergeController mergeController;

  const CompareSelectionView({
    required this.mergeController,
    Key? key,
  }) : super(key: key, listenable: mergeController);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        if (mergeController.packsLoading) const LinearProgressIndicator(),
        ListTile(
          title: mergeController.basePack == null
              ? const Text('Pick Base Pack')
              : Text(mergeController.basePack!.manifest.header.name),
          subtitle: mergeController.basePack == null
              ? const Text('Select..')
              : const Text('Base Pack'),
          leading: mergeController.basePack == null
              ? const Icon(Icons.arrow_forward)
              : const Icon(Icons.check),
          onTap: () => _pickBase(context),
        ),
        ListTile(
          title: mergeController.comparePack == null
              ? const Text('Pick Comparing Pack')
              : Text(mergeController.comparePack!.manifest.header.name),
          subtitle: mergeController.comparePack == null
              ? const Text('Select..')
              : const Text('Comparing Pack'),
          leading: mergeController.comparePack == null
              ? const Icon(Icons.arrow_forward)
              : const Icon(Icons.check),
          onTap: () => _pickCompare(context),
        ),
      ],
    );
  }

  _pickBase(BuildContext context) async {
    final _pack =
        await Navigator.pushNamed<Pack>(context, PackPickerLayout.routeName);
    mergeController.loadBasePack(_pack);
  }

  _pickCompare(BuildContext context) async {
    final _pack =
        await Navigator.pushNamed<Pack>(context, PackPickerLayout.routeName);
    mergeController.loadComparePack(_pack);
  }
}