// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LootTier _$LootTierFromJson(Map<String, dynamic> json) => LootTier(
      bonusChance: (json['bonus_chance'] as num?)?.toDouble() ?? 0,
      bonusRolls: json['bonus_rolls'] as int? ?? 0,
      initialRange: json['initial_range'] as int? ?? 1,
    );

Map<String, dynamic> _$LootTierToJson(LootTier instance) => <String, dynamic>{
      'bonus_chance': instance.bonusChance,
      'bonus_rolls': instance.bonusRolls,
      'initial_range': instance.initialRange,
    };

LootEntry _$LootEntryFromJson(Map<String, dynamic> json) => LootEntry(
      type: $enumDecode(_$LootTypeEnumMap, json['type']),
      weight: json['weight'] as int? ?? 1,
      functions: (json['functions'] as List<dynamic>?)
          ?.map(
              (e) => const LootFunctions().fromJson(e as Map<String, dynamic>))
          .toList(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$LootEntryToJson(LootEntry instance) => <String, dynamic>{
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
