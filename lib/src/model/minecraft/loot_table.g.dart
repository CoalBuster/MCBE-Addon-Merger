// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loot_table.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MinecraftLootTable _$MinecraftLootTableFromJson(Map<String, dynamic> json) =>
    MinecraftLootTable(
      entries: (json['entries'] as List<dynamic>?)
          ?.map(
              (e) => MinecraftLootPoolEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
      conditions: (json['conditions'] as List<dynamic>?)
          ?.map(
              (e) => MinecraftLootCondition.fromJson(e as Map<String, dynamic>))
          .toList(),
      rolls:
          json['rolls'] == null ? null : CountOrRange.fromJson(json['rolls']),
      tiers: json['tiers'] == null
          ? null
          : MinecraftLootPoolTier.fromJson(
              json['tiers'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MinecraftLootTableToJson(MinecraftLootTable instance) =>
    <String, dynamic>{
      'conditions': instance.conditions,
      'entries': instance.entries,
      'rolls': instance.rolls,
      'tiers': instance.tiers,
    };

MinecraftLootPoolTier _$MinecraftLootPoolTierFromJson(
        Map<String, dynamic> json) =>
    MinecraftLootPoolTier(
      bonusChance: (json['bonus_chance'] as num?)?.toDouble() ?? 0,
      bonusRolls: json['bonus_rolls'] as int? ?? 0,
      initialRange: json['initial_range'] as int? ?? 1,
    );

Map<String, dynamic> _$MinecraftLootPoolTierToJson(
        MinecraftLootPoolTier instance) =>
    <String, dynamic>{
      'bonus_chance': instance.bonusChance,
      'bonus_rolls': instance.bonusRolls,
      'initial_range': instance.initialRange,
    };

MinecraftLootPoolEntry _$MinecraftLootPoolEntryFromJson(
        Map<String, dynamic> json) =>
    MinecraftLootPoolEntry(
      type: $enumDecode(_$MinecraftLootTypeEnumMap, json['type']),
      weight: json['weight'] as int? ?? 1,
      functions: (json['functions'] as List<dynamic>?)
          ?.map((e) => MinecraftFunction.fromJson(e as Map<String, dynamic>))
          .toList(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$MinecraftLootPoolEntryToJson(
        MinecraftLootPoolEntry instance) =>
    <String, dynamic>{
      'functions': instance.functions,
      'name': instance.name,
      'type': _$MinecraftLootTypeEnumMap[instance.type],
      'weight': instance.weight,
    };

const _$MinecraftLootTypeEnumMap = {
  MinecraftLootType.empty: 'empty',
  MinecraftLootType.item: 'item',
  MinecraftLootType.lootTable: 'loot_table',
};
