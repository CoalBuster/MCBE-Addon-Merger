// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pack_element.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PackElement _$PackElementFromJson(Map<String, dynamic> json) => PackElement(
      formatVersion: Version.fromText(json['format_version'] as String),
      animationControllers:
          (json['animation_controllers'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k,
            MinecraftAnimationController.fromJson(e as Map<String, dynamic>)),
      ),
      entity: json['minecraft:entity'] == null
          ? null
          : MinecraftServerEntity.fromJson(
              json['minecraft:entity'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PackElementToJson(PackElement instance) =>
    <String, dynamic>{
      'animation_controllers': instance.animationControllers,
      'format_version': Version.toText(instance.formatVersion),
      'minecraft:entity': instance.entity,
    };
