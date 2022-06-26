// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enchant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LootFunctionEnchant _$LootFunctionEnchantFromJson(Map<String, dynamic> json) =>
    LootFunctionEnchant(
      function: json['function'] as String,
      enchants: (json['enchants'] as List<dynamic>)
          .map((e) => Enchantment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LootFunctionEnchantToJson(
        LootFunctionEnchant instance) =>
    <String, dynamic>{
      'function': instance.function,
      'enchants': instance.enchants,
    };
