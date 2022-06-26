import 'package:flutter/material.dart';

import '../controller/merge_controller.dart';
import '../repository/addon_picker.dart';

class CompareSelectionView extends AnimatedWidget {
  final AddonPicker addonPicker;
  final MergeController mergeController;

  const CompareSelectionView({
    required this.addonPicker,
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
              : Text(mergeController.basePack!.header.name),
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
              : Text(mergeController.comparePack!.header.name),
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
    // final _pack =
    //     await Navigator.pushNamed<Pack>(context, PackPickerLayout.routeName);
    // mergeController.loadBasePack(_pack);
  }

  _pickCompare(BuildContext context) async {
    // final _pack =
    //     await Navigator.pushNamed<Pack>(context, PackPickerLayout.routeName);
    // mergeController.loadComparePack(_pack);
  }
}
