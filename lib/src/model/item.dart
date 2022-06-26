import 'package:json_annotation/json_annotation.dart';

import 'component.dart';

part 'item.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Item {
  @JsonKey(fromJson: Components.fromJson, toJson: Components.toJson)
  final Map<String, Component> components;
  final ItemDescription description;

  Item({
    required this.components,
    required this.description,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ItemDescription {
  final String? category;
  final String identifier;

  ItemDescription({
    required this.identifier,
    this.category,
  });

  factory ItemDescription.fromJson(Map<String, dynamic> json) =>
      _$ItemDescriptionFromJson(json);

  Map<String, dynamic> toJson() => _$ItemDescriptionToJson(this);
}
