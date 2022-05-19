import 'package:json_annotation/json_annotation.dart';

part 'patch.g.dart';

@JsonSerializable()
class Patch {
  @JsonKey(name: 'op')
  final PatchOperation operation;
  final String path;
  final dynamic value;

  Patch({
    required this.operation,
    required this.path,
    this.value,
  });

  factory Patch.fromJson(Map<String, dynamic> json) => _$PatchFromJson(json);

  Map<String, dynamic> toJson() => _$PatchToJson(this);

  @override
  String toString() => '[$operation] $path -> $value';
}

@JsonEnum()
enum PatchOperation {
  add,
  copy,
  move,
  remove,
  replace,
  test;

  @override
  String toString() => name.toUpperCase();
}
