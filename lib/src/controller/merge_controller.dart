// import 'dart:convert';

// import 'package:collection/collection.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:json_patch/json_patch.dart';
// import 'package:logger/logger.dart';

// import '../model/manifest.dart';
// import '../model/pack_difference.dart';
// import '../model/pack_element.dart';
// import '../model/pack_image.dart';
// import '../model/patch.dart';
// import '../repository/addon_repository.dart';
// import 'pack_controller.dart';

// class MergeController with ChangeNotifier {
//   final AddonRepository addonRepository;
//   final PackController _basePackController;
//   final PackController _comparePackController;
//   final Logger logger;

//   List<PackDifference> _diff = [];

//   MergeController({
//     required this.addonRepository,
//     required this.logger,
//   })  : _basePackController = PackController(
//           addonRepository: addonRepository,
//         ),
//         _comparePackController = PackController(
//           addonRepository: addonRepository,
//         ) {
//     _basePackController.addListener(notifyListeners);
//     _comparePackController.addListener(notifyListeners);
//   }

//   String? get basePackId => _basePackController.id;
//   List<PackElementInfo>? get basePackContent => _basePackController.elements;
//   String? get comparePackId => _comparePackController.id;
//   List<PackElementInfo>? get comparePackContent =>
//       _comparePackController.elements;
//   List<PackDifference> get diff => UnmodifiableListView(_diff);
//   bool get packsLoading =>
//       _basePackController.loading || _comparePackController.loading;
//   bool get packsSelected =>
//       _basePackController.elements != null &&
//       _comparePackController.elements != null;

//   void clear() {
//     _basePackController.clear();
//     _comparePackController.clear();
//     _diff.clear();
//     notifyListeners();
//   }

//   Future<List<PackDifference>?> compare() async {
//     _diff.clear();
//     notifyListeners();

//     if (!packsSelected) {
//       return null;
//     }

//     List<PackDifference> result = [];
//     for (var baseEntry in _basePackController.elements!) {
//       final diff = await _compareEntryAsync(baseEntry);

//       if (diff != null) {
//         result.add(diff);
//       }
//     }

//     _diff = result;
//     notifyListeners();
//     return result;
//   }

//   Future<PackDifference?> _compareEntryAsync(PackElementInfo baseEntry) async {
//     switch (baseEntry.type) {
//       case PackElementType.animationControllers:
//       case PackElementType.animations:
//       case PackElementType.entity:
//       case PackElementType.item:
//       case PackElementType.recipeShaped:
//       case PackElementType.recipeShapeless:
//         return _compareJsonAsync(
//             baseEntry, await _getComparingByName(baseEntry));
//       case PackElementType.lootTable:
//         return _compareJsonAsync(
//             baseEntry, await _getComparingByPath(baseEntry));
//       case PackElementType.image:
//       case PackElementType.unknown:
//         return null;
//     }
//   }

//   Future<PackDifference?> _compareJsonAsync(
//       PackElementInfo baseEntry, PackElementInfo? compareEntry) async {
//     if (compareEntry == null) {
//       logger.d('[$baseEntry] REMOVED');
//       return null;
//     }

//     final baseElement = await addonRepository.getElementByPathAsync(
//         basePackId!, baseEntry.path);
//     final compareElement = await addonRepository.getElementByPathAsync(
//         comparePackId!, compareEntry.path);

//     if (baseElement == null || compareElement == null) {
//       logger.e(
//           'Failed to fetch either base or comparing element (${baseEntry.path})');
//       return null;
//     }

//     final baseJson = jsonEncode(baseElement);
//     final compJson = jsonEncode(compareElement);
//     final diff = JsonPatch.diff(jsonDecode(baseJson), jsonDecode(compJson))
//         .map((e) => Patch.fromJson(e))
//         .toList();

