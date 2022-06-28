import 'dart:convert';

import 'package:archive/archive.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart' as paths;

import '../model/manifest.dart';
import '../model/pack_content.dart';
import '../model/pack_element.dart';
import '../model/pack_image.dart';

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

  Archive? _archive;
  bool? _isAddon;
  final Map<String, String> _manifests = {};

  AddonRepository({
    required this.logger,
  });

  Future<List<int>> download() {
    throw UnimplementedError();
  }

  Future<List<Manifest>> listPacksAsync() async {
    final archive = _archive;

    if (archive == null) {
      logger.w('No addon loaded');
      return [];
    }

    if (_isAddon!) {
      var manifestFiles = archive
          .where((e) => paths.split(e.name).length == 2)
          .where((e) => e.name.endsWith(manifestFileName));

      if (manifestFiles.isEmpty) {
        logger.w('Manifest(s) not found for Addon');
        return [];
      }

      List<Manifest> manifests = [];

      for (var f in manifestFiles) {
        var m = _readManifestAsync(f);

        if (m == null) {
          continue;
        }

        _manifests[m.header.uuid] = paths.dirname(f.name);
        manifests.add(m);
      }

      return manifests;
    } else {
      var manifestFile = archive.findFile(manifestFileName);

      if (manifestFile == null) {
        logger.w('Manifest not found for Pack');
        return [];
      }

      var manifest = _readManifestAsync(manifestFile);

      if (manifest == null) {
        return [];
      }

      _manifests[manifest.header.uuid] = '.';
      return [manifest];
    }
  }

  Future<PackContent> listElementsByPackId(String packId) async {
    final packPath = _manifests[packId]!;
    final Map<String, dynamic> result = {};
    final packFiles = _archive!
        .where((e) => e.isFile)
        .where((e) => paths.isWithin(packPath, e.name))
        .where(
            (e) => !ignoredFiles.contains(paths.basename(e.name).toLowerCase()))
        .where((e) => !paths
            .split(paths.dirname(e.name))
            .any((part) => ignoredDirectories.contains(part.toLowerCase())))
        .where((e) => paths.basename(e.name) != manifestFileName)
        .toList();

    for (var packFile in packFiles) {
      final packFilePath = paths.relative(packFile.name, from: packPath);
      final packFileExtension = paths.extension(packFile.name);

      switch (packFileExtension) {
        case packFileExtensionElement:
          result[packFilePath] = await _tryParsePackElementAsync(packFile);
          break;
        case packFileExtensionImage:
          result[packFilePath] = PackImage(path: packFilePath);
          break;
        default:
          result[packFilePath] = null;
          logger.w('Unrecognized file: ${packFile.name}');
          break;
      }
    }

    return PackContent(
      files: result,
    );
  }

  Future<bool> uploadAddon(List<int> data) {
    _manifests.clear();
    _archive = ZipDecoder().decodeBytes(data);
    _isAddon = true;
    return Future.value(true);
  }

  Future<bool> uploadPack(List<int> data) {
    _archive = ZipDecoder().decodeBytes(data);
    _isAddon = false;
    return Future.value(true);
  }

  Manifest? _readManifestAsync(ArchiveFile file) {
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

  Future<PackElement?> _tryParsePackElementAsync(ArchiveFile file) async {
    try {
      final contents = file.content as List<int>;
      final utf = utf8.decode(contents);
      final json = jsonDecode(utf);
      final element = PackElement.fromJson(json);

      if (element.type == null) {
        return null;
      }

      // logger.i('[${element.type?.asString()}] ${path.basename(file.path)}');
      return element;
    } catch (e, s) {
      logger.w('Could not parse ${paths.basename(file.name)}: $e\n$s');
      return null;
    }
  }
}
