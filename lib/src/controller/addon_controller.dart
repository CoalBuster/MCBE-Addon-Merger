import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../model/pack.dart';
import '../repository/addon_repository.dart';

class AddonController with ChangeNotifier {
  final AddonRepository addonRepository;
  final Logger logger;

  String? _error;
  bool _loading = false;
  List<Pack> _packs = [];
  final List<String> _selected = [];

  AddonController({
    required this.addonRepository,
    required this.logger,
  });

  String? get errorMessage => _error;
  bool get loading => _loading;
  List<Pack> get packs => UnmodifiableListView(_packs);
  List<Pack> get selected =>
      packs.where((p) => _selected.contains(p.uuid)).toList();
  bool get succeeded => !_loading && _error == null;

  void add(Pack pack) {
    _packs.add(pack);
    notifyListeners();
  }

  void clear() {
    _packs.clear();
    notifyListeners();
  }

  void clearSelection() {
    _selected.clear();
    notifyListeners();
  }

  Future<bool> loadAsync() async {
    clear();
    _error = null;
    _loading = true;
    notifyListeners();

    _packs = await addonRepository.pickPacksAsync();
    _loading = false;
    notifyListeners();
    return true;
  }

  void select(String packUuid) {
    if (_packs.any((p) => p.uuid == packUuid)) {
      _selected.add(packUuid);
      notifyListeners();
    }
  }
}
