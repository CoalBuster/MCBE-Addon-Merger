import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../controller/element_controller.dart';
import '../controller/pack_controller.dart';
import '../model/pack_element.dart';
import '../view/manifest_view.dart';
import '../view/pack_detail_view.dart';
import '../view/pack_element_view.dart';
import 'pack_element_layout.dart';

class PackElementLayout extends AnimatedWidget {
  static const routeName = '/pack/element';

  final PackElementController elementController;

  const PackElementLayout({
    required this.elementController,
    Key? key,
  }) : super(key: key, listenable: elementController);

  @override
  Widget build(BuildContext context) {
    // return LayoutBuilder(
    //   builder: (context, constraints) {
    //     final mobile = constraints.maxWidth < 650;
    //     if (mobile) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pack Detaills'),
      ),
      // body: PackElementListView(
      //   elementController: elementController,
      //   // onElementSelected: (e) => _onElementSelected(context, mobile, e),
      // ),
    );
    // }

    //   return Scaffold(
    //     appBar: AppBar(
    //       title: const Text('Pack Details'),
    //     ),
    //     body: Row(
    //       children: [
    //         SizedBox(
    //           width: 360,
    //           child: Column(
    //             children: [
    //               Padding(
    //                 padding: const EdgeInsets.all(8),
    //                 child: ManifestView(
    //                   manifest: packController.manifest!,
    //                 ),
    //               ),
    //               Expanded(
    //                 child: PackDetailView(
    //                   packController: packController,
    //                   onElementSelected: (e) =>
    //                       _onElementSelected(context, mobile, e),
    //                   showManifest: false,
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //         Expanded(
    //           child: Card(
    //             color: Theme.of(context).primaryColor,
    //             elevation: 0,
    //             margin: const EdgeInsets.all(8),
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 if (elementController.path != null)
    //                   Padding(
    //                     padding: const EdgeInsets.symmetric(
    //                         vertical: 8, horizontal: 16),
    //                     child: Text(
    //                       elementController.name ?? elementController.path!,
    //                       style: Theme.of(context).textTheme.headline5,
    //                     ),
    //                   ),
    //                 Expanded(
    //                   child: PackElementDetailView(
    //                     elementController: elementController,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   );
    // },
    // );
  }

  void _onElementSelected(
      BuildContext context, bool mobile, PackElementInfo elementId) {
    // packController.unselectAll();
    // packController.select(elementId);
    // elementController.loadElementByIdAsync(packController.id!, elementId);

    if (mobile) {
      Navigator.restorablePushNamed(context, PackElementLayout.routeName);
    }
  }
}

// import 'package:flutter/material.dart';

// import '../controller/element_controller.dart';
// import '../view/pack_element_view.dart';

// class PackElementLayout extends StatelessWidget {
//   static const routeName = '/pack/element';

//   final PackElementController elementController;

//   const PackElementLayout({
//     required this.elementController,
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // final element = elementController.selectedElement;
//     // final name = elementController.selectedElementName ?? element?.name;
//     // final path = elementController.selectedElementPath;
//     // final patches = elementController.patches;
//     final name = elementController.name;
//     final path = elementController.path;

//     return Scaffold(
//       appBar: AppBar(
//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Text(name ?? path ?? 'Pack Element Details'),
//             if (name != null && path != null)
//               Text(
//                 path,
//                 style: const TextStyle(fontSize: 14),
//               ),
//           ],
//         ),
//       ),
//       body: PackElementDetailView(
//         elementController: elementController,
//         // addonRepository: packController.addonRepository,
//         // element: element,
//         // name: name,
//         // pack: packController.pack,
//         // patches: patches,
//       ),
//     );
//   }
// }
