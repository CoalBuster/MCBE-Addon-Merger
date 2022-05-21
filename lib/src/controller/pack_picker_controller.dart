import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../model/pack.dart';
import '../repository/addon_repository.dart';

class PackPickerController with ChangeNotifier {
  final AddonRepository addonRepository;
  final Logger logger;

  bool _loading = false;
  List<Pack> _packs = [];

  PackPickerController({
    required this.addonRepository,
    required this.logger,
  });

  bool get loading => _loading;
  List<Pack> get packs => UnmodifiableListView(_packs);

  Future<bool> loadAsync() async {
    _packs.clear();
    _loading = true;
    notifyListeners();

    _packs = await addonRepository.pickPacksAsync();
    _loading = false;
    notifyListeners();
    return true;
  }
}
