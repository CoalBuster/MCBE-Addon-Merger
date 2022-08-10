import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../controller/pack_controller.dart';
import '../model/pack_element.dart';
import '../view/manifest_view.dart';
import '../sliver/pack_content_sliver.dart';
import 'pack_element_layout.dart';

class PackDetailLayout extends StatelessWidget {
  static const routeName = '/pack';

  final Logger logger;
  final PackController packController;

  const PackDetailLayout({
    required this.logger,
    required this.packController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pack Details'),
      ),
      body: AnimatedBuilder(
        animation: packController,
        builder: (context, child) {
          final pack = packController.pack;

          if (pack == null) {
            return const Center(
              child: Text('No Pack selected'),
            );
          }

          if (packController.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: ManifestView(
                  manifest: pack,
                ),
              ),
              const SliverToBoxAdapter(
                child: Divider(height: 1),
              ),
              PackContentSliver(
                content: packController.elements!,
                moduleTypes: pack.moduleTypes,
                onElementSelected: (type, path, [name]) =>
                    _onElementSelected(context, type, path, name),
              ),
            ],
          );
        },
      ),
    );
  }

  void _onElementSelected(
      BuildContext context, PackElementType type, String path, String? name) {
    packController.selectElement(path, name);
    Navigator.restorablePushNamed(context, PackElementLayout.routeName);
  }
}
