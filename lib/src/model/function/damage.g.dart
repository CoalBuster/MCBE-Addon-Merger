// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'damage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LootFunctionDamage _$LootFunctionDamageFromJson(Map<String, dynamic> json) =>
    LootFunctionDamage(
      function: json['function'] as String,
      damage: DoubleRange.fromJson(json['damage'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LootFunctionDamageToJson(LootFunctionDamage instance) =>
    <String, dynamic>{
      'function': instance.function,
      'damage': instance.damage,
    };
