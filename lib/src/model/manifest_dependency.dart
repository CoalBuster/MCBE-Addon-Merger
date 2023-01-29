import 'package:json_annotation/json_annotation.dart';

import 'parameter.dart';
import 'version.dart';

part 'manifest_dependency.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ManifestDependency implements Parameterized {
  final String uuid;
  @JsonKey(fromJson: Version.fromJson, toJson: Version.toJson)
  final Version version;

  ManifestDependency({
    required this.uuid,
    required this.version,
  });

  @override
  List<Parameter> get parameters => [
        Parameter('Unique Identifier', '/uuid'),
        Parameter('Version', '/version'),
      ];

  factory ManifestDependency.fromJson(Map<String, dynamic> json) =>
      _$ManifestDependencyFromJson(json);

  Map<String, dynamic> toJson() => _$ManifestDependencyToJson(this);
}