//     if (diff.isEmpty) {
//       logger
//           .d('[${baseEntry.type.asString()}][id=${baseEntry.name}] UNCHANGED');
//     } else {
//       logger.d('[${baseEntry.type.asString()}][id=${baseEntry.name}] CHANGED'
//           ' (${diff.length} change(s)):\n  ${diff.join('\n  ')}');
//     }

//     return null;
//     // return PackDifference(
//     //   filename: filename,
//     //   packElement: baseEntity,
//     //   patches: diff,
//     // );
//   }

//   Future<PackElementInfo?> _getComparingByName(
//       PackElementInfo baseEntry) async {
//     if (baseEntry.name == null) {
//       logger.w('Expected element with path ${baseEntry.path} to have a name');
//       return null;
//     }

//     final compareEntry = _comparePackController.elements!
//         .singleWhereOrNull((e) => e.name == baseEntry.name);
//     return compareEntry;
//   }

//   Future<PackElementInfo?> _getComparingByPath(
//       PackElementInfo baseEntry) async {
//     final compareEntry = _comparePackController.elements!
//         .singleWhereOrNull((e) => e.path == baseEntry.path);
//     return compareEntry;
//   }

//   // final baseEntity = await addonRepository.getElementByPathAsync(
//   //     basePack!.header.uuid, baseEntry.path);
//   // final compareEntity = await addonRepository.getElementByPathAsync(
//   //     comparePack!.header.uuid, baseEntry.path);
//   // // final compareEntity = _comparePackController.elements
//   // //     ?.firstWhereOrNull((file) =>
//   // //         file.value.entity?.description.identifier ==
//   // //         baseEntity.entity!.description.identifier)
//   // //     ?.value;

//   // if (compareEntity == null) {
//   //   return null;
//   // }

//   // final baseJson = jsonEncode(baseEntity);
//   // final compJson = jsonEncode(compareEntity);
//   // final diff = JsonPatch.diff(jsonDecode(baseJson), jsonDecode(compJson))
//   //     .map((e) => Patch.fromJson(e))
//   //     .toList();
//   // logger.i('[ENTITY] [$filename] DIFF:\n  ${diff.join('\n  ')}');
//   // return PackDifference(
//   //   filename: filename,
//   //   packElement: baseEntity,
//   //   patches: diff,
//   // );
//   // }

//   // PackDifference? _compareFile(String filename) {
//   //   final compareFile = _comparePackController.packContent!.files.keys
//   //       .firstWhereOrNull((name) => name == filename);

//   //   if (compareFile == null) {
//   //     return null;
//   //   }

//   //   logger.i('[FILE] [$filename] OVERIDDEN');
//   //   return PackDifference(
//   //     filename: filename,
//   //   );
//   // }

//   // PackDifference? _compareImage(PackImage baseImage) {
//   //   final compareImage = _comparePackController.packContent!.files.entries
//   //       .firstWhereOrNull((element) => element.key == baseImage.path)
//   //       ?.value;

//   //   if (compareImage is! PackImage) {
//   //     return null;
//   //   }

//   //   logger.i('[IMAGE] [${baseImage.path}] OVERIDDEN');
//   //   return PackDifference(
//   //     filename: baseImage.path,
//   //     packElement: baseImage,
//   //   );
//   // }

//   Future<bool> loadBasePack(String basePackId) =>
//       _basePackController.loadPackByIdAsync(basePackId);

//   // Future<bool> loadBasePackByPathAsync(String basePackPath) async {
//   //   final basePack = await addonRepository.fetchPackByPath(basePackPath);
//   //   return _basePackController.loadAsync(basePack);
//   // }

//   Future<bool> loadComparePack(String comparePackId) =>
//       _comparePackController.loadPackByIdAsync(comparePackId);

//   // Future<bool> loadComparePackByPathAsync(String comparePackPath) async {
//   //   final comparePack = await addonRepository.fetchPackByPath(comparePackPath);
//   //   return _comparePackController.loadAsync(comparePack);
//   // }
// }
