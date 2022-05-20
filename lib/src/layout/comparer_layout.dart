import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../controller/merge_controller.dart';
import '../view/comparer_view.dart';
import '../view/pack_element_view.dart';

class ComparerLayout extends StatefulWidget {
  static const routeName = '/compare';

  final Logger logger;
  final MergeController mergeController;

  const ComparerLayout({
    required this.logger,
    required this.mergeController,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ComparerLayoutState();
}

class _ComparerLayoutState extends State<ComparerLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compare Packs'),
      ),
      body: AnimatedBuilder(
        animation: widget.mergeController,
        builder: (context, child) => Row(
          children: [
            Expanded(
              child: !widget.mergeController.packsLoaded
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ComparerView(
                      basePack: widget.mergeController.basePack!,
                      comparePack: widget.mergeController.comparePack!,
                      diff: widget.mergeController.diff,
                    ),
            ),
            Expanded(
              child: PackElementDetailView(
                element: widget.mergeController.diff.firstOrNull?.packElement,
                name: null,
                patches: widget.mergeController.diff.firstOrNull?.patches,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => widget.mergeController.compare(),
        child: const Icon(Icons.bug_report),
      ),
    );
  }
}

//   Widget _buildDiff(PackElement packElement, List<Patch> patches) {
//     final json = jsonDecode(jsonEncode(packElement));
//     final texts = patches.map((e) {
//       dynamic prev = json;
//       final path =
//           e.path.substring(1); // '${packElement.type!.jsonKey()}${e.path}';

//       for (var p in path.split('/')) {
//         prev = prev?[int.tryParse(p) ?? p];
//       }

//       switch (e.operation) {
//         case PatchOperation.add:
//           return '${e.path}: ADD ${e.value}';
//         case PatchOperation.copy:
//           return '${e.path}: COPY TO ${e.value}';
//         case PatchOperation.move:
//           return '${e.path}: MOVE TO ${e.value}';
//         case PatchOperation.remove:
//           return '${e.path}: REMOVE (was: $prev)';
//         case PatchOperation.replace:
//           return prev == null
//               ? '${e.path}: SET WITH ${e.value}'
//               : '${e.path}: REPLACE $prev WITH ${e.value}';
//         case PatchOperation.test:
//           return '${e.path}: TEST';
//       }
//     });

//     return Text(texts.join('\n'));
//   }
// }
