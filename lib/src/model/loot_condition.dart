import 'package:json_annotation/json_annotation.dart';

part 'loot_condition.g.dart';

abstract class LootCondition {
  final String condition;

  LootCondition({
    required this.condition,
  });

  Map<String, dynamic> toJson();
}

class LootConditions
    implements JsonConverter<LootCondition, Map<String, dynamic>> {
  static const _conditions = {
    'random_chance_with_looting': LootConditionChance.fromJson,
    'killed_by_player': LootConditionPlayerKill.fromJson,
  };

  const LootConditions();

  @override
  LootCondition fromJson(Map<String, dynamic> json) {
    final condition = json['condition'] as String;
    return _conditions[condition]?.call(json) ??
        LootConditionUnknown.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(LootCondition condition) => condition.toJson();
}

///
/// Loot Conditions
///

/// Random Chance
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

/// Player Kill
@JsonSerializable(fieldRename: FieldRename.snake)
class LootConditionPlayerKill extends LootCondition {
  LootConditionPlayerKill({
    required String condition,
  }) : super(condition: condition);

  factory LootConditionPlayerKill.fromJson(Map<String, dynamic> json) =>
      _$LootConditionPlayerKillFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LootConditionPlayerKillToJson(this);

  @override
  String toString() => 'Player Kill Required';
}

@JsonSerializable(fieldRename: FieldRename.snake)
class LootConditionUnknown extends LootCondition {
  LootConditionUnknown({
    required String condition,
  }) : super(condition: condition);

  factory LootConditionUnknown.fromJson(Map<String, dynamic> json) =>
      _$LootConditionUnknownFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LootConditionUnknownToJson(this);

  @override
  String toString() => '<$condition>';
}
