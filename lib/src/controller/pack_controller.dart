import 'package:flutter/material.dart';

import '../model/manifest.dart';
import '../model/pack_element.dart';
import '../repository/addon_repository.dart';

class PackController with ChangeNotifier {
  final AddonRepository addonRepository;

  PackElementType? _category;
  final List<PackElementInfo> _elements = [];
  bool _loading = false;
  Manifest? _manifest;
  // final Set<PackElementInfo> _selected = {};

  PackController({
    required this.addonRepository,
  });

  List<PackElementType> get categories =>
      _elements.map((e) => e.type).toSet().toList();
  // PackElementType? get category => _category;
  List<PackElementInfo> get elements => _elementsSplitByName();
  //_selectedElementsByCategorySplitByName().toList();
  String? get id => _manifest?.header.uuid;
  bool get loading => _loading;
  Manifest? get manifest => _manifest;
  // PackElementInfo? get selectedElement => _elements.singleWhereOrNull(
  //     (e) => _selected.any((s) => s.path == e.path && s.name == e.name));

  // set category(PackElementType? value) {
  //   _category = value;
  //   notifyListeners();
  // }

  void clear() {
    _category = null;
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

  // void select(PackElementInfo elementId) {
  //   _selected.add(elementId);
  //   notifyListeners();
  // }

  // void unselectAll() {
  //   _selected.clear();
  //   notifyListeners();
  // }

  List<PackElementInfo> _elementsSplitByName() {
    return _elements
        // .where((e) => e.type == _category)
        .expand((e) => (e.name ?? e.path).split(',').map((n) => PackElementInfo(
              path: e.path,
              type: e.type,
              name: n.trim(),
              formatVersion: e.formatVersion,
            )))
        .toList();
  }
}
