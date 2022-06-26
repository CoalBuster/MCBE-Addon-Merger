// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServerEntity _$ServerEntityFromJson(Map<String, dynamic> json) => ServerEntity(
      componentGroups: json['component_groups'] as Map<String, dynamic>?,
      components:
          Components.fromJson(json['components'] as Map<String, dynamic>),
      description: ServerEntityDescription.fromJson(
          json['description'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ServerEntityToJson(ServerEntity instance) =>
    <String, dynamic>{
      'component_groups': instance.componentGroups,
      'components': Components.toJson(instance.components),
      'description': instance.description,
    };

ServerEntityDescription _$ServerEntityDescriptionFromJson(
        Map<String, dynamic> json) =>
    ServerEntityDescription(
      identifier: json['identifier'] as String,
      animations: (json['animations'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      isExperimental: json['is_experimental'] as bool?,
      isSpawnable: json['is_spawnable'] as bool?,
      isSummonable: json['is_summonable'] as bool?,
      scripts: json['scripts'] == null
          ? null
          : ServerEntityScripts.fromJson(
              json['scripts'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ServerEntityDescriptionToJson(
        ServerEntityDescription instance) =>
    <String, dynamic>{
      'animations': instance.animations,
      'identifier': instance.identifier,
      'is_spawnable': instance.isSpawnable,
      'is_summonable': instance.isSummonable,
      'is_experimental': instance.isExperimental,
      'scripts': instance.scripts,
    };

ServerEntityScripts _$ServerEntityScriptsFromJson(Map<String, dynamic> json) =>
    ServerEntityScripts(
      animate:
          (json['animate'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ServerEntityScriptsToJson(
        ServerEntityScripts instance) =>
    <String, dynamic>{
      'animate': instance.animate,
    };
