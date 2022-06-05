import 'package:json_annotation/json_annotation.dart';

part 'seed.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MinecraftComponentSeed {
  final String cropResult;
  final String plantAt;

  MinecraftComponentSeed({
    required this.cropResult,
    required this.plantAt,
  });

  factory MinecraftComponentSeed.fromJson(Map<String, dynamic> json) =>
      _$MinecraftComponentSeedFromJson(json);

  Map<String, dynamic> toJson() => _$MinecraftComponentSeedToJson(this);

  @override
  String toString() => 'Plant on $plantAt to grow $cropResult';
}
