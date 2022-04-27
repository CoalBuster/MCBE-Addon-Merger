// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loot_table.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MinecraftLootTable _$MinecraftLootTableFromJson(Map<String, dynamic> json) =>
    MinecraftLootTable(
      entries: (json['entries'] as List<dynamic>)
          .map(
              (e) => MinecraftLootPoolEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
      rolls:
          json['rolls'] == null ? null : CountOrRange.fromJson(json['rolls']),
    );

Map<String, dynamic> _$MinecraftLootTableToJson(MinecraftLootTable instance) =>
    <String, dynamic>{
      'entries': instance.entries,
      'rolls': instance.rolls,
    };

MinecraftLootPoolEntry _$MinecraftLootPoolEntryFromJson(
        Map<String, dynamic> json) =>
    MinecraftLootPoolEntry(
      type: json['type'] as String,
      weight: json['weight'] as int? ?? 1,
      functions: (json['functions'] as List<dynamic>?)
          ?.map(
              (e) => MinecraftLootFunction.fromJson(e as Map<String, dynamic>))
          .toList(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$MinecraftLootPoolEntryToJson(
        MinecraftLootPoolEntry instance) =>
    <String, dynamic>{
      'functions': instance.functions,
      'name': instance.name,
      'type': instance.type,
      'weight': instance.weight,
    };

MinecraftLootFunction _$MinecraftLootFunctionFromJson(
        Map<String, dynamic> json) =>
    MinecraftLootFunction(
      function:
          $enumDecode(_$MinecraftLootFuntionTypeEnumMap, json['function']),
      count:
          json['count'] == null ? null : CountOrRange.fromJson(json['count']),
      damage: json['damage'] == null
          ? null
          : DoubleRange.fromJson(json['damage'] as Map<String, dynamic>),
      destination: json['destination'] as String?,
      data: json['data'] as int?,
      levels:
          json['levels'] == null ? null : CountOrRange.fromJson(json['levels']),
      treasure: json['treasure'] as bool?,
      values: json['values'] == null
          ? null
          : IntegerRange.fromJson(json['values'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MinecraftLootFunctionToJson(
        MinecraftLootFunction instance) =>
    <String, dynamic>{
      'count': instance.count,
      'damage': instance.damage,
      'data': instance.data,
      'destination': instance.destination,
      'function': _$MinecraftLootFuntionTypeEnumMap[instance.function],
      'levels': instance.levels,
      'treasure': instance.treasure,
      'values': instance.values,
    };

const _$MinecraftLootFuntionTypeEnumMap = {
  MinecraftLootFuntionType.enchantRandomly: 'enchant_randomly',
  MinecraftLootFuntionType.enchantRandomly2: 'minecraft:enchant_randomly',
  MinecraftLootFuntionType.enchantWithLevels: 'enchant_with_levels',
  MinecraftLootFuntionType.explorationMap: 'exploration_map',
  MinecraftLootFuntionType.randomAuxValue: 'random_aux_value',
  MinecraftLootFuntionType.setCount: 'set_count',
  MinecraftLootFuntionType.setCount2: 'minecraft:set_count',
  MinecraftLootFuntionType.setDamage: 'minecraft:set_damage',
  MinecraftLootFuntionType.setData: 'set_data',
  MinecraftLootFuntionType.setData2: 'minecraft:set_data',
  MinecraftLootFuntionType.specificEnchants: 'specific_enchants',
};
