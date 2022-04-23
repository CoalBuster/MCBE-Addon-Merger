import 'package:json_annotation/json_annotation.dart';
import 'package:mcbe_addon_merger/src/model/version.dart';

part 'manifest_dependency.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ManifestDependency {
  final String uuid;
  @JsonKey(fromJson: Version.fromJson, toJson: Version.toJson)
  final Version version;

  ManifestDependency({
    required this.uuid,
    required this.version,
  });

  factory ManifestDependency.fromJson(Map<String, dynamic> json) =>
      _$ManifestDependencyFromJson(json);

  Map<String, dynamic> toJson() => _$ManifestDependencyToJson(this);
}
