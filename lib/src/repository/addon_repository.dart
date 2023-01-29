import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:collection/collection.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart' as paths;

import '../model/manifest.dart';
import '../model/pack_element.dart';
import '../model/pack_element_json.dart';

class _PackEntry {
  final Archive archive;
  final Manifest manifest;
  final String path;

  _PackEntry(this.archive, this.path, this.manifest);
}

class AddonRepository {
  static const manifestFileName = 'manifest.json';
  static const packFileExtensionElement = '.json';
  static const packFileExtensionImage = '.png';

  final Logger logger;

  final List<_PackEntry> _entries = [];

  AddonRepository({
    required this.logger,
  });

  Future<List<int>> download() {
    throw UnimplementedError();
  }

  Future<PackJsonElement?> getJsonElementByPathAsync(
      String packId, String elementPath) async {
    final entry = _entries.singleWhere((e) => e.manifest.header.uuid == packId);
    final elementFullPath =
        paths.posix.normalize(paths.posix.join(entry.path, elementPath));
    final elementFile = entry.archive.findFile(elementFullPath);

    if (paths.extension(elementFullPath) != '.json' || elementFile == null) {
      return null;
    }

    return _parseJsonElement(path: elementPath, file: elementFile)
        .values
        .singleOrNull;
  }

  Future<Uint8List?> getFileContentByPathAsync(
      String packId, String elementPath) async {
    final entry = _entries.singleWhere((e) => e.manifest.header.uuid == packId);
    final fileFullPath =
        paths.posix.normalize(paths.posix.join(entry.path, elementPath));
    final archivedFile = entry.archive.findFile(fileFullPath);

    if (archivedFile == null) {
      return null;
    }

    return Uint8List.fromList(archivedFile.content as List<int>);
  }

  Future<Manifest?> getManifestByIdAsync(String packId) async {
    final entry = _entries.singleWhere((e) => e.manifest.header.uuid == packId);
    return entry.manifest;
  }

  Future<List<PackElementInfo>> listElementsByPackId(String packId) async {
    final entry =
        _entries.singleWhereOrNull((e) => e.manifest.header.uuid == packId);

    if (entry == null) {
      logger.w('Pack not found (uuid=$packId)');
      return [];
    }

    final packElements = entry.archive
        .where((e) => e.isFile && paths.isWithin(entry.path, e.name))
        .map((e) => _parseElementInfo(path: entry.path, file: e))
        .toList();

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

  PackElementInfo _parseElementInfo(
      {required ArchiveFile file, required String path}) {
    final packFilePath = paths.posix.relative(file.name, from: path);
    final packFileExtension = paths.extension(file.name);

    switch (packFileExtension) {
      case '.json':
        return _parseJsonElementInfo(path: packFilePath, file: file);
      case '.png':
        return PackElementInfo(
          category: PackElementCategory.image,
          displayName: paths.basenameWithoutExtension(file.name),
          path: packFilePath,
        );
      default:
        return PackElementInfo(
          category: PackElementCategory.unknown,
          displayName: paths.basenameWithoutExtension(file.name),
          path: packFilePath,
        );
    }
  }

  Map<String, PackJsonElement> _parseJsonElement(
      {required String path, required ArchiveFile file}) {
    try {
      final json = jsonDecode(utf8.decode(file.content));
      return const PackJsonElements().fromJson(json);
    } catch (e, s) {
      logger.w('Could not parse ${paths.basename(file.name)}: $e\n$s');
      return {};
    }
  }

  PackElementInfo _parseJsonElementInfo(
      {required String path, required ArchiveFile file}) {
    final element =
        _parseJsonElement(path: path, file: file).values.singleOrNull;

    if (element == null) {
      return PackElementInfo(
        category: PackElementCategory.unknown,
        displayName: paths.basenameWithoutExtension(file.name),
        path: path,
      );
    }

    return PackElementInfo(
      category: element.category,
      displayName: element.name ?? paths.basenameWithoutExtension(file.name),
      path: path,
    );
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
}
