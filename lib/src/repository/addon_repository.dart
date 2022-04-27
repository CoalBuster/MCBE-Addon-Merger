import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:logger/logger.dart';
import 'package:mcbe_addon_merger/src/model/manifest.dart';
import 'package:path/path.dart' as path;

import '../model/pack.dart';
import '../model/pack_element.dart';

class AddonRepository {
  static const manifestFileName = 'manifest.json';
  static const packElementExtension = '.json';

  final Logger logger;

  AddonRepository({
    required this.logger,
  });

  // Future<List<PackElement>> fetchServerEntitiesAsync(
  //     Iterable<File> filesToParse) async {
  //   final List<PackElement> elements = [];

  //   for (var file in filesToParse) {
  //     logger.d('Try to parse element ${path.basename(file.path)} ..');
  //     try {
  //       final contents = await file.readAsString();
  //       final json = jsonDecode(contents);
  //       final element = PackElement.fromJson(json);

  //       elements.add(element);
  //     } catch (e) {
  //       logger.d('Failed to parse element', e);
  //     }
  //   }

  //   return elements;
  // }

  // Future<List<PackElement>> fetchPackElementsAsync(
  Future<Map<String, PackElement>> fetchPackElementsAsync(
      Directory packDirectory) async {
    final Map<String, PackElement> result = {};
    final candidates = await packDirectory
        .list(recursive: true)
        .where((e) => e is File)
        .cast<File>()
        .where((f) => path.extension(f.path) == packElementExtension)
        .toList();

    for (var packElementFile in candidates) {
      final packElement = await _tryParsePackElementAsync(packElementFile);

      if (packElement != null) {
        final elementPath =
            path.relative(packElementFile.path, from: packDirectory.path);
        result[elementPath] = packElement;
      }
    }

    return result;
  }

  Future<List<Pack>> fetchPacksAsync(
    Directory searchDirectory, [
    int maxDepth = 1,
  ]) async {
    final List<Pack> result = [];
    final entries = await searchDirectory.list().toList();
    final candidates = entries
        .whereType<File>()
        .where((f) => path.basename(f.path) == manifestFileName)
        .toList();

    if (candidates.isEmpty && maxDepth > 0) {
      logger.d('Manifest not found, checking sub-directories..');

      for (var dir in entries.whereType<Directory>()) {
        result.addAll(await fetchPacksAsync(dir, maxDepth - 1));
      }
    }

    for (var manifestFile in candidates) {
      final manifest = await _tryParseManifestAsync(manifestFile);

      if (manifest != null) {
        logger.i('Manifest found at ${manifestFile.path}');
        final pack = Pack(
          directory: searchDirectory,
          manifest: manifest,
        );
        result.add(pack);
      }
    }

    return result;
  }

  Future<List<Pack>> pick() async {
    logger.i('Picking addon..');
    final result = await FilePicker.platform.getDirectoryPath(
      dialogTitle: 'Select Addon',
    );

    if (result == null) {
      logger.w('Nothing picked');
      return [];
    }

    logger.i('Picked directory: $result');
    final dir = Directory(result);

    if (!await dir.exists()) {
      logger.w('Directory does not exist');
      return [];
    }

    final manifests = await fetchPacksAsync(dir);
    return manifests;
  }

  Future<PackElement?> _tryParsePackElementAsync(File file) async {
    try {
      final contents = await file.readAsString();
      final json = jsonDecode(contents);
      final element = PackElement.fromJson(json);

      logger.i('Successfully parsed PackElement ${path.basename(file.path)}');
      return element;
    } catch (e) {
      return null;
    }
  }

  Future<Manifest?> _tryParseManifestAsync(File file) async {
    try {
      final contents = await file.readAsString();
      final json = jsonDecode(contents);
      final manifest = Manifest.fromJson(json);

      logger.i('Successfully parsed Manifest (uuid=${manifest.header.name})');
      return manifest;
    } catch (e) {
      return null;
    }
  }
}
