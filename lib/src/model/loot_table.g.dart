// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loot_table.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LootTable _$LootTableFromJson(Map<String, dynamic> json) => LootTable(
      entries: (json['entries'] as List<dynamic>?)
          ?.map((e) => LootPoolEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
      conditions: (json['conditions'] as List<dynamic>?)
          ?.map(
              (e) => const LootConditions().fromJson(e as Map<String, dynamic>))
          .toList(),
      rolls:
          json['rolls'] == null ? null : CountOrRange.fromJson(json['rolls']),
      tiers: json['tiers'] == null
          ? null
          : LootPoolTier.fromJson(json['tiers'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LootTableToJson(LootTable instance) => <String, dynamic>{
      'conditions':
          instance.conditions?.map(const LootConditions().toJson).toList(),
      'entries': instance.entries,
      'rolls': instance.rolls,
      'tiers': instance.tiers,
    };

LootPoolTier _$LootPoolTierFromJson(Map<String, dynamic> json) => LootPoolTier(
      bonusChance: (json['bonus_chance'] as num?)?.toDouble() ?? 0,
      bonusRolls: json['bonus_rolls'] as int? ?? 0,
      initialRange: json['initial_range'] as int? ?? 1,
    );

Map<String, dynamic> _$LootPoolTierToJson(LootPoolTier instance) =>
    <String, dynamic>{
      'bonus_chance': instance.bonusChance,
      'bonus_rolls': instance.bonusRolls,
      'initial_range': instance.initialRange,
    };

LootPoolEntry _$LootPoolEntryFromJson(Map<String, dynamic> json) =>
    LootPoolEntry(
      type: $enumDecode(_$LootTypeEnumMap, json['type']),
      weight: json['weight'] as int? ?? 1,
      functions: (json['functions'] as List<dynamic>?)
          ?.map(
              (e) => const LootFunctions().fromJson(e as Map<String, dynamic>))
          .toList(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$LootPoolEntryToJson(LootPoolEntry instance) =>
    <String, dynamic>{
      'functions':
          instance.functions?.map(const LootFunctions().toJson).toList(),
      'name': instance.name,
      'type': _$LootTypeEnumMap[instance.type],
      'weight': instance.weight,
    };

const _$LootTypeEnumMap = {
  LootType.empty: 'empty',
  LootType.item: 'item',
  LootType.lootTable: 'loot_table',
};
