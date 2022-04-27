import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../model/minecraft/animation_controller.dart';
import '../model/minecraft/item.dart';
import '../model/minecraft/server_entity.dart';
import '../model/pack.dart';
import '../model/pack_element.dart';
import '../model/pack_element_type.dart';
import '../repository/addon_repository.dart';

class PackController with ChangeNotifier {
  final AddonRepository addonRepository;
  final Logger logger;

  // List<PackElement> _elements = [];
  Map<String, PackElement> _elements = {};
  String? _error;
  bool _loading = false;
  Pack? _pack;
  String? _status;

  PackController({
    required this.addonRepository,
    required this.logger,
  });

  Map<String, Map<String, MinecraftAnimationController>>
      get animationControllers =>
          Map.fromEntries(elements(PackElementType.animationController)
              .entries
              .map((e) => MapEntry(e.key, e.value.animationControllers!)));

  Map<String, MinecraftServerEntity> get entities =>
      Map.fromEntries(elements(PackElementType.entity)
          .entries
          .map((e) => MapEntry(e.key, e.value.entity!)));

  Map<String, MinecraftItem> get items =>
      Map.fromEntries(elements(PackElementType.item)
          .entries
          .map((e) => MapEntry(e.key, e.value.item!)));

  String? get errorMessage => _error;
  bool get loading => _loading;
  Pack? get pack => _pack;
  String? get statusMessage => _status;
  bool get succeeded => !_loading && _error == null;

  void clear() {
    _pack = null;
    _elements.clear();
    notifyListeners();
  }

  PackElement? element(String path) {
    return _elements[path];
  }

  Map<String, PackElement> elements(PackElementType type) {
    return Map.fromEntries(
        _elements.entries.where((element) => element.value.type == type));
  }

  Future<bool> loadAsync(Pack? pack) async {
    _error = null;
    clear();

    if (pack == null) {
      return false;
    }

    _pack = pack;
    _loading = true;
    _status = 'Loading pack..';
    notifyListeners();

    _elements = await addonRepository.fetchPackElementsAsync(pack.directory);
    _loading = false;
    notifyListeners();
    return true;
  }
}
