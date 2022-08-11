import 'package:json_annotation/json_annotation.dart';
import 'function.dart';
import 'range.dart';

part 'loot.g.dart';

@JsonEnum(fieldRename: FieldRename.snake)
enum LootType {
  empty,
  item,
  lootTable,
}

@JsonSerializable(fieldRename: FieldRename.snake)
class LootTier {
  final double bonusChance;
  final int bonusRolls;
  final int initialRange;

  LootTier({
    this.bonusChance = 0,
    this.bonusRolls = 0,
    this.initialRange = 1,
  });

  CountOrRange get start => initialRange == 1
      ? const CountOrRange.count(1)
      : CountOrRange.range(1, initialRange);

  factory LootTier.fromJson(Map<String, dynamic> json) =>
      _$LootTierFromJson(json);

  Map<String, dynamic> toJson() => _$LootTierToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class LootEntry {
  @LootFunctions()
  final List<LootFunction>? functions;
  final String? name;
  final LootType type;
  final int weight;

  LootEntry({
    required this.type,
    this.weight = 1,
    this.functions,
    this.name,
  });

  factory LootEntry.fromJson(Map<String, dynamic> json) =>
      _$LootEntryFromJson(json);

  Map<String, dynamic> toJson() => _$LootEntryToJson(this);
}
