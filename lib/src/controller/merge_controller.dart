import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:json_patch/json_patch.dart';
import 'package:logger/logger.dart';

import '../model/pack.dart';
import '../model/pack_content.dart';
import '../model/pack_difference.dart';
import '../model/pack_element.dart';
import '../model/pack_element_type.dart';
import '../model/pack_image.dart';
import '../model/patch.dart';
import '../repository/addon_repository.dart';
import 'pack_controller.dart';

class MergeController with ChangeNotifier {
  final AddonRepository addonRepository;
  final PackController _basePackController;
  final PackController _comparePackController;
  final Logger logger;

  List<PackDifference> _diff = [];

  MergeController({
    required this.addonRepository,
    required this.logger,
  })  : _basePackController = PackController(
          addonRepository: addonRepository,
        ),
        _comparePackController = PackController(
          addonRepository: addonRepository,
        ) {
    _basePackController.addListener(notifyListeners);
    _comparePackController.addListener(notifyListeners);
  }

  Pack? get basePack => _basePackController.pack;
  PackContent? get basePackContent => _basePackController.packContent;
  Pack? get comparePack => _comparePackController.pack;
  PackContent? get comparePackContent => _comparePackController.packContent;
  List<PackDifference> get diff => UnmodifiableListView(_diff);
  bool get packsLoading =>
      _basePackController.loading || _comparePackController.loading;
  bool get packsSelected =>
      _basePackController.packContent != null &&
      _comparePackController.packContent != null;

  void clear() {
    _basePackController.clear();
    _comparePackController.clear();
    _diff.clear();
    notifyListeners();
  }

  List<PackDifference>? compare() {
    _diff.clear();
    notifyListeners();

    if (!packsSelected) {
      return null;
    }

    List<PackDifference> result = [];
    for (var baseEntry in _basePackController.packContent!.files.entries) {
      final diff = _compareEntry(baseEntry.key, baseEntry.value);

      if (diff != null) {
        result.add(diff);
      }
    }

    _diff = result;
    notifyListeners();
    return result;
  }

  PackDifference? _compareEntry(String filename, dynamic base) {
    if (base is PackElement) {
      switch (base.type) {
        case PackElementType.entity:
          return _compareEntity(filename, base);
        default:
          return _compareFile(filename);
      }
    }

    switch (base?.runtimeType) {
      case PackImage:
        return _compareImage(base);
      default:
        return _compareFile(filename);
    }
  }

  PackDifference? _compareEntity(String filename, PackElement baseEntity) {
    final compareEntity = _comparePackController.packContent!.elements.entries
        .firstWhereOrNull((file) =>
            file.value.entity?.description.identifier ==
            baseEntity.entity!.description.identifier)
        ?.value;

    if (compareEntity == null) {
      return null;
    }

    final baseJson = jsonEncode(baseEntity);
    final compJson = jsonEncode(compareEntity);
    final diff = JsonPatch.diff(jsonDecode(baseJson), jsonDecode(compJson))
        .map((e) => Patch.fromJson(e))
        .toList();
    logger.i('[ENTITY] [$filename] DIFF:\n  ${diff.join('\n  ')}');
    return PackDifference(
      filename: filename,
      packElement: baseEntity,
      patches: diff,
    );
  }

  PackDifference? _compareFile(String filename) {
    final compareFile = _comparePackController.packContent!.files.keys
        .firstWhereOrNull((name) => name == filename);

    if (compareFile == null) {
      return null;
    }

    logger.i('[FILE] [$filename] OVERIDDEN');
    return PackDifference(
      filename: filename,
    );
  }

  PackDifference? _compareImage(PackImage baseImage) {
    final compareImage = _comparePackController.packContent!.files.entries
        .firstWhereOrNull((element) => element.key == baseImage.path)
        ?.value;

    if (compareImage is! PackImage) {
      return null;
    }

    logger.i('[IMAGE] [${baseImage.path}] OVERIDDEN');
    return PackDifference(
      filename: baseImage.path,
      packElement: baseImage,
    );
  }

  Future<bool> loadBasePack(Pack? basePack) =>
      _basePackController.loadAsync(basePack);

  Future<bool> loadBasePackByPathAsync(String basePackPath) async {
    final basePack = await addonRepository.fetchPackByPath(basePackPath);
    return _basePackController.loadAsync(basePack);
  }

  Future<bool> loadComparePack(Pack? comparePack) =>
      _comparePackController.loadAsync(comparePack);

  Future<bool> loadComparePackByPathAsync(String comparePackPath) async {
    final comparePack = await addonRepository.fetchPackByPath(comparePackPath);
    return _comparePackController.loadAsync(comparePack);
  }
}
