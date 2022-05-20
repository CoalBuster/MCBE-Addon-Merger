import 'package:flutter/material.dart';

import '../model/pack.dart';
import '../model/pack_difference.dart';
import '../model/pack_element.dart';
import '../model/pack_image.dart';
import '../util/pluralizer.dart';

class ComparerView extends StatelessWidget {
  final Pack basePack;
  final Pack comparePack;
  final List<PackDifference> diff;
  final ScrollController? scrollController;

  ComparerView({
    required this.basePack,
    required this.comparePack,
    required this.diff,
    ScrollController? scrollController,
    Key? key,
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
                    subtitle: Text(_d(e)),
                  ))
              .toList(),
        ),
      ],
    );
  }
}

String _d(PackDifference diff) {
  switch (diff.packElement?.runtimeType) {
    case PackImage:
      return 'Image';
    case PackElement:
      return (diff.packElement as PackElement).type!.asString();
    default:
      return 'File';
  }
}

// Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Image.file(
//                       File(path.absolute(basePack.directory.path, e.filename)),
//                       cacheHeight: 512,
//                       cacheWidth: 512,
//                       height: 64,
//                       width: 64,
//                     ),
//                     const Padding(
//                       padding: EdgeInsets.all(8),
//                       child: Icon(Icons.arrow_forward),
//                     ),
//                     Image.file(
//                       File(path.absolute(
//                           comparePack.directory.path, e.filename)),
//                       cacheHeight: 512,
//                       cacheWidth: 512,
//                       height: 64,
//                       width: 64,
//                     ),
//                   ],
//                 ),
