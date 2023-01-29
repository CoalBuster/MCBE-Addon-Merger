import 'package:flutter/material.dart';

import '../model/manifest.dart';
import '../model/pack_element.dart';
import '../repository/addon_repository.dart';

class PackController with ChangeNotifier {
  final AddonRepository addonRepository;

  final List<PackElementInfo> _elements = [];
  bool _loading = false;
  Manifest? _manifest;

  PackController({
    required this.addonRepository,
  });

  List<PackElementCategory> get categories =>
      _elements.map((e) => e.category).toSet().toList();
  List<PackElementInfo> get elements => _elements;
  String? get id => _manifest?.header.uuid;
  bool get loading => _loading;
  Manifest? get manifest => _manifest;

  void clear() {
    _elements.clear();
    _manifest = null;
    notifyListeners();
  }

  Future<bool> loadPackByIdAsync(String packId) async {
    clear();
    _loading = true;
    notifyListeners();

    _manifest = await addonRepository.getManifestByIdAsync(packId);
    _elements.addAll(await addonRepository.listElementsByPackId(packId));

    _loading = false;
    notifyListeners();
    return _manifest != null;
  }
}
