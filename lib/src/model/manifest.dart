import 'package:json_annotation/json_annotation.dart';

import 'manifest_dependency.dart';
import 'manifest_header.dart';
import 'manifest_module.dart';
import 'module_type.dart';

part 'manifest.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Manifest {
  final List<ManifestDependency>? dependencies;
  final int formatVersion;
  final ManifestHeader header;
  final List<ManifestModule> modules;

  Manifest({
    required this.dependencies,
    required this.formatVersion,
    required this.header,
    required this.modules,
  });

  bool get isBehaviorPack => modules.any((m) => m.type == ModuleType.data);
  bool get isResourcePack => modules.any((m) => m.type == ModuleType.resources);
  Iterable<ModuleType> get moduleTypes => modules.map((m) => m.type);

  factory Manifest.fromJson(Map<String, dynamic> json) =>
      _$ManifestFromJson(json);

  Map<String, dynamic> toJson() => _$ManifestToJson(this);
}
