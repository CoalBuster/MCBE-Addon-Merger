// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loot_condition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LootConditionChance _$LootConditionChanceFromJson(Map<String, dynamic> json) =>
    LootConditionChance(
      condition: json['condition'] as String,
      chance: (json['chance'] as num).toDouble(),
      lootingMultiplier: (json['looting_multiplier'] as num).toDouble(),
    );

Map<String, dynamic> _$LootConditionChanceToJson(
        LootConditionChance instance) =>
    <String, dynamic>{
      'condition': instance.condition,
      'chance': instance.chance,
      'looting_multiplier': instance.lootingMultiplier,
    };

LootConditionPlayerKill _$LootConditionPlayerKillFromJson(
        Map<String, dynamic> json) =>
    LootConditionPlayerKill(
      condition: json['condition'] as String,
    );

Map<String, dynamic> _$LootConditionPlayerKillToJson(
        LootConditionPlayerKill instance) =>
    <String, dynamic>{
      'condition': instance.condition,
    };

LootConditionUnknown _$LootConditionUnknownFromJson(
        Map<String, dynamic> json) =>
    LootConditionUnknown(
      condition: json['condition'] as String,
    );

Map<String, dynamic> _$LootConditionUnknownToJson(
        LootConditionUnknown instance) =>
    <String, dynamic>{
      'condition': instance.condition,
    };
