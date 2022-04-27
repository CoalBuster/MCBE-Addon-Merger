// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MinecraftItem _$MinecraftItemFromJson(Map<String, dynamic> json) =>
    MinecraftItem(
      components: json['components'] as Map<String, dynamic>?,
      description: MinecraftItemDescription.fromJson(
          json['description'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MinecraftItemToJson(MinecraftItem instance) =>
    <String, dynamic>{
      'components': instance.components,
      'description': instance.description,
    };

MinecraftItemDescription _$MinecraftItemDescriptionFromJson(
        Map<String, dynamic> json) =>
    MinecraftItemDescription(
      identifier: json['identifier'] as String,
      category: json['category'] as String?,
    );

Map<String, dynamic> _$MinecraftItemDescriptionToJson(
        MinecraftItemDescription instance) =>
    <String, dynamic>{
      'category': instance.category,
      'identifier': instance.identifier,
    };
