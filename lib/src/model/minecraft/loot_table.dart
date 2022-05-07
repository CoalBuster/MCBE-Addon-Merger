import 'package:json_annotation/json_annotation.dart';

import '../count_or_range.dart';
import 'functions.dart';
import 'loot_condition.dart';

part 'loot_table.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MinecraftLootTable {
  final List<MinecraftLootCondition>? conditions;
  final List<MinecraftLootPoolEntry>? entries;
  final CountOrRange? rolls;
  final MinecraftLootPoolTier? tiers;

  MinecraftLootTable({
    this.entries,
    this.conditions,
    this.rolls,
    this.tiers,
  });

  bool get isEmpty =>
      entries == null || entries!.isEmpty || (rolls == null && tiers == null);

  bool get isTiered => tiers != null;

  int get totalWeight =>
      entries
          ?.map((e) => e.weight)
          .reduce((value, element) => value + element) ??
      0;

  factory MinecraftLootTable.fromJson(Map<String, dynamic> json) =>
      _$MinecraftLootTableFromJson(json);

  Map<String, dynamic> toJson() => _$MinecraftLootTableToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class MinecraftLootPoolTier {
  final double bonusChance;
  final int bonusRolls;
  final int initialRange;

  MinecraftLootPoolTier({
    this.bonusChance = 0,
    this.bonusRolls = 0,
    this.initialRange = 1,
  });

  CountOrRange get start => initialRange == 1
      ? const CountOrRange.count(1)
      : CountOrRange.range(1, initialRange);

  factory MinecraftLootPoolTier.fromJson(Map<String, dynamic> json) =>
      _$MinecraftLootPoolTierFromJson(json);

  Map<String, dynamic> toJson() => _$MinecraftLootPoolTierToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class MinecraftLootPoolEntry {
  final List<MinecraftFunction>? functions;
  final String? name;
  final MinecraftLootType type;
  final int weight;

  MinecraftLootPoolEntry({
    required this.type,
    this.weight = 1,
    this.functions,
    this.name,
  });

  factory MinecraftLootPoolEntry.fromJson(Map<String, dynamic> json) =>
      _$MinecraftLootPoolEntryFromJson(json);

  Map<String, dynamic> toJson() => _$MinecraftLootPoolEntryToJson(this);
}

@JsonEnum(fieldRename: FieldRename.snake)
enum MinecraftLootType {
  empty,
  item,
  lootTable,
}
