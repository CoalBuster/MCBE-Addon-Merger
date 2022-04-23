// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manifest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Manifest _$ManifestFromJson(Map<String, dynamic> json) => Manifest(
      dependencies: (json['dependencies'] as List<dynamic>)
          .map((e) => ManifestDependency.fromJson(e as Map<String, dynamic>))
          .toList(),
      formatVersion: json['format_version'] as int,
      header: ManifestHeader.fromJson(json['header'] as Map<String, dynamic>),
      modules: (json['modules'] as List<dynamic>)
          .map((e) => ManifestModule.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ManifestToJson(Manifest instance) => <String, dynamic>{
      'dependencies': instance.dependencies,
      'format_version': instance.formatVersion,
      'header': instance.header,
      'modules': instance.modules,
    };
