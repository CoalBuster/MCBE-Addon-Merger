import 'dart:convert';

import 'package:archive/archive.dart';
import 'package:collection/collection.dart';
import 'package:logger/logger.dart';
import 'package:mcbe_addon_merger/src/model/version.dart';
import 'package:path/path.dart' as paths;

import '../model/manifest.dart';
import '../model/pack_element.dart';

class _PackEntry {
  final Archive archive;
  final Manifest manifest;
  final String path;

  _PackEntry(this.archive, this.path, this.manifest);
}

class AddonRepository {
  static const ignoredDirectories = [
    '.git',
    'documentation',
    'texts',
  ];
  static const ignoredFiles = [
    '.gitignore',
    'changelog.md',
    'readme.md',
  ];
  static const manifestFileName = 'manifest.json';
  static const packFileExtensionElement = '.json';
  static const packFileExtensionImage = '.png';

  final Logger logger;

  final List<_PackEntry> _entries = [];
  // Archive? _archive;
  // bool? _isAddon;
  // final Map<String, String> _manifests = {};

  AddonRepository({
    required this.logger,
  });

  Future<List<int>> download() {
    throw UnimplementedError();
  }

  Future<PackElement?> getElementByPathAsync(
      String packId, String elementPath) async {
    final entry = _entries.singleWhere((e) => e.manifest.header.uuid == packId);
    final elementFullPath = paths.posix.join(entry.path, elementPath);
    final elementFile = entry.archive.findFile(elementFullPath);

    if (elementFile == null) {
      return null;
    }

    final element = _tryParsePackElementAsync(elementFile);
    return element;
  }

  Future<List<PackElementInfo>> listElementsByPackId(String packId) async {
    final entry =
        _entries.singleWhereOrNull((e) => e.manifest.header.uuid == packId);

    if (entry == null) {
      logger.w('Pack not found (uuid=$packId)');
      return [];
    }

    final packFiles = entry.archive
        .where((e) => e.isFile)
        .where((e) => paths.isWithin(entry.path, e.name))
        .where(
            (e) => !ignoredFiles.contains(paths.basename(e.name).toLowerCase()))
        .where((e) => !paths
            .split(paths.dirname(e.name))
            .any((part) => ignoredDirectories.contains(part.toLowerCase())))
        .where((e) => paths.basename(e.name) != manifestFileName)
        .toList();

    final packElements =
        packFiles.map((e) => _parseElementInfo(entry.path, e)).toList();
    return packElements;
  }

  Future<List<Manifest>> listPacksAsync() async {
    return Future.value(_entries.map((e) => e.manifest).toList());
  }

  Future<bool> uploadAddon(List<int> data) {
    var archive = ZipDecoder().decodeBytes(data);
    var manifestFiles = archive
        .where((e) => e.isFile)
        .where((e) => paths.split(e.name).length == 2)
        .where((e) => paths.basename(e.name) == manifestFileName);

    for (var file in manifestFiles) {
      var manifest = _readManifest(file);

      if (manifest == null) {
        return Future.value(false);
      }

      _entries
          .removeWhere((e) => e.manifest.header.uuid == manifest.header.uuid);
      _entries.add(_PackEntry(
        archive,
        paths.posix.dirname(file.name),
        manifest,
      ));
    }

    return Future.value(true);
  }

  Future<bool> uploadPack(List<int> data) {
    var archive = ZipDecoder().decodeBytes(data);
    var manifestFile = archive
        .where((e) => e.isFile)
        .where((e) => paths.split(e.name).length == 1)
        .where((e) => paths.basename(e.name) == manifestFileName)
        .singleOrNull;

    if (manifestFile == null) {
      logger.w('Expected a single manifest');
      return Future.value(false);
    }

    var manifest = _readManifest(manifestFile);

    if (manifest == null) {
      return Future.value(false);
    }

    _entries.removeWhere((e) => e.manifest.header.uuid == manifest.header.uuid);
    _entries.add(_PackEntry(
      archive,
      paths.dirname(manifestFile.name),
      manifest,
    ));
    return Future.value(true);
  }

  PackElementInfo _parseElementInfo(String packPath, ArchiveFile packFile) {
    final packFilePath = paths.posix.relative(packFile.name, from: packPath);
    final packFileExtension = paths.extension(packFile.name);

    switch (packFileExtension) {
      case packFileExtensionElement:
        try {
          final contents = packFile.content as List<int>;
          final utf = utf8.decode(contents);
          final json = jsonDecode(utf);
          final elementType = PackElementType.fromJson(json);

          if (elementType == null) {
            return PackElementInfo(
              type: PackElementType.unknown,
              path: packFilePath,
            );
          }

          return PackElementInfo(
            type: elementType,
            path: packFilePath,
            name: elementType.nameFromJson(json),
            formatVersion: Version.fromText(json['format_version']),
          );
        } catch (e) {
          return PackElementInfo(
            type: PackElementType.unknown,
            path: packFilePath,
          );
        }
      case packFileExtensionImage:
        return PackElementInfo(
          type: PackElementType.image,
          path: packFilePath,
        );
      default:
        return PackElementInfo(
          type: PackElementType.unknown,
          path: packFilePath,
        );
    }
  }

