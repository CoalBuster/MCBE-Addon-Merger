// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manifest_header.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ManifestHeader _$ManifestHeaderFromJson(Map<String, dynamic> json) =>
    ManifestHeader(
      description: json['description'] as String,
      minEngineVersion: Version.fromJson(json['min_engine_version'] as List),
      name: json['name'] as String,
      uuid: json['uuid'] as String,
      version: Version.fromJson(json['version'] as List),
    );

Map<String, dynamic> _$ManifestHeaderToJson(ManifestHeader instance) =>
    <String, dynamic>{
      'description': instance.description,
      'min_engine_version': Version.toJson(instance.minEngineVersion),
      'name': instance.name,
      'uuid': instance.uuid,
      'version': Version.toJson(instance.version),
    };
