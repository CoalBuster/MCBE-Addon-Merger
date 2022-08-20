import 'package:flutter/material.dart';

import '../controller/element_controller.dart';
import '../view/pack_element_view.dart';

class PackElementLayout extends StatelessWidget {
  static const routeName = '/pack/element';

  final PackElementController elementController;

  const PackElementLayout({
    required this.elementController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final element = elementController.selectedElement;
    // final name = elementController.selectedElementName ?? element?.name;
    // final path = elementController.selectedElementPath;
    // final patches = elementController.patches;
    final name = elementController.name;
    final path = elementController.path;

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
      body: PackElementDetailView(
        elementController: elementController,
        // addonRepository: packController.addonRepository,
        // element: element,
        // name: name,
        // pack: packController.pack,
        // patches: patches,
      ),
    );
  }
}