  Manifest? _readManifest(ArchiveFile file) {
    try {
      final contents = file.content as List<int>;
      final utf = utf8.decode(contents);
      final json = jsonDecode(utf);
      final manifest = Manifest.fromJson(json);

      logger.i('Successfully parsed Manifest (uuid=${manifest.header.uuid})');
      return manifest;
    } catch (e) {
      logger.w('Failed to read Manifest', e);
      return null;
    }
  }

  Future<PackElement?> _tryParsePackElementAsync(ArchiveFile file) async {
    try {
      final contents = file.content as List<int>;
      final utf = utf8.decode(contents);
      final json = jsonDecode(utf);
      final element = const PackElements().fromJson(json);
      // logger.i('[${element.type?.asString()}] ${path.basename(file.path)}');
      return element;
    } catch (e, s) {
      logger.w('Could not parse ${paths.basename(file.name)}: $e\n$s');
      return null;
    }
  }

  // Future<List<Manifest>> listPacksAsync() async {
  //   final archive = _archive;

  //   if (archive == null) {
  //     logger.w('No addon loaded');
  //     return [];
  //   }

  //   if (_isAddon!) {
  //     var manifestFiles = archive
  //         .where((e) => paths.split(e.name).length == 2)
  //         .where((e) => e.name.endsWith(manifestFileName));

  //     if (manifestFiles.isEmpty) {
  //       logger.w('Manifest(s) not found for Addon');
  //       return [];
  //     }

  //     List<Manifest> manifests = [];

  //     for (var f in manifestFiles) {
  //       var m = _readManifestAsync(f);

  //       if (m == null) {
  //         continue;
  //       }

  //       _manifests[m.header.uuid] = paths.dirname(f.name);
  //       manifests.add(m);
  //     }

  //     return manifests;
  //   } else {
  //     var manifestFile = archive.findFile(manifestFileName);

  //     if (manifestFile == null) {
  //       logger.w('Manifest not found for Pack');
  //       return [];
  //     }

  //     var manifest = _readManifestAsync(manifestFile);

  //     if (manifest == null) {
  //       return [];
  //     }

  //     _manifests[manifest.header.uuid] = '.';
  //     return [manifest];
  //   }
  // }

  // Future<PackContent> listElementsByPackId(String packId) async {
  //   final packPath = _manifests[packId]!;
  //   final Map<String, dynamic> result = {};
  //   final packFiles = _archive!
  //       .where((e) => e.isFile)
  //       .where((e) => paths.isWithin(packPath, e.name))
  //       .where(
  //           (e) => !ignoredFiles.contains(paths.basename(e.name).toLowerCase()))
  //       .where((e) => !paths
  //           .split(paths.dirname(e.name))
  //           .any((part) => ignoredDirectories.contains(part.toLowerCase())))
  //       .where((e) => paths.basename(e.name) != manifestFileName)
  //       .toList();

  //   for (var packFile in packFiles) {
  //     final packFilePath = paths.relative(packFile.name, from: packPath);
  //     final packFileExtension = paths.extension(packFile.name);

  //     switch (packFileExtension) {
  //       case packFileExtensionElement:
  //         result[packFilePath] = await _tryParsePackElementAsync(packFile);
  //         break;
  //       case packFileExtensionImage:
  //         result[packFilePath] = PackImage(path: packFilePath);
  //         break;
  //       default:
  //         result[packFilePath] = null;
  //         logger.w('Unrecognized file: ${packFile.name}');
  //         break;
  //     }
  //   }

  //   return PackContent(
  //     files: result,
  //   );
  // }

  // Future<Pack?> fetchPackByPath(String packPath) async {
  //   final packDirectory = Directory(packPath);

  //   if (!await packDirectory.exists()) {
  //     return null;
  //   }

  //   try {
  //     final packFiles = await packDirectory.list().toList();
  //     final manifest = await _tryParseManifestAsync(packFiles
  //         .whereType<File>()
  //         .firstWhere((f) => path.basename(f.path) == manifestFileName));

  //     if (manifest == null) {
  //       return null;
  //     }

  //     final pack = Pack(
  //       directory: packDirectory,
  //       manifest: manifest,
  //     );

  //     return pack;
  //   } catch (e) {
  //     return null;
  //   }
  // }

  // Future<List<Pack>> fetchPacksAsync(
  //   Directory searchDirectory, [
  //   int maxDepth = 1,
  // ]) async {
  //   final List<Pack> result = [];
  //   final entries = await searchDirectory.list().toList();

  //   if (maxDepth > 0) {
  //     for (var dir in entries.whereType<Directory>()) {
  //       result.addAll(await fetchPacksAsync(dir, maxDepth - 1));
  //     }
  //   }

  //   final pack = await fetchPackByPath(searchDirectory.path);

  //   if (pack != null) {
  //     result.add(pack);
  //   }

  //   return result;
  // }

  // Future<List<Pack>> pickPacksAsync() async {
  //   logger.i('Picking addon..');
  //   final result = await FilePicker.platform.getDirectoryPath(
  //     dialogTitle: 'Select Addon',
  //   );

  //   if (result == null) {
  //     logger.w('Nothing picked');
  //     return [];
  //   }

  //   logger.i('Picked directory: $result');
  //   final dir = Directory(result);

  //   if (!await dir.exists()) {
  //     logger.w('Directory does not exist');
  //     return [];
  //   }

  //   final manifests = await fetchPacksAsync(dir, 2);
  //   return manifests;
  // }
}
