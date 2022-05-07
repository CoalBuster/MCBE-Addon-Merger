import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../controller/pack_controller.dart';
import '../model/pack_element_type.dart';
import '../view/manifest_view.dart';
import '../view/pack_view.dart';
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

          return Column(
            children: [
              ManifestView(
                pack: pack,
              ),
              const Divider(
                height: 0,
              ),
              Expanded(
                child: PackView(
                  packController: packController,
                  onElementSelected: (type, path, [name]) =>
                      _onElementSelected(context, type, path, name),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _onElementSelected(
      BuildContext context, PackElementType type, String path, String? name) {
    Navigator.restorablePushNamed(
      context,
      PackElementLayout.routeName,
      arguments: [path, name],
    );
  }
}
