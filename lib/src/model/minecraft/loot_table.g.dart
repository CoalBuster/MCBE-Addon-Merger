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
          ?.map((e) => MinecraftFunction.fromJson(e as Map<String, dynamic>))
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
