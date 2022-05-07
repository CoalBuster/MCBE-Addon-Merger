import 'package:json_annotation/json_annotation.dart';

part 'loot_condition.g.dart';

class MinecraftLootCondition {
  final String condition;

  MinecraftLootCondition({
    required this.condition,
  });

  factory MinecraftLootCondition.fromJson(Map<String, dynamic> json) {
    final condition = json['condition'] as String;
    switch (condition) {
      case 'random_chance_with_looting':
        return MinecraftLootConditionChance.fromJson(json);
      case 'killed_by_player':
        return MinecraftLootConditionPlayerKill.fromJson(json);
      default:
        return MinecraftLootConditionUnknown.fromJson(json);
    }
  }

  Map<String, dynamic> toJson() => {
        'condition': condition,
      };
}

@JsonSerializable(fieldRename: FieldRename.snake)
class MinecraftLootConditionChance extends MinecraftLootCondition {
  final double chance;
  final double lootingMultiplier;

  MinecraftLootConditionChance({
    required String condition,
    required this.chance,
    required this.lootingMultiplier,
  }) : super(condition: condition);

  factory MinecraftLootConditionChance.fromJson(Map<String, dynamic> json) =>
      _$MinecraftLootConditionChanceFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MinecraftLootConditionChanceToJson(this);

  @override
  String toString() =>
      'Overall chance: ${chance * 100}% (+${lootingMultiplier * 100}% per looting lvl)';
}

@JsonSerializable(fieldRename: FieldRename.snake)
class MinecraftLootConditionPlayerKill extends MinecraftLootCondition {
  MinecraftLootConditionPlayerKill({
    required String condition,
  }) : super(condition: condition);

  factory MinecraftLootConditionPlayerKill.fromJson(
          Map<String, dynamic> json) =>
      _$MinecraftLootConditionPlayerKillFromJson(json);

  @override
  Map<String, dynamic> toJson() =>
      _$MinecraftLootConditionPlayerKillToJson(this);

  @override
  String toString() => 'Player Kill Required';
}

@JsonSerializable(fieldRename: FieldRename.snake)
class MinecraftLootConditionUnknown extends MinecraftLootCondition {
  MinecraftLootConditionUnknown({
    required String condition,
  }) : super(condition: condition);

  factory MinecraftLootConditionUnknown.fromJson(Map<String, dynamic> json) =>
      _$MinecraftLootConditionUnknownFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MinecraftLootConditionUnknownToJson(this);

  @override
  String toString() => '<$condition>';
}
