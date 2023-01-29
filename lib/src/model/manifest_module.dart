import 'package:json_annotation/json_annotation.dart';

import 'module_type.dart';
import 'parameter.dart';
import 'version.dart';

part 'manifest_module.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ManifestModule implements Parameterized {
  final ModuleType type;
  final String uuid;
  @JsonKey(fromJson: Version.fromJson, toJson: Version.toJson)
  final Version version;

  ManifestModule({
    required this.type,
    required this.uuid,
    required this.version,
  });

  @override
  List<Parameter> get parameters => [
        Parameter('Type', '/type'),
        Parameter('Unique Identifier', '/uuid'),
        Parameter('Version', '/version')
      ];

  factory ManifestModule.fromJson(Map<String, dynamic> json) =>
      _$ManifestModuleFromJson(json);

  Map<String, dynamic> toJson() => _$ManifestModuleToJson(this);
}
