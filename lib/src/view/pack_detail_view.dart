import 'package:flutter/material.dart';

import '../controller/pack_controller.dart';
import '../layout/pack_element_layout.dart';
import '../model/pack_element.dart';
import '../view/manifest_view.dart';
import '../sliver/pack_content_sliver.dart';

class PackDetailView extends AnimatedWidget {
  final Function(PackElementInfo elementInfo)? onElementSelected;
  final PackController packController;

  const PackDetailView({
    required this.packController,
    Key? key,
    this.onElementSelected,
  }) : super(key: key, listenable: packController);

  @override
  Widget build(BuildContext context) {
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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: CustomScrollView(
        controller: ScrollController(),
        slivers: [
          SliverToBoxAdapter(
            child: ManifestView(
              manifest: packController.manifest!,
            ),
          ),
          SliverGrid.extent(
            maxCrossAxisExtent: 320,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            children: packController.categories
                .map((e) => _PackCategoryTile(
                      title: e.asString(),
                      icon: Icons.ac_unit,
                      // onTap: () => _onElementSelected(context),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  // Iterable<PackElementInfo> _splitOnName(Iterable<PackElementInfo> iterable) =>
  //     iterable.expand(
  //         (e) => (e.name ?? e.path).split(',').map((n) => PackElementInfo(
  //               path: e.path,
  //               type: e.type,
  //               name: n.trim(),
  //               formatVersion: e.formatVersion,
  //             )));

  // void _onElementSelected(
  //   BuildContext context,
  //   /*bool mobile, PackElementInfo elementId*/
  // ) {
  //   packController.unselectAll();
  //   // packController.select(elementId);
  //   // elementController.loadElementByIdAsync(packController.id!, elementId);

  //   if (true /*mobile*/) {
  //     Navigator.restorablePushNamed(context, PackElementLayout.routeName);
  //   }
  // }
}

class _PackCategoryTile extends StatelessWidget {
  final IconData icon;
  final Function()? onTap;
  final String title;

  const _PackCategoryTile({
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
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: textColor,
                    ),
                  ),
                ),
                Text(
                  '3',
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
