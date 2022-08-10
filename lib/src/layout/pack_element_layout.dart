import 'package:flutter/material.dart';

import '../controller/pack_controller.dart';
import '../view/pack_element_view.dart';

class PackElementLayout extends StatelessWidget {
  static const routeName = '/pack/element';

  final PackController packController;

  const PackElementLayout({
    required this.packController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final element = packController.selectedElement;
    final name = packController.selectedElementName ?? element?.name;
    final path = packController.selectedElementPath;
    final patches = packController.patches;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(name ?? path ?? 'Pack Element Details'),
            if (name != null && path != null)
              Text(
                path,
                style: const TextStyle(fontSize: 14),
              ),
          ],
        ),
      ),
      body: element == null
          ? const Center(
              child: Text('No Element selected'),
            )
          : PackElementDetailView(
              addonRepository: packController.addonRepository,
              element: element,
              name: name,
              pack: packController.pack,
              patches: patches,
            ),
    );
  }
}
