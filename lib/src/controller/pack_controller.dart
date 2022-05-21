import 'package:flutter/material.dart';

import '../model/pack.dart';
import '../model/pack_content.dart';
import '../model/pack_element.dart';
import '../model/patch.dart';
import '../repository/addon_repository.dart';

class PackController with ChangeNotifier {
  final AddonRepository addonRepository;

  bool _loading = false;
  Pack? _pack;
  PackContent? _packContent;
  String? _packElementName;
  String? _packElementPath;
  List<Patch>? _patches;

  PackController({
    required this.addonRepository,
  });

  bool get loading => _loading;
  Pack? get pack => _pack;
  PackContent? get packContent => _packContent;
  List<Patch>? get patches => _patches;
  PackElement? get selectedElement => _packElementPath == null
      ? null
      : _packContent?.element(_packElementPath!);
  String? get selectedElementName => _packElementName;
  String? get selectedElementPath => _packElementPath;

  set packContent(PackContent? packContent) {
    _packContent = packContent;
    notifyListeners();
  }

  set patches(List<Patch>? patches) {
    _patches = patches;
    notifyListeners();
  }

  void clear() {
    _pack = null;
    _packContent = null;
    _packElementName = null;
    _packElementPath = null;
    notifyListeners();
  }

  void clearElement() {
    _packElementName = null;
    _packElementPath = null;
    notifyListeners();
  }

  Future<bool> loadAsync(Pack? pack) async {
    clear();

    if (pack == null) {
      return false;
    }

    _pack = pack;
    _loading = true;
    notifyListeners();

    _packContent = await addonRepository.fetchPackContentAsync(pack);
    _loading = false;
    notifyListeners();
    return true;
  }

  void selectElement(String path, [String? name]) {
    _packElementPath = path;
    _packElementName = name;
    notifyListeners();
  }
}
