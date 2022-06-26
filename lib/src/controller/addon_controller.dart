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

  AddonController({
    required this.addonPicker,
    required this.addonRepository,
    required this.logger,
  });

  bool get loading => _loading;
  List<Manifest> get packs => UnmodifiableListView(_packs);

  Future<bool> loadAddonAsync(List<int>? data) async {
    _packs.clear();
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
}
