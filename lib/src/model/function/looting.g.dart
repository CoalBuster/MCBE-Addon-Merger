// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'looting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LootFunctionLooting _$LootFunctionLootingFromJson(Map<String, dynamic> json) =>
    LootFunctionLooting(
      function: json['function'] as String,
      count: IntegerRange.fromJson(json['count'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LootFunctionLootingToJson(
        LootFunctionLooting instance) =>
    <String, dynamic>{
      'function': instance.function,
      'count': instance.count,
    };
