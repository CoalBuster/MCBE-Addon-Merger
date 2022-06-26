import 'package:json_annotation/json_annotation.dart';
import 'condition/loot_condition.dart';
import 'condition/loot_conditions.dart';
import 'function/function.dart';
import 'function/functions.dart';
import 'range.dart';

part 'loot_table.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class LootTable {
  @LootConditions()
  final List<LootCondition>? conditions;
  final List<LootPoolEntry>? entries;
  final CountOrRange? rolls;
  final LootPoolTier? tiers;

  LootTable({
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

  factory LootTable.fromJson(Map<String, dynamic> json) =>
      _$LootTableFromJson(json);

  Map<String, dynamic> toJson() => _$LootTableToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class LootPoolTier {
  final double bonusChance;
  final int bonusRolls;
  final int initialRange;

  LootPoolTier({
    this.bonusChance = 0,
    this.bonusRolls = 0,
    this.initialRange = 1,
  });

  CountOrRange get start => initialRange == 1
      ? const CountOrRange.count(1)
      : CountOrRange.range(1, initialRange);

  factory LootPoolTier.fromJson(Map<String, dynamic> json) =>
      _$LootPoolTierFromJson(json);

  Map<String, dynamic> toJson() => _$LootPoolTierToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class LootPoolEntry {
  @LootFunctions()
  final List<LootFunction>? functions;
  final String? name;
  final LootType type;
  final int weight;

  LootPoolEntry({
    required this.type,
    this.weight = 1,
    this.functions,
    this.name,
  });

  factory LootPoolEntry.fromJson(Map<String, dynamic> json) =>
      _$LootPoolEntryFromJson(json);

  Map<String, dynamic> toJson() => _$LootPoolEntryToJson(this);
}

@JsonEnum(fieldRename: FieldRename.snake)
enum LootType {
  empty,
  item,
  lootTable,
}
