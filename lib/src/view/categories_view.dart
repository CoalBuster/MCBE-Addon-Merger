import 'package:flutter/material.dart';

import '../model/pack_element.dart';

class CategoriesView extends StatelessWidget {
  final List<PackElementType> categories;
  final Function(PackElementType type)? onCategorySelected;
  final PackElementType? selected;

  const CategoriesView({
    required this.categories,
    Key? key,
    this.onCategorySelected,
    this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) {
      return const Center(
        child: SizedBox(
          width: 500,
          child: Center(
            child: Text('No elements'),
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final e = categories[index];
        return _CategoryItemView(
          title: e.asString(),
          icon: e.asIcon(),
          onTap: () => onCategorySelected?.call(e),
          selected: e == selected,
        );
      },
    );
  }
}

class _CategoryItemView extends StatelessWidget {
  final IconData icon;
  final Function()? onTap;
  final String title;
  final bool selected;

  const _CategoryItemView({
    required this.title,
    required this.icon,
    this.onTap,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.secondary;
    // final textColor = Theme.of(context).colorScheme.onSecondary;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title),
      onTap: onTap,
      selected: selected,
    );
    // return Card(
    //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    //   clipBehavior: Clip.antiAlias,
    //   child: InkWell(
    //     onTap: onTap,
    //     child: GridTile(
    //       child: Icon(icon, color: color),
    //       footer: GridTileBar(
    //         backgroundColor: color,
    //         title: Row(
    //           children: [
    //             Expanded(
    //               child: Text(
    //                 title,
    //                 style: TextStyle(
    //                   color: textColor,
    //                 ),
    //               ),
    //             ),
    //             Text(
    //               '3',
    //               style: TextStyle(
    //                 color: textColor,
    //                 fontWeight: FontWeight.bold,
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}

// class CategorizedListView extends StatelessWidget {
//   final List<PackElementType> categories;
//   final Widget Function(PackElementType type) categoryBuilder;

//   const CategorizedListView({
//     required this.categories,
//     required this.categoryBuilder,
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     if (categories.isEmpty) {
//       return const Center(
//         child: SizedBox(
//           width: 500,
//           child: Center(
//             child: Text('No elements'),
//           ),
//         ),
//       );
//     }

//     return ListView.builder(
//       itemCount: categories.length,
//       itemBuilder: (context, index) {
//         final e = categories[index];
//         return categoryBuilder(e);
//         // return ListTile(
//         //   title: Text(
//         //     e.name ?? e.path,
//         //     maxLines: 1,
//         //     overflow: TextOverflow.ellipsis,
//         //   ),
//         //   subtitle: Text(e.path),
//         //   selected: e == selected,
//         //   onTap: () => onElementSelected?.call(e),
//         // );
//       },
//     );
//   }
// }

// class CategoryGridView extends StatelessWidget {
//   final List<PackElementType> categories;
//   final Function(PackElementType type)? onCategorySelected;
//   final PackElementType? selected;

//   const CategoryGridView({
//     required this.categories,
//     Key? key,
//     this.onCategorySelected,
//     this.selected,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 32),
//       child: CustomScrollView(
//         controller: ScrollController(),
//         slivers: [
//           // SliverToBoxAdapter(
//           //   child: ManifestView(
//           //     manifest: packController.manifest!,
//           //   ),
//           // ),
//           SliverGrid.extent(
//             maxCrossAxisExtent: 320,
//             mainAxisSpacing: 8,
//             crossAxisSpacing: 8,
//             children: categories
//                 .map((e) => _PackCategoryTile(
//                       title: e.asString(),
//                       icon: e.asIcon(),
//                       onTap: () => onCategorySelected?.call(e),
//                     ))
//                 .toList(),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CategoryRailView extends StatelessWidget {
//   final List<PackElementType> categories;
//   final Function(PackElementType type)? onCategorySelected;
//   final PackElementType? selected;

//   const CategoryRailView({
//     required this.categories,
//     Key? key,
//     this.onCategorySelected,
//     this.selected,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) => SingleChildScrollView(
//         child: ConstrainedBox(
//           constraints: BoxConstraints(minHeight: constraints.maxHeight),
//           child: IntrinsicHeight(
//             child: NavigationRail(
//               destinations: categories
//                   .map((e) => NavigationRailDestination(
//                         icon: Icon(e.asIcon()),
//                         label: Text(e.asString()),
//                       ))
//                   .toList(),
//               selectedIndex:
//                   selected == null ? null : categories.indexOf(selected!),
//               onDestinationSelected: (index) =>
//                   onCategorySelected?.call(categories[index]),
//             ),
//           ),
//         ),
//       ),
//     );
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
//             title: Row(
//               children: [
//                 Expanded(
//                   child: Text(
//                     title,
//                     style: TextStyle(
//                       color: textColor,
//                     ),
//                   ),
//                 ),
//                 Text(
//                   '3',
//                   style: TextStyle(
//                     color: textColor,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
