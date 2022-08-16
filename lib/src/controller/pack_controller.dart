import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../model/manifest.dart';
import '../model/pack_element.dart';
import '../model/patch.dart';
import '../repository/addon_repository.dart';

class PackController with ChangeNotifier {
  final AddonRepository addonRepository;

  List<PackElementInfo>? _elements;
  bool _loading = false;
  Manifest? _pack;
  // PackContent? _packContent;
  String? _packElementName;
  String? _packElementPath;
  List<Patch>? _patches;

  PackController({
    required this.addonRepository,
  });

  List<PackElementInfo>? get elements => _elements;
  bool get loading => _loading;
  Manifest? get pack => _pack;
  // PackContent? get packContent => _packContent;
  List<Patch>? get patches => _patches;
  PackElementInfo? get selectedElement =>
      _elements?.singleWhereOrNull((e) => e.path == _packElementPath);
  String? get selectedElementName => _packElementName;
  String? get selectedElementPath => _packElementPath;

  // set packContent(PackContent? packContent) {
  //   _packContent = packContent;
  //   notifyListeners();
  // }

  set patches(List<Patch>? patches) {
    _patches = patches;
    notifyListeners();
  }

  void clear() {
    _pack = null;
    // _packContent = null;
    _packElementName = null;
    _packElementPath = null;
    notifyListeners();
  }

  void clearElement() {
    _packElementName = null;
    _packElementPath = null;
    notifyListeners();
  }

  Future<bool> loadPackByIdAsync(String packId) async {
    clear();
    _loading = true;
    notifyListeners();

    _pack = await addonRepository.getManifestByIdAsync(packId);
    _elements = await addonRepository.listElementsByPackId(packId);

    _loading = false;
    notifyListeners();
    return _elements != null;
  }

  void selectElement(String path, [String? name]) {
    _packElementPath = path;
    _packElementName = name;
    notifyListeners();
  }
}
