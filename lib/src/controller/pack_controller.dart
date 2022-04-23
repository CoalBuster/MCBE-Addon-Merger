import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../model/minecraft/animation_controller.dart';
import '../model/minecraft/server_entity.dart';
import '../model/pack.dart';
import '../model/pack_element.dart';
import '../repository/addon_repository.dart';

class PackController with ChangeNotifier {
  final AddonRepository addonRepository;
  final Logger logger;

  List<PackElement> _elements = [];
  String? _error;
  bool _loading = false;
  Pack? _pack;
  String? _status;

  PackController({
    required this.addonRepository,
    required this.logger,
  });

  Map<String, MinecraftAnimationController> get animationControllers =>
      Map.fromEntries(_elements
          .where((element) => element.animationControllers != null)
          .expand((e) => e.animationControllers!.entries));
  List<MinecraftServerEntity> get entities => _elements
      .where((element) => element.entity != null)
      .map((e) => e.entity!)
      .toList();

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
