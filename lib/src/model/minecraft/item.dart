import 'package:json_annotation/json_annotation.dart';

part 'item.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MinecraftItem {
  final Map<String, dynamic>? components;
  final MinecraftItemDescription description;

  MinecraftItem({
    required this.components,
    required this.description,
  });

  factory MinecraftItem.fromJson(Map<String, dynamic> json) =>
      _$MinecraftItemFromJson(json);

  Map<String, dynamic> toJson() => _$MinecraftItemToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class MinecraftItemDescription {
  final String? category;
  final String identifier;

  MinecraftItemDescription({
    required this.identifier,
    this.category,
  });

  factory MinecraftItemDescription.fromJson(Map<String, dynamic> json) =>
      _$MinecraftItemDescriptionFromJson(json);

  Map<String, dynamic> toJson() => _$MinecraftItemDescriptionToJson(this);
}
