import 'package:json_annotation/json_annotation.dart';
import 'package:mcbe_addon_merger/src/model/range.dart';

import '../count_or_range.dart';

part 'loot_table.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MinecraftLootTable {
  final List<MinecraftLootPoolEntry> entries;
  final CountOrRange? rolls;

  MinecraftLootTable({
    required this.entries,
    required this.rolls,
  });

  int get totalWeight =>
      entries.map((e) => e.weight).reduce((value, element) => value + element);

  factory MinecraftLootTable.fromJson(Map<String, dynamic> json) =>
      _$MinecraftLootTableFromJson(json);

  Map<String, dynamic> toJson() => _$MinecraftLootTableToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class MinecraftLootPoolEntry {
  final List<MinecraftLootFunction>? functions;
  final String? name;
  final String type;
  final int weight;

  MinecraftLootPoolEntry({
    required this.type,
    this.weight = 1,
    this.functions,
    this.name,
  });

  CountOrRange? get count {
    final c = functions?.where((f) =>
        f.function == MinecraftLootFuntionType.setCount ||
        f.function == MinecraftLootFuntionType.setCount2);
    return (c?.isNotEmpty ?? false) ? c!.first.count : null;
  }

  factory MinecraftLootPoolEntry.fromJson(Map<String, dynamic> json) =>
      _$MinecraftLootPoolEntryFromJson(json);

  Map<String, dynamic> toJson() => _$MinecraftLootPoolEntryToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class MinecraftLootFunction {
  final CountOrRange? count;
  final DoubleRange? damage;
  final int? data;
  final String? destination;
  final MinecraftLootFuntionType function;
  final CountOrRange? levels;
  final bool? treasure;
  final IntegerRange? values;

  MinecraftLootFunction({
    required this.function,
    this.count,
    this.damage,
    this.destination,
    this.data,
    this.levels,
    this.treasure,
    this.values,
  });

  factory MinecraftLootFunction.fromJson(Map<String, dynamic> json) =>
      _$MinecraftLootFunctionFromJson(json);

  Map<String, dynamic> toJson() => _$MinecraftLootFunctionToJson(this);
}

@JsonEnum(fieldRename: FieldRename.snake)
enum MinecraftLootFuntionType {
  enchantRandomly,
  @JsonValue('minecraft:enchant_randomly')
  enchantRandomly2,
  enchantWithLevels,
  explorationMap,
  randomAuxValue,
  setCount,
  @JsonValue('minecraft:set_count')
  setCount2,
  @JsonValue('minecraft:set_damage')
  setDamage,
  setData,
  @JsonValue('minecraft:set_data')
  setData2,
  specificEnchants,
}
