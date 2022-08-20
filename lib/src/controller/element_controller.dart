import 'package:flutter/material.dart';

import '../model/pack_element.dart';
import '../model/patch.dart';
import '../model/version.dart';
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

  PackElement? get element => _element;
  Version? get formatVersion => _elementId?.formatVersion;
  bool get loading => _loading;
  String? get name => _elementId?.name;
  String? get packId => _packId;
  String? get path => _elementId?.path;
  List<Patch>? get patches => _patches;
  PackElementType? get type => _elementId?.type;

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
    _element =
        await addonRepository.getElementByPathAsync(packId, elementId.path);

    _loading = false;
    notifyListeners();
    return _element != null;
  }

  Future<bool> loadElementDiffByIdAsync(
      String packId, PackElementInfo elementId) async {
    clear();
    _loading = true;
    notifyListeners();

    _packId = packId;
    _elementId = elementId;
    _element =
        await addonRepository.getElementByPathAsync(packId, elementId.path);
    // diff =

    _loading = false;
    notifyListeners();
    return _element != null;
  }
}
