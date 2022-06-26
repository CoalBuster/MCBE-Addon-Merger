import 'package:json_annotation/json_annotation.dart';

import 'loot_condition.dart';

part 'chance.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class LootConditionChance extends LootCondition {
  final double chance;
  final double lootingMultiplier;

  LootConditionChance({
    required String condition,
    required this.chance,
    required this.lootingMultiplier,
  }) : super(condition: condition);

  factory LootConditionChance.fromJson(Map<String, dynamic> json) =>
      _$LootConditionChanceFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LootConditionChanceToJson(this);

  @override
  String toString() =>
      'Overall chance: ${chance * 100}% (+${lootingMultiplier * 100}% per looting lvl)';
}
