// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      components:
          Components.fromJson(json['components'] as Map<String, dynamic>),
      description:
          ItemDescription.fromJson(json['description'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'components': Components.toJson(instance.components),
      'description': instance.description,
    };

ItemDescription _$ItemDescriptionFromJson(Map<String, dynamic> json) =>
    ItemDescription(
      identifier: json['identifier'] as String,
      category: json['category'] as String?,
    );

Map<String, dynamic> _$ItemDescriptionToJson(ItemDescription instance) =>
    <String, dynamic>{
      'category': instance.category,
      'identifier': instance.identifier,
    };
