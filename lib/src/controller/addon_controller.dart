import 'dart:collection';

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
  List<Manifest> _packs = [];
  List<Manifest> _selected = [];

  AddonController({
    required this.addonPicker,
    required this.addonRepository,
    required this.logger,
  });

  bool get loading => _loading;
  List<Manifest> get packs => UnmodifiableListView(_packs);
  List<Manifest> get selected => UnmodifiableListView(_selected);

  void clear() {
    _packs.clear();
    notifyListeners();
  }

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
}
