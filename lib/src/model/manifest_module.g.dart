// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manifest_module.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ManifestModule _$ManifestModuleFromJson(Map<String, dynamic> json) =>
    ManifestModule(
      type: $enumDecode(_$ModuleTypeEnumMap, json['type']),
      uuid: json['uuid'] as String,
      version: Version.fromJson(json['version'] as List),
    );

Map<String, dynamic> _$ManifestModuleToJson(ManifestModule instance) =>
    <String, dynamic>{
      'type': _$ModuleTypeEnumMap[instance.type],
      'uuid': instance.uuid,
      'version': Version.toJson(instance.version),
    };

const _$ModuleTypeEnumMap = {
  ModuleType.data: 'data',
  ModuleType.javascript: 'javascript',
  ModuleType.resources: 'resources',
};
