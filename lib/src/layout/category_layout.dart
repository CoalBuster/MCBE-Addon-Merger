import 'package:flutter/material.dart';

import '../controller/element_controller.dart';
import '../controller/pack_controller.dart';
import '../model/pack_element_json.dart';
import '../view/elements_view.dart';
import 'element_layout.dart';

// class CategoryLayout extends StatelessWidget {
//   static const routeName = '/pack/category';

//   final PackElementController elementController;
//   final PackController packController;

//   const CategoryLayout({
//     required this.elementController,
//     required this.packController,
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final mobile = constraints.maxWidth < 850;

//         if (!mobile) {
//           Navigator.pop(context);
//         }

//         return Scaffold(
//           appBar: AppBar(
//               // title: Text(packController.category?.asString() ?? 'Category'),
//               ),
//           body: ElementListView(
//             elements: packController.elements,
//             onElementSelected: (e) => _onElementSelected(context, e),
//           ),
//         );
//       },
//     );
//   }

//   _onElementSelected(BuildContext context, PackElementInfo elementId) {
//     elementController.loadElementByIdAsync(packController.id!, elementId);
//     Navigator.restorablePushNamed(context, ElementLayout.routeName);
//   }
// }
