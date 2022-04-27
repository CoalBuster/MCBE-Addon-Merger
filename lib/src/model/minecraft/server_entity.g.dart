// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MinecraftServerEntity _$MinecraftServerEntityFromJson(
        Map<String, dynamic> json) =>
    MinecraftServerEntity(
      componentGroups: json['component_groups'] as Map<String, dynamic>?,
      components: json['components'] as Map<String, dynamic>,
      description: MinecraftServerEntityDescription.fromJson(
          json['description'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MinecraftServerEntityToJson(
        MinecraftServerEntity instance) =>
    <String, dynamic>{
      'component_groups': instance.componentGroups,
      'components': instance.components,
      'description': instance.description,
    };

MinecraftServerEntityDescription _$MinecraftServerEntityDescriptionFromJson(
        Map<String, dynamic> json) =>
    MinecraftServerEntityDescription(
      identifier: json['identifier'] as String,
      animations: (json['animations'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      isExperimental: json['is_experimental'] as bool?,
      isSpawnable: json['is_spawnable'] as bool?,
      isSummonable: json['is_summonable'] as bool?,
      scripts: json['scripts'] == null
          ? null
          : MinecraftServerEntityScripts.fromJson(
              json['scripts'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MinecraftServerEntityDescriptionToJson(
        MinecraftServerEntityDescription instance) =>
    <String, dynamic>{
      'animations': instance.animations,
      'identifier': instance.identifier,
      'is_spawnable': instance.isSpawnable,
      'is_summonable': instance.isSummonable,
      'is_experimental': instance.isExperimental,
      'scripts': instance.scripts,
    };

MinecraftServerEntityScripts _$MinecraftServerEntityScriptsFromJson(
        Map<String, dynamic> json) =>
    MinecraftServerEntityScripts(
      animate:
          (json['animate'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$MinecraftServerEntityScriptsToJson(
        MinecraftServerEntityScripts instance) =>
    <String, dynamic>{
      'animate': instance.animate,
    };
