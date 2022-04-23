import 'package:flutter/material.dart';

import '../controller/pack_controller.dart';
import '../model/pack_element_type.dart';

class PackView extends StatelessWidget {
  final Function(PackElementType type, String item)? onElementSelected;
  final PackController packController;

  const PackView({
    required this.packController,
    Key? key,
    this.onElementSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = packController;
    final pack = packController.pack;

    if (controller.loading) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            Text(controller.statusMessage ?? ''),
          ],
        ),
      );
    }

    if (pack == null) {
      return const Center(
        child: Text('No pack selected'),
      );
    }

    return ListView(
      restorationId: 'packContentsListView',
      children: [
        ExpansionTile(
          title: const Text('Animation Controllers'),
          subtitle:
              Text('${controller.animationControllers.length} controller(s)'),
          children: controller.animationControllers.entries
              .map((e) => ListTile(
                    title: Text(e.key),
                    onTap: () => onElementSelected?.call(
                        PackElementType.animationController, e.key),
                  ))
              .toList(),
        ),
        if (pack.isBehaviorPack)
          ExpansionTile(
            title: const Text('Enitities'),
            subtitle:
                Text('${controller.entities.length} (server-side) entities'),
            children: controller.entities
                .map((e) => ListTile(
                      title: Text(e.description.identifier),
                      onTap: () => onElementSelected?.call(
                          PackElementType.entity, e.description.identifier),
                    ))
                .toList(),
          ),
      ],
    );
  }
}
