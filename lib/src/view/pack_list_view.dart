import 'package:flutter/material.dart';

import '../controller/addon_controller.dart';
import '../model/manifest.dart';
import 'pack_view.dart';

class PackListView extends AnimatedWidget {
  final AddonController addonController;
  final Function(Manifest pack)? onPackTapped;

  const PackListView({
    required this.addonController,
    Key? key,
    this.onPackTapped,
  }) : super(key: key, listenable: addonController);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 600,
        child: ListView.builder(
          shrinkWrap: true,
          restorationId: 'packListView',
          itemCount: addonController.packs.length,
          itemBuilder: (BuildContext context, int index) {
            final pack = addonController.packs[index];
            return PackView(
              addonController: addonController,
              pack: pack,
              onTap: () => onPackTapped?.call(pack),
            );
          },
        ),
      ),
    );
  }
}
// class PackListView extends StatelessWidget {
//   final AddonController addonController;
//   final Function(Manifest pack)? onPackTapped;
//   // final List<Manifest> packs;
//   // final List<Manifest> selected;

//   const PackListView({
//     required this.addonController,
//     Key? key,
//     this.onPackTapped,
//     // this.packs = const [],
//     // this.selected = const [],
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: addonController,
//       builder: (context, child) {
//         if (addonController.packs.isEmpty) {
//           return const Center(child: Text('No packs'));
//         }

//         return ListView.builder(
//           restorationId: 'packListView',
//           itemCount: addonController.packs.length,
//           itemBuilder: (BuildContext context, int index) {
//             final pack = addonController.packs[index];

//             return ListTile(
//               title: Text(pack.header.name),
//               leading: FutureBuilder<Uint8List?>(
//                 future: addonController.getPackIconAsync(pack.header.uuid),
//                 builder: (context, snapshot) => snapshot.hasData
//                     ? CircleAvatar(
//                         backgroundImage: MemoryImage(snapshot.data!),
//                       )
//                     : const CircleAvatar(),
//               ),
//               selected: addonController.isSelected(pack.header.uuid),
//               subtitle: Text('v${pack.header.version} | ' +
//                   (pack.isBehaviorPack
//                       ? 'Behavior Pack'
//                       : pack.isResourcePack
//                           ? 'Resource Pack'
//                           : 'Unknown Pack')),
//               onTap: () {
//                 if (addonController.multiSelectMode) {
//                   addonController.isSelected(pack.header.uuid)
//                       ? addonController.unselect(pack.header.uuid)
//                       : addonController.select(pack.header.uuid);
//                 } else {
//                   addonController.select(pack.header.uuid);
//                   onPackTapped?.call(pack);
//                 }
//               },
//               onLongPress: () {
//                 addonController.select(pack.header.uuid, true);
//               },
//             );
//           },
//         );
//       },
//     );
//   }
// }
