import 'package:flutter/material.dart';

import '../model/pack_element.dart';

class ElementsView extends StatelessWidget {
  final Iterable<PackElementInfo> elements;
  final Function(PackElementInfo element)? onElementSelected;
  final PackElementInfo? selected;

  const ElementsView({
    required this.elements,
    Key? key,
    this.onElementSelected,
    this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverGrid.extent(
          childAspectRatio: 1.5,
          maxCrossAxisExtent: 240,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          children: elements
              .map((e) => _ElementItemView(
                    title: e.name ?? e.path,
                    icon: Icons.ac_unit,
                    onTap: () => onElementSelected?.call(e),
                  ))
              .toList(),
        ),
      ],
    );
  }
}

class _ElementItemView extends StatelessWidget {
  final IconData icon;
  final Function()? onTap;
  final String title;

  const _ElementItemView({
    required this.title,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.secondary;
    final textColor = Theme.of(context).colorScheme.onSecondary;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: GridTile(
          child: Icon(icon, color: color),
          footer: GridTileBar(
            backgroundColor: color,
            title: Text(
              title,
              style: TextStyle(
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// class ElementGridView extends StatelessWidget {
//   final Iterable<PackElementInfo> elements;
//   final Function(PackElementInfo element)? onElementSelected;
//   final PackElementInfo? selected;

//   const ElementGridView({
//     required this.elements,
//     Key? key,
//     this.onElementSelected,
//     this.selected,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final categories = elements.map((e) => e.type).toSet().toList();

//     return CustomScrollView(
//       slivers: categories
//           .expand((e) => [
//                 SliverToBoxAdapter(
//                   child: Text(e.asString()),
//                 ),
//                 SliverGrid.extent(
//                   childAspectRatio: 1.5,
//                   maxCrossAxisExtent: 240,
//                   mainAxisSpacing: 8,
//                   crossAxisSpacing: 8,
//                   children: elements
//                       .where((element) => element.type == e)
//                       .map((e) => _PackCategoryTile(
//                             title: e.name ?? e.path,
//                             icon: Icons.ac_unit,
//                             onTap: () => onElementSelected?.call(e),
//                           ))
//                       .toList(),
//                 ),
//               ])
//           .toList(),
//     );

//     // ListView.builder(
//     //   itemCount: categories.length,
//     //   itemBuilder: (context, index) {
//     //     final e = categories[index];
//     //     return categoryBuilder(e);

//     // return Column(
//     //   crossAxisAlignment: CrossAxisAlignment.start,
//     //   children: [
//     //     Text(category.asString()),
//     //     SizedBox(
//     //       // height: 160,
//     //       child: GridView.builder(
//     //         shrinkWrap: true,
//     //         // scrollDirection: Axis.horizontal,
//     //         gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//     //           childAspectRatio: 0.7,
//     //           maxCrossAxisExtent: 160,
//     //           mainAxisSpacing: 8,
//     //           crossAxisSpacing: 8,
//     //         ),
//     //         itemCount: elements.length,
//     //         itemBuilder: (context, index) {
//     //           var e = elements[index];
//     //           return _PackCategoryTile(
//     //             title: e.name ?? e.path,
//     //             icon: Icons.ac_unit,
//     //             onTap: () {}, //=> onCategorySelected?.call(e),
//     //           );
//     //         },
//     //       ),
//     //     ),
//     //   ],
//     // );
//   }
// }

// class _PackCategoryTile extends StatelessWidget {
//   final IconData icon;
//   final Function()? onTap;
//   final String title;

//   const _PackCategoryTile({
//     required this.title,
//     required this.icon,
//     this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final color = Theme.of(context).colorScheme.secondary;
//     final textColor = Theme.of(context).colorScheme.onSecondary;

//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       clipBehavior: Clip.antiAlias,
//       child: InkWell(
//         onTap: onTap,
//         child: GridTile(
//           child: Icon(icon, color: color),
//           footer: GridTileBar(
//             backgroundColor: color,
//             title: Text(
//               title,
//               style: TextStyle(
//                 color: textColor,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ElementListView extends StatelessWidget {
//   final List<PackElementInfo> elements;
//   final Function(PackElementInfo elementInfo)? onElementSelected;
//   final PackElementInfo? selected;

//   const ElementListView({
//     required this.elements,
//     Key? key,
//     this.onElementSelected,
//     this.selected,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     if (elements.isEmpty) {
//       return const Center(
//         child: SizedBox(
//           width: 300,
//           child: Center(
//             child: Text('No elements'),
//           ),
//         ),
//       );
//     }

//     return Center(
//       child: SizedBox(
//         width: 300,
//         child: ListView.builder(
//           itemCount: elements.length,
//           itemBuilder: (context, index) {
//             final e = elements[index];
//             return ListTile(
//               title: Text(
//                 e.name ?? e.path,
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//               ),
//               subtitle: Text(e.path),
//               selected: e == selected,
//               onTap: () => onElementSelected?.call(e),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   // void _onElementSelected(
//   //   BuildContext context,
//   //   /*bool mobile, PackElementInfo elementId*/
//   // ) {
//   //   packController.unselectAll();
//   //   // packController.select(elementId);
//   //   // elementController.loadElementByIdAsync(packController.id!, elementId);

//   //   if (true /*mobile*/) {
//   //     Navigator.restorablePushNamed(context, PackElementLayout.routeName);
//   //   }
//   // }
// }
