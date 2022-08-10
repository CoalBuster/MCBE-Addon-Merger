// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manifest_dependency.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ManifestDependency _$ManifestDependencyFromJson(Map<String, dynamic> json) =>
    ManifestDependency(
      uuid: json['uuid'] as String,
      version: Version.fromJson(json['version']),
    );

Map<String, dynamic> _$ManifestDependencyToJson(ManifestDependency instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'version': Version.toJson(instance.version),
    };
