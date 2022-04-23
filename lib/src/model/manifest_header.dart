import 'package:json_annotation/json_annotation.dart';

import 'version.dart';

part 'manifest_header.g.dart';

/// The header part of the Addon manifest
@JsonSerializable(fieldRename: FieldRename.snake)
class ManifestHeader {
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

  factory ManifestHeader.fromJson(Map<String, dynamic> json) =>
      _$ManifestHeaderFromJson(json);

  Map<String, dynamic> toJson() => _$ManifestHeaderToJson(this);
}
