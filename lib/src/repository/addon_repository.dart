import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:logger/logger.dart';
import 'package:mcbe_addon_merger/src/model/pack_content.dart';
import 'package:mcbe_addon_merger/src/model/pack_image.dart';
import 'package:path/path.dart' as path;

import '../model/manifest.dart';
import '../model/pack.dart';
import '../model/pack_element.dart';

class AddonRepository {
  static const ignoredDirectories = [
    '.git',
    'documentation',
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

  AddonRepository({
    required this.logger,
  });

  Future<PackContent> fetchPackContentAsync(Pack pack) async {
    final Map<String, dynamic> result = {};
    final packFiles = await pack.directory
        .list(recursive: true)
        .where((e) => e is File)
        .cast<File>()
        .where(
            (f) => !ignoredFiles.contains(path.basename(f.path).toLowerCase()))
        .where((f) => !path
            .split(path.dirname(f.path))
            .any((part) => ignoredDirectories.contains(part.toLowerCase())))
        .where((f) => path.basename(f.path) != manifestFileName)
        .toList();

    for (var packFile in packFiles) {
      final packFilePath =
          path.relative(packFile.path, from: pack.directory.path);
      final packFileExtension = path.extension(packFile.path);

      switch (packFileExtension) {
        case packFileExtensionElement:
          result[packFilePath] = await _tryParsePackElementAsync(packFile);
          break;
        case packFileExtensionImage:
          result[packFilePath] = PackImage(path: packFilePath);
          break;
        default:
          result[packFilePath] = null;
          logger.w('Unrecognized file: ${packFile.path}');
          break;
      }
    }

    return PackContent(
      files: result,
    );
  }

  Future<Pack?> fetchPackByPath(String packPath) async {
    final packDirectory = Directory(packPath);

    if (!await packDirectory.exists()) {
      return null;
    }

    try {
      final packFiles = await packDirectory.list().toList();
      final manifest = await _tryParseManifestAsync(packFiles
          .whereType<File>()
          .firstWhere((f) => path.basename(f.path) == manifestFileName));

      if (manifest == null) {
        return null;
      }

      final pack = Pack(
        directory: packDirectory,
        manifest: manifest,
      );

      return pack;
    } catch (e) {
      return null;
    }
  }

  Future<List<Pack>> fetchPacksAsync(
    Directory searchDirectory, [
    int maxDepth = 1,
  ]) async {
    final List<Pack> result = [];
    final entries = await searchDirectory.list().toList();

    if (maxDepth > 0) {
      for (var dir in entries.whereType<Directory>()) {
        result.addAll(await fetchPacksAsync(dir, maxDepth - 1));
      }
    }

    final pack = await fetchPackByPath(searchDirectory.path);

    if (pack != null) {
      result.add(pack);
    }

    return result;
  }

  Future<List<Pack>> pickPacksAsync() async {
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

    final manifests = await fetchPacksAsync(dir, 2);
    return manifests;
  }

  Future<PackElement?> _tryParsePackElementAsync(File file) async {
    try {
      final contents = await file.readAsString();
      final json = jsonDecode(contents);
      final element = PackElement.fromJson(json);

      if (element.type == null) {
        return null;
      }

      // logger.i('[${element.type?.asString()}] ${path.basename(file.path)}');
      return element;
    } on FormatException catch (e) {
      logger.w('Could not parse ${path.basename(file.path)}: ${e.message}');
      return null;
    } catch (e) {
      logger.w('Could not parse ${path.basename(file.path)}: $e');
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
