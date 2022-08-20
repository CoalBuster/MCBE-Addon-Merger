import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../model/manifest.dart';
import '../model/pack_element.dart';
import '../repository/addon_repository.dart';

class PackController with ChangeNotifier {
  final AddonRepository addonRepository;

  final List<PackElementInfo> _elements = [];
  bool _loading = false;
  Manifest? _manifest;
  final Set<PackElementInfo> _selected = {};

  PackController({
    required this.addonRepository,
  });

  List<PackElementInfo>? get elements => _elements;
  String? get id => _manifest?.header.uuid;
  bool get loading => _loading;
  Manifest? get manifest => _manifest;
  PackElementInfo? get selectedElement => _elements.singleWhereOrNull(
      (e) => _selected.any((s) => s.path == e.path && s.name == e.name));

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

  void select(PackElementInfo elementId) {
    _selected.add(elementId);
    notifyListeners();
  }

  void unselectAll() {
    _selected.clear();
    notifyListeners();
  }
}
