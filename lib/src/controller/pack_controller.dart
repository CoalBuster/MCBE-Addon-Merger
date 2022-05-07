import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:mcbe_addon_merger/src/model/pack_content.dart';

import '../model/pack.dart';
import '../repository/addon_repository.dart';

class PackController with ChangeNotifier {
  final AddonRepository addonRepository;
  final Logger logger;

  String? _error;
  bool _loading = false;
  Pack? _pack;
  PackContent? _packContent;
  String? _status;

  PackController({
    required this.addonRepository,
    required this.logger,
  });

  String? get errorMessage => _error;
  bool get loading => _loading;
  Pack? get pack => _pack;
  PackContent? get packContent => _packContent;
  String? get statusMessage => _status;
  bool get succeeded => !_loading && _error == null;

  void clear() {
    _pack = null;
    _packContent = null;
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

    _packContent = await addonRepository.fetchPackContentAsync(pack);
    _loading = false;
    notifyListeners();
    return true;
  }
}
