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
  PackElementType? _category;

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
                        .where((e) => e.type == _category),
                    onElementSelected: (e) => _onElementSelected(context, e),
                  ),
                ),
            ],
          ),
          // body: mobile
          //     ? _category == null
          //         ? CategoriesView(
          //             categories: widget.packController.categories,
          //             onCategorySelected: (type) =>
          //                 _onCategorySelected(context, type),
          //           )
          //         : ElementsView(elements: _importantElements())
          //     : _PackWideLayout(
          //         elementController: widget.elementController,
          //         packController: widget.packController,
          //       ),
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

//   _onCategorySelected(BuildContext context, PackElementType type) {
//     setState(() {
//       _category = type;
//     });
//     // packController.category = type;
//     // Navigator.restorablePushNamed(context, CategoryLayout.routeName);
//   }
// }

// class _PackWideLayout extends AnimatedWidget {
//   final PackElementController elementController;
//   final PackController packController;

//   _PackWideLayout({
//     required this.elementController,
//     required this.packController,
//     Key? key,
//   }) : super(
//           key: key,
//           listenable: Listenable.merge([elementController, packController]),
//         );

//   @override
//   Widget build(BuildContext context) {
//     final elements = _importantElements(packController);

//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 32),
//       child: ElementsView(
//         elements: elements,
//         onElementSelected: (e) => _onElementSelected(context, e),
//       ),
//     );
//   }

//   _onElementSelected(BuildContext context, PackElementInfo element) {
//     elementController.loadElementByIdAsync(packController.id!, element);
//     Navigator.restorablePushNamed(context, ElementLayout.routeName);
//   }
// }

// List<PackElementInfo> _importantElements(PackController packController) {
//   return packController.elements.where((element) {
//     switch (element.type) {
//       case PackElementType.entity:
//         return element.name == 'minecraft:player';
//       case PackElementType.recipeShaped:
//       case PackElementType.recipeShapeless:
//         return true;
//       case PackElementType.animationControllers:
//       case PackElementType.animations:
//       case PackElementType.image:
//       case PackElementType.item:
//       case PackElementType.lootTable:
//       case PackElementType.unknown:
//       default:
//         return false;
//     }
//   }).toList();
// }
