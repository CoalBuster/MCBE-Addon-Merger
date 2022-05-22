import 'package:flutter/material.dart';

import '../controller/pack_picker_controller.dart';
import '../model/pack.dart';
import '../view/pack_list_view.dart';

class PackPickerLayout extends AnimatedWidget {
  static const routeName = '/pack-picker';

  final PackPickerController packPickerController;

  const PackPickerLayout({
    required this.packPickerController,
    Key? key,
  }) : super(key: key, listenable: packPickerController);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick Pack'),
        actions: [
          IconButton(
              icon: const Icon(Icons.folder),
              onPressed: () => packPickerController.loadAsync())
        ],
      ),
      body: packPickerController.loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : PackListView(
              onPackTapped: (pack) => _onPacksSelected(context, pack),
              packs: packPickerController.packs,
              // selected: _packs,
            ),
    );
  }

  void _onPacksSelected(BuildContext context, Pack pack) {
    Navigator.pop(context, pack);
  }
}
