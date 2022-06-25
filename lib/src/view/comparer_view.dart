import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mcbe_addon_merger_core/mcbe_addon_merger_core.dart';
import 'package:path/path.dart' as path;

import '../model/pack_difference.dart';
import '../util/pluralizer.dart';

class ComparerView extends StatelessWidget {
  final Manifest basePack;
  final Manifest comparePack;
  final List<PackDifference> diff;
  final Function(PackDifference difference)? onDiffSelected;
  final ScrollController? scrollController;

  ComparerView({
    required this.basePack,
    required this.comparePack,
    required this.diff,
    Key? key,
    this.onDiffSelected,
    ScrollController? scrollController,
  })  : scrollController = scrollController ?? ScrollController(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      restorationId: 'packCompareListView',
      children: [
        ExpansionTile(
          title: const Text('Conflicts'),
          subtitle:
              Text(diff.length.pluralText('file', 'files', 'conflicting')),
          children: diff
              .map((e) => ListTile(
                    title: Text(e.filename),
                    subtitle: Text(_typeOfElementToString(e.packElement)),
                    onTap: e.packElement is PackImage
                        ? null
                        : () => onDiffSelected?.call(e),
                    trailing: e.packElement is PackImage
                        ? _buildImageDiff(e.filename)
                        : null,
                  ))
              .toList(),
        ),
      ],
    );
  }

  String _typeOfElementToString(dynamic packElement) {
    switch (packElement?.runtimeType) {
      case PackImage:
        return 'Image';
      case PackElement:
        return (packElement as PackElement).type!.asString();
      default:
        return 'File';
    }
  }

  _buildImageDiff(String filename) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Image.file(
        //   File(path.absolute(basePack.directory.path, filename)),
        //   cacheHeight: 512,
        //   cacheWidth: 512,
        //   height: 64,
        //   width: 64,
        // ),
        const Icon(Icons.arrow_forward),
        // Image.file(
        //   File(path.absolute(comparePack.directory.path, filename)),
        //   cacheHeight: 512,
        //   cacheWidth: 512,
        //   height: 64,
        //   width: 64,
        // ),
      ],
    );
  }
}
