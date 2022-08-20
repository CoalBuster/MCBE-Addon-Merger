import 'dart:collection';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:mcbe_addon_merger/src/repository/addon_picker.dart';

import '../model/manifest.dart';
import '../repository/addon_repository.dart';

class AddonController with ChangeNotifier {
  final AddonPicker addonPicker;
  final AddonRepository addonRepository;
  final Logger logger;

  bool _loading = false;
  bool _multiSelect = false;
  List<Manifest> _packs = [];
  final List<String> _selected = [];

  AddonController({
    required this.addonPicker,
    required this.addonRepository,
    required this.logger,
  });

  bool get anySelected => _selected.isNotEmpty;
  bool get loading => _loading;
  bool get multiSelectMode => _multiSelect;
  List<Manifest> get packs => UnmodifiableListView(_packs);
  List<String> get selectedIds => UnmodifiableListView(_selected);

  void clear() {
    _packs.clear();
    notifyListeners();
  }

  Future<Uint8List?> getPackIconAsync(String packId) {
    return addonRepository.getFileContentByPathAsync(packId, 'pack_icon.png');
  }

  bool isSelected(String packId) => _selected.contains(packId);

  Future<bool> loadAddonAsync(List<int>? data) async {
    if (loading) {
      return false;
    }

    _loading = true;
    notifyListeners();

    if (data == null) {
      _loading = false;
      notifyListeners();
      return false;
    }

    await addonRepository.uploadAddon(data);
    _packs = await addonRepository.listPacksAsync();
    _loading = false;
    notifyListeners();
    return true;
  }

  Future<bool> loadPackAsync(List<int>? data) async {
    if (loading) {
      return false;
    }

    _loading = true;
    notifyListeners();

    if (data == null) {
      _loading = false;
      notifyListeners();
      return false;
    }

    await addonRepository.uploadPack(data);
    _packs = await addonRepository.listPacksAsync();
    _loading = false;
    notifyListeners();
    return true;
  }

  void select(String packId, [bool? multi]) {
    if (!_multiSelect) {
      _selected.clear();
    }

    _multiSelect = multi ?? _multiSelect;
    _selected.add(packId);
    notifyListeners();
  }

  void unselect(String packId) {
    _selected.remove(packId);
    _multiSelect = _multiSelect && _selected.isNotEmpty;
    notifyListeners();
  }

  void unselectAll() {
    _selected.clear();
    _multiSelect = false;
    notifyListeners();
  }
}
