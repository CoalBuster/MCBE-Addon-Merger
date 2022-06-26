import 'package:json_annotation/json_annotation.dart';

import 'chance.dart';
import 'loot_condition.dart';
import 'player_kill.dart';
import 'unknown.dart';

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
