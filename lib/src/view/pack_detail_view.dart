import 'package:flutter/material.dart';

import '../controller/pack_controller.dart';
import '../model/pack_element.dart';
import '../view/manifest_view.dart';
import '../sliver/pack_content_sliver.dart';

class PackDetailView extends AnimatedWidget {
  final Function(PackElementInfo elementInfo)? onElementSelected;
  final PackController packController;
  final bool showManifest;

  const PackDetailView({
    required this.packController,
    Key? key,
    this.onElementSelected,
    this.showManifest = true,
  }) : super(key: key, listenable: packController);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: packController,
      builder: (context, child) {
        if (packController.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (packController.id == null) {
          return const Center(
            child: Text('No Pack selected'),
          );
        }

        return CustomScrollView(
          controller: ScrollController(),
          slivers: [
            if (showManifest)
              SliverToBoxAdapter(
                child: ManifestView(
                  manifest: packController.manifest!,
                ),
              ),
            if (showManifest)
              const SliverToBoxAdapter(
                child: Divider(height: 1),
              ),
            PackContentSliver(
              content: packController.elements!,
              moduleTypes: packController.manifest!.moduleTypes,
              onElementSelected: onElementSelected,
              selected: packController.selectedElement == null
                  ? []
                  : [packController.selectedElement!],
            ),
          ],
        );
      },
    );
  }
}
