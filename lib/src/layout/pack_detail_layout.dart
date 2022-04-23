import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../controller/pack_controller.dart';
import '../model/pack_element_type.dart';
import '../view/manifest_view.dart';
import '../view/pack_view.dart';
import 'animation_controller_layout.dart';

class PackDetailLayout extends StatefulWidget {
  static const routeName = '/pack';

  final Logger logger;
  final PackController packController;

  const PackDetailLayout({
    required this.logger,
    required this.packController,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PackDetailLayoutState();
}

class _PackDetailLayoutState extends State<PackDetailLayout> {
  PackElementType? selected;
  int? index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pack Details'),
      ),
      body: AnimatedBuilder(
        animation: widget.packController,
        builder: (context, child) {
          final pack = widget.packController.pack;

          if (pack == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Column(
            children: [
              ManifestView(
                manifest: pack.manifest,
              ),
              if (selected != null)
                ListTile(
                  leading: BackButton(
                    onPressed: () => setState(() {
                      selected = index == null ? null : selected;
                      index = null;
                    }),
                  ),
                  title: Text(selected!.name),
                ),
              Expanded(
                child: PackView(
                  packController: widget.packController,
                  onElementSelected: (type, item) =>
                      _onElementSelected(context, type, item),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _onElementSelected(
      BuildContext context, PackElementType type, String item) {
    switch (type) {
      case PackElementType.animationController:
        Navigator.restorablePushNamed(
          context,
          AnimationControllerLayout.routeName,
          arguments: item,
        );
        break;
      default:
        widget.logger.w('Unhandled PackElementType $type');
        break;
    }
  }
}
