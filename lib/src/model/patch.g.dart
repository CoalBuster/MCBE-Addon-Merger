// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Patch _$PatchFromJson(Map<String, dynamic> json) => Patch(
      operation: $enumDecode(_$PatchOperationEnumMap, json['op']),
      path: json['path'] as String,
      value: json['value'],
    );

Map<String, dynamic> _$PatchToJson(Patch instance) => <String, dynamic>{
      'op': _$PatchOperationEnumMap[instance.operation]!,
      'path': instance.path,
      'value': instance.value,
    };

const _$PatchOperationEnumMap = {
  PatchOperation.add: 'add',
  PatchOperation.copy: 'copy',
  PatchOperation.move: 'move',
  PatchOperation.remove: 'remove',
  PatchOperation.replace: 'replace',
  PatchOperation.test: 'test',
};
