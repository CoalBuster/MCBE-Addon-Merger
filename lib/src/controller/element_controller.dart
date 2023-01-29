import 'package:flutter/material.dart';

import '../model/pack_element.dart';
import '../model/patch.dart';
import '../repository/addon_repository.dart';

class PackElementController with ChangeNotifier {
  final AddonRepository addonRepository;

  PackElement? _element;
  PackElementInfo? _elementId;
  bool _loading = false;
  String? _packId;
  List<Patch>? _patches;

  PackElementController({
    required this.addonRepository,
  });

  PackElementCategory? get category => _elementId?.category;
  String? get displayName => _elementId?.displayName;
  PackElement? get element => _element;
  bool get loading => _loading;
  String? get packId => _packId;
  String? get path => _elementId?.path;
  List<Patch>? get patches => _patches;

  void clear() {
    _packId = null;
    _element = null;
    _elementId = null;
    notifyListeners();
  }

  Future<bool> loadElementByIdAsync(
      String packId, PackElementInfo elementId) async {
    clear();
    _loading = true;
    notifyListeners();

    _packId = packId;
    _elementId = elementId;

    _element = await addonRepository.getElementByPathAsync(packId, elementId);

    _loading = false;
    notifyListeners();
    return _element != null;
  }

  // Future<bool> loadElementDiffByIdAsync(
  //     String packId, PackElementInfo elementId) async {
  //   clear();
  //   _loading = true;
  //   notifyListeners();

  //   _packId = packId;
  //   _elementId = elementId;
  //   _element =
  //       await addonRepository.getElementByPathAsync(packId, elementId.path);
  //   // diff =

  //   _loading = false;
  //   notifyListeners();
  //   return _element != null;
  // }
}
