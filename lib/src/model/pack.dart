import 'dart:io';

import 'manifest.dart';

class Pack {
  final Directory directory;
  final Manifest manifest;

  Pack({
    required this.directory,
    required this.manifest,
  });

  bool get isBehaviorPack => manifest.isBehaviorPack;
  bool get isResourcePack => manifest.isResourcePack;
  String get uuid => manifest.header.uuid;
}
