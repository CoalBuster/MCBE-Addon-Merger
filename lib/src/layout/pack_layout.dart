import 'package:flutter/material.dart';

import '../controller/element_controller.dart';
import '../controller/pack_controller.dart';
import '../model/pack_element.dart';
import '../view/categories_view.dart';
import '../view/elements_view.dart';
import 'element_layout.dart';

class PackLayout extends StatefulWidget {
  static const routeName = '/pack';

  final PackElementController elementController;
  final PackController packController;

  const PackLayout({
    required this.elementController,
    required this.packController,
    Key? key,
  }) : super(key: key);

  @override
  State<PackLayout> createState() => _PackLayoutState();
}

class _PackLayoutState extends State<PackLayout> {
  PackElementCategory? _category;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final mobile = constraints.maxWidth < 850;

        return Scaffold(
          appBar: AppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.packController.manifest!.header.name),
                Text(
                  widget.packController.manifest!.isBehaviorPack
                      ? 'Behavior Pack'
                      : 'Resource Pack',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          drawer: mobile
              ? Drawer(
                  child: CategoriesView(
                    categories: widget.packController.categories,
                    onCategorySelected: (type) => setState(() {
                      _category = type;
                      Navigator.pop(context);
                    }),
                    selected: _category,
                  ),
                )
              : null,
          body: Row(
            children: [
              if (!mobile || _category == null)
                Flexible(
                  flex: 1,
                  child: CategoriesView(
                    categories: widget.packController.categories,
                    onCategorySelected: (type) => setState(() {
                      _category = type;
                    }),
                    selected: _category,
                  ),
                ),
              if (!mobile || _category != null)
                Flexible(
                  flex: 2,
                  child: ElementsView(
                    elements: widget.packController.elements
                        .where((e) => e.category == _category),
                    onElementSelected: (e) => _onElementSelected(context, e),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  _onElementSelected(BuildContext context, PackElementInfo element) {
    widget.elementController
        .loadElementByIdAsync(widget.packController.id!, element);
    Navigator.restorablePushNamed(context, ElementLayout.routeName);
  }
}
