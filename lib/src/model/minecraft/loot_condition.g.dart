// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loot_condition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MinecraftLootConditionChance _$MinecraftLootConditionChanceFromJson(
        Map<String, dynamic> json) =>
    MinecraftLootConditionChance(
      condition: json['condition'] as String,
      chance: (json['chance'] as num).toDouble(),
      lootingMultiplier: (json['looting_multiplier'] as num).toDouble(),
    );

Map<String, dynamic> _$MinecraftLootConditionChanceToJson(
        MinecraftLootConditionChance instance) =>
    <String, dynamic>{
      'condition': instance.condition,
      'chance': instance.chance,
      'looting_multiplier': instance.lootingMultiplier,
    };

MinecraftLootConditionPlayerKill _$MinecraftLootConditionPlayerKillFromJson(
        Map<String, dynamic> json) =>
    MinecraftLootConditionPlayerKill(
      condition: json['condition'] as String,
    );

Map<String, dynamic> _$MinecraftLootConditionPlayerKillToJson(
        MinecraftLootConditionPlayerKill instance) =>
    <String, dynamic>{
      'condition': instance.condition,
    };

MinecraftLootConditionUnknown _$MinecraftLootConditionUnknownFromJson(
        Map<String, dynamic> json) =>
    MinecraftLootConditionUnknown(
      condition: json['condition'] as String,
    );

Map<String, dynamic> _$MinecraftLootConditionUnknownToJson(
        MinecraftLootConditionUnknown instance) =>
    <String, dynamic>{
      'condition': instance.condition,
    };
