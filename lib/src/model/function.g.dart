// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'function.dart';

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

LootFunctionData _$LootFunctionDataFromJson(Map<String, dynamic> json) =>
    LootFunctionData(
      function: json['function'] as String,
      data: json['data'] as int,
    );

Map<String, dynamic> _$LootFunctionDataToJson(LootFunctionData instance) =>
    <String, dynamic>{
      'function': instance.function,
      'data': instance.data,
    };

LootFunctionEnchantRandomly _$LootFunctionEnchantRandomlyFromJson(
        Map<String, dynamic> json) =>
    LootFunctionEnchantRandomly(
      function: json['function'] as String,
      chance: (json['chance'] as num?)?.toDouble(),
      levels:
          json['levels'] == null ? null : CountOrRange.fromJson(json['levels']),
      treasure: json['treasure'] as bool? ?? false,
    );

Map<String, dynamic> _$LootFunctionEnchantRandomlyToJson(
        LootFunctionEnchantRandomly instance) =>
    <String, dynamic>{
      'function': instance.function,
      'chance': instance.chance,
      'levels': instance.levels,
      'treasure': instance.treasure,
    };

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

LootFunctionExploration _$LootFunctionExplorationFromJson(
        Map<String, dynamic> json) =>
    LootFunctionExploration(
      function: json['function'] as String,
      destination: json['destination'] as String,
    );

Map<String, dynamic> _$LootFunctionExplorationToJson(
        LootFunctionExploration instance) =>
    <String, dynamic>{
      'function': instance.function,
      'destination': instance.destination,
    };

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

LootFunctionRandomAux _$LootFunctionRandomAuxFromJson(
        Map<String, dynamic> json) =>
    LootFunctionRandomAux(
      function: json['function'] as String,
      values: IntegerRange.fromJson(json['values'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LootFunctionRandomAuxToJson(
        LootFunctionRandomAux instance) =>
    <String, dynamic>{
      'function': instance.function,
      'values': instance.values,
    };

LootFunctionUnknown _$LootFunctionUnknownFromJson(Map<String, dynamic> json) =>
    LootFunctionUnknown(
      function: json['function'] as String,
    );

Map<String, dynamic> _$LootFunctionUnknownToJson(
        LootFunctionUnknown instance) =>
    <String, dynamic>{
      'function': instance.function,
    };
