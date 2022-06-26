// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'count.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LootFunctionCount _$LootFunctionCountFromJson(Map<String, dynamic> json) =>
    LootFunctionCount(
      function: json['function'] as String,
      count: CountOrRange.fromJson(json['count']),
    );

Map<String, dynamic> _$LootFunctionCountToJson(LootFunctionCount instance) =>
    <String, dynamic>{
      'function': instance.function,
      'count': instance.count,
    };
