import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:mcbe_addon_merger/src/model/pack_element.dart';
import 'package:mcbe_addon_merger/src/model/pack_image.dart';
import 'package:path/path.dart' as path;

import '../controller/merge_controller.dart';
import '../model/patch.dart';
import '../util/pluralizer.dart';

class ComparerLayout extends AnimatedWidget {
  static const routeName = '/compare';

  final Logger logger;
  final MergeController mergeController;

  const ComparerLayout({
    required this.logger,
    required this.mergeController,
    Key? key,
  }) : super(key: key, listenable: mergeController);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compare Packs'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              restorationId: 'packContentsListView',
              children: [
                ExpansionTile(
                  title: const Text('Conflicts'),
                  subtitle: Text(mergeController.diff.length
                      .pluralText('file', 'files', 'conflicting')),
                  children: mergeController.diff.map((e) {
                    if (e.packElement is PackImage) {
                      return ListTile(
                        title: Text(e.filename),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.file(
                              File(path.absolute(
                                  mergeController.basePack!.directory.path,
                                  e.filename)),
                              cacheHeight: 512,
                              cacheWidth: 512,
                              height: 64,
                              width: 64,
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8),
                              child: Icon(Icons.arrow_forward),
                            ),
                            Image.file(
                              File(path.absolute(
                                  mergeController.comparePack!.directory.path,
                                  e.filename)),
                              cacheHeight: 512,
                              cacheWidth: 512,
                              height: 64,
                              width: 64,
                            ),
                          ],
                        ),
                      );
                    }

                    if (e.patches != null) {
                      return ListTile(
                        title: Text(e.filename),
                        subtitle: _buildDiff(e.packElement, e.patches!),
                      );
                    }

                    return ListTile(
                      title: Text(e.filename),
                      subtitle: Text('File Diff'),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => mergeController.compare(),
        child: const Icon(Icons.bug_report),
      ),
    );
  }

  Widget _buildDiff(PackElement packElement, List<Patch> patches) {
    final json = jsonDecode(jsonEncode(packElement));
    final texts = patches.map((e) {
      dynamic prev = json;
      final path =
          e.path.substring(1); // '${packElement.type!.jsonKey()}${e.path}';

      for (var p in path.split('/')) {
        prev = prev?[int.tryParse(p) ?? p];
      }

      switch (e.operation) {
        case PatchOperation.add:
          return '${e.path}: ADD ${e.value}';
        case PatchOperation.copy:
          return '${e.path}: COPY TO ${e.value}';
        case PatchOperation.move:
          return '${e.path}: MOVE TO ${e.value}';
        case PatchOperation.remove:
          return '${e.path}: REMOVE (was: $prev)';
        case PatchOperation.replace:
          return prev == null
              ? '${e.path}: SET WITH ${e.value}'
              : '${e.path}: REPLACE $prev WITH ${e.value}';
        case PatchOperation.test:
          return '${e.path}: TEST';
      }
    });

    return Text(texts.join('\n'));
  }
}
