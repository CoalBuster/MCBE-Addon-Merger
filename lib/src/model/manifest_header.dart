import 'package:json_annotation/json_annotation.dart';

import 'parameter.dart';
import 'version.dart';

part 'manifest_header.g.dart';

/// The header part of the Addon manifest
@JsonSerializable(fieldRename: FieldRename.snake)
class ManifestHeader implements Parameterized {
  final String description;
  @JsonKey(fromJson: Version.fromJson, toJson: Version.toJson)
  final Version minEngineVersion;
  final String name;
  final String uuid;
  @JsonKey(fromJson: Version.fromJson, toJson: Version.toJson)
  final Version version;

  const ManifestHeader({
    required this.description,
    required this.minEngineVersion,
    required this.name,
    required this.uuid,
    required this.version,
  });

  @override
  List<Parameter> get parameters => [
        Parameter('Name', '/name'),
        Parameter('Description', '/description'),
        Parameter('Unique Identifier', '/uuid'),
        Parameter('Version', '/version'),
        Parameter('Minimal Engine Version', '/min_engine_version'),
      ];

  factory ManifestHeader.fromJson(Map<String, dynamic> json) =>
      _$ManifestHeaderFromJson(json);

  Map<String, dynamic> toJson() => _$ManifestHeaderToJson(this);
}
