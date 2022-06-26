// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chance.dart';

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
