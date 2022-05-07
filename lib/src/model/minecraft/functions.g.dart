// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'functions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MinecraftFunctionCount _$MinecraftFunctionCountFromJson(
        Map<String, dynamic> json) =>
    MinecraftFunctionCount(
      function: json['function'] as String,
      count: CountOrRange.fromJson(json['count']),
    );

Map<String, dynamic> _$MinecraftFunctionCountToJson(
        MinecraftFunctionCount instance) =>
    <String, dynamic>{
      'function': instance.function,
      'count': instance.count,
    };

MinecraftFunctionDamage _$MinecraftFunctionDamageFromJson(
        Map<String, dynamic> json) =>
    MinecraftFunctionDamage(
      function: json['function'] as String,
      damage: DoubleRange.fromJson(json['damage'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MinecraftFunctionDamageToJson(
        MinecraftFunctionDamage instance) =>
    <String, dynamic>{
      'function': instance.function,
      'damage': instance.damage,
    };

MinecraftFunctionData _$MinecraftFunctionDataFromJson(
        Map<String, dynamic> json) =>
    MinecraftFunctionData(
      function: json['function'] as String,
      data: json['data'] as int,
    );

Map<String, dynamic> _$MinecraftFunctionDataToJson(
        MinecraftFunctionData instance) =>
    <String, dynamic>{
      'function': instance.function,
      'data': instance.data,
    };

MinecraftFunctionEnchant _$MinecraftFunctionEnchantFromJson(
        Map<String, dynamic> json) =>
    MinecraftFunctionEnchant(
      function: json['function'] as String,
      enchants: (json['enchants'] as List<dynamic>)
          .map((e) => MinecraftEnchantment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MinecraftFunctionEnchantToJson(
        MinecraftFunctionEnchant instance) =>
    <String, dynamic>{
      'function': instance.function,
      'enchants': instance.enchants,
    };

MinecraftFunctionEnchantRandomly _$MinecraftFunctionEnchantRandomlyFromJson(
        Map<String, dynamic> json) =>
    MinecraftFunctionEnchantRandomly(
      function: json['function'] as String,
      chance: (json['chance'] as num?)?.toDouble(),
      levels:
          json['levels'] == null ? null : CountOrRange.fromJson(json['levels']),
      treasure: json['treasure'] as bool? ?? false,
    );

Map<String, dynamic> _$MinecraftFunctionEnchantRandomlyToJson(
        MinecraftFunctionEnchantRandomly instance) =>
    <String, dynamic>{
      'function': instance.function,
      'chance': instance.chance,
      'levels': instance.levels,
      'treasure': instance.treasure,
    };

MinecraftFunctionExploration _$MinecraftFunctionExplorationFromJson(
        Map<String, dynamic> json) =>
    MinecraftFunctionExploration(
      function: json['function'] as String,
      destination: json['destination'] as String,
    );

Map<String, dynamic> _$MinecraftFunctionExplorationToJson(
        MinecraftFunctionExploration instance) =>
    <String, dynamic>{
      'function': instance.function,
      'destination': instance.destination,
    };

MinecraftFunctionLooting _$MinecraftFunctionLootingFromJson(
        Map<String, dynamic> json) =>
    MinecraftFunctionLooting(
      function: json['function'] as String,
      count: IntegerRange.fromJson(json['count'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MinecraftFunctionLootingToJson(
        MinecraftFunctionLooting instance) =>
    <String, dynamic>{
      'function': instance.function,
      'count': instance.count,
    };

MinecraftFunctionRandomAux _$MinecraftFunctionRandomAuxFromJson(
        Map<String, dynamic> json) =>
    MinecraftFunctionRandomAux(
      function: json['function'] as String,
      values: IntegerRange.fromJson(json['values'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MinecraftFunctionRandomAuxToJson(
        MinecraftFunctionRandomAux instance) =>
    <String, dynamic>{
      'function': instance.function,
      'values': instance.values,
    };

MinecraftFunctionUnknown _$MinecraftFunctionUnknownFromJson(
        Map<String, dynamic> json) =>
    MinecraftFunctionUnknown(
      function: json['function'] as String,
    );

Map<String, dynamic> _$MinecraftFunctionUnknownToJson(
        MinecraftFunctionUnknown instance) =>
    <String, dynamic>{
      'function': instance.function,
    };

MinecraftEnchantment _$MinecraftEnchantmentFromJson(
        Map<String, dynamic> json) =>
    MinecraftEnchantment(
      id: json['id'] as String,
      level: (json['level'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$MinecraftEnchantmentToJson(
        MinecraftEnchantment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'level': instance.level,
    };
